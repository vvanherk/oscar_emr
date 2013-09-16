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


package oscar.oscarEncounter.pageUtil;

import java.net.URLEncoder;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Properties;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts.util.MessageResources;

import org.oscarehr.common.dao.OscarLogDao;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;
import org.oscarehr.common.dao.SpireAccessionNumberMapDao;
import org.oscarehr.common.model.SpireAccessionNumberMap;
import org.oscarehr.common.model.SpireCommonAccessionNumber;

import oscar.OscarProperties;
import oscar.oscarLab.ca.all.web.LabDisplayHelper;
import oscar.oscarLab.ca.on.CommonLabResultData;
import oscar.oscarLab.ca.on.LabResultData;
import oscar.util.DateUtils;
import oscar.util.OscarRoleObjectPrivilege;
import oscar.util.StringUtils;

//import oscar.oscarSecurity.CookieSecurity;

public class EctDisplayLabAction2 extends EctDisplayAction {
	private static final Logger logger = MiscUtils.getLogger();
	private static final String cmd = "labs";

	public boolean getInfo(EctSessionBean bean, HttpServletRequest request, NavBarDisplayDAO Dao, MessageResources messages) {

		logger.debug("EctDisplayLabAction2");
		OscarLogDao oscarLogDao = (OscarLogDao) SpringUtils.getBean("oscarLogDao");

		boolean a = true;
		Vector v = OscarRoleObjectPrivilege.getPrivilegeProp("_newCasemgmt.labResult");
		String roleName = (String) request.getSession().getAttribute("userrole") + "," + (String) request.getSession().getAttribute("user");
		a = OscarRoleObjectPrivilege.checkPrivilege(roleName, (Properties) v.get(0), (Vector) v.get(1));
		if (!a) {
			return true; // Lab result link won't show up on new CME screen.
		} else {

			CommonLabResultData comLab = new CommonLabResultData();
			ArrayList<LabResultData> labs = comLab.populateLabResultsData("", bean.demographicNo, "", "", "", "U");
			logger.debug("local labs found : "+labs.size());
			
			labs = collapseSpireLabs(labs);
			
			logger.debug("local labs found after collapsing Spire labs: "+labs.size());
			
			LoggedInInfo loggedInInfo = LoggedInInfo.loggedInInfo.get();
			if (loggedInInfo.currentFacility.isIntegratorEnabled()) {
				ArrayList<LabResultData> remoteResults = CommonLabResultData.getRemoteLabs(Integer.parseInt(bean.demographicNo));
				logger.debug("remote labs found : "+remoteResults.size());
				labs.addAll(remoteResults);
			}

			Collections.sort(labs);

			// set text for lefthand module title
			Dao.setLeftHeading(messages.getMessage(request.getLocale(), "oscarEncounter.LeftNavBar.Labs"));

			// set link for lefthand module title
			String winName = "Labs" + bean.demographicNo;
			String url = "popupPage(700,599,'" + winName + "','" + request.getContextPath() + "/lab/DemographicLab.jsp?demographicNo=" + bean.demographicNo + "'); return false;";
			Dao.setLeftURL(url);

			// we're going to display popup menu of 2 selections - row display and grid display
			String menuId = "2";
			Dao.setRightHeadingID(menuId);
			Dao.setRightURL("return !showMenu('" + menuId + "', event);");
			Dao.setMenuHeader(messages.getMessage("oscarEncounter.LeftNavBar.LabMenuHeading"));

			winName = "AllLabs" + bean.demographicNo;

			if (OscarProperties.getInstance().getBooleanProperty("HL7TEXT_LABS", "yes")) {
				url = "popupPage(700,1000, '" + winName + "','" + request.getContextPath() + "/lab/CumulativeLabValues3.jsp?demographic_no=" + bean.demographicNo + "')";
				Dao.addPopUpUrl(url);
				Dao.addPopUpText(messages.getMessage("oscarEncounter.LeftNavBar.LabMenuItem1"));
				if (OscarProperties.getInstance().getProperty("labs.hide_old_grid_display", "false").equals("false")) {
					url = "popupPage(700,1000, '" + winName + "','" + request.getContextPath() + "/lab/CumulativeLabValues2.jsp?demographic_no=" + bean.demographicNo + "')";
					Dao.addPopUpUrl(url);
					Dao.addPopUpText(messages.getMessage("oscarEncounter.LeftNavBar.LabMenuItem1") + "-OLD");
				}
			} else {
				url = "popupPage(700,1000, '" + winName + "','" + request.getContextPath() + "/lab/CumulativeLabValues2.jsp?demographic_no=" + bean.demographicNo + "')";
				Dao.addPopUpUrl(url);
				Dao.addPopUpText(messages.getMessage("oscarEncounter.LeftNavBar.LabMenuItem1"));
			}
			url = "popupPage(700,1000, '" + winName + "','" + request.getContextPath() + "/lab/CumulativeLabValues.jsp?demographic_no=" + bean.demographicNo + "')";
			Dao.addPopUpUrl(url);
			Dao.addPopUpText(messages.getMessage("oscarEncounter.LeftNavBar.LabMenuItem2"));

			// now we add individual module items
			LabResultData result;
			String labDisplayName, label;
			// String bgcolour = "FFFFCC";
			StringBuilder func;
			int hash;

			LinkedHashMap<String,LabResultData> accessionMap = new LinkedHashMap<String,LabResultData>();

			for (int i = 0; i < labs.size(); i++) {
				result = labs.get(i);
				if (result.accessionNumber == null || result.accessionNumber.equals("")) {
					accessionMap.put("noAccessionNum" + i + result.labType, result);
				} else {
					if (!accessionMap.containsKey(result.accessionNumber + result.labType)) accessionMap.put(result.accessionNumber + result.labType, result);
				}
			}
			labs = new ArrayList<LabResultData>(accessionMap.values());
			logger.info("number of labs: " + labs.size());
			for (int j = 0; j < labs.size(); j++) {
				result = labs.get(j);
				Date date = result.getDateObj();
				String formattedDate = DateUtils.getDate(date, "dd-MMM-yyyy", request.getLocale());
				// String formattedDate = DateUtils.getDate(date);
				func = new StringBuilder("popupPage(700,960,'");
				label = result.getLabel();

				String remoteFacilityIdQueryString = "";
				if (result.getRemoteFacilityId() != null) {
					try {
						remoteFacilityIdQueryString = "&remoteFacilityId=" + result.getRemoteFacilityId();
						String remoteLabKey = LabDisplayHelper.makeLabKey(Integer.parseInt(result.getLabPatientId()), result.getSegmentID(), result.labType, result.getDateTime());
						remoteFacilityIdQueryString = remoteFacilityIdQueryString + "&remoteLabKey=" + URLEncoder.encode(remoteLabKey, "UTF-8");
					} catch (Exception e) {
						logger.error("Error", e);
					}
				}

				if (result.isMDS()) {
					if (label == null || label.equals("")) labDisplayName = result.getDiscipline();
	            	else labDisplayName = label;
					url = request.getContextPath() + "/oscarMDS/SegmentDisplay.jsp?demographicId=" + bean.demographicNo + "&providerNo=" + bean.providerNo + "&segmentID=" + result.segmentID + "&multiID=" + result.multiLabId + "&status=" + result.getReportStatus() + remoteFacilityIdQueryString;
				} else if (result.isCML()) {
					if (label == null || label.equals("")) labDisplayName = result.getDiscipline();
	            	else labDisplayName = label;
					url = request.getContextPath() + "/lab/CA/ON/CMLDisplay.jsp?demographicId=" + bean.demographicNo + "&providerNo=" + bean.providerNo + "&segmentID=" + result.segmentID + "&multiID=" + result.multiLabId + remoteFacilityIdQueryString;
				} else if (result.isHL7TEXT()) {
					if (label == null || label.equals("")) labDisplayName = result.getDiscipline();
	            	else labDisplayName = label;
					// url = request.getContextPath() + "/lab/CA/ALL/labDisplay.jsp?providerNo="+bean.providerNo+"&segmentID="+result.segmentID;
					url = request.getContextPath() + "/lab/CA/ALL/labDisplay.jsp?demographicId=" + bean.demographicNo + "&providerNo=" + bean.providerNo + "&segmentID=" + result.segmentID + "&multiID=" + result.multiLabId + remoteFacilityIdQueryString;
				} else {
					if (label == null || label.equals("")) labDisplayName = result.getDiscipline();
	            	else labDisplayName = label;
					url = request.getContextPath() + "/lab/CA/BC/labDisplay.jsp?demographicId=" + bean.demographicNo + "&segmentID=" + result.segmentID + "&providerNo=" + bean.providerNo + "&multiID=" + result.multiLabId + remoteFacilityIdQueryString;
				}
				String labRead = "";
				if(!oscarLogDao.hasRead(( (String) request.getSession().getAttribute("user")   ),"lab",result.segmentID)){
                	labRead = "*";
                }

				NavBarDisplayDAO.Item item = NavBarDisplayDAO.Item();
				logger.info("Adding link: " + labDisplayName + " : " + formattedDate);
				item.setLinkTitle(labDisplayName + " " + formattedDate);
				labDisplayName = StringUtils.maxLenString(labDisplayName, MAX_LEN_TITLE, CROP_LEN_TITLE, ELLIPSES); // +" "+formattedDate;
				hash = winName.hashCode();
				hash = hash < 0 ? hash * -1 : hash;
				func.append(hash + "','" + url + "'); return false;");

				item.setTitle(labRead+labDisplayName+labRead);
				item.setURL(func.toString());
				item.setDate(date);
				if(result.isAbnormal()){
					item.setColour("red");
				}


				// item.setBgColour(bgcolour);
				Dao.addItem(item);
			}

			return true;
		}
	}

