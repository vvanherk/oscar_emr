/**
 * Copyright (c) 2006-. OSCARservice, OpenSoft System. All Rights Reserved.
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
 */

package oscar.oscarBilling.ca.on.data;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.oscarehr.common.dao.BillingServiceDao;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.common.dao.SiteDao;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.common.model.Site;
import org.oscarehr.util.SpringUtils;

import oscar.OscarProperties;
import oscar.oscarProvider.data.ProviderBillCenter;

public class JdbcBillingCreateBillingFile {
	private static final Logger _logger = Logger.getLogger(JdbcBillingCreateBillingFile.class);
	public String errorFatalMsg = "";
	private BillingBatchHeaderData bhObj = null;
	private BillingClaimHeader1Data ch1Obj = null;
	private BillingItemData itemObj = null;
	private Properties propBillingNo = null;
	private DemographicDao demographicDao = (DemographicDao) SpringUtils.getBean("demographicDao");

	// private String batchCount = "";
	private String batchHeader;
	private BigDecimal bdFee = new BigDecimal((double) 0).setScale(2, BigDecimal.ROUND_HALF_UP);
	private BigDecimal BigTotal = new BigDecimal((double) 0).setScale(2, BigDecimal.ROUND_HALF_UP);
	public BigDecimal getBigTotal() {
    	return BigTotal;
    }

	private String dateRange = "";
	public String[] dbParam;
	private double dFee;
	private String diagcode;
	private String eFlag = "1";
	public String errorMsg = "";
	public String errorPartMsg = "";
	private String fee;
	private SimpleDateFormat formatter;
	private String hcCount = "";
	private String hcFirst = "";
	private String hcFlag = "";
	private String hcLast = "";
	private int healthcardCount = 0;
	private String htmlCode = "";
	private String htmlContent = "";
	private String htmlFilename;
	private String htmlFooter = "";
	private String htmlHeader = "";
	private String htmlValue = "";
	private int invCount = 0;
	private String m_Flag = "";
	private String ohipClaim;
	private String ohipFilename;
	private String ohipReciprocal;
	private String ohipRecord;
	private String ohipVer;
	private String output;
	private int patientCount = 0;
	private String pCount = "";
	// private BigDecimal percent = new BigDecimal((double) 0).setScale(2,
	// BigDecimal.ROUND_HALF_UP);
	private String providerNo;
	private String query;
	private String rCount = "";
	private int recordCount = 0;
	public int getRecordCount() {
    	return recordCount;
    }

	private String referral;
	private java.util.Date today;
	private String totalAmount;
	private String value;
	private String clinicBgColor;
	private HashMap<String,String> clinicShortName;
	private boolean summaryView;
	
	public JdbcBillingCreateBillingFile() {
		formatter = new SimpleDateFormat("yyyyMMdd"); // yyyyMMddHmm");
		today = new java.util.Date();
		output = formatter.format(today);
		
		//multisite, get site short name
		clinicShortName = new HashMap<String,String>();
		SiteDao siteDao = (SiteDao)SpringUtils.getBean("siteDao");
		List<Site> sites = siteDao.getAllSites();
		for (Site s : sites) {
			clinicShortName.put(s.getName(), s.getShortName());
		}
	}

	private String buildBatchHeader() {
		String ret = "";
		errorFatalMsg = "";
		ret = bhObj.getTransc_id() + bhObj.getRec_id() + bhObj.getSpec_id() + bhObj.getMoh_office()
				+ bhObj.getBatch_id() + space(6) + bhObj.getGroup_num() + bhObj.getProvider_reg_num()
				+ bhObj.getSpecialty() + space(42) + "\r";
		if (ret.length() != 80)
			errorFatalMsg += "Batch Header length wrong! - " + bhObj.getProvider_reg_num() + "<br>";
		return ret;
	}

	private void checkBatchHeader() {
		if (bhObj.getSpec_id().length() != 3) {
			errorPartMsg = "Batch Header: Version code wrong! - " + bhObj.getProvider_reg_num() + "<br>";
		}
		if (bhObj.getMoh_office().length() != 1) {
			errorPartMsg += "Batch Header: Health Office Code wrong!<br>";
		}
		if (bhObj.getGroup_num().length() != 4) {
			errorPartMsg += "Batch Header: GroupNo. wrong!<br>";
		}
		if (bhObj.getProvider_reg_num().length() != 6) {
			errorPartMsg += "Batch Header: Provider OHIP No. wrong!<br>";
		}
		if (bhObj.getSpecialty().length() != 2) {
			errorPartMsg += "Batch Header: Specialty Code wrong!<br>";
		}
		errorMsg += errorPartMsg;
	}

	private String buildHeader1() {
		String ret = "";
		String header1 = null;
		String header2 = "";
		updateDemoData(ch1Obj);
		boolean bRMB = ch1Obj.getPay_program().equals("RMB") ? true : false;
		String str1Hin = bRMB ? space(10) : leftJustify(" ", 10, ch1Obj.getHin());
		String ver = bRMB ? space(2) : leftJustify(" ", 2, ch1Obj.getVer());
        String dob = leftJustify(" ", 8, ch1Obj.getDob().replaceAll("-", ""));
		referral = ch1Obj.getRef_num().length() > 1 ? "R" : "";
		hcFlag = bRMB ? "H" : "";
		m_Flag = ch1Obj.getMan_review().equals("Y") ? "M" : "";
		_logger.info("buildHeader1(ver = " + ver + ")");

		header1 = ch1Obj.getTransc_id() + ch1Obj.getRec_id() + str1Hin + ver + dob
				+ rightJustify("0", 8, ch1Obj.getId()) + ch1Obj.getPay_program() + ch1Obj.getPayee()
				+ rightJustify(" ", 6, ch1Obj.getRef_num())
				+ rightJustify(" ", 4, ch1Obj.getFacilty_num().equals("0000") ? "" : ch1Obj.getFacilty_num())
				+ rightJustify(" ", 8, getCompactDateStr(ch1Obj.getAdmission_date()))
				+ rightJustify(" ", 4, ch1Obj.getRef_lab_num()) + rightJustify(" ", 1, ch1Obj.getMan_review())
				+ leftJustify(" ", 4, ch1Obj.getLocation().equals("0000") ? "" : ch1Obj.getLocation()) + space(11)
				+ space(6);
		checkHeader1();
		if (bRMB) {
			header2 = buildHeader2();
		}

		ret = "\n" + header1 + "\r" + header2;
		if (header1.length() != 79)
			errorFatalMsg += "Header 1 length wrong! - " + ch1Obj.getId() + "<br>";

		return ret;
	}

