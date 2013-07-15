/**
 *
 * Copyright (c) 2005-2012. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved.
 * This software is published under the GPL GNU General Public License.
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * This software was written for
 * Centre for Research on Inner City Health, St. Michael's Hospital,
 * Toronto, Ontario, Canada
 */

package org.oscarehr.PMmodule.web;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.oscarehr.PMmodule.caisi_integrator.CaisiIntegratorManager;
import org.oscarehr.caisi_integrator.ws.ConnectException_Exception;
import org.oscarehr.caisi_integrator.ws.ConsentState;
import org.oscarehr.caisi_integrator.ws.DuplicateHinExceptionException;
import org.oscarehr.caisi_integrator.ws.GetConsentTransfer;
import org.oscarehr.caisi_integrator.ws.InvalidHinExceptionException;
import org.oscarehr.casemgmt.dao.ClientImageDAO;
import org.oscarehr.casemgmt.model.ClientImage;
import org.oscarehr.common.dao.ClientLinkDao;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.common.dao.HnrDataValidationDao;
import org.oscarehr.common.model.ClientLink;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.common.model.HnrDataValidation;
import org.oscarehr.hnr.ws.Gender;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;

public class ManageHnrClientAction {
	private static Logger logger = MiscUtils.getLogger();
	private static DemographicDao demographicDao = (DemographicDao) SpringUtils.getBean("demographicDao");
	private static ClientLinkDao clientLinkDao = (ClientLinkDao) SpringUtils.getBean("clientLinkDao");
	private static ClientImageDAO clientImageDAO = (ClientImageDAO) SpringUtils.getBean("clientImageDAO");
	private static HnrDataValidationDao hnrDataValidationDao = (HnrDataValidationDao) SpringUtils.getBean("hnrDataValidationDao");
	
	public static void copyHnrToLocal(Integer clientId) throws ConnectException_Exception {
		try {
			LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();
			
			logger.debug("copyHnrToLocal currentFacility=" + loggedInInfo.currentFacility.getId() + ", loggedInInfo.loggedInProvider=" + loggedInInfo.loggedInProvider.getProviderNo() + ", client=" + clientId);

			List<ClientLink> clientLinks = clientLinkDao.findByFacilityIdClientIdType(loggedInInfo.currentFacility.getId(), clientId, true, ClientLink.Type.HNR);

			// it might be 0 if some one unlinked the client at the same time you are looking at this screen.
			if (clientLinks.size() > 0) {
				ClientLink clientLink = clientLinks.get(0);
				org.oscarehr.hnr.ws.Client hnrClient = CaisiIntegratorManager.getHnrClient(clientLink.getRemoteLinkId());

				Demographic demographic = demographicDao.getDemographicById(clientId);

				if (hnrClient.getBirthDate() != null) 
				{
					demographic.setBirthDay(hnrClient.getBirthDate());
				}
				
				if (hnrClient.getCity() != null) demographic.setCity(hnrClient.getCity());
				if (hnrClient.getFirstName() != null) demographic.setFirstName(hnrClient.getFirstName());
				if (hnrClient.getGender()!=null) demographic.setSex(hnrClient.getGender().name());
				if (hnrClient.getHin() != null) demographic.setHin(hnrClient.getHin());
				if (hnrClient.getHinVersion() != null) demographic.setVer(hnrClient.getHinVersion());
				if (hnrClient.getHinType() != null) demographic.setHcType(hnrClient.getHinType());
				if (hnrClient.getHinValidStart() != null) demographic.setEffDate(MiscUtils.toDate(hnrClient.getHinValidStart()));
				if (hnrClient.getHinValidEnd() != null) demographic.setHcRenewDate(MiscUtils.toDate(hnrClient.getHinValidEnd()));

				if (hnrClient.getImage() != null) {
					ClientImage clientImage = clientImageDAO.getClientImage(clientId);
					if (clientImage == null) {
						clientImage = new ClientImage();
						clientImage.setDemographic_no(clientId);
					}

					clientImage.setImage_data(hnrClient.getImage());
					clientImage.setImage_type("jpg");
					clientImage.setUpdate_date(new Date());

					clientImageDAO.saveClientImage(clientImage);
				}

				if (hnrClient.getLastName() != null) demographic.setLastName(hnrClient.getLastName());
				if (hnrClient.getProvince() != null) demographic.setProvince(hnrClient.getProvince());
				if (hnrClient.getStreetAddress() != null) demographic.setAddress(hnrClient.getStreetAddress());

				demographicDao.getHibernateTemplate().saveOrUpdate(demographic);
			}
		} catch (ConnectException_Exception e) {
			throw(e);
		} catch (Exception e) {
			logger.error("Unexpected Error.", e);
		}
	}

