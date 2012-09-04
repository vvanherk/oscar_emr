<%--

    Copyright (c) 2006-. OSCARservice, OpenSoft System. All Rights Reserved.
    This software is published under the GPL GNU General Public License.
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

--%>
<%@page import="java.util.List, java.util.Collections, java.util.Comparator, java.util.Date, java.text.SimpleDateFormat, java.text.NumberFormat" %>
<%@page import="org.oscarehr.util.SpringUtils, org.oscarehr.common.dao.OscarAppointmentDao, org.oscarehr.common.model.Appointment" %>

<%@page import="org.oscarehr.billing.CA.ON.dao.BillingClaimDAO" %>
<%@page import="org.oscarehr.common.dao.BillingServiceDao" %>

<%@page import="org.oscarehr.billing.CA.ON.model.BillingClaimHeader1" %>
<%@page import="org.oscarehr.billing.CA.ON.model.BillingItem" %>
<%@page import="org.oscarehr.common.model.BillingService" %>

<%@page import="oscar.oscarBilling.ca.on.data.BillingDataHlp" %>

<%@page import="org.oscarehr.util.MiscUtils"%>


<% OscarAppointmentDao appointmentDao = (OscarAppointmentDao)SpringUtils.getBean("oscarAppointmentDao"); %>
<% BillingClaimDAO billingClaimDAO = (BillingClaimDAO)SpringUtils.getBean("billingClaimDAO"); %>
<% BillingServiceDao billingServiceDao = (BillingServiceDao)SpringUtils.getBean("billingServiceDao"); %>

<%! boolean bMultisites = org.oscarehr.common.IsPropertiesOn.isMultisitesEnable(); %>

<%@ taglib uri="/WEB-INF/security.tld" prefix="security"%>
<%
    if(session.getAttribute("userrole") == null )  response.sendRedirect("../logout.jsp");
    String roleName$ = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
	boolean isTeamBillingOnly=false; 
%>
<security:oscarSec objectName="_team_billing_only" roleName="<%= roleName$ %>" rights="r" reverse="false">
<% isTeamBillingOnly=true; %>
</security:oscarSec>

<%    
if(session.getAttribute("user") == null) response.sendRedirect("../logout.jsp");
String user_no = (String) session.getAttribute("user");


int nItems=0;
String strLimit1="0";
String strLimit2="50";
if(request.getParameter("limit1")!=null) strLimit1 = request.getParameter("limit1");
if(request.getParameter("limit2")!=null) strLimit2 = request.getParameter("limit2");
String providerview = request.getParameter("providerview")==null?"all":request.getParameter("providerview") ;
%>

<%@ page
	import="java.util.*, java.sql.*, oscar.login.*, oscar.*, java.net.*"
	errorPage="../errorpage.jsp"%>
<%@ include file="../../../../admin/dbconnection.jsp"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />
<jsp:useBean id="SxmlMisc" class="oscar.SxmlMisc" scope="session" />
<%@ include file="../dbBilling.jspf"%>

<%
GregorianCalendar now=new GregorianCalendar(); 
int curYear = now.get(Calendar.YEAR);
int curMonth = (now.get(Calendar.MONTH)+1);
int curDay = now.get(Calendar.DAY_OF_MONTH);

String xml_vdate = request.getParameter("xml_vdate") == null ? "" : request.getParameter("xml_vdate");
String xml_appointment_date = request.getParameter("xml_appointment_date") == null? "" : request.getParameter("xml_appointment_date");
%>

<%
// action
ArrayList<String> vecHeader = new ArrayList<String>();
ArrayList<Properties> vecValue = new ArrayList<Properties>();
List< List<BillingClaimHeader1> > vecBills = new ArrayList< List<BillingClaimHeader1> >();
ArrayList<String> vecDemographicNo = new ArrayList<String>();
ArrayList<String> vecAppointmentNo = new ArrayList<String>();
ArrayList<String> vecProviderNo = new ArrayList<String>();
ArrayList<String> vecTotal = new ArrayList<String>();

Properties prop = null;
ResultSet rs = null;
String sql = null;

boolean editable = true;

// handle saving of submitted bills
if (request.getParameter("submit_billing") != null) {
	String tempNumberOfBills = request.getParameter("number_of_bills");
	int numBills = 0;
	try {
		numBills = Integer.parseInt(tempNumberOfBills);
	} catch (Exception e) {
	}
	//MiscUtils.getLogger().info("numbills: " + numBills);
	for (int i=0; i < numBills; i++) {
		String billId = request.getParameter("bill_id"+i);
		String apptNo = request.getParameter("appt_no"+i);
		Integer demoNo = null;
		try {
			demoNo = Integer.parseInt(request.getParameter("demo_no"+i));
		} catch (Exception e) {
			MiscUtils.getLogger().error("Invalid demographic number:", e);
		}
		String provNo = request.getParameter("prov_no"+i);
		boolean billSaved = (request.getParameter("bill_saved"+i) != null);
		String billDate = request.getParameter("bill_date"+i);
		String billTime = request.getParameter("bill_time"+i);
		String demoName = request.getParameter("demo_name"+i);
		String[] billCodes = request.getParameterValues("bill_code"+i);
		String[] amounts = request.getParameterValues("amount"+i);
		String[] units = request.getParameterValues("units"+i);
		String[] dxCodes = request.getParameterValues("dx_code"+i);
		String[] dxDescs = request.getParameterValues("dx_desc"+i);
		String[] totals = request.getParameterValues("total"+i);
		String[] sliCodes = request.getParameterValues("sli_code"+i);
		
		if (billId != null && billSaved) {
			BillingClaimHeader1 bill = null;
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date billDateAsDate = (Date)formatter.parse(billDate);
			formatter = new SimpleDateFormat("HH:mm:ss");
			Date billTimeAsDate = (Date)formatter.parse(billTime);
			
			if (billId.equals("")) {
				// create new bill
				bill = new BillingClaimHeader1();
				bill.setHeader_id(0);
				bill.setDemographic_no(demoNo);
				bill.setProvider_no(provNo);
				bill.setAppointment_no(apptNo);
				bill.setBilling_date(billDateAsDate);
				bill.setBilling_time(billTimeAsDate);
				bill.setDemographic_name(demoName);
				bill.setStatus("W");
				bill.setApptProvider_no("none");
			} else {
				// set old bills' status as 'D' for deleted
				bill = billingClaimDAO.getInvoice(billId);
				bill.setStatus("D");
				billingClaimDAO.updateBill(bill);
				
				String apptProvNo = bill.getApptProvider_no();
				
				// create new bill to replace old bill
				bill = new BillingClaimHeader1();
				bill.setHeader_id(0);
				bill.setDemographic_no(demoNo);
				bill.setProvider_no(provNo);
				bill.setAppointment_no(apptNo);
				bill.setBilling_date(billDateAsDate);
				bill.setBilling_time(billTimeAsDate);
				bill.setDemographic_name(demoName);
				bill.setStatus("W");
				
				bill.setApptProvider_no(apptProvNo);
				
				bill.getBillingItems().clear();
			}
			
			// set values for billing items
			
			for (int j=0; j < billCodes.length; j++) {
		        BillingItem item = null;
		        for( String code : billCodes) {
		            item = new BillingItem();
		            item.setCh1_id(bill.getId());
		            item.setTransc_id(BillingDataHlp.ITEM_TRANSACTIONIDENTIFIER);
		            item.setRec_id(BillingDataHlp.ITEM_REORDIDENTIFICATION);
		            item.setService_code(billCodes[j]);
		
		            item.setFee(amounts[j]);
		            item.setSer_num(units[j]);
		            item.setStatus("S");
					
		            item.setService_date(billDateAsDate);
					
					item.setDx(billCodes[j]);
					item.setDx1("");
	                item.setDx2("");
		
		            bill.getBillingItems().add(item);
		        }
				
				try {
					billingClaimDAO.createBill(bill);
				} catch (Exception e) {
					MiscUtils.getLogger().error("create bill error:", e);
				}
			}
			
			// update appointment status to be 'B' for billed
			Appointment appointment = appointmentDao.getAppointment(new Integer(apptNo));
			
			if (appointment != null) {
				appointment.setStatus("B");
				appointmentDao.updateAppointment(appointment);
			}
		}
	}
}


