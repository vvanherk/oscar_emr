/**
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
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
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */



package org.oscarehr.common.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.oscarehr.PMmodule.dao.ProviderDao;
import org.oscarehr.PMmodule.dao.SecUserRoleDao;
import org.oscarehr.PMmodule.model.SecUserRole;
import org.oscarehr.common.model.Provider;
import org.oscarehr.common.model.RaHeader;
import org.oscarehr.common.model.Site;
import org.oscarehr.util.SpringUtils;

import oscar.SxmlMisc;

public class PrivateProvidersUtil {

	public List getPrivateProvidersData(Boolean isMultisite, Boolean isTeamAccessPrivacy, 
			Boolean isSiteAccessPrivacy, 
			String providerNo, String selectedSite, 
			boolean isNoGroupsForDoctors) {
		List<Object> ret = new ArrayList<Object>();
		ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");
		//		Provider curProvider = providerDao.getProvider(providerNo);
		SiteDao siteDao = (SiteDao) SpringUtils.getBean("siteDao");
		List<Site> sites = new ArrayList<Site>();
		List<Site> curUserSites = new ArrayList<Site>();
		List<Provider> siteProviders = new ArrayList<Provider>();
		List<String> siteGroups = new ArrayList<String>();


		boolean isDoctor = false;
		if(isNoGroupsForDoctors) {
			SecUserRoleDao secDao = (SecUserRoleDao) SpringUtils.getBean("secUserRoleDao");
			List<SecUserRole> roles = secDao.getUserRoles(providerNo);
			for(SecUserRole role : roles) {
				if(role.getRoleName().equalsIgnoreCase("doctor")) {
					isDoctor = true;
					break;
				}	
			}
		}	

		if(isMultisite) {
			sites = siteDao.getAllActiveSites();

			if(isDoctor) { //no groups
				if(isSiteAccessPrivacy) {
					if (selectedSite != null) {
						siteProviders = providerDao.getProvidersBySiteLocation(selectedSite);
					} else {
						siteProviders = providerDao.getSiteProvidersByProviderNo(providerNo);
					}
					curUserSites = siteDao.getActiveSitesByProviderNo(providerNo);
				} else {
					if (selectedSite != null) {
						siteProviders = providerDao.getProvidersBySiteLocation(selectedSite);
					} else {
						siteProviders = providerDao.getProvidersForAllSites();
					}	
					curUserSites = sites;
				}
			} else { //providers and groups
				if(isSiteAccessPrivacy) {
					if (selectedSite != null) {
						siteProviders = providerDao.getProvidersBySiteLocation(selectedSite);
						siteGroups = siteDao.getGroupBySiteLocation(selectedSite);
					} else {
						siteProviders = providerDao.getSiteProvidersByProviderNo(providerNo);
						siteGroups = siteDao.getGroupsBySiteProviderNo(providerNo);
					}
					curUserSites = siteDao.getActiveSitesByProviderNo(providerNo);
				} else {
					if (selectedSite != null) {
						siteProviders = providerDao.getProvidersBySiteLocation(selectedSite);
						siteGroups = siteDao.getGroupBySiteLocation(selectedSite);
					} else {
						siteProviders = providerDao.getProvidersForAllSites();
						siteGroups = siteDao.getGroupsForAllSites();					
					}	
					curUserSites = sites;
				}
			}
		}
		List<Provider> teamProviders = new ArrayList<Provider>();
		if(isTeamAccessPrivacy) {
			String team = providerDao.getProviderTeam(providerNo);
			teamProviders = providerDao.getProvidersByTeam(team); 
		}

		List<Provider> providers = new ArrayList<Provider>();	
		if(!isMultisite && !isTeamAccessPrivacy) {
			providers = providerDao.getBillableProviders();
		} else {
			if(siteProviders.size() == 0) {
				if(isTeamAccessPrivacy) 
					providers = teamProviders;
			} else {
				if(teamProviders.size() == 0) {
					providers = siteProviders;
				} else {
					for(Provider sp : siteProviders) {
						for(Provider tp : teamProviders) {
							if(sp.getProviderNo().equals(tp.getProviderNo())) {
								providers.add(sp);
								break;
							}
						}
					}
				}
			}			
		}

		ret.add(sites);
		ret.add(curUserSites);
		ret.add(providers);
		ret.add(siteGroups);
		return ret;
	}