	private String buildHeader2() {
		healthcardCount++;
		String str1Hin = leftJustify(" ", 12, ch1Obj.getHin());
		String strDemoName = ch1Obj.getDemographic_name();
		hcLast = strDemoName.substring(0, strDemoName.indexOf(",")).toUpperCase();
		hcFirst = strDemoName.substring(strDemoName.indexOf(",") + 1).toUpperCase();
		hcLast.replaceAll("\\W", "");
		hcFirst.replaceAll("\\W", "");
		hcLast = hcLast.length() < 9 ? (hcLast + space(9 - hcLast.length())) : (hcLast.substring(0, 9));
		hcFirst = hcFirst.length() < 5 ? (hcFirst + space(5 - hcFirst.length())) : (hcFirst.substring(0, 5));
		checkHeader2();
		String header2 = "\n" + "HER" + str1Hin + hcLast + hcFirst + ch1Obj.getSex() + ch1Obj.getProvince() + space(47)
				+ "\r";
		if (header2.length() != 81)
			errorFatalMsg += "Header 2 length wrong! - " + ch1Obj.getId() + " length = " + header2.length() + "<br>";
		return header2;
	}

	private String buildHTMLContentHeader() {
		String ret = null;
		ret = "<script type=\"text/JavaScript\">\n<!--\nfunction popupPage(vheight,vwidth,varpage) {\n  var page = \"\" + varpage;\n";
		ret += "  windowprops = \"height=\"+vheight+\",width=\"+vwidth+\",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes,screenX=0,screenY=0,top=0,left=0\";\n";
		ret += "  var popup=window.open(page, \"billcorrection\", windowprops);\n";
		ret += "    if (popup != null) {\n";
		ret += "    if (popup.opener == null) {\n";
		ret += "      popup.opener = self;\n";
		ret += "    }\n";
		ret += "    popup.focus();\n";
		ret += "  }\n";
		ret += "}\n//-->\n</script>\n";
		ret += "\n<table width='100%' border='0' cellspacing='0' cellpadding='2' class='myDarkGreen'>\n"
				+ "<tr><td colspan='4' class='myGreen'>OHIP Invoice for OHIP No." + bhObj.getProvider_reg_num()
				+ "</td><td colspan='4' class='myGreen'>Payment date of " + output + "\n</td></tr>";
		ret += "\n<tr><td class='myGreen'>ACCT NO</td>"
				+ "<td width='25%' class='myGreen'>NAME</td><td class='myGreen'>RO</td><td class='myGreen'>DOB</td><td class='myGreen'>Sex</td><td class='myGreen'>HEALTH #</td>"
				+ "<td class='myGreen'>BILLDATE</td><td class='myGreen'>CODE</td>"
				+ "<td align='right' class='myGreen'>BILLED</td>"
				+ "<td align='right' class='myGreen'>DX</td><td align='right' class='myGreen'>Comment</td></tr>";
		return ret;
	}

	private String buildSiteHTMLContentHeader() {
		String ret = null;
		ret = "<script type=\"text/JavaScript\">\n<!--\nfunction popupPage(vheight,vwidth,varpage) {\n  var page = \"\" + varpage;\n";
		ret += "  windowprops = \"height=\"+vheight+\",width=\"+vwidth+\",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes,screenX=0,screenY=0,top=0,left=0\";\n";
		ret += "  var popup=window.open(page, \"billcorrection\", windowprops);\n";
		ret += "    if (popup != null) {\n";
		ret += "    if (popup.opener == null) {\n";
		ret += "      popup.opener = self;\n";
		ret += "    }\n";
		ret += "    popup.focus();\n";
		ret += "  }\n";
		ret += "}\n//-->\n</script>\n";
		ret += "\n<table width='100%' border='0' cellspacing='0' cellpadding='2' class='myIvory'>\n"
				+ "<tr><td colspan='4' class='myGreen'>OHIP Invoice for OHIP No." + bhObj.getProvider_reg_num()
				+ "</td><td colspan='5' class='myGreen'>Payment date of " + output + "\n</td></tr>";
		ret += "\n<tr><td class='myGreen'>ACCT NO</td>"
				+ "<td width='25%' class='myGreen'>NAME</td><td class='myGreen'>HEALTH #</td>"
				+ "<td class='myGreen'>BILLDATE</td><td class='myGreen'>CODE</td>"
				+ "<td align='right' class='myGreen'>BILLED</td>"
				+ "<td align='right' class='myGreen'>DX</td><td align='right' class='myGreen'>Comment</td>"
				+ "<td align='centre' class='myGreen'>SITE</td></tr>";
		return ret;
	}

	
	private String buildHTMLContentRecord(int invCount,boolean simulation) {
		String ret = null;
		ret = "";
		String styleClass = patientCount % 2 == 0 ? "myLightBlue" : "myIvory";
		if (invCount == 0) {			
			Demographic demo = demographicDao.getDemographic(ch1Obj.getDemographic_no());
			ret += "\n<tr "+(summaryView ? "style='display:none;' class='record"+providerNo+"'": "")+">"; 
			if (simulation) {
				ret += "<td class='" + styleClass + "'>"
					 + ch1Obj.getProvider_ohip_no()
					 + "</td>";				
			}
			ret += "<td class='" + styleClass + "'><a href=# onclick=\"popupPage(720,640,'billingONCorrection.jsp?billing_no="
					+ ch1Obj.getId()
					+ "');return false;\">"
					+ ch1Obj.getId()
					+ "</a></td>"
					+ "<td class='" + styleClass + "'><a href=# onclick=\"popupPage(720,740,'../../../demographic/demographiccontrol.jsp?demographic_no="
					+ ch1Obj.getDemographic_no()
					+ "&displaymode=edit&dboperation=search_detail');return false;\">"
					+ ch1Obj.getDemographic_name()
					+ "</a></td>"
					+ "<td class='" + styleClass + "'>" + demo.getRosterStatus() + "</td>"
					+ "<td class='" + styleClass + "'>" + demo.getBirthDayAsString() + "</td>"
					+ "<td class='" + styleClass + "'>" + demo.getSex() + "</td>"
					+ "<td class='" + styleClass + "'>"
					+ ch1Obj.getHin() + ch1Obj.getVer()
					+ "</td><td class='" + styleClass + "'>"
					+ ch1Obj.getBilling_date()
					+ "</td><td class='" + styleClass + "'>"
					+ itemObj.getService_code()
					+ "</td><td align='right' class='" + styleClass + "'>"
					+ itemObj.getFee()
					+ "</td><td align='right' class='" + styleClass + "'>"
					+ itemObj.getDx()
					+ "</td><td class='" + styleClass + "'> &nbsp; &nbsp;" + referral + hcFlag + m_Flag + " </td></tr>";
		} else {
			ret = "\n<tr "+(summaryView ? "style='display:none;' class='record"+providerNo+"'": "")+">"+ "<td class='" + styleClass + "'>&nbsp;</td>" + "<td class='" + styleClass + "'>&nbsp;</td> <td class='" + styleClass + "'>&nbsp;</td><td class='" + styleClass + "'>&nbsp;</td><td class='" + styleClass + "'>&nbsp;</td><td class='" + styleClass + "'>&nbsp;</td>"
					+ "<td class='" + styleClass + "'>&nbsp;</td> " + "<td class='" + styleClass + "'>"
					+ itemObj.getService_code() + "</td><td align='right' class='" + styleClass + "'>" + itemObj.getFee()
					+ "</td><td align='right' class='" + styleClass + "'>" + itemObj.getDx()
					+ "</td><td class='" + styleClass + "'>&nbsp;</td></tr>";
		}
		return ret;
	}