String action = request.getParameter("reportAction") == null ? "" : request.getParameter("reportAction");

// handle loading of unbilled items
if("unbilled".equals(action)) {
    vecHeader.add("Service Date");
    vecHeader.add("Time");
    vecHeader.add("Patient Name");
    vecHeader.add("Remarks");
    vecHeader.add("Notes");
    vecHeader.add("Service Description");
    
	Comparator<Appointment> appointmentComparator = new Comparator<Appointment>() {
		// This is where the sorting happens.
		public int compare(Appointment a1, Appointment a2) {
			int result = a1.getAppointmentDate().compareTo(a2.getAppointmentDate());
			
			if (result == 0) {
				result = a1.getStartTime().compareTo(a2.getStartTime());
			}
			return result;
		}
	};
	
    
    /*
    sql = "select * from appointment where provider_no='" + providerview + "' and appointment_date >='" + xml_vdate   
            + "' and appointment_date<='" + xml_appointment_date + "' and (status='P' or status='H' or status='HS' or status='PV' or status='PS' or status='E' or status='ES' or status='EV')" 
            + " and demographic_no != 0 order by appointment_date , start_time ";
    rs = dbObj.searchDBRecord(sql);
    */
    
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
    
    Date startTime = (Date)formatter.parse(xml_vdate);
    Date endTime = (Date)formatter.parse(xml_appointment_date);
    List<Appointment> appointments = appointmentDao.findByDateRangeAndProvider(startTime, endTime, providerview);
    
    // sort appointments
    Collections.sort(appointments, appointmentComparator);
    
    for (Appointment apt : appointments) {
		String status = apt.getStatus();
		if (apt.getDemographicNo() == 0 || !(status.equals("P") || status.equals("H") || status.equals("HS") || status.equals("PV") || status.equals("PS") || status.equals("E") || status.equals("ES") || status.equals("EV")))
			continue;
		
    	if (bMultisites) {
    		// skip record if location does not match the selected site, blank location always gets displayed for backward-compatibility
    		String location = apt.getLocation();
    		if (StringUtils.isNotBlank(location) && !location.equals(request.getParameter("site"))) 
    			continue; 
    	}

    	prop = new Properties();
        prop.setProperty( "Service Date", apt.getAppointmentDate().toString() );
        prop.setProperty( "Time", apt.getStartTime().toString() );
        prop.setProperty( "Patient Name", apt.getName() );
        prop.setProperty( "Service Description", apt.getReason() );
		prop.setProperty( "Remarks",  apt.getRemarks() );
		prop.setProperty( "Notes", apt.getNotes() );
        
        /*
        String tempStr = "<a href=# onClick='popupPage(700,1000, \"billingOB.jsp?billForm=" 
                + URLEncoder.encode(oscarVariables.getProperty("default_view")) + "&hotclick=&appointment_no="
                + apt.getId() + "&demographic_name=" + URLEncoder.encode(apt.getName())
				+ "&demographic_no=" + apt.getDemographicNo() + "&user_no=" + apt.getProviderNo() 
				+ "&apptProvider_no=" + providerview + "&appointment_date=" + apt.getAppointmentDate().toString() 
				+ "&start_time=" + apt.getStartTime().toString() + "&bNewForm=1\"); return false;'>Bill ";
		*/
        //prop.setProperty("COMMENTS", tempStr);
        vecValue.add(prop);
        
        List<BillingClaimHeader1> bills = billingClaimDAO.getInvoices(new Integer(apt.getDemographicNo()).toString(), apt.getId().toString());
        vecBills.add(bills);
        
        vecDemographicNo.add( "" + apt.getDemographicNo() );
        vecAppointmentNo.add( "" + apt.getId() );
        vecProviderNo.add( "" + apt.getProviderNo() );
    }

}

