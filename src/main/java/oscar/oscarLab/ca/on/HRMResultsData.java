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


package oscar.oscarLab.ca.on;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.log4j.Logger;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.hospitalReportManager.HRMReport;
import org.oscarehr.hospitalReportManager.HRMReportParser;
import org.oscarehr.hospitalReportManager.dao.HRMDocumentDao;
import org.oscarehr.hospitalReportManager.dao.HRMDocumentToDemographicDao;
import org.oscarehr.hospitalReportManager.dao.HRMDocumentToProviderDao;
import org.oscarehr.hospitalReportManager.model.HRMDocument;
import org.oscarehr.hospitalReportManager.model.HRMDocumentToDemographic;
import org.oscarehr.hospitalReportManager.model.HRMDocumentToProvider;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;

public class HRMResultsData {

	private static Logger logger = MiscUtils.getLogger();
	private HRMDocumentDao hrmDocumentDao = (HRMDocumentDao) SpringUtils.getBean("HRMDocumentDao");
	private HRMDocumentToProviderDao hrmDocumentToProviderDao = (HRMDocumentToProviderDao) SpringUtils.getBean("HRMDocumentToProviderDao");
	private HRMDocumentToDemographicDao hrmDocumentToDemographicDao = (HRMDocumentToDemographicDao) SpringUtils.getBean("HRMDocumentToDemographicDao");
	private DemographicDao demographicDao = (DemographicDao) SpringUtils.getBean("demographicDao");

	public HRMResultsData() {
	}

	public Collection<LabResultData> populateHRMdocumentsResultsData(String providerNo, String status, Date newestDate, Date oldestDate) {
		if (providerNo == null || "".equals(providerNo)) {
			providerNo = "%";
		} else if (providerNo.equalsIgnoreCase("0")) {
			providerNo = "-1";
		}

		Integer viewed = 1;
		Integer signedOff = 0;
		if (status == null || status.equalsIgnoreCase("N")) {
			viewed = 0;
		} else if (status != null && (status.equalsIgnoreCase("A") || status.equalsIgnoreCase("F"))) {
			signedOff = 1;
		}

		if (status != null && status.equalsIgnoreCase("")) {
			viewed = 2;
		}

		List<HRMDocumentToProvider> hrmDocResultsProvider = hrmDocumentToProviderDao.findByProviderNoLimit(providerNo, newestDate, oldestDate, viewed, signedOff);

		// the key = SendingFacility+':'+ReportNumber+':'+DeliverToUserID as per HRM spec can be used to signify duplicate report
		HashMap<String,LabResultData> labResults=new HashMap<String,LabResultData>();
		HashMap<String,HRMReport> labReports=new HashMap<String,HRMReport>();

		for (HRMDocumentToProvider hrmDocResult : hrmDocResultsProvider) {
			Integer id = Integer.parseInt(hrmDocResult.getHrmDocumentId());
			LabResultData lbData = new LabResultData(LabResultData.HRM);

			List<HRMDocument> hrmDocument = hrmDocumentDao.findById(id);

			lbData.dateTime = hrmDocument.get(0).getTimeReceived().toString();
			lbData.acknowledgedStatus = "U";
			lbData.reportStatus = hrmDocument.get(0).getReportStatus();
			lbData.segmentID = hrmDocument.get(0).getId().toString();
			lbData.setDateObj(hrmDocument.get(0).getReportDate());
			lbData.patientName = "Not, Assigned";

			// check if patient is matched
			List<HRMDocumentToDemographic> hrmDocResultsDemographic = hrmDocumentToDemographicDao.findByHrmDocumentId(hrmDocument.get(0).getId().toString());
			HRMReport hrmReport = HRMReportParser.parseReport(hrmDocument.get(0).getReportFile());
			if (hrmReport == null) continue;

			hrmReport.setHrmDocumentId(id);

			if (hrmDocResultsDemographic.size() > 0) {
				Demographic demographic = demographicDao.getDemographic(hrmDocResultsDemographic.get(0).getDemographicNo());
				if (demographic != null) {
					lbData.patientName = demographic.getLastName() + "," + demographic.getFirstName();
					lbData.sex = demographic.getSex();
					lbData.healthNumber = demographic.getHin();
					lbData.isMatchedToPatient = true;
				}
			} else {
				lbData.sex = hrmReport.getGender();
				lbData.healthNumber = hrmReport.getHCN();
				lbData.patientName = hrmReport.getLegalName();

			}

			lbData.reportStatus = hrmReport.getResultStatus();
			lbData.priority = "----";
			lbData.requestingClient = "";
			lbData.discipline = "HRM";
			lbData.resultStatus = hrmReport.getResultStatus();

			String duplicateKey=hrmReport.getSendingFacilityId()+':'+hrmReport.getSendingFacilityReportNo()+':'+hrmReport.getDeliverToUserId();

			// if no duplicate
			if (!labResults.containsKey(duplicateKey))
			{
				labResults.put(duplicateKey,lbData);
				labReports.put(duplicateKey, hrmReport);
			}
			else // there exists an entry like this one
			{
				HRMReport previousHrmReport=labReports.get(duplicateKey);

				logger.debug("Duplicate report found : previous="+previousHrmReport.getHrmDocumentId()+", current="+hrmReport.getHrmDocumentId());

				// if the current entry is newer than the previous one then replace it, other wise just keep the previous entry
				if (isNewer(hrmReport, previousHrmReport))
				{
					LabResultData olderLabData=labResults.get(duplicateKey);

					lbData.getDuplicateLabIds().addAll(olderLabData.getDuplicateLabIds());
					lbData.getDuplicateLabIds().add(previousHrmReport.getHrmDocumentId());

					labResults.put(duplicateKey,lbData);
					labReports.put(duplicateKey, hrmReport);
				}
				else
				{
					LabResultData newerLabData=labResults.get(duplicateKey);
					newerLabData.getDuplicateLabIds().add(hrmReport.getHrmDocumentId());
				}
			}

		}

		if (logger.isDebugEnabled()) {
			for (LabResultData temp : labResults.values()) {
				logger.debug("------------------");
				logger.debug(ReflectionToStringBuilder.toString(temp));
			}
		}

		return labResults.values();
	}