	//for billing reconciliation
		public List<Properties> getPrivateProvidersRahdProperties(Boolean isTeamBillingOnly, Boolean isTeamAccessPrivacy,
				Boolean isSiteAccessPrivacy, String status, String providerNo) {
			List<Properties> aL = new ArrayList<Properties>();
			//		RaHeaderDao raHeaderDao = (RaHeaderDao)SpringUtils.getBean("raHeaderDao");
			if ((isTeamBillingOnly || isTeamAccessPrivacy) && isSiteAccessPrivacy) {
				ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");
				List<Provider> providers = providerDao.getSiteProvidersByProviderNo(providerNo);
				aL = getTeamAndSiteRahdProperties(status, providerNo, providers);
			}
			else if (isTeamBillingOnly || isTeamAccessPrivacy) {
				aL = getTeamRahdProperties(status, providerNo);
			}
			else if (isSiteAccessPrivacy) {
				ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");
				List<Provider> providers = providerDao.getSiteProvidersByProviderNo(providerNo);
				aL = getSiteRahdProperties(status, providers);
			}
			else {
				aL = getAllRahdProperties(status);
			}
			
			return aL;
		}
		
		public List<Properties> getSiteRahdProperties(String status, List<Provider> providers) {
			List<Properties> ret = new ArrayList<Properties>();

			RaHeaderDao dao = (RaHeaderDao) SpringUtils.getBean("raHeaderDao");
			List<RaHeader> headers = dao.getSiteRahd(status, providers);
			for(RaHeader header : headers) {
				Properties prop = new Properties();
				prop.setProperty("raheader_no", header.getId().toString());
				prop.setProperty("readdate", header.getReadDate());
				prop.setProperty("paymentdate", header.getPaymentDate());
				prop.setProperty("payable", header.getPayable());
				prop.setProperty("claims", header.getClaims());
				prop.setProperty("records", header.getRecords());
				prop.setProperty("totalamount", header.getTotalAmount());
				prop.setProperty("status", header.getStatus());
				ret.add(prop);
			}
			return ret;
		}

		public List<Properties> getTeamRahdProperties(String status, String providerNo) {
			List<Properties> ret = new ArrayList<Properties>();

			RaHeaderDao dao = (RaHeaderDao) SpringUtils.getBean("raHeaderDao");
			List<RaHeader> headers = dao.getTeamRahd(status, providerNo);
			for(RaHeader header : headers) {
				Properties prop = new Properties();
				prop.setProperty("raheader_no", header.getId().toString());
				prop.setProperty("readdate", header.getReadDate());
				prop.setProperty("paymentdate", header.getPaymentDate());
				prop.setProperty("payable", header.getPayable());
				prop.setProperty("claims", header.getClaims());
				prop.setProperty("records", header.getRecords());
				prop.setProperty("totalamount", header.getTotalAmount());
				prop.setProperty("status", header.getStatus());
				ret.add(prop);
			}
			return ret;
		}

		public List<Properties> getTeamAndSiteRahdProperties(String status, String provider_no, List<Provider> providers) {
			List<Properties> ret = new ArrayList<Properties>();
			List<Properties> theaders = getTeamRahdProperties(status, provider_no);
			List<Properties> sheaders = getSiteRahdProperties(status, providers);
			for(Properties tprop : theaders) {
				String raNo = tprop.getProperty("raheader_no");
				for(Properties sprop : sheaders) {
					if(sprop.getProperty("raheader_no").equals(raNo)) {
						ret.add(sprop);
						break;
					}
				}
			}

			return ret;
		}

		public List<Properties> getAllRahdProperties(String status) {
			List<Properties> ret = new ArrayList<Properties>();
			RaHeaderDao dao = (RaHeaderDao) SpringUtils.getBean("raHeaderDao");
			List<RaHeader> headers = dao.getAllRahd(status);
			for(RaHeader header : headers) {
				Properties prop = new Properties();
				prop.setProperty("raheader_no", header.getId().toString());
				prop.setProperty("readdate", header.getReadDate());
				prop.setProperty("paymentdate", header.getPaymentDate());
				prop.setProperty("payable", header.getPayable());
				prop.setProperty("claims", header.getClaims());
				prop.setProperty("records", header.getRecords());
				prop.setProperty("totalamount", header.getTotalAmount());
				prop.setProperty("status", header.getStatus());
				ret.add(prop);
			}
			return ret;
		}