// handle loading of billed items
if("billed".equals(action)) {
	editable = false;
	
    vecHeader.add("Service Date");
    vecHeader.add("Time");
    vecHeader.add("Patient Name");
    vecHeader.add("Service Description");
    vecHeader.add("ACCOUNT");
	
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
    
    Date startTime = (Date)formatter.parse(xml_vdate);
    Date endTime = (Date)formatter.parse(xml_appointment_date);
	
	List<BillingClaimHeader1> bills = billingClaimDAO.getInvoices(providerview, startTime, endTime);
    
    //sql = "select * from billing_on_cheader1 where provider_no='" + providerview + "' and billing_date >='" + xml_vdate 
    //        + "' and billing_date<='" + xml_appointment_date + "' and (status<>'D' and status<>'S' and status<>'B')" 
    //        + " order by billing_date , billing_time ";
    //rs = dbObj.searchDBRecord(sql);
    
    for (BillingClaimHeader1 bill : bills) {
		String status = bill.getStatus();
		if (status.equals("D") || status.equals("S") || status.equals("B"))
			continue;
		
    	if (bMultisites) {
			String clinic = bill.getClinic();
    		// skip record if clinic is not match the selected site, blank clinic always gets displayed for backward compatible
    		if (StringUtils.isNotBlank(clinic) && !clinic.equals(request.getParameter("site"))) 
    			continue; 
    	}

		prop = new Properties();
		
    	prop.setProperty( "Service Date", bill.getBilling_date().toString() );
        prop.setProperty( "Time", bill.getBilling_time().toString() );
        prop.setProperty( "Patient Name", bill.getDemographic_name() );

        String apptDoctorNo = bill.getApptProvider_no();
        String userno= bill.getProvider_no();
        String reason = bill.getStatus();
        String note = "";

        if (apptDoctorNo.compareTo("none") == 0){
        	note = "No Appt / INR";
        } else {
    	    if (apptDoctorNo.compareTo(userno) == 0) {
    	    	note = "With Appt. Doctor";
    	    } else {
    	    	note = "Unmatched Appt. Doctor";
    	    }
        }

    	if (reason.compareTo("N") == 0) reason="Do Not Bill ";
    	else if (reason.compareTo("O") == 0) reason="Bill OHIP ";
    	else if (reason.compareTo("W") == 0) reason="Bill WSIB ";
    	else if (reason.compareTo("H") == 0) reason="Capitated Bill ";
    	else if (reason.compareTo("P") == 0) reason="Bill Patient";

    	prop.setProperty("Service Description", reason + "(" + note + ")");
        String tempStr = "<a href=# onClick='popupPage(700,720, \"../../../billing/CA/ON/billingCorrection.jsp?billing_no="
                + bill.getId() + "&dboperation=search_bill&hotclick=0\"); return false;' title="
                + reason + ">" + bill.getId() + "</a>";

  	    prop.setProperty("ACCOUNT", tempStr);
        vecValue.add(prop);
        
        List<BillingClaimHeader1> appointmentBill = billingClaimDAO.getInvoices(new Integer(bill.getDemographic_no()).toString(), bill.getAppointment_no());
        vecBills.add(appointmentBill);
        
        vecDemographicNo.add( "" + bill.getDemographic_no() );
        vecAppointmentNo.add( "" + bill.getAppointment_no() );
        vecProviderNo.add( "" + bill.getProvider_no() );
    }
}

// no longer used (not sure why)
if("paid".equals(action)) {
    vecHeader.add("No");
    vecHeader.add("Billing No");
    vecHeader.add("HIN");
    vecHeader.add("Claim");
    vecHeader.add("Paid");
    vecHeader.add("Billing Date");
    //vecHeader.add("Time");
    float fTotalClaim = 0.00f;
    float fTotalPaid = 0.00f;
        
    // get billing no in the date range
    ArrayList<String> vecBillingNo = new ArrayList<String>();
    Properties propTotal = new Properties();
    sql = "select billing_no,total from billing where provider_no='" + providerview 
    + "' and billing_date>='" + xml_vdate + "' and billing_date<='" + xml_appointment_date 
    + "' and status ='S' order by billing_date, billing_time";
    
    // change 'S' to 'O' for testing
    
    //rs = dbObj.searchDBRecord(sql);
    while (rs.next()) {
        vecBillingNo.add("" + rs.getInt("billing_no"));
        propTotal.setProperty(""+rs.getInt("billing_no"), rs.getString("total"));
    }
    rs.close();
    
    // get detail ra for the billing no
    String tempStr = "";
    for(int i=0; i<vecBillingNo.size(); i++) {
        tempStr += ("".equals(tempStr) ? "" : ",") + (String)vecBillingNo.get(i);
    }
    tempStr = "".equals(tempStr) ? "-1" : tempStr;
    
    // change tempStr to '75980, 75982, 75990' for testing
    //tempStr = "75980, 75982, 75990,79571,79066";
    
    sql = "select billing_no, amountclaim, amountpay, hin, service_date from radetail where billing_no in ("
            + tempStr + ") and raheader_no !=0 order by billing_no, radetail_no";
    //rs = dbObj.searchDBRecord(sql);
    String sAmountclaim = "", sAmountpay = "", hin = "";
    int nNo = 0;
    while (rs.next()) {
        if(!tempStr.equals("" + rs.getInt("billing_no")) ) { // new billing no
            prop = new Properties();
        	// reset something
            tempStr = "" + rs.getInt("billing_no");
            nNo++;
            sAmountclaim = rs.getString("amountclaim");
			sAmountpay = rs.getString("amountpay");
			String strT = "<a href=# onClick='popupPage(700,720, \"../../../billing/CA/BC/billingView.do?billing_no="
		        + rs.getString("billing_no") + "&dboperation=search_bill&hotclick=0\"); return false;' >" 
		        + rs.getString("billing_no") + "</a>";
	        prop.setProperty("No", ""+nNo);
	        prop.setProperty("Billing No", strT);
	        prop.setProperty("HIN", rs.getString("hin"));
	        prop.setProperty("Claim", sAmountclaim);
	        prop.setProperty("Paid", sAmountpay);
	        prop.setProperty("Billing Date", getFormatDateStr(rs.getString("service_date")));
	        vecValue.add(prop);
	        
	        fTotalClaim += Float.parseFloat(rs.getString("amountclaim"));
	        fTotalPaid += Float.parseFloat(rs.getString("amountpay"));
        } else { // old billing no
            prop = new Properties();
            //sAmountclaim = rs.getString("amountclaim");
			//sAmountpay = rs.getString("amountpay");
			float fAmountclaim = Float.parseFloat(sAmountclaim);
			fAmountclaim = fAmountclaim + Float.parseFloat(rs.getString("amountclaim"));
			sAmountclaim = "" + Math.round(fAmountclaim*100)/100.00;
			float fAmountpay = Float.parseFloat(sAmountpay);
			fAmountpay = fAmountpay + Float.parseFloat(rs.getString("amountpay"));
			sAmountpay = "" + Math.round(fAmountpay*100)/100.00;
			//hin = rs.getString("hin");
			String strT = "<a href=# onClick='popupPage(700,720, \"../../../billing/CA/BC/billingView.do?billing_no="
		        + rs.getString("billing_no") + "&dboperation=search_bill&hotclick=0\"); return false;' >" 
		        + rs.getString("billing_no") + "</a>";
	        prop.setProperty("No", ""+nNo);
	        prop.setProperty("Billing No", strT);
	        prop.setProperty("HIN", rs.getString("hin"));
	        // repeated records
	        //prop.setProperty("Claim", sAmountclaim);
	        prop.setProperty("Claim", propTotal.getProperty(tempStr));
	        prop.setProperty("Paid", sAmountpay);
	        prop.setProperty("Billing Date", getFormatDateStr(rs.getString("service_date")));
	        vecValue.remove(vecValue.size()-1);
	        vecValue.add(prop);
	        
	        fTotalClaim += Float.parseFloat(rs.getString("amountclaim"));
	        fTotalPaid += Float.parseFloat(rs.getString("amountpay"));
        }
    }
    rs.close();
    vecTotal.add("Total");  
    vecTotal.add("");  
    vecTotal.add("");  
    vecTotal.add("" + Math.round(fTotalClaim*100)/100.00);  
    vecTotal.add("" + Math.round(fTotalPaid*100)/100.00);  
    vecTotal.add("");  
}