	/**
	 * @return true if the currentEntry is deemed to be newer than the previousEntry
	 */
	public static boolean isNewer(HRMReport currentEntry, HRMReport previousEntry) {
		// try to parse messageUniqueId for date portion to compare, no gurantees it exists or is well formed.
		try
		{
			String currentUid=currentEntry.getMessageUniqueId();
			String previousUid=previousEntry.getMessageUniqueId();
			String currentDatePart=currentUid.substring(0, currentUid.indexOf('^'));
			String previousDatePart=previousUid.substring(0, previousUid.indexOf('^'));
			long currentDateNum=Long.parseLong(currentDatePart);
			long previousDateNum=Long.parseLong(previousDatePart);

			if (currentDateNum>previousDateNum) return(true);
			if (currentDateNum<previousDateNum) return(false);
			// if they are equal, then we can not determine it based on this field
		}
		catch (Exception e)
		{
			// can ignore, messageUniqueId's are note guranteed to exist, nor their format.
			logger.debug("Error attempting to use messageUniqueId, currentUid="+currentEntry.getMessageUniqueId()+", prevUId="+previousEntry.getMessageUniqueId(), e);
		}

		logger.debug("could not determine newer based on messageUniqueId");

		// try to pick the one that's not canceled.
		if (!"C".equals(currentEntry.getResultStatus()) && "C".equals(previousEntry.getResultStatus())) return(true);
		if ("C".equals(currentEntry.getResultStatus()) && !"C".equals(previousEntry.getResultStatus())) return(false);
		// if both canceled or neither canceled then we can't figure it out from this field.

		// at this point I have to make a random guess, we know it's a duplicate but we can't tell which is newer.
		return(currentEntry.getHrmDocumentId()>previousEntry.getHrmDocumentId());
	}

	/*
	 * public List<LabResultData> populateHRMdocumentsResultsData(String providerNo){
	 *
	 *
	 * List<HRMDocumentToProvider> hrmDocResultsProvider = hrmDocumentToProviderDao.findByProviderNo(providerNo);
	 *
	 *
	 * ArrayList<LabResultData> labResults = new ArrayList<LabResultData>();
	 *
	 * for (HRMDocumentToProvider hrmDocResult : hrmDocResultsProvider) { String id = hrmDocResult.getHrmDocumentId(); LabResultData lbData = new LabResultData(LabResultData.HRM);
	 *
	 * List<HRMDocument> hrmDocument = hrmDocumentDao.findById(Integer.parseInt(id));
	 *
	 *
	 * lbData.dateTime = hrmDocument.get(0).getTimeReceived().toString(); lbData.acknowledgedStatus = "U"; lbData.reportStatus = hrmDocument.get(0).getReportStatus(); lbData.segmentID = hrmDocument.get(0).getId().toString(); lbData.patientName =
	 * "Not, Assigned";
	 *
	 * // check if patient is matched List<HRMDocumentToDemographic> hrmDocResultsDemographic = hrmDocumentToDemographicDao.findByHrmDocumentId(hrmDocument.get(0).getId().toString()); if (hrmDocResultsDemographic.size()>0) { Demographic demographic =
	 * demographicDao.getDemographic(hrmDocResultsDemographic.get(0).getDemographicNo()); if (demographic != null) { lbData.patientName = demographic.getLastName()+","+demographic.getFirstName(); lbData.isMatchedToPatient = true; } } else { HRMReport
	 * hrmReport = HRMReportParser.parseReport(hrmDocument.get(0).getReportFile()); lbData.sex = hrmReport.getGender(); lbData.healthNumber = hrmReport.getHCN(); lbData.patientName = hrmReport.getLegalName(); lbData.reportStatus =
	 * hrmReport.getResultStatus(); lbData.priority = "----"; lbData.requestingClient = ""; lbData.discipline = "HRM"; lbData.resultStatus = hrmReport.getResultStatus();
	 *
	 * }
	 *
	 * labResults.add(lbData);
	 *
	 * }
	 *
	 * return labResults; }
	 */

}