	private String buildSiteHTMLContentRecord(int invCount) {
		String ret = null;
		if (invCount == 0) {
			ret = "\n<tr><td class='myIvory'><a href=# onclick=\"popupPage(720,640,'billingONCorrection.jsp?billing_no="
					+ ch1Obj.getId()
					+ "');return false;\">"
					+ ch1Obj.getId()
					+ "</a></td>"
					+ "<td class='myIvory'><a href=# onclick=\"popupPage(720,740,'../../../demographic/demographiccontrol.jsp?demographic_no="
					+ ch1Obj.getDemographic_no()
					+ "&displaymode=edit&dboperation=search_detail');return false;\">"
					+ ch1Obj.getDemographic_name()
					+ "</a></td><td class='myIvory'>"
					+ ch1Obj.getHin() + ch1Obj.getVer()
					+ "</td><td class='myIvory'>"
					+ ch1Obj.getBilling_date()
					+ "</td><td class='myIvory'>"
					+ itemObj.getService_code()
					+ "</td><td align='right' class='myIvory'>"
					+ itemObj.getFee()
					+ "</td><td align='right' class='myIvory'>"
					+ itemObj.getDx()
					+ "</td><td class='myIvory'> &nbsp; &nbsp;" + referral + hcFlag + m_Flag + " </td>" 
					+ "<td bgcolor='" + clinicBgColor + "'> " + clinicShortName.get(ch1Obj.getClinic()) + "</td></tr>";
		} else {
			ret = "\n<tr><td class='myIvory'>&nbsp;</td> <td class='myIvory'>&nbsp;</td>"
					+ "<td class='myIvory'>&nbsp;</td> <td class='myIvory'>&nbsp;</td>" + "<td class='myIvory'>"
					+ itemObj.getService_code() + "</td><td align='right' class='myIvory'>" + itemObj.getFee()
					+ "</td><td align='right' class='myIvory'>" + itemObj.getDx()
					+ "</td><td class='myIvory'>&nbsp;</td>" 
					+ "<td bgcolor='" + clinicBgColor + "'> " + clinicShortName.get(ch1Obj.getClinic()) + "</td></tr>";
		}
		return ret;
	}
	private String buildHTMLContentTrailer(boolean simulation) {
		if (!simulation) {
		htmlContent += "\n<tr><td colspan='11' class='myIvory'>&nbsp;</td></tr><tr><td colspan='7' class='myIvory'>OHIP No: "
				+ bhObj.getProvider_reg_num()
				+ ": "
				+ pCount
				+ " RECORDS PROCESSED</td><td colspan='4' class='myIvory'>TOTAL: "
				+ BigTotal.toString()
				+ "\n</td></tr>" + "\n</table>";
		}
		
		String checkSummary = "";

		// Error is 0 if there is no error, otherwise 1 for a normal error, 2 for a fatal error, 3 for both.
		int error = 0 | (errorMsg.equals("") ? 0 : 1) | (errorFatalMsg.equals("") ? 0 : 2);
		String totalError = errorMsg + (error == 3 ? "<br>" : "") + errorFatalMsg;
		String errorMsgHtml = "";
		int errorCount = totalError.split("<br>").length;
		if (error > 0) { 
			if (errorCount > 3) {
				int remainingErrors = totalError.indexOf("<br>",totalError.indexOf("<br>",totalError.indexOf("<br>") + 4) + 4);
				errorMsgHtml  = "<tr><td colspan='12'><font color='black'>" 
					        + totalError.substring(0, remainingErrors) 
					        + "</font></td></tr>";
				errorMsgHtml += "<tr><td colspan='12'><font color='black'>"
							+ "<button onclick='jQuery(this).next().show();jQuery(this).hide();return false;'>Click here to see remaining "+(errorCount-3)+" results.</button>"
							+ "<div style='display:none;'>"
							+ totalError.substring(remainingErrors + 4)
							+ "</div>"
							+ "</font></td></tr>";
			}
			else {				
				errorMsgHtml = "<tr><td colspan='12'><font color='black'>" + totalError + "</font></td></tr>";
			}
		}
		if (error == 0) {
			checkSummary = simulation 
							? "\n<tr><td colspan='12'><table border='0' width='100%' bgcolor='green'><tr><td>Pass</td></tr></table></td></tr>"
							: "\n<table border='0' width='100%' bgcolor='green'><tr><td>Pass</td></tr></table>";
		}
		else {
			checkSummary = simulation
							? "\n<tr><td colspan='12' style='padding:2px;'><table border='0' width='100%' style='border: 1px dashed red'><tr style='background-color: #CCCCCC;'><td>FAIL - Please correct the errors and run this simulation again!</td></tr>"
									+ errorMsgHtml + "</table></td></tr>"
							: "\n<table border='0' width='100%' bgcolor='orange'><tr><td>Please correct the errors and run this simulation again!</td></tr></table>";
		}
		
		htmlValue += htmlContent + checkSummary;
		if (!simulation) { 
			htmlHeader = "<html><body><style type='text/css'><!-- .myGreen{  font-family: Arial, Helvetica, sans-serif;  font-size: 12px; font-style: normal;  line-height: normal;  font-weight: normal;  font-variant: normal;  text-transform: none;  color: #003366;  text-decoration: none; --></style>";
			htmlFooter = "</body></html>";
		}
		else {
			htmlValue += "<tr><td colspan='12'>&nbsp;</td></tr>";
		}
		htmlCode = htmlHeader + htmlValue + htmlFooter;
		return htmlCode;

		
	}

	private String buildSiteHTMLContentTrailer() {
		htmlContent += "\n<tr><td colspan='9' class='myIvory'>&nbsp;</td></tr><tr><td colspan='4' class='myIvory'>OHIP No: "
				+ bhObj.getProvider_reg_num()
				+ ": "
				+ pCount
				+ " RECORDS PROCESSED</td><td colspan='5' class='myIvory'>TOTAL: "
				+ BigTotal.toString()
				+ "\n</td></tr>" + "\n</table>";
		// writeFile(value);
		String checkSummary = errorMsg.equals("") ? "\n<table border='0' width='100%' bgcolor='green'><tr><td>Pass</td></tr></table>"
				: "\n<table border='0' width='100%' bgcolor='orange'><tr><td>Please correct the errors and run this simulation again!</td></tr></table>";
		htmlValue += htmlContent + checkSummary;
		htmlHeader = "<html><body><style type='text/css'><!-- .myGreen{  font-family: Arial, Helvetica, sans-serif;  font-size: 12px; font-style: normal;  line-height: normal;  font-weight: normal;  font-variant: normal;  text-transform: none;  color: #003366;  text-decoration: none; --></style>";
		htmlFooter = "</body></html>";
		htmlCode = htmlHeader + htmlValue + htmlFooter;
		return htmlCode;
	}
	