	public static void copyLocalValidatedToHnr(Integer clientId) throws DuplicateHinExceptionException, InvalidHinExceptionException, ConnectException_Exception {
		try {
			LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();

			logger.debug("copyLocalToHnr currentFacility=" +loggedInInfo.currentFacility.getId() + ", loggedInInfo.loggedInProvider=" + loggedInInfo.loggedInProvider.getProviderNo() + ", client=" + clientId);

			// there's 2 cases here
			// 1) there's a linked client at which point update the linked client on the hnr
			// 2) there is no linked client at which point create a new linked client on the hnr and create the link.

			// were ignoring the anomalie of multiple hnr links as it should never really happen though it's theoretically possible due to lack of atomic updates on this table.
			List<ClientLink> clientLinks = clientLinkDao.findByFacilityIdClientIdType(loggedInInfo.currentFacility.getId(), clientId, true, ClientLink.Type.HNR);

			org.oscarehr.hnr.ws.Client hnrClient = null;
			ClientLink clientLink = null;

			// try to retrieve existing linked client to update
			if (clientLinks.size() >= 1) {
				clientLink = clientLinks.get(0);
				hnrClient = CaisiIntegratorManager.getHnrClient(clientLink.getRemoteLinkId());
			}

			// can be null if there's no existing link or if the data on the hnr has been revoked of consent
			if (hnrClient == null) {
				hnrClient = new org.oscarehr.hnr.ws.Client();
			}

			// copy any non null data to the HNR if it's validated
			// you have to check for null before setting because if it's an existing record you don't want to nullify existing data
			boolean isAtLeastOneThingValidated = false;
			Demographic demographic = demographicDao.getDemographicById(clientId);

			HnrDataValidation tempValidation = hnrDataValidationDao.findMostCurrentByFacilityIdClientIdType(loggedInInfo.currentFacility.getId(), clientId, HnrDataValidation.Type.HC_INFO);
			boolean hcInfoValidated = (tempValidation != null && tempValidation.isValidAndMatchingCrc(HnrDataValidation.getHcInfoValidationBytes(demographic)));

			if (hcInfoValidated) {
				isAtLeastOneThingValidated = true;

				if (demographic.getFirstName() != null) hnrClient.setFirstName(demographic.getFirstName());
				if (demographic.getLastName() != null) hnrClient.setLastName(demographic.getLastName());
				
				try
				{
					if (demographic.getSex()!=null) hnrClient.setGender(Gender.valueOf(demographic.getSex().toUpperCase()));
				}
				catch (Exception e)
				{
					// do nothing, this is on a best attempt basis. until genders are defined constants.
				}
				
				if (demographic.getBirthDay() != null) hnrClient.setBirthDate(demographic.getBirthDay());
				if (demographic.getHin() != null) hnrClient.setHin(demographic.getHin());
				if (demographic.getVer() != null) hnrClient.setHinVersion(demographic.getVer());
				if (demographic.getHcType() != null) hnrClient.setHinType(demographic.getHcType().toLowerCase());
				if (demographic.getEffDate() != null) hnrClient.setHinValidStart(MiscUtils.toCalendar(demographic.getEffDate()));
				if (demographic.getHcRenewDate() != null) hnrClient.setHinValidEnd(MiscUtils.toCalendar(demographic.getHcRenewDate()));
			}

			ClientImage clientImage = clientImageDAO.getClientImage(clientId);
			tempValidation = hnrDataValidationDao.findMostCurrentByFacilityIdClientIdType(loggedInInfo.currentFacility.getId(), clientId, HnrDataValidation.Type.PICTURE);
			boolean pictureValidated = (tempValidation != null && tempValidation.isValidAndMatchingCrc(clientImage.getImage_data()));
			if (pictureValidated && clientImage != null) {
				isAtLeastOneThingValidated = true;

				hnrClient.setImage(clientImage.getImage_data());
			}

			tempValidation = hnrDataValidationDao.findMostCurrentByFacilityIdClientIdType(loggedInInfo.currentFacility.getId(), clientId, HnrDataValidation.Type.OTHER);
			boolean otherValidated = (tempValidation != null && tempValidation.isValidAndMatchingCrc(HnrDataValidation.getOtherInfoValidationBytes(demographic)));
			if (otherValidated) {
				isAtLeastOneThingValidated=true;
				
				if (demographic.getAddress() != null) hnrClient.setStreetAddress(demographic.getAddress());
				if (demographic.getCity() != null) hnrClient.setCity(demographic.getCity());
				if (demographic.getProvince() != null) hnrClient.setProvince(demographic.getProvince());
			}

			if (isAtLeastOneThingValidated)
			{
				// link back to currently linked client if previously linked.
				if (clientLink != null) {
					hnrClient.setLinkingId(clientLink.getRemoteLinkId());
				}

				// set the consent
				hnrClient.setHidden(true);
// this section will produce correct results based on the model but unexpected from the user, so we're hacking it
//				List<IntegratorConsent> consents=integratorConsentDao.findByFacilityAndDemographic(loggedInInfo.currentFacility.getId(), clientId);
//				if (consents.size()>0) {
//					// only 1 hnr setting so using the latest is fine.
//					IntegratorConsent integratorConsent=consents.get(0);
//					// was asked to remove hnr consent and just apply the general consent setting to the hnr
//					hnrClient.setHidden(integratorConsent.getClientConsentStatus()!=ConsentStatus.GIVEN);
//					hnrClient.setHiddenChangeDate(integratorConsent.getCreatedDate());
//				}
				// new hacked consent which is actually wrong but may produced "expected" results
				GetConsentTransfer remoteConsent=CaisiIntegratorManager.getConsentState(clientId);
				if (remoteConsent!=null)
				{
					if (remoteConsent.getConsentState()==ConsentState.ALL)
					{
						hnrClient.setHidden(false);
						hnrClient.setHiddenChangeDate(remoteConsent.getConsentDate());
					}
				}
				
				
				// save the client
				hnrClient.setUpdatedBy("faciliy: " + loggedInInfo.currentFacility.getName() + ", provider:" + loggedInInfo.loggedInProvider.getFormattedName());
				Integer linkingId = CaisiIntegratorManager.setHnrClient(hnrClient);

				// if the hnr client is new / not previously linked, save the new link
				// in theory this can lead to multiple links if 2 people run this method
				// at the same time, in reality it should really be a problem and
				// the code is set to "ignore" multiple hnr links so it should function fine anyways.
				if (clientLink == null && linkingId != null) {
					clientLink = new ClientLink();
					clientLink.setFacilityId(loggedInInfo.currentFacility.getId());
					clientLink.setClientId(clientId);
					clientLink.setLinkDate(new Date());
					clientLink.setLinkProviderNo(loggedInInfo.loggedInProvider.getProviderNo());
					clientLink.setLinkType(ClientLink.Type.HNR);
					clientLink.setRemoteLinkId(linkingId);
					clientLinkDao.persist(clientLink);
				}
			}
		} catch (ConnectException_Exception e) {
			throw(e);
		} catch (InvalidHinExceptionException e) {
			throw(e);
		} catch (DuplicateHinExceptionException e) {
			throw(e);
		} catch (Exception e) {
			logger.error("Unexpected Error.", e);
		}
	}