	public String getCmd() {
		return cmd;
	}
	
	/**
	 * Method collapseSpireLabs
	 * 
	 * Returns a list of Lab Results that include all non-spire labs, and include only a single spire
	 * lab for any given unique spire accession number.
	 * 
	 * Furthermore, for spire labs that share the same 'common' accession number, the newest lab will be
	 * included.
	 * 
	 * To elaborate, Spire labs have a 'regular' accession number, and also a 'unique' accession number.
	 * The unique accession number identifies seperate spire labs that are actually part of a single lab, but
	 * were sent as seperate HL7 files.  
	 */ 
	private ArrayList<LabResultData> collapseSpireLabs(ArrayList<LabResultData> labdocs) {
		ArrayList<LabResultData> collapsedLabdocs = new ArrayList<LabResultData>();
		
		List<String> accns = new ArrayList<String>();
		
		// get accession numbers for all labs
		for (LabResultData data : labdocs) {
			accns.add(data.getAccessionNum());
		}
		
		// Get accession number mappings for spire labs
		SpireAccessionNumberMapDao accnDao = (SpireAccessionNumberMapDao)SpringUtils.getBean("spireAccessionNumberMapDao");
		List<SpireAccessionNumberMap> accnsMap = accnDao.getFromCommonAccessionNumbers(accns);
		
		// Add non-spire labs to the collapsed lab list
		for (LabResultData data : labdocs) {
			boolean found = false;
			if (accnsMap != null) {
				for (SpireAccessionNumberMap map : accnsMap) {
					List<SpireCommonAccessionNumber> cAccns = map.getCommonAccessionNumbers();
					for (SpireCommonAccessionNumber commonAccessionNumber : cAccns) {
						if (data.getAccessionNum().equals( commonAccessionNumber.getCommonAccessionNumber() )) {
							found = true;
							break;
						}
					}
					
					if (found)
						break;
				}
			}
			
			// Add the Lab Result to the collapsed list if it isn't a spire lab
			if (!found) {
				collapsedLabdocs.add(data);
			}	
		}
		
		
		if (accnsMap != null) {
			// Add only a single Spire lab to the collapsed lab list for any given unique spire accession number
			for (SpireAccessionNumberMap map : accnsMap) {
				List<SpireCommonAccessionNumber> cAccns = map.getCommonAccessionNumbers();
				
				LabResultData addedData = null;
				// Only add one spire lab 'LabResultData' for each unique accession number
				for (SpireCommonAccessionNumber commonAccessionNumber : cAccns) {
					for (LabResultData data : labdocs) {
						if (data.getAccessionNum().equals( commonAccessionNumber.getCommonAccessionNumber() )) {
							if (addedData == null) {
								collapsedLabdocs.add(data);
								addedData = data;
							} else {
								if (data.isAbnormal())
									addedData.setIsAbnormal(true);
							}
						}
					}
				}
			}
		}
		
		return collapsedLabdocs;
	}
}