	private String buildItem() {
		String ret = itemObj.getTransc_id() + itemObj.getRec_id() + itemObj.getService_code() + space(2)
				+ rightJustify("0", 6, itemObj.getFee().replaceAll("\\.", ""))
				+ rightJustify("0", 2, itemObj.getSer_num()) + itemObj.getService_date().replaceAll("-", "")
				+ leftJustify(" ", 4, itemObj.getDx()) + space(11) + space(5) + space(2) + space(6) + space(25);
		if (ret.length() != 79)
			errorFatalMsg += "Item length wrong! - " + ch1Obj.getId() + "<br>";
		return "\n" + ret + "\r";
	}

	private String buildTrailer() {
		String ret = "\n" + "HEE" + rightJustify("0", 4, pCount) + rightJustify("0", 4, hcCount)
				+ rightJustify("0", 5, rCount) + space(63) + "\r";
		return ret;
	}

	private void checkHeader1() {
		if (!ch1Obj.getRef_num().equals("") && ch1Obj.getRef_num().length() != 6)
			errorPartMsg = "Header1: Referral Doc. No. wrong!<br>";
		if (ch1Obj.getVisittype() != null && ch1Obj.getVisittype().compareTo("00") != 0) {
			if ((ch1Obj.getFacilty_num() != null && ch1Obj.getFacilty_num().length() != 4)
					|| ch1Obj.getFacilty_num() == null) {
				errorPartMsg += "Header1: outPatient Visit. wrong!<br>";
			}
		}
		if (ch1Obj.getVer() != null && (ch1Obj.getVer().length() > 2 || "##".equals(ch1Obj.getVer())))
			errorPartMsg += "Header1: Ver. code wrong!<br>";
		
		errorMsg += errorPartMsg;
	}

	private void checkHeader2() {
		/*
		 * if (hcHin.length() == 0 || hcHin.length() > 12) errorPartMsg +=
		 * "Header2: Reg. No. wrong!<br>"; if (hcLast.length() == 0)
		 * errorPartMsg += "Header2: Patient's Lastname wrong!<br>"; if
		 * (hcFirst.length() == 0) errorPartMsg += "Header2: Patient's Firstname
		 * wrong!<br>"; if (!(demoSex.equals("1") || demoSex.equals("2")))
		 * errorPartMsg += "Header2: Patient's Sex Code wrong! (1 or 2)<br>";
		 * if (hcType.length() != 2 || !(hcType.equals("AB") ||
		 * hcType.equals("BC") || hcType.equals("MB") || hcType.equals("NL") ||
		 * hcType.equals("NB") || hcType.equals("NT") || hcType.equals("NS") ||
		 * hcType.equals("PE") || hcType.equals("SK") || hcType.equals("YT")))
		 * errorPartMsg += "Header2: Patient's Province Code wrong!<br>";
		 * errorMsg += errorPartMsg;
		 */
	}

	private void checkItem() {
		if (itemObj.getService_code().trim().length() != 5)
			errorPartMsg = "Item: Service Code wrong!<br>";
		errorMsg += errorPartMsg;
	}

	private void checkNoDetailRecord(int invCount) {
		if (invCount == 0)
			errorPartMsg = "The billing no:" + ch1Obj.getId() + " should be marked as 'Delete'.<br>";
		errorMsg += errorPartMsg;
	}

	private String printErrorPartMsg() {
		String ret = "";
		ret = errorPartMsg.length() > 0 ? ("\n<tr bgcolor='yellow'><td colspan='11'><font color='red'>" + errorPartMsg + "</font></td></tr>")
				: "";
		errorPartMsg = "";
		return ret;
	}
	
	private String printSiteErrorPartMsg() {
		String ret = "";
		ret = errorPartMsg.length() > 0 ? ("\n<tr bgcolor='yellow'><td colspan='9'><font color='red'>" + errorPartMsg + "</font></td></tr>")
				: "";
		errorPartMsg = "";
		return ret;
	}

	public void createBillingFileStr(String bid, String status) {
		createBillingFileStr(bid,status,false);
	}
	
	public void createBillingFileStr(String bid, String status, boolean simulation) {
		createBillingFileStr(bid, status, simulation, null);
	}
	public void createBillingFileStr(String bid, String status, boolean simulation, String mohOffice) {
		createBillingFileStr(bid, status, simulation, mohOffice, false);
	}
	