// no longer used (not sure why)
if("unpaid".equals(action)) {
    vecHeader.add("No");
    vecHeader.add("Billing No");
    vecHeader.add("Patient");
    vecHeader.add("Claim");
    vecHeader.add("Description");
    vecHeader.add("Service Date");
    vecHeader.add("Time");
    float fTotalClaim = 0.00f;
    String sAmountclaim = "";
        
    sql = "select * from billing where provider_no='" + providerview + "' and billing_date >='" + xml_vdate 
    + "' and billing_date<='" + xml_appointment_date + "' and (status<>'D' and status<>'S')" 
    + " order by billing_date , billing_time ";
    int nNo = 0;
	//rs = dbObj.searchDBRecord(sql);
	while (rs.next()) {
		prop = new Properties();
		nNo++;
        prop.setProperty("No", ""+nNo);
		prop.setProperty("Service Date", rs.getString("billing_date"));
		prop.setProperty("Time", rs.getString("billing_time").substring(0,5));
		prop.setProperty("Patient", rs.getString("demographic_name"));
		
		String apptDoctorNo = rs.getString("apptProvider_no");
		String userno=rs.getString("provider_no");
		String reason = rs.getString("status");
		String note = "";
		if (apptDoctorNo.compareTo("none") == 0){
			note = "No Appt / INR";
		} else {
		    if (apptDoctorNo.compareTo(userno) == 0) {
		    	note = "With Appt. Doctor";
		    } else {
		    	note = "Unmatched Appt. Doctor";
		    }
		}
		if (reason.compareTo("N") == 0) reason="Do Not Bill ";
		else if (reason.compareTo("O") == 0) reason="Bill OHIP ";
		else if (reason.compareTo("W") == 0) reason="Bill WSIB ";
		else if (reason.compareTo("H") == 0) reason="Capitated Bill ";
		else if (reason.compareTo("P") == 0) reason="Bill Patient";
		else if (reason.compareTo("B") == 0) reason="Sent OHIP";
		
		prop.setProperty("Description", reason + "(" + note + ")");
		String tempStr = "<a href=# onClick='popupPage(700,720, \"../../../billing/CA/BC/billingView.do?billing_no="
		        + rs.getString("billing_no") + "&dboperation=search_bill&hotclick=0\"); return false;' title="
		        + reason + ">" + rs.getString("billing_no") + "</a>";
		prop.setProperty("Billing No", tempStr);
        sAmountclaim = rs.getString("total");
		prop.setProperty("Claim", sAmountclaim);
        fTotalClaim += Float.parseFloat(rs.getString("total"));
		
		vecValue.add(prop);
	}
    rs.close();
    vecTotal.add("Total");  
    vecTotal.add("");  
    vecTotal.add("");  
    vecTotal.add("" + Math.round(fTotalClaim*100)/100.00);  
    vecTotal.add("");  
    vecTotal.add("");  
    vecTotal.add("");  
}

%>


<%@page import="org.oscarehr.common.dao.SiteDao"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.oscarehr.common.model.Site"%>
<%@page import="org.oscarehr.common.model.Provider"%>
<%@page import="org.apache.commons.lang.StringUtils"%><html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<!-- totalNumberOfBills and incrementingId are required for the billingONNewReport.js script -->
<script type="text/javascript"> 
var totalNumberOfBills = 0;
var incrementingId = 0;
var demographicNumbers = new Array(<%
	for (int i=0; i < vecDemographicNo.size(); i++) {
		if (i != 0) {
			%>, <%
		}
		%> "<%=vecDemographicNo.get(i)%>" <%
	}
%>);
var appointmentNumbers = new Array(<%
	for (int i=0; i < vecAppointmentNo.size(); i++) {
		if (i != 0) {
			%>, <%
		}
		%> "<%=vecAppointmentNo.get(i)%>" <%
	}
%>);

</script>
<script type="text/javascript" src="reports/billingONNewReport.js"></script>
<title>ON Billing Report</title>
<link rel="stylesheet" href="../../web.css">
<link rel="stylesheet" type="text/css" media="all" href="../share/css/extractedFromPages.css"  />
<link rel="stylesheet" type="text/css" media="all" href="reports/billingONNewReport.css"  />
<!-- calendar stylesheet -->
<link rel="stylesheet" type="text/css" media="all"
	href="../../../share/calendar/calendar.css" title="win2k-cold-1" />
<!-- main calendar program -->
<script type="text/javascript" src="../../../share/calendar/calendar.js"></script>
<!-- language for the calendar -->
<script type="text/javascript"
	src="../../../share/calendar/lang/calendar-en.js"></script>