	public static void setPictureValidation(Integer clientId, boolean valid) {
		try {
			LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();

			logger.debug("setPictureValidation currentFacility=" +loggedInInfo.currentFacility.getId() + ", loggedInInfo.loggedInProvider=" + loggedInInfo.loggedInProvider.getProviderNo() + ", client=" + clientId + ", valid=" + valid);

			ClientImage clientImage = clientImageDAO.getClientImage(clientId);
			if (!HnrDataValidation.isImageValidated(clientImage)) throw (new IllegalStateException("Attempt to validate an image that doesn't exist, button should have been disabled. clientId=" + clientId));

			HnrDataValidation hnrDataValidation = new HnrDataValidation();
			hnrDataValidation.setClientId(clientId);
			hnrDataValidation.setCreated(new Date());
			hnrDataValidation.setFacilityId(loggedInInfo.currentFacility.getId());
			hnrDataValidation.setValid(valid);
			hnrDataValidation.setValidationCrc(clientImage.getImage_data());
			hnrDataValidation.setValidationType(HnrDataValidation.Type.PICTURE);
			hnrDataValidation.setValidatorProviderNo(loggedInInfo.loggedInProvider.getProviderNo());
			hnrDataValidationDao.persist(hnrDataValidation);
		} catch (Exception e) {
			logger.error("Unexpected Error.", e);
		}
	}