	public void createBillingFileStr(String bid, String status, boolean simulation, String mohOffice, boolean summaryView) {
		createBillingFileStr(bid, status, simulation, mohOffice, summaryView, false);		
	}
	public void createBillingFileStr(String bid, String status, boolean simulation, String mohOffice, boolean summaryView, boolean useProviderMOH) {
		this.summaryView = summaryView;
		try {
			if (!"0".equals(bid)) { // for simulation only
				getBatchHeaderObj(bid);
				if (useProviderMOH) {
					ProviderBillCenter pbc = new ProviderBillCenter();
					String billCenter = pbc.getBillCenter(providerNo);
					if (billCenter != null && billCenter.length() == 1) {
						bhObj.setMoh_office(billCenter);						
					}
					else {
						bhObj.setMoh_office(mohOffice);
					}
				}
				else if (mohOffice != null) {
					bhObj.setMoh_office(mohOffice);
				}
			}
			
			if (!simulation) {
				checkBatchHeader();
				batchHeader = buildBatchHeader();
				htmlValue = buildHTMLContentHeader();
			}
			// start here
			value = batchHeader;
			BillingONDataHelp dbObj = new BillingONDataHelp();
			
			
			BigDecimal proTotal = new BigDecimal(0.0).setScale(2, BigDecimal.ROUND_HALF_UP);
			int proItem = 0;
			String ohipNo = "";

			// (status='O' or status='W')
			query = "select * from billing_on_cheader1 where provider_no='" + providerNo + "' and  " + status + " "
					+ dateRange + " and pay_program in ('HCP', 'WCB', 'RMB') order by billing_date, billing_time";
			_logger.info("createBillingFileStr(sql = " + query + ")");
			ResultSet rs = dbObj.searchDBRecord(query);
			
			while (rs.next()) {
				// recreate judge
				String bNo = "" + rs.getInt("id");
				if(propBillingNo != null && !propBillingNo.containsKey(bNo)) {
					continue;
				}
				
				patientCount++;
				ch1Obj = new BillingClaimHeader1Data();
				ch1Obj.setId(bNo);
				ch1Obj.setTransc_id(rs.getString("transc_id"));
				ch1Obj.setRec_id(rs.getString("rec_id"));
				ch1Obj.setHin(rs.getString("hin"));
				ch1Obj.setVer(rs.getString("ver"));
				ch1Obj.setDob(rs.getString("dob"));

				ch1Obj.setPay_program(rs.getString("pay_program"));
				ch1Obj.setPayee(rs.getString("payee"));
				ch1Obj.setRef_num(rs.getString("ref_num"));
				ch1Obj.setFacilty_num(rs.getString("facilty_num"));
				ch1Obj.setAdmission_date(rs.getString("admission_date"));
				ch1Obj.setRef_lab_num(rs.getString("ref_lab_num"));
				ch1Obj.setMan_review(rs.getString("man_review"));
				ch1Obj.setLocation(rs.getString("location"));

				ch1Obj.setDemographic_no(rs.getString("demographic_no"));
				ch1Obj.setProviderNo(rs.getString("provider_no"));
				ch1Obj.setAppointment_no(rs.getString("appointment_no"));
				ch1Obj.setDemographic_name(rs.getString("demographic_name"));
				// String temp[] =
				// getPatientLF(val.getParameter("demographic_name"));
				// ch1Obj.setLast_name(rs.getString("transc_id"));
				// ch1Obj.setFirst_name(rs.getString("transc_id"));
				ch1Obj.setSex(rs.getString("sex"));
				ch1Obj.setProvince(rs.getString("province"));

				ch1Obj.setBilling_date(rs.getString("billing_date"));
				ch1Obj.setBilling_time(rs.getString("billing_time"));
				// ch1Obj.setUpdate_datetime(rs.getString("transc_id"));
				ch1Obj.setTotal(rs.getString("total"));
				ch1Obj.setPaid(rs.getString("paid"));
				ch1Obj.setStatus(rs.getString("status"));
				ch1Obj.setComment(rs.getString("comment1"));
				ch1Obj.setVisittype(rs.getString("visittype"));
				ch1Obj.setProvider_ohip_no(rs.getString("provider_ohip_no"));
				ohipNo = ch1Obj.getProvider_ohip_no();
				ch1Obj.setProvider_rma_no(rs.getString("provider_rma_no"));
				ch1Obj.setApptProvider_no(rs.getString("apptProvider_no"));
				ch1Obj.setAsstProvider_no(rs.getString("asstProvider_no"));
				ch1Obj.setCreator(rs.getString("creator"));
				
				ch1Obj.setClinic(rs.getString("clinic"));

				// invNo = rs.getString("id");
				// ohipVer = rs.getString("organization_spec_code");
				// inPatient = rs.getString("clinic_no");
				// if there is no clinic no for a clinic, it should be an empty
				// str
				// inPatient = "0".equals(inPatient) ? " " : inPatient;
				// demoName = rs.getString("demographic_name");
				// hin = rs.getString("hin");
				//dob = rs.getString("dob");
				// visitDate = rs.getDate("visitdate");
				// visitType = rs.getString("visittype");
				// outPatient = rs.getString("clinic_ref_code");
				// specCode = rs.getString("status");
				// content = rs.getString("content");
				value += buildHeader1();
				if (!simulation) {
					htmlContent += printErrorPartMsg();
				} else {
					errorPartMsg = "";
				}
			
				// build billing detail
				invCount = 0;
				query = "select * from billing_on_item where ch1_id=" + ch1Obj.getId()
						+ " and status!='D' and status!='S'";
				_logger.info("createBillingFileStr(sql = " + query + ")");
				ResultSet rs2 = dbObj.searchDBRecord(query);
				boolean hasSliCode = ch1Obj.getLocation().trim().length() == 3;
				while (rs2.next()) {
					itemObj = new BillingItemData();
					recordCount++;
					// int count = 0;

					itemObj.setTransc_id(rs2.getString("transc_id"));
					itemObj.setRec_id(rs2.getString("rec_id"));
					itemObj.setService_code(rs2.getString("service_code"));
					itemObj.setFee(rs2.getString("fee"));
					itemObj.setSer_num(rs2.getString("ser_num"));
					itemObj.setService_date(rs2.getString("service_date"));
					diagcode = rs2.getString("dx");
					diagcode = ":::".equals(diagcode) ? "   " : diagcode;
					itemObj.setDx(diagcode);
					itemObj.setDx1(rs2.getString("dx1"));
					itemObj.setDx2(rs2.getString("dx2"));
					itemObj.setStatus(rs2.getString("status"));

					// serviceCode = rs2.getString("service_code");
					fee = rs2.getString("fee");
					// appt = rs2.getDate("appointment_date").toString();
					// billingUnit = rs2.getString("billingunit");
					// count = 6 - fee.length();
					// apptDate =
					// UtilDateUtilities.DateToString(rs2.getDate("appointment_date"),
					// "yyyyMMdd");
					if (!hasSliCode) {
						BillingServiceDao bsd = (BillingServiceDao) SpringUtils.getBean("billingServiceDao");
						if (bsd.codeRequiresSLI(itemObj.getService_code())) {
							errorPartMsg = "Service code '"+itemObj.getService_code()+"' requires an SLI code. <br/>";
						}
					}
					
					if (fee == null || fee.length() == 0)
						fee = "0.0";

					dFee = Double.parseDouble(fee);
					bdFee = new BigDecimal(dFee).setScale(2, BigDecimal.ROUND_HALF_UP);
					proTotal = proTotal.add(bdFee);
					BigTotal = BigTotal.add(bdFee);					
					_logger.info("createBillingFileStr(BigTotal = " + BigTotal + ")");
					checkItem();
					value += buildItem();
					_logger.info("createBillingFileStr(value = " + value + ")");
					htmlContent += buildHTMLContentRecord(invCount,simulation);
					if (!simulation) {
						htmlContent += printErrorPartMsg();
					} else {
						errorPartMsg = "";
					}
					invCount++;
					proItem++;
				}
				checkNoDetailRecord(invCount);
				if (!simulation) {
					htmlContent += printErrorPartMsg();
				} else {
					errorPartMsg = "";					
				}
				if (eFlag.compareTo("1") == 0) {
					updateHeader1BilledBatchId(ch1Obj.getId(), bhObj.getId());
				}
			}
			hcCount = hcCount + healthcardCount;
			pCount = pCount + patientCount;
			rCount = rCount + recordCount;
			// percent = new BigDecimal((double) 0.01).setScale(2,
			// BigDecimal.ROUND_HALF_UP);
			// BigTotal = BigTotal.multiply(percent);
			
			if (summaryView) {
				String items = htmlContent;
				htmlContent = "<tr><td class='myIvory'>"+ohipNo+"</td><td class='myIvory'>"+proItem+"</td><td class='myIvory'>"+proTotal.toString()+"</td><td class='myIvory' colspan='6'><button id='recordShowButton"+providerNo+"' onclick='jQuery(\".record"+providerNo+"\").show();jQuery(this).hide();jQuery(\"#recordHideButton"+providerNo+"\").show();return false;'>Show record details.</button><button id='recordHideButton"+providerNo+"' style='display:none;' onclick='jQuery(\".record"+providerNo+"\").hide();jQuery(this).hide();jQuery(\"#recordShowButton"+providerNo+"\").show();return false;'>Hide record details.</button></td></tr>";
				htmlContent  += "\n<tr style='display:none;' class='record"+providerNo+"'><td class='myGreen'>OHIP NO</td><td class='myGreen'>ACCT NO</td>"
						+ "<td width='25%' class='myGreen'>NAME</td><td class='myGreen'>RO</td><td class='myGreen'>DOB</td><td class='myGreen'>Sex</td><td class='myGreen'>HEALTH #</td>"
						+ "<td class='myGreen'>BILLDATE</td><td class='myGreen'>CODE</td>"
						+ "<td align='right' class='myGreen'>BILLED</td>"
						+ "<td align='right' class='myGreen'>DX</td><td align='right' class='myGreen'>Comment</td></tr>";
				htmlContent += items;				
			}
			
			BigTotal = BigTotal.setScale(2, BigDecimal.ROUND_HALF_UP);
			value += buildTrailer();

			htmlCode = buildHTMLContentTrailer(simulation);
			// writeHtml(htmlCode);
			ohipReciprocal = String.valueOf(hcCount);
			ohipRecord = String.valueOf(rCount);
			ohipClaim = String.valueOf(pCount);
			totalAmount = BigTotal.toString();
			if (eFlag.compareTo("1") == 0) {
				updateBatchHeaderSum(bhObj.getId(), "" + healthcardCount, "" + patientCount, "" + recordCount);
			}
		} catch (SQLException e) {
			_logger.error("JdbcBillingCreateBillingFile(sql = " + query + ")");
		}
	}

