/*
 * AcknowledgementData.java
 *
 * Created on July 9, 2007, 11:49 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package oscar.oscarLab.ca.all;

import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;
import org.oscarehr.common.dao.SpireAccessionNumberMapDao;
import org.oscarehr.common.model.SpireAccessionNumberMap;
import org.oscarehr.common.model.SpireCommonAccessionNumber;

import oscar.oscarDB.DBHandler;
import oscar.oscarMDS.data.ReportStatus;

public class AcknowledgementData {

	private static Logger logger = MiscUtils.getLogger();

	/** Creates a new instance of AcknowledgementData */
	private AcknowledgementData() {
		// don't instantiate
	}
	
	public static ArrayList<ReportStatus> getAcknowledgements(List<String> idList) {
		return getAcknowledgements(null, idList);
	}

	public static ArrayList<ReportStatus> getAcknowledgements(String segmentID) {
		return getAcknowledgements(null, segmentID);
	}

	public static ArrayList<ReportStatus> getAcknowledgements(String docType, String segmentID) {
		List<String> list = new ArrayList<String>();
		list.add(segmentID);
		
		return getAcknowledgements(docType, list);
	}
	
	public static ArrayList<ReportStatus> getAcknowledgements(String docType, List<String> idList) {
		String docTypeTest = "";
		if (docType != null)
			docTypeTest = "and providerLabRouting.lab_type='" + docType + "'";
			
		if (idList == null) {
			logger.error("The list of lab ids was null", new IllegalArgumentException("'idList' cannot be null"));
			return null;
		}
		
		List<String> labIds = new ArrayList<String>();
		
		// Get all spire lab ids attached to this segment
		for (String id : idList) {
			labIds.addAll( getSpireLabIds(id) );
		}
		
		// Add other lab ids to the list
		for (String id : idList) {
			labIds.add(id);
		}
		
		
		// Turn the list into a String
		String labIdsAsString = "";
		for (String labNo : labIds) {
			if (labIdsAsString.length() > 0)
				labIdsAsString += ", ";
			labIdsAsString += "'" + labNo + "'";
		}
		
		
		ArrayList<ReportStatus> acknowledgements = null;
		try {

			acknowledgements = new ArrayList<ReportStatus>();
			String sql = "select provider.first_name, provider.last_name, provider.provider_no, providerLabRouting.status, providerLabRouting.comment, providerLabRouting.timestamp, providerLabRouting.lab_no from provider, providerLabRouting where provider.provider_no = providerLabRouting.provider_no and providerLabRouting.lab_no in (" + labIdsAsString + ") " + docTypeTest;
			ResultSet rs = DBHandler.GetSQL(sql);
			while (rs.next()) {
				acknowledgements.add(new ReportStatus(oscar.Misc.getString(rs, "first_name") + " " + oscar.Misc.getString(rs, "last_name"), oscar.Misc.getString(rs, "provider_no"), oscar.Misc.getString(rs, "status"), oscar.Misc.getString(rs, "comment"), oscar.Misc.getString(rs, "timestamp"), oscar.Misc.getString(rs, "lab_no")));
			}
			rs.close();
		} catch (Exception e) {
			logger.error("Could not retrieve acknowledgement data", e);
		}

		return acknowledgements;
	}
	
	private static List<String> getSpireLabIds(String labNo) {
		SpireAccessionNumberMapDao accnDao = (SpireAccessionNumberMapDao)SpringUtils.getBean("spireAccessionNumberMapDao");
		SpireAccessionNumberMap map = accnDao.getFromLabNumber(new Integer(labNo));
		
		List<String> retList = new ArrayList<String>();
		
		if (map != null) {
			List<SpireCommonAccessionNumber> cAccns = map.getCommonAccessionNumbers();
			
			if (cAccns != null) {				
				
				for (SpireCommonAccessionNumber cAccn : cAccns) {
					retList.add( cAccn.getLabNo().toString() );
				}
			}
		}
		
		return retList;
	}
}