		public List<Provider> getActiveTeamAndSiteProviders(String providerNo) {
			List<Provider> ret = new ArrayList<Provider>();
			ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");
			List<Provider> tproviders = providerDao.getActiveSiteProviders(providerNo);
			List<Provider> sproviders = providerDao.getActiveTeamProviders(providerNo);

			for(Provider tp : tproviders) {
				String tpNo = tp.getProviderNo();
				for(Provider sp : sproviders) {
					if(sp.getProviderNo().equals(tpNo)) {
						ret.add(sp);
						break;
					}
				}
			}

			return ret;
		}
	//for OHIP simulation	
		public List<String> getActivePrivateProvidersStr(Boolean isTeamBillingOnly, Boolean isTeamAccessPrivacy,
				Boolean isSiteAccessPrivacy, String providerNo) {
			List<String> ret = new ArrayList<String>();
			ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");
			List<Provider> providers = null;
			if ((isTeamBillingOnly || isTeamAccessPrivacy) && isSiteAccessPrivacy) {
				providers = getActiveTeamAndSiteProviders(providerNo);
			}
			else if (isTeamBillingOnly || isTeamAccessPrivacy) {
				providers = providerDao.getActiveTeamProviders(providerNo);
			}
			else if (isSiteAccessPrivacy) {
				providers = providerDao.getActiveSiteProviders(providerNo);
			}
			else {
				providers = providerDao.getActiveProviders();
			}
			
			for (Provider p : providers) {		
				
				String proid = p.getProviderNo();
				String proFirst = p.getLastName();
				String proLast = p.getFirstName();
				String proOHIP = p.getOhipNo();
				
				//Only list the providers who have OHIP number
				if(StringUtils.isBlank(proOHIP) )
					continue;
				
				String specialty_code = getXMLStringWithDefault(p.getComments(), "xml_p_specialty_code", "00");
				String billinggroup_no = getXMLStringWithDefault(p.getComments(), "xml_p_billinggroup_no",
						"0000");
				ret.add(proid + "|" + proLast + "|" + proFirst + "|" + proOHIP + "|" + billinggroup_no + "|"
						+ specialty_code);
			}	
			return ret;
		}
		
		public Map<String,String> getActivePrivateProvidersNoMap(Boolean isTeamBillingOnly, Boolean isTeamAccessPrivacy,
				Boolean isSiteAccessPrivacy, String providerNo) {
			Map<String,String> ret = new HashMap<String,String>();
			ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");
			List<Provider> providers = null;
			if ((isTeamBillingOnly || isTeamAccessPrivacy) && isSiteAccessPrivacy) {
				providers = getActiveTeamAndSiteProviders(providerNo);
			}
			else if (isTeamBillingOnly || isTeamAccessPrivacy) {
				providers = providerDao.getActiveTeamProviders(providerNo);
			}
			else if (isSiteAccessPrivacy) {
				providers = providerDao.getActiveSiteProviders(providerNo);
			}
			else {
				providers = providerDao.getActiveProviders();
			}
			for (Provider p : providers) {
				ret.put(p.getProviderNo(), "true");
			}	
			return ret;
		}
	//for billing correction	
		public List<Provider> getPrivateProviders(
				Boolean isMultisites,
				Boolean isTeamAccessPrivacy, 
				Boolean isSiteAccessPrivacy, 
				String providerNo) {
			
			List providersData = getPrivateProvidersData(
					isMultisites, 
					isTeamAccessPrivacy, 
					isSiteAccessPrivacy, 
					providerNo, null, 
					true); 
			return (List<Provider>)providersData.get(2);		
		}	

	//copy from JdbcBillingPageUtil	
		private String getXMLStringWithDefault(String xmlStr, String xmlName, String strDefault) {
			String retval = SxmlMisc.getXmlContent(xmlStr, "<" + xmlName + ">", "</" + xmlName + ">");
			retval = retval == null || "".equals(retval) ? strDefault : retval;
			return retval;
		}	
// used by appointmentprovideradminday, appointmentprovideradminmonth pages		
		public List getPrivateProviders(boolean isMultisite, boolean isTeamAccessPrivacy, 
				boolean isSiteAccessPrivacy, 
				String providerNo, String selectedSite, 
				boolean isNoGroupsForDoctors) {
			return getPrivateProvidersData(isMultisite, isTeamAccessPrivacy, 
					isSiteAccessPrivacy, providerNo, selectedSite, isNoGroupsForDoctors);
		}
		
		
}