	public void createSiteBillingFileStr(String bid, String status) {
		
		SiteDao siteDao = (SiteDao)SpringUtils.getBean("siteDao");
		
		try {
			if (!"0".equals(bid)) { // for simulation only
				getBatchHeaderObj(bid);
			}
			checkBatchHeader();
			batchHeader = buildBatchHeader();
			htmlValue = buildSiteHTMLContentHeader();
			// start here
			value = batchHeader;
			BillingONDataHelp dbObj = new BillingONDataHelp();
			// (status='O' or status='W')
			query = "select * from billing_on_cheader1 where provider_no='" + providerNo + "' and  " + status + " "
					+ dateRange + " and pay_program in ('HCP', 'WCB', 'RMB') order by billing_date, billing_time";
			_logger.info("createBillingFileStr(sql = " + query + ")");
			ResultSet rs = dbObj.searchDBRecord(query);
			while (rs.next()) {
				// recreate judge
				String bNo = "" + rs.getInt("id");
				if(propBillingNo != null && !propBillingNo.containsKey(bNo)) {
					continue;
				}
				
				patientCount++;
				ch1Obj = new BillingClaimHeader1Data();
				ch1Obj.setId(bNo);
				ch1Obj.setTransc_id(rs.getString("transc_id"));
				ch1Obj.setRec_id(rs.getString("rec_id"));
				ch1Obj.setHin(rs.getString("hin"));
				ch1Obj.setVer(rs.getString("ver"));
				ch1Obj.setDob(rs.getString("dob"));

				ch1Obj.setPay_program(rs.getString("pay_program"));
				ch1Obj.setPayee(rs.getString("payee"));
				ch1Obj.setRef_num(rs.getString("ref_num"));
				ch1Obj.setFacilty_num(rs.getString("facilty_num"));
				ch1Obj.setAdmission_date(rs.getString("admission_date"));
				ch1Obj.setRef_lab_num(rs.getString("ref_lab_num"));
				ch1Obj.setMan_review(rs.getString("man_review"));
				ch1Obj.setLocation(rs.getString("location"));

				ch1Obj.setDemographic_no(rs.getString("demographic_no"));
				ch1Obj.setProviderNo(rs.getString("provider_no"));
				ch1Obj.setAppointment_no(rs.getString("appointment_no"));
				ch1Obj.setDemographic_name(rs.getString("demographic_name"));
				// String temp[] =
				// getPatientLF(val.getParameter("demographic_name"));
				// ch1Obj.setLast_name(rs.getString("transc_id"));
				// ch1Obj.setFirst_name(rs.getString("transc_id"));
				ch1Obj.setSex(rs.getString("sex"));
				ch1Obj.setProvince(rs.getString("province"));

				ch1Obj.setBilling_date(rs.getString("billing_date"));
				ch1Obj.setBilling_time(rs.getString("billing_time"));
				// ch1Obj.setUpdate_datetime(rs.getString("transc_id"));
				ch1Obj.setTotal(rs.getString("total"));
				ch1Obj.setPaid(rs.getString("paid"));
				ch1Obj.setStatus(rs.getString("status"));
				ch1Obj.setComment(rs.getString("comment1"));
				ch1Obj.setVisittype(rs.getString("visittype"));
				ch1Obj.setProvider_ohip_no(rs.getString("provider_ohip_no"));
				ch1Obj.setProvider_rma_no(rs.getString("provider_rma_no"));
				ch1Obj.setApptProvider_no(rs.getString("apptProvider_no"));
				ch1Obj.setAsstProvider_no(rs.getString("asstProvider_no"));
				ch1Obj.setCreator(rs.getString("creator"));
				
				ch1Obj.setClinic(rs.getString("clinic"));
				if (ch1Obj.getClinic() == null || ch1Obj.getClinic().equalsIgnoreCase("null")) {
					ch1Obj.setClinic("");
					clinicBgColor = "FFFFFF";
				}
				else {
					clinicBgColor = siteDao.getByLocation(ch1Obj.getClinic()).getBgColor();
					clinicBgColor = (clinicBgColor == null || clinicBgColor.equalsIgnoreCase("null") ? "FFFFFF" : clinicBgColor);
				}
				
				// invNo = rs.getString("id");
				// ohipVer = rs.getString("organization_spec_code");
				// inPatient = rs.getString("clinic_no");
				// if there is no clinic no for a clinic, it should be an empty
				// str
				// inPatient = "0".equals(inPatient) ? " " : inPatient;
				// demoName = rs.getString("demographic_name");
				// hin = rs.getString("hin");
				// dob = rs.getString("dob");
				// visitDate = rs.getDate("visitdate");
				// visitType = rs.getString("visittype");
				// outPatient = rs.getString("clinic_ref_code");
				// specCode = rs.getString("status");
				// content = rs.getString("content");
				value += buildHeader1();
				htmlContent += printSiteErrorPartMsg();
				// build billing detail
				invCount = 0;
				query = "select * from billing_on_item where ch1_id=" + ch1Obj.getId()
						+ " and status!='D' and status!='S'";
				_logger.info("createBillingFileStr(sql = " + query + ")");
				ResultSet rs2 = dbObj.searchDBRecord(query);
				while (rs2.next()) {
					itemObj = new BillingItemData();
					recordCount++;
					// int count = 0;

					itemObj.setTransc_id(rs2.getString("transc_id"));
					itemObj.setRec_id(rs2.getString("rec_id"));
					itemObj.setService_code(rs2.getString("service_code"));
					itemObj.setFee(rs2.getString("fee"));
					itemObj.setSer_num(rs2.getString("ser_num"));
					itemObj.setService_date(rs2.getString("service_date"));
					diagcode = rs2.getString("dx");
					diagcode = ":::".equals(diagcode) ? "   " : diagcode;
					itemObj.setDx(diagcode);
					itemObj.setDx1(rs2.getString("dx1"));
					itemObj.setDx2(rs2.getString("dx2"));
					itemObj.setStatus(rs2.getString("status"));

					// serviceCode = rs2.getString("service_code");
					fee = rs2.getString("fee");
					// appt = rs2.getDate("appointment_date").toString();
					// billingUnit = rs2.getString("billingunit");
					// count = 6 - fee.length();
					// apptDate =
					// UtilDateUtilities.DateToString(rs2.getDate("appointment_date"),
					// "yyyyMMdd");
					dFee = Double.parseDouble(fee);
					bdFee = new BigDecimal(dFee).setScale(2, BigDecimal.ROUND_HALF_UP);
					BigTotal = BigTotal.add(bdFee);
					_logger.info("createBillingFileStr(BigTotal = " + BigTotal + ")");
					checkItem();
					value += buildItem();
					_logger.info("createBillingFileStr(value = " + value + ")");
					htmlContent += buildSiteHTMLContentRecord(invCount);
					htmlContent += printSiteErrorPartMsg();
					invCount++;
				}
				checkNoDetailRecord(invCount);
				htmlContent += printSiteErrorPartMsg();
				if (eFlag.compareTo("1") == 0) {
					updateHeader1BilledBatchId(ch1Obj.getId(), bhObj.getId());
				}
			}
			hcCount = hcCount + healthcardCount;
			pCount = pCount + patientCount;
			rCount = rCount + recordCount;
			// percent = new BigDecimal((double) 0.01).setScale(2,
			// BigDecimal.ROUND_HALF_UP);
			// BigTotal = BigTotal.multiply(percent);
			BigTotal = BigTotal.setScale(2, BigDecimal.ROUND_HALF_UP);
			value += buildTrailer();

			htmlCode = buildSiteHTMLContentTrailer();
			// writeHtml(htmlCode);
			ohipReciprocal = String.valueOf(hcCount);
			ohipRecord = String.valueOf(rCount);
			ohipClaim = String.valueOf(pCount);
			totalAmount = BigTotal.toString();
			if (eFlag.compareTo("1") == 0) {
				updateBatchHeaderSum(bhObj.getId(), "" + healthcardCount, "" + patientCount, "" + recordCount);
			}
		} catch (SQLException e) {
			_logger.error("JdbcBillingCreateBillingFile(sql = " + query + ")");
		}
	}
	