<!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
<script type="text/javascript"
	src="../../../share/calendar/calendar-setup.js"></script>
<script type="text/javascript">
<!--

function selectprovider(s) {
  if(self.location.href.lastIndexOf("&providerview=") > 0 ) a = self.location.href.substring(0,self.location.href.lastIndexOf("&providerview="));
  else a = self.location.href;
	self.location.href = a + "&providerview=" +s.options[s.selectedIndex].value ;
}
function openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function refresh() {
  var u = self.location.href;
  if(u.lastIndexOf("view=1") > 0) {
    self.location.href = u.substring(0,u.lastIndexOf("view=1")) + "view=0" + u.substring(eval(u.lastIndexOf("view=1")+6));
  } else {
    history.go(0);
  }
}
function calToday(field) {
	var calDate=new Date();
	varMonth = calDate.getMonth()+1;
	varMonth = varMonth>9? varMonth : ("0"+varMonth);
	varDate = calDate.getDate()>9? calDate.getDate(): ("0"+calDate.getDate());
	field.value = calDate.getFullYear() + '/' + (varMonth) + '/' + varDate;
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" rightmargin="0"
	topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr bgcolor="#CCCCFF">
		<td width="5%"></td>
		<td width="80%" align="left">
		<p><b><font face="Verdana, Arial" color="#FFFFFF" size="3"><a
			href="billingReportCenter.jsp">OSCARbilling</a></font></b></p>
		</td>
		<td align="right"><a href=#
			onClick="popupPage(700,720,'../../../oscarReport/manageProvider.jsp?action=billingreport')">
		<font size="1">Manage Provider List </font></a></td>
	</tr>
</table>

<table width="100%" border="0" bgcolor="#EEEEFF">
	<form name="serviceform" method="post" action="billingONReport.jsp">
	<tr>
		<td width="30%" align="center"><font size="2"> <input
			type="radio" name="reportAction" value="unbilled"
			<%="unbilled".equals(action)? "checked" : "" %>>Unbilled <input
			type="radio" name="reportAction" value="billed"
			<%="billed".equals(action)? "checked" : "" %>>Billed 
			<!--  input type="radio" name="reportAction" value="paid" <%="paid".equals(action)? "checked" : "" %>>Paid 
			<input type="radio" name="reportAction" value="unpaid" <%="unpaid".equals(action)? "checked" : "" %>>Unpaid -->
		</font></td>
		<td width="20%" align="right" nowrap><b>Provider </b></font> 
<% if (bMultisites) 
{ // multisite start ==========================================
        	SiteDao siteDao = (SiteDao)WebApplicationContextUtils.getWebApplicationContext(application).getBean("siteDao");
          	List<Site> sites = siteDao.getActiveSitesByProviderNo(user_no); 
          	// now get all report providers
          	ResultSet rslocal = isTeamBillingOnly
				?apptMainBean.queryResults(new String[]{"billingreport", user_no, user_no }, "search_reportteam")
				:apptMainBean.queryResults("billingreport", "search_reportprovider");
          	HashSet<String> reporters=new HashSet<String>();
          	while (rslocal.next()) {
          		reporters.add(rslocal.getString("provider_no"));
          	}
      %> 
      <script>
var _providers = [];
<%	for (int i=0; i<sites.size(); i++) { %>
	_providers["<%= sites.get(i).getName() %>"]="<% Iterator<Provider> iter = sites.get(i).getProviders().iterator();
	while (iter.hasNext()) {
		Provider p=iter.next();
		if (reporters.contains(p.getProviderNo())) {
	%><option value='<%= p.getProviderNo() %>'><%= p.getLastName() %>, <%= p.getFirstName() %></option><% }} %>";
<% } %>
function changeSite(sel) {
	sel.form.providerview.innerHTML=sel.value=="none"?"":_providers[sel.value];
	sel.style.backgroundColor=sel.options[sel.selectedIndex].style.backgroundColor;
}
      </script>
      	<select id="site" name="site" onchange="changeSite(this)">
      		<option value="none" style="background-color:white">---select clinic---</option>
      	<%
      	for (int i=0; i<sites.size(); i++) {
      	%>
      		<option value="<%= sites.get(i).getName() %>" style="background-color:<%= sites.get(i).getBgColor() %>"
      				<%=sites.get(i).getName().toString().equals(request.getParameter("site"))?"selected":"" %>><%= sites.get(i).getName() %></option>
      	<% } %>
      	</select>
      	<select id="providerview" name="providerview" style="width:140px"></select>
<% if (request.getParameter("providerview")!=null) { %>
      	<script>
     	changeSite(document.getElementById("site"));
      	document.getElementById("providerview").value='<%=request.getParameter("providerview")%>';     	
      	</script>
<% } // multisite end ==========================================
} else {
%>
		<select
			class="dropdown" name="providerview">
			<% 
String proFirst="";
String proLast="";
String proOHIP="";
String specialty_code; 
String billinggroup_no;
int Count = 0;

ResultSet rslocal = isTeamBillingOnly
?apptMainBean.queryResults(new String[]{"billingreport", user_no, user_no }, "search_reportteam")
:apptMainBean.queryResults("billingreport", "search_reportprovider");
while(rslocal.next()){
	proFirst = rslocal.getString("first_name");
	proLast = rslocal.getString("last_name");
	proOHIP = rslocal.getString("provider_no"); 
%>
			<option value="<%=proOHIP%>"
				<%=providerview.equals(proOHIP)?"selected":""%>><%=proLast%>,
			<%=proFirst%></option>
			<%
}      
%>
		</select>
<% } %>
		
		
		</td>
		<td align="center" nowrap><font size="1"> From:</font> <input
			type="text" name="xml_vdate" id="xml_vdate" size="10"
			value="<%=xml_vdate%>"> <font size="1"> <img
			src="../../../images/cal.gif" id="xml_vdate_cal"> To:</font> <input
			type="text" name="xml_appointment_date" id="xml_appointment_date"
			onDblClick="calToday(this)" size="10"
			value="<%=xml_appointment_date%>"> <img
			src="../../../images/cal.gif" id="xml_appointment_date_cal"></td>
		<td align="right"><input type="submit" class="billing_button" name="Submit"
			value="Create Report"> </font></td>
	</tr>
	<tr>
		</form>
</table>

<%
if (editable) {
%>
<form name="submitbillingform" method="post" action="billingONReport.jsp">
<%
}
%>

<table class="search_details">
	<thead></thead>
	<tbody>
		<tr>
			<td>Visit Type &nbsp;
				<select class="dropdown" name="visit_type">
					<option value="Clinic">Clinic</option>
				</select>
			</td>
			
			<td>Location &nbsp;
				<select class="dropdown" name="location">
					<option value="Kitchener">Kitchener</option>
				</select>
			</td>
			
			<td>Bill Type &nbsp;
				<select class="dropdown" name="bill_type">
					<option value="OHIP">OHIP</option>
				</select>
			</td>
			<td> <a class="billing_button" href="" tabindex="-1" onclick="setAsProviderDefault(); return false;">Set as Provider Default</a> </td>
			<%
			if (editable) {
			%>
				<td> <input type="submit" method="POST" class="billing_button" name="submit_billing" value="Submit Billing" /> </td>
			<%
			}
			%>
		</tr>
	</tbody>
</table>

<table class="bill-list">
<thead>
	<tr>
		<% for (int i=0; i<vecHeader.size(); i++) { %>
			<th><%=vecHeader.get(i) %></th>
		<% } %>
	</tr>
</thead>

<tbody>
	<%	int uniqueId = 0;
		for (int i=0; i < vecValue.size(); i++) {
			boolean hasBills = true;
			double billTotal = 0.0;
			String style = "";
			String billId = "";
			if ( vecBills.get(i) == null || vecBills.get(i).size() == 0 ) {
				hasBills = false;
				style = "class=\"no-bills\"";
			} else {
				billId = ((BillingClaimHeader1)vecBills.get(i).get(0)).getId().toString();
			}
			String appointmentNo = "-1";
			prop = (Properties)vecValue.get(i);	
			%>
			<tr id="bill<%=i%>" onclick="showBillDetails(<%=i%>); setFocusOnInputField(<%=i%>);">
				<% for (int j=0; j < vecHeader.size(); j++) {
					%>
					<td <%=style%>><%=prop.getProperty((String)vecHeader.get(j), "&nbsp;") %>&nbsp;</td>
				<% } %>
			</tr>
			<tr id="bill_details<%=i%>" class="bill hide_bill">
				<td colspan="5">
					<%
					if (editable) {
					%>
						<a class="billing_button" href="" tabindex="-1" onclick="addBillingItem(<%=i%>); return false;">Add Item</a>
						<select class="dropdown" onchange="">
							<option>1</option>
							<option>2</option>
							<option>3</option>
						</select>
						<a class="billing_button" href="" tabindex="-1" onclick="">Add Super Code</a>
						<input type="checkbox" class="checkbox" name="manual_checkbox<%=i%>" /> <span class="input_element_label">Manual</span>
						<input type="checkbox" class="checkbox" name="referral_doc_checkbox<%=i%>" /> <span class="input_element_label">Referral Doctor</span>
						<input type="hidden" name="bill_id<%=i%>" value="<%=billId%>" />
						<input type="hidden" name="bill_date<%=i%>" value="<%=prop.getProperty("Service Date", "")%>" />
						<input type="hidden" name="bill_time<%=i%>" value="<%=prop.getProperty("Time", "")%>" />
						<input type="hidden" name="demo_name<%=i%>" value="<%=prop.getProperty("Patient Name", "")%>" />
						<input type="hidden" name="appt_no<%=i%>" value="<%=vecAppointmentNo.get(i)%>" />
						<input type="hidden" name="demo_no<%=i%>" value="<%=vecDemographicNo.get(i)%>" />
						<input type="hidden" name="prov_no<%=i%>" value="<%=vecProviderNo.get(i)%>" />
					<%
					}
					%>
									
					<table>
						<thead>
							<tr>
								<td></td>
								<td>Billing Code</td>
								<td>Amount</td>
								<td>Units</td>
								<td>Dx Code</td>
								<td>Dx Description</td>
								<td>Total</td>
								<td>SLI Code</td>
							</tr>
						<thead>
						<tbody id="billing_items<%=i%>">
							<%								
							if (!hasBills) {								
								%>
								
								<%
								if (editable) {
								%>
									<%=getEditableBillingItemText(i, uniqueId, vecDemographicNo.get(i), vecAppointmentNo.get(i), null)%>
								<%
								} else {
								%>
									<%=getUneditableBillingItemText(i, uniqueId, vecDemographicNo.get(i), vecAppointmentNo.get(i), null)%>
								<%
								}
								%>
								
								<%
								uniqueId++;
							} else {
								for (BillingClaimHeader1 bill : vecBills.get(i)) {
									appointmentNo = bill.getAppointment_no();									
									List<BillingItem> billingItems = bill.getBillingItems();
									for (BillingItem item : billingItems) {
										String serviceDesc = "";
										
										List<BillingService> billingServices = billingServiceDao.findBillingCodesByCode(item.getService_code(), "ON");
										if (billingServices.size() > 0) {
											BillingService billingService = billingServices.get(0);
											if (billingService != null) {
												serviceDesc = billingService.getDescription();
											}
										}
										
										String fee = item.getFee();
										String units = item.getSer_num();
										Double feeAsDouble = new Double(0.0);
										Double unitsAsDouble = new Double(0.0);
										if (fee != null) {
											feeAsDouble = Double.valueOf( fee );
										}
										if (units != null) {
											unitsAsDouble = Double.valueOf( units );
										}
										double tempTotal = feeAsDouble.doubleValue() * unitsAsDouble.doubleValue();
										billTotal += tempTotal;
										String total = String.format("%1$,.2f", tempTotal);
										
										List<String> values = new ArrayList<String>();
										values.add(item.getService_code());
										values.add(fee);
										values.add(units);
										values.add(item.getDx());
										values.add(serviceDesc);
										values.add(total);
										%>
										
										<%
										if (editable) {
											%>
											<%=getEditableBillingItemText(i, uniqueId, vecDemographicNo.get(i), vecAppointmentNo.get(i), values)%>
										<%
										} else {
										%>
											<%=getUneditableBillingItemText(i, uniqueId, vecDemographicNo.get(i), vecAppointmentNo.get(i), values)%>
										<%
										}
										%>
										
										<%
										uniqueId++;
									}
								}
							}
							String billTotalAsString = NumberFormat.getCurrencyInstance().format(billTotal);
							%>
						</tbody>
					</table>
					<a class="billing_button" href="" id="more_details_button<%=i%>" tabindex="-1" onclick="showMoreDetails(<%=i%>, <%=vecDemographicNo.get(i)%>, <%=vecAppointmentNo.get(i)%>); return false;">more</a>
					<table width="40%">
						<tbody>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td align="right"><b>Total:</b></td>
								<td id="bill_total<%=i%>"><%=billTotalAsString%></td>
								<td></td>
							</tr>
						</tbody>
					</table>
					<table id="more_details<%=i%>" class="more_details hide">
						<tr>
							<td>
								<div class="more_details">
									<table class="billing_history" id="billing_history<%=i%>" >
										<tbody><tr><td>Loading...Please wait.</td></tr></tbody>
									</table>
								</div>
							</td>
							<td>
								<div class="more_details">
									<table class="appointment_notes" id="appointment_notes<%=i%>" >
										<tbody><tr><td>Loading...Please wait.</td></tr></tbody>
									</table>
								</div>
							</td>
						</tr>	
					</table>
				</td>
			</tr>
		<%}%>
	
	<% if(vecTotal.size() > 0) { %>
		<tr bgcolor="silver">
		<% for (int i=0; i < vecTotal.size(); i++) {%>
			<th><%=vecTotal.get(i) %>&nbsp;</th>
		<% } %>
		</tr>
	<%}%>
</tbody>
</table>

<br>

<hr width="100%">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td><a href=# onClick="javascript:history.go(-1);return false;">
		<img src="images/leftarrow.gif" border="0" width="25" height="20"
			align="absmiddle"> Back </a></td>
		<td align="right"><a href="" onClick="self.close();">Close
		the Window<img src="images/rightarrow.gif" border="0" width="25"
			height="20" align="absmiddle"></a></td>
	</tr>
</table>

<%
if (editable) {
%>
<input type="hidden" name="number_of_bills" value="<%=vecValue.size()%>" />
</form>
<%
}
%>

</body>
<script type="text/javascript">
Calendar.setup( { inputField : "xml_vdate", ifFormat : "%Y/%m/%d", showsTime :false, button : "xml_vdate_cal", singleClick : true, step : 1 } );
Calendar.setup( { inputField : "xml_appointment_date", ifFormat : "%Y/%m/%d", showsTime :false, button : "xml_appointment_date_cal", singleClick : true, step : 1 } );
</script>

<script type="text/javascript">

totalNumberOfBills = <%=vecValue.size()%>;
incrementingId = <%=uniqueId%>;

</script>

</html>
<%! 
String getFormatDateStr(String str) {
    String ret = str;
	if(str.length() == 8) {
	    ret = str.substring(0,4) + "/" + str.substring(4,6) + "/" + str.substring(6);
	}
	return ret;
}

String getOnKeydownString(int i, String demoNo, String apptNo) {
	String onkeydown = "onkeydown=\"";
	onkeydown+= "if (isTabKey(event)) {";
	onkeydown+= "	hideAllLookups("+i+"); ";
	onkeydown+= "	return true; ";
	onkeydown+= "}";
	onkeydown+= "if (isDeleteBillingItemKey(event)) {";
	//onkeydown+= "	deleteBillingItem("+i+", "+uniqueId+");";
	onkeydown+= "";
	onkeydown+= "}";
	onkeydown+= "var lookupIsOpen = isLookupOpen("+i+");";
	onkeydown+= "if (!lookupIsOpen) {";
	onkeydown+= "	if (isSaveBill(event)) {";
	onkeydown+= "		saveBill("+i+"); ";
	onkeydown+= "		moveToNextBill("+i+"); ";
	onkeydown+= "	}";
	onkeydown+= "	if (isMoveBetweenBills(event)) {";
	onkeydown+= "		moveBetweenBills(event, "+i+"); ";
	onkeydown+= "	}";
	onkeydown+= "} else {";
	onkeydown+= "	if (isMoveBetweenLookupItems(event)) {";
	onkeydown+= "		moveBetweenLookupItems(event, "+i+");";
	onkeydown+= "	}";
	onkeydown+= "	if (isSelectLookupItem(event)) {";
	onkeydown+= "		selectLookupItem("+i+");";
	onkeydown+= "	}";
	onkeydown+= "	if (isEscapeKey(event)) {";
	onkeydown+= "		hideAllLookups("+i+");";
	onkeydown+= "	}";
	onkeydown+= "}";
	onkeydown+= "if (isMoveBetweenBillingItems(event)) {";
	onkeydown+= "	moveBetweenBillingItems(event, "+i+");";
	onkeydown+= "}";
	onkeydown+= "if (isShowMoreDetails(event)) {";
	onkeydown+= "	toggleMoreDetails("+i+", "+demoNo+", "+apptNo+");";
	onkeydown+= "}";
	onkeydown+= "return true;\"";
	
	return onkeydown;
}

String getTotalOnKeydownString(int i, int uniqueId, String demoNo, String apptNo) {
	String totalOnkeydown = "onkeydown=\"";
	totalOnkeydown+= "if (isTabKey(event)) {";
	totalOnkeydown+= "	hideAllServiceCodeLookups("+i+"); ";
	totalOnkeydown+= "	if (checkIfLastBillingItem("+i+", "+uniqueId+")) {";
	totalOnkeydown+= "		addBillingItem("+i+"); ";
	totalOnkeydown+= "	} ";
	totalOnkeydown+= "} ";
	totalOnkeydown+= "if (isSaveBill(event)) {";
	totalOnkeydown+= "	saveBill("+i+"); ";
	totalOnkeydown+= "	moveToNextBill("+i+"); ";
	totalOnkeydown+= "}";
	totalOnkeydown+= "if (isMoveBetweenBillingItems(event)) {";
	totalOnkeydown+= "	moveBetweenBillingItems(event, "+i+");";
	totalOnkeydown+= "}";
	totalOnkeydown+= "if (isShowMoreDetails(event)) {";
	totalOnkeydown+= "	toggleMoreDetails("+i+", "+demoNo+", "+apptNo+");";
	totalOnkeydown+= "}";
	totalOnkeydown+= "return true;\"";
	
	return totalOnkeydown;
}

String getTotalOnKeyupString(int i) {
	String totalOnKeyup = "onkeyup=\"";
	totalOnKeyup+= "updateBillTotal("+i+");";
	totalOnKeyup+= "return true;\"";
	
	return totalOnKeyup;
}

String getOnKeyupString(int i, int uniqueId) {
	String onkeyup = "onkeyup=\"";
	onkeyup+= "if (this.value.length == 0) {";
	onkeyup+= "	hideServiceCodeLookup("+i+", "+uniqueId+");";
	onkeyup+= "	hideDiagnosticCodeLookup("+i+", "+uniqueId+");";
	onkeyup+= "	if (this.id.indexOf('amount') == 0 || this.id.indexOf('units') == 0) {";
	onkeyup+= "		updateBillingItemTotal("+i+", "+uniqueId+");";
	onkeyup+= "		updateBillTotal("+i+");";
	onkeyup+= "	}";
	onkeyup+= "} else { ";
	onkeyup+= "	if (isAlphaNumericKey(event) || isBackspaceKey(event) || isDeleteKey(event)) {";
					// show diagnostic/service codes lookup list
	onkeyup+= "		if (this.id.indexOf('bill_code') == 0) {";
	onkeyup+= "			showAvailableServiceCodes("+i+", "+uniqueId+", this.value);";
	onkeyup+= "		} else if (this.id.indexOf('dx_code') == 0) {";
	onkeyup+= "			showAvailableDiagnosticCodes("+i+", "+uniqueId+", this.value);";
	onkeyup+= "		} else if (this.id.indexOf('dx_desc') == 0) {";
	onkeyup+= "			showAvailableDiagnosticCodes("+i+", "+uniqueId+", '', this.value);";
	onkeyup+= "		}";
					// update total if units/amount values change
	onkeyup+= "		else if (this.id.indexOf('amount') == 0 || this.id.indexOf('units') == 0) {";
	onkeyup+= "			if (isNumericKey(event) || isBackspaceKey(event) || isDeleteKey(event)) {";
	onkeyup+= "				updateBillingItemTotal("+i+", "+uniqueId+");";
	onkeyup+= "				updateBillTotal("+i+");";
	onkeyup+= "			}";
	onkeyup+= "		}";
	onkeyup+= "	}";
	onkeyup+= "}";
	onkeyup+= "return true; \"";
	
	return onkeyup;
}

String getEditableBillingItemText(int i, int uniqueId, String demoNo, String apptNo, List<String> values) {
	String onkeydown = getOnKeydownString(i, demoNo, apptNo);
	String totalOnKeyup = getTotalOnKeyupString(i);
	String totalOnkeydown = getTotalOnKeydownString(i, uniqueId, demoNo, apptNo);
	String onkeyup = getOnKeyupString(i, uniqueId);
	
	if (values == null) 
		values = new ArrayList<String>();
	
	while (values.size() < 7) {
		// 'units' should default to '1'
		if (values.size() == 2)
			values.add("1");
		// everything else defaults to an empty string
		else 
			values.add("");
	}
	
	String html = "";
	html += "<tr id='billing_item"+i+"_"+uniqueId+"'>";
	html += "	<td> <a class='billing_button' href='' tabindex='-1' onclick='deleteBillingItem("+i+", "+uniqueId+"); updateBillTotal("+i+"); return false;' >X</a></td>";
	html += "	<td> <input type='text' size='6'  name='bill_code"+i+"' id='bill_code"+i+"_"+uniqueId+"' value='"+values.get(0)+"' "+onkeydown+" "+onkeyup+" /> <div id='service_code_lookup"+i+"_"+uniqueId+"' class='lookup_box' style='display:none;'></div> </td>";
	html += "	<td> <input type='text' size='6' name='amount"+i+"' id='amount"+i+"_"+uniqueId+"' value='"+values.get(1)+"' "+onkeydown+" "+onkeyup+" /> </td>";
	html += "	<td> <input type='text' size='3' name='units"+i+"' id='units"+i+"_"+uniqueId+"' value='"+values.get(2)+"' "+onkeydown+" "+onkeyup+" /> </td>";
	html += "	<td> <input type='text' size='6' name='dx_code"+i+"' id='dx_code"+i+"_"+uniqueId+"' value='"+values.get(3)+"' "+onkeydown+" "+onkeyup+" /> <div id='diagnostic_code_lookup"+i+"_"+uniqueId+"' class='lookup_box' style='display:none;'></div> </td>";
	html += "	<td> <input type='text' size='12' name='dx_desc"+i+"' id='dx_desc"+i+"_"+uniqueId+"' value='"+values.get(4)+"' "+onkeydown+" "+onkeyup+" /> <div id='diagnostic_desc_lookup"+i+"_"+uniqueId+"' class='lookup_box' style='display:none;'></div> </td>";
	html += "	<td> <input type='text' size='6' name='total"+i+"' id='total"+i+"_"+uniqueId+"' value='"+values.get(5)+"' "+totalOnkeydown+" "+totalOnKeyup+" /> </td>";
	html += "	<td> <input type='text' size='6' name='sli_code"+i+"' id='sli_code"+i+"_"+uniqueId+"' value='"+values.get(6)+"' /> </td>";
	html += "</tr>";
	
	return html;
}

String getUneditableBillingItemText(int i, int uniqueId, String demoNo, String apptNo, List<String> values) {	
	if (values == null) 
		values = new ArrayList<String>();
	
	while (values.size() < 7) {
		// 'units' should default to '1'
		if (values.size() == 2)
			values.add("1");
		// everything else defaults to an empty string
		else 
			values.add("");
	}
	
	String html = "";
	html += "<tr>";
	html += "	<td> </td>";
	html += "	<td> <span>"+values.get(0)+"</span> </td>";
	html += "	<td> <span>"+values.get(1)+"</span> </td>";
	html += "	<td> <span>"+values.get(2)+"</span> </td>";
	html += "	<td> <span>"+values.get(3)+"</span> </td>";
	html += "	<td> <span>"+values.get(4)+"</span> </td>";
	html += "	<td> <span>"+values.get(5)+"</span> </td>";
	html += "	<td> <span>"+values.get(6)+"</span> </td>";
	html += "</tr>";
	
	return html;
}
%>