	public static void setHcInfoValidation(Integer clientId, boolean valid) {
		try {
			LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();

			logger.debug("setHcInfoValidation currentFacility=" +loggedInInfo.currentFacility.getId() + ", loggedInInfo.loggedInProvider=" + loggedInInfo.loggedInProvider.getProviderNo() + ", client=" + clientId + ", valid=" + valid);

			Demographic demographic = demographicDao.getDemographicById(clientId);
			if (!HnrDataValidation.isHcInfoValidateable(demographic)) throw (new IllegalStateException("Attempt to validate a clients hc info that is not validateable, button should have been disabled. clientId=" + clientId));

			HnrDataValidation hnrDataValidation = new HnrDataValidation();
			hnrDataValidation.setClientId(clientId);
			hnrDataValidation.setCreated(new Date());
			hnrDataValidation.setFacilityId(loggedInInfo.currentFacility.getId());
			hnrDataValidation.setValid(valid);
			hnrDataValidation.setValidationCrc(HnrDataValidation.getHcInfoValidationBytes(demographic));
			hnrDataValidation.setValidationType(HnrDataValidation.Type.HC_INFO);
			hnrDataValidation.setValidatorProviderNo(loggedInInfo.loggedInProvider.getProviderNo());
			hnrDataValidationDao.persist(hnrDataValidation);
		} catch (Exception e) {
			logger.error("Unexpected Error.", e);
		}
	}

	public static void setOtherInfoValidation(Integer clientId, boolean valid) {
		try {
			LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();

			logger.debug("setOtherInfoValidation currentFacility=" +loggedInInfo.currentFacility.getId() + ", loggedInInfo.loggedInProvider=" + loggedInInfo.loggedInProvider.getProviderNo() + ", client=" + clientId + ", valid=" + valid);

			Demographic demographic = demographicDao.getDemographicById(clientId);
			if (!HnrDataValidation.isOtherInfoValidateable(demographic)) throw (new IllegalStateException("Attempt to validate a clients other info that is not validateable, button should have been disabled. clientId=" + clientId));

			HnrDataValidation hnrDataValidation = new HnrDataValidation();
			hnrDataValidation.setClientId(clientId);
			hnrDataValidation.setCreated(new Date());
			hnrDataValidation.setFacilityId(loggedInInfo.currentFacility.getId());
			hnrDataValidation.setValid(valid);
			hnrDataValidation.setValidationCrc(HnrDataValidation.getOtherInfoValidationBytes(demographic));
			hnrDataValidation.setValidationType(HnrDataValidation.Type.OTHER);
			hnrDataValidation.setValidatorProviderNo(loggedInInfo.loggedInProvider.getProviderNo());
			hnrDataValidationDao.persist(hnrDataValidation);
		} catch (Exception e) {
			logger.error("Unexpected Error.", e);
		}
	}
}