	public String getHtmlCode() {
		return htmlCode;
	}

	public String getHtmlValue() {
		return htmlValue;
	}

	public String getOhipClaim() {
		return ohipClaim;
	}

	public String getOhipReciprocal() {
		return ohipReciprocal;
	}

	public String getOhipRecord() {
		return ohipRecord;
	}

	public String getOhipVer() {
		return ohipVer;
	}

	public String getTotalAmount() {
		return totalAmount;
	}

	public String getValue() {
		return value;
	}

	public void updateHeader1BilledBatchId(String newInvNo, String batchId) {
		BillingONDataHelp dbObj = new BillingONDataHelp();
		String sql = "update billing_on_cheader1 set status='B',header_id=" + batchId + " where id=" + newInvNo + "";
		dbObj.updateDBRecord(sql);
	}

	private void updateBatchHeaderSum(String bid, String hn, String rn, String tn) {
		BillingONDataHelp dbObj = new BillingONDataHelp();
		String sql = "update billing_on_header set h_count='" + hn + "', r_count='" + rn + "', t_count='" + tn
				+ "' where id=" + bid;
		_logger.info("JdbcBillingCreateBillingFile(sql = " + sql + ")");
		dbObj.updateDBRecord(sql);
	}

	public void updateDisknameSum(int bid) {
		BillingONDataHelp dbObj = new BillingONDataHelp();
		String sql = "update billing_on_filename set claimrecord='" + (healthcardCount + patientCount) + "/"
				+ recordCount + "', total='" + totalAmount + "' where disk_id=" + bid + " and providerno='"
				+ providerNo + "'";
		_logger.info("JdbcBillingCreateBillingFile(sql = " + sql + ")");
		dbObj.updateDBRecord(sql);
	}

	private void updateDemoData(BillingClaimHeader1Data chObj) {
                // last_name,first_name,dob,hin,ver,hc_type,sex
		List vecStr = (new JdbcBillingPageUtil()).getPatientCurBillingDemo(chObj.getDemographic_no());
                
                //Bonus Billing (Incentives)? Block out patient data : update with patient data
                if( chObj.getStatus().equals("I") ) {
                    ch1Obj.setDemographic_name("");
                    ch1Obj.setDob("");
                    ch1Obj.setHin("");
                    ch1Obj.setVer("");
                    ch1Obj.setProvince("ON");
                    ch1Obj.setSex("");                    
                }
                else {
                    ch1Obj.setDemographic_name(vecStr.get(0) + "," + vecStr.get(1));
                    ch1Obj.setDob((String) vecStr.get(2));
                    ch1Obj.setHin((String) vecStr.get(3));
                    ch1Obj.setVer((String) vecStr.get(4));
                    ch1Obj.setProvince((String) vecStr.get(5));
                    ch1Obj.setSex((String) vecStr.get(6));
                }
		
		if (!"ON".equals(ch1Obj.getProvince()) && !"".equals(ch1Obj.getProvince()))
			ch1Obj.setPay_program("RMB");
	}

	public void getBatchHeaderObj(String bid) {
		BillingONDataHelp dbObj = new BillingONDataHelp();
		String sql = "select * from billing_on_header where id=" + bid;
		ResultSet rs = dbObj.searchDBRecord(sql);
		try {
			while (rs.next()) {
				bhObj = new BillingBatchHeaderData();
				bhObj.setId(bid);
				bhObj.setDisk_id("" + rs.getInt("disk_id"));
				bhObj.setTransc_id(rs.getString("transc_id"));
				bhObj.setRec_id(rs.getString("rec_id"));
				bhObj.setSpec_id(rs.getString("spec_id"));
				bhObj.setMoh_office(rs.getString("moh_office"));

				bhObj.setBatch_id(rs.getString("batch_id"));
				bhObj.setOperator(rs.getString("operator"));
				bhObj.setGroup_num(rs.getString("group_num"));
				bhObj.setProvider_reg_num(rs.getString("provider_reg_num"));
				bhObj.setSpecialty(rs.getString("specialty"));
				bhObj.setH_count(rs.getString("h_count"));
				bhObj.setR_count(rs.getString("r_count"));
				bhObj.setT_count(rs.getString("t_count"));
				bhObj.setBatch_date(rs.getString("batch_date"));
			}
		} catch (SQLException e) {
			_logger.error("JdbcBillingCreateBillingFile(sql = " + sql + ")");
		}

		setOhipFilename(getOhipFilename(bhObj.getDisk_id()));
	}

	public void setBatchHeaderObj(BillingBatchHeaderData value) {
		bhObj = value;
		setOhipFilename(getOhipFilename(bhObj.getDisk_id()));
	}

	public String getOhipFilename(String id) {
		String ret = null;
		BillingONDataHelp dbObj = new BillingONDataHelp();
		String sql = "select * from billing_on_diskname where id=" + id;
		ResultSet rs = dbObj.searchDBRecord(sql);
		try {
			while (rs.next()) {
				ret = rs.getString("ohipfilename");
			}
		} catch (SQLException e) {
			_logger.error("getOhipFilename(sql = " + sql + ")");
		}
		return ret;
	}

	// public synchronized void setBatchCount(String newBatchCount) {
	// batchCount = newBatchCount;
	// }

	public synchronized void setDateRange(String newDateRange) {
		dateRange = newDateRange;
	}

	// flag 0 - nothing ??? 1 - set as billed.
	public synchronized void setEFlag(String neweFlag) {
		eFlag = neweFlag;
	}

	public synchronized void setHtmlFilename(String newHtmlFilename) {
		htmlFilename = newHtmlFilename;
	}

	public synchronized void setOhipFilename(String newOhipFilename) {
		ohipFilename = newOhipFilename;
	}

	public synchronized void setOhipVer(String newOhipVer) {
		ohipVer = newOhipVer;
	}

	public synchronized void setProviderNo(String newProviderNo) {
		providerNo = newProviderNo;
	}

	// return i space str, e.g. " "
	public String space(int i) {
		String returnValue = new String();
		for (int j = 0; j < i; j++) {
			returnValue += " ";
		}
		return returnValue;
	}

	// readin billingNo 
	public void readInBillingNo() {
		String home_dir;
		home_dir = OscarProperties.getInstance().getProperty("HOME_DIR");
		propBillingNo = new Properties();
		
		try {
			RandomAccessFile raf = new RandomAccessFile(home_dir + ohipFilename, "r");
			do {
				String lineValue = raf.readLine();
				if(lineValue == null) {
					break;
				}
				if (lineValue.startsWith("HEH")) {
					// consider different cases
					String bNo = "-1";
					if(lineValue.length() == 79 && lineValue.substring(31,34).matches("HCP|WCB|RMB")) {
						bNo = lineValue.substring(23,31);
					} else {
						int nt = 0;
						if(lineValue.indexOf("HCPP")>0) nt = lineValue.indexOf("HCPP");
						if(lineValue.indexOf("WCBP")>0) nt = lineValue.indexOf("WCBP");
						if(lineValue.indexOf("RMBP")>0) nt = lineValue.indexOf("RMBP");
						bNo = lineValue.substring(nt-8,nt);
					}

					bNo = "" + Integer.parseInt(bNo);
					
					propBillingNo.setProperty(bNo, "");
				}
			} while (true);
			raf.close();
			
		} catch (Exception e) {
			_logger.error("Read OHIP File Error");
		}
	}

	// rename OHIP file 
	public void renameFile() {
		String home_dir;
		home_dir = OscarProperties.getInstance().getProperty("HOME_DIR");
	    File file = new File(home_dir + ohipFilename);
		
	    // new filename
	    String newName = ohipFilename + "." + GregorianCalendar.getInstance().getTimeInMillis();

	    File file2 = new File(home_dir + newName);
		
	    boolean success = file.renameTo(file2);
	    if (!success) {
	    	_logger.error("Rename OHIP File Error");
	    }
	}

	// write OHIP file to it
	public void writeFile(String value1) {
		try {
			String home_dir;
			home_dir = OscarProperties.getInstance().getProperty("HOME_DIR");
			FileOutputStream out = new FileOutputStream(home_dir + ohipFilename);
			PrintStream p = new PrintStream(out);
			p.println(value1);

			p.close();
			out.close();
		} catch (Exception e) {
			_logger.error("Write OHIP File Error");
		}
	}

	// get path from the property file, e.g.
	// OscarDocument/.../billing/download/, and then write to it
	public void writeHtml(String htmlvalue1) {
		try {
			String home_dir1;
			home_dir1 = OscarProperties.getInstance().getProperty("HOME_DIR");

			FileOutputStream out1 = new FileOutputStream(home_dir1 + htmlFilename);
			PrintStream p1 = new PrintStream(out1);
			p1.println(htmlvalue1);

			p1.close();
			out1.close();
		} catch (Exception e) {
			_logger.error("Write HTML File Error!!!");
		}
	}

	// return x zero str, e.g. 000000
	public String zero(int x) {
		String returnZeroValue = new String();
		for (int y = 0; y < x; y++) {
			returnZeroValue += "0";
		}
		return returnZeroValue;
	}

	// return x length string with zero str, e.g. 0018
	public String forwardZero(String y, int x) {
		// x must >= y.length()
		String returnZeroValue = "";
		for (int i = y.length(); i < x; i++) {
			returnZeroValue += "0";
		}

		return (returnZeroValue + y);
	}

	// return x length string with zero str, e.g. 1800
	public String leftJustify(String y, int x, String z) {
		// x must >= y.length()
		if(z != null && z.length() > x) {
			z = z.substring(0, x);
		}
		
		String returnZeroValue = "";
		for (int i = 0; i < x; i++) {
			returnZeroValue += y;
		}
		returnZeroValue = z + returnZeroValue.substring(z.length());

		return (returnZeroValue);
	}

	public String rightJustify(String y, int x, String z) {
		// x must >= y.length()
		String returnZeroValue = "";
		for (int i = 0; i < x; i++) {
			returnZeroValue += y;
		}
		returnZeroValue = returnZeroValue.substring(0, x - z.length()) + z;

		return (returnZeroValue);
	}

	private String getCompactDateStr(String y) {
		String ret = y;
		if (y.length() > 6) {
			String[] temp = y.split("\\-");
			if (temp.length == 3) {
				ret = temp[0] + (temp[1].length() == 1 ? ("0" + temp[1]) : temp[1])
						+ (temp[2].length() == 1 ? ("0" + temp[2]) : temp[2]);
			}
		}
		return ret;
	}

	public BillingBatchHeaderData getBhObj() {
		return bhObj;
	}

	public void setBhObj(BillingBatchHeaderData bhObj) {
		this.bhObj = bhObj;
	}

	public BillingClaimHeader1Data getCh1Obj() {
		return ch1Obj;
	}

	public void setCh1Obj(BillingClaimHeader1Data ch1Obj) {
		this.ch1Obj = ch1Obj;
	}

	public String getHtmlContent() {
		return htmlContent;
	}

	public void setHtmlContent(String htmlContent) {
		this.htmlContent = htmlContent;
	}

}
