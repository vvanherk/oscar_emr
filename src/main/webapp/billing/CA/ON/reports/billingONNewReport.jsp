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
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<%@page import="java.util.List, java.util.Set, java.util.Collections, java.util.Comparator, java.util.Date, java.text.SimpleDateFormat, java.text.NumberFormat" %>
<%@page import="org.oscarehr.util.SpringUtils, org.oscarehr.common.dao.OscarAppointmentDao, org.oscarehr.common.model.Appointment" %>

<%@page import="javax.validation.Validator, javax.validation.Validation, javax.validation.ValidationException, javax.validation.ConstraintViolation, javax.validation.ConstraintViolationException" %>

<%@page import="org.oscarehr.billing.CA.ON.dao.BillingClaimDAO" %>
<%@page import="org.oscarehr.common.dao.DemographicDao" %>
<%@page import="org.oscarehr.PMmodule.dao.ProviderDao" %>
<%@page import="org.oscarehr.common.dao.BillingServiceDao" %>
<%@page import="org.oscarehr.common.dao.DiagnosticCodeDao" %>

<%@page import="org.oscarehr.billing.CA.ON.model.BillingClaimHeader1" %>
<%@page import="org.oscarehr.billing.CA.ON.model.BillingItem" %>
<%@page import="org.oscarehr.common.model.BillingService" %>
<%@page import="org.oscarehr.common.model.DiagnosticCode" %>
<%@page import="org.oscarehr.common.model.Demographic" %>
<%@page import="org.oscarehr.common.model.Provider" %>

<%@page import="oscar.oscarBilling.ca.on.data.BillingDataHlp" %>

<%@page import="org.oscarehr.util.MiscUtils"%>
<%@page import="oscar.OscarProperties"%>


<% OscarAppointmentDao appointmentDao = (OscarAppointmentDao)SpringUtils.getBean("oscarAppointmentDao"); %>
<% DemographicDao demographicDao = (DemographicDao)SpringUtils.getBean("demographicDao"); %>
<% ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao"); %>
<% BillingClaimDAO billingClaimDAO = (BillingClaimDAO)SpringUtils.getBean("billingClaimDAO"); %>
<% BillingServiceDao billingServiceDao = (BillingServiceDao)SpringUtils.getBean("billingServiceDao"); %>
<% DiagnosticCodeDao diagnosticCodeDao = (DiagnosticCodeDao)SpringUtils.getBean("diagnosticCodeDao"); %>

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

boolean hasEChartPermission = false;
%>

<security:oscarSec objectName="_eChart" roleName="<%=roleName$%>" rights="r" reverse="false">
	<% hasEChartPermission = true; %>
</security:oscarSec>

<%
String user_no = (String) session.getAttribute("user");


int nItems=0;
int firstResult = 0;
int maxPerPage = 25;
int maxPaginationListSize = 10;
int totalResults = 0;
int currentPage = 1;
int totalNumberOfPages = 0;
if(request.getParameter("current_page")!=null) {
	try {
		currentPage = Integer.parseInt(request.getParameter("current_page"));
	} catch (Exception e) { }
}
if(request.getParameter("max_per_page")!=null) {
	try {
		maxPerPage = Integer.parseInt(request.getParameter("max_per_page"));
	} catch (Exception e) { }
} 
String providerview = request.getParameter("providerview")==null?"all":request.getParameter("providerview") ;
String billingProvider = request.getParameter("billing_provider")==null? providerview : request.getParameter("billing_provider") ;
%>

<%@ page
	import="java.util.*, java.sql.*, oscar.login.*, oscar.*, java.net.*"
	errorPage="../errorpage.jsp"%>
<%@ include file="../../../../admin/dbconnection.jsp"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean" scope="session" />
<jsp:useBean id="SxmlMisc" class="oscar.SxmlMisc" scope="session" />
<%@ include file="../dbBilling.jspf"%>

<%
GregorianCalendar now=new GregorianCalendar(); 
int curYear = now.get(Calendar.YEAR);
int curMonth = (now.get(Calendar.MONTH)+1);
int curDay = now.get(Calendar.DAY_OF_MONTH);

List<Appointment> date_appts = appointmentDao.getFirstAndLastUnbilledAppointments( );                                                                                    
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
String xml_vdate            = request.getParameter("xml_vdate"           ) == null ? sdf.format( date_appts.get( 0 ).getAppointmentDate( ) ) : request.getParameter("xml_vdate"           );
String xml_appointment_date = request.getParameter("xml_appointment_date") == null ? sdf.format( date_appts.get( 1 ).getAppointmentDate( ) ) : request.getParameter("xml_appointment_date");
%>

<%
String action = request.getParameter("reportAction") == null ? "" : request.getParameter("reportAction");
%>

<%
// action
ArrayList<String> vecHeader = new ArrayList<String>();
ArrayList<String> vecHeaderWidths = new ArrayList<String>();
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

boolean billsSubmitted = request.getParameter("submit_billing") != null;
boolean showBillSaveStatus = false;
int numBillsSaved = 0;
int numBillsSubmitted = 0;
int numBills = 0;

// handle saving of submitted bills
if (billsSubmitted) {
	int[] results = saveSubmittedBills( request, appointmentDao, billingClaimDAO, billingServiceDao, diagnosticCodeDao, demographicDao, providerDao );	
	
	numBills = results[0];
	numBillsSubmitted = results[1];
	numBillsSaved = results[2];
	
	String getVariables = "?numBills=" + numBills + "&numBillsSubmitted=" + numBillsSubmitted + "&numBillsSaved=" + numBillsSaved;
	getVariables += "&reportAction=" + action + "&providerview=" + providerview + "&xml_vdate=" + xml_vdate + "&xml_appointment_date=" + xml_appointment_date;
	getVariables += "&current_page=" + currentPage + "&max_per_page=" + maxPerPage + "&billing_provider=" + billingProvider;
		
	response.sendRedirect("reports/billingONNewReport.jsp" + getVariables);
} else {
	try {
		if (request.getParameter("numBills") != null) {
			numBills = Integer.parseInt(request.getParameter("numBills"));
			showBillSaveStatus = true;
		}
		if (request.getParameter("numBillsSubmitted") != null) {
			numBillsSubmitted = Integer.parseInt(request.getParameter("numBillsSubmitted"));
			showBillSaveStatus = true;
		}
		if (request.getParameter("numBillsSaved") != null) {
			numBillsSaved = Integer.parseInt(request.getParameter("numBillsSaved"));
			showBillSaveStatus = true;
		}
	} catch (Exception e) {
		MiscUtils.getLogger().error("Unable to parse bills submitted GET parameters", e);
	}
}

%>


<%

// handle loading of unbilled items
if("unbilled".equals(action)) {
    vecHeader.add("Service Date");
    vecHeader.add("Time");
    vecHeader.add("Patient Name");
    vecHeader.add("DOB");
    vecHeader.add("Remarks");
    vecHeader.add("Notes");
    vecHeader.add("Service Description");
    vecHeader.add("COMMENTS");
    
	vecHeaderWidths.add("10%");
	vecHeaderWidths.add("10%");
	vecHeaderWidths.add("20%");
	vecHeaderWidths.add("10%");
	vecHeaderWidths.add("10%");
	vecHeaderWidths.add("15%");
	vecHeaderWidths.add("30%");
	vecHeaderWidths.add("30%");
    
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
    
    Date startTime = null;
    
    Date endTime = null;
    
    try {
		startTime = (Date)formatter.parse(xml_vdate);
	} catch (Exception e) {}
	try {
		endTime = (Date)formatter.parse(xml_appointment_date);
    } catch (Exception e) {}
	
	totalResults = appointmentDao.getCountUnbilledByDateRangeAndProvider(startTime, endTime, providerview);
    totalNumberOfPages = (int)Math.ceil( (double)totalResults / (double)maxPerPage);
    if (currentPage > totalNumberOfPages)
		currentPage = totalNumberOfPages;
	
    firstResult = currentPage * maxPerPage - maxPerPage;
    
    List<Appointment> appointments = appointmentDao.getUnbilledByDateRangeAndProvider(startTime, endTime, providerview, new Integer(firstResult), new Integer(maxPerPage));    
    
    //MiscUtils.getLogger().info("na: " + appointments.size());
    
    // sort appointments
    Collections.sort(appointments, appointmentComparator);
    
    for (Appointment apt : appointments) {
		String status = apt.getStatus();
		if (apt.getDemographicNo() == 0 )
			continue;
		
    	if (bMultisites) {
    		// skip record if location does not match the selected site, blank location always gets displayed for backward-compatibility
    		String location = apt.getLocation();
    		if (StringUtils.isNotBlank(location) && !location.equals(request.getParameter("site"))) 
    			continue; 
    	}
    	
    	Demographic demo = demographicDao.getDemographic( "" + apt.getDemographicNo() );

    	prop = new Properties();
        prop.setProperty( "Service Date", apt.getAppointmentDate().toString() );
        prop.setProperty( "Time", apt.getStartTime().toString() );        
        prop.setProperty( "Patient Name", apt.getName() );
        
        prop.setProperty( "DOB", demo.getYearOfBirth() + "-" + demo.getMonthOfBirth() + "-" + demo.getDateOfBirth() );
        prop.setProperty( "Service Description", apt.getReason() );
        prop.setProperty( "Remarks",  apt.getRemarks() );
        prop.setProperty( "Notes", apt.getNotes() );
        String family_doctor = demo.getFamilyDoctor( );
        String r_doctor      = SxmlMisc.getXmlContent( family_doctor, "rd"     ) == null ? "" : SxmlMisc.getXmlContent(family_doctor, "rd"     );
        String r_doctor_ohip = SxmlMisc.getXmlContent( family_doctor, "rdohip" ) == null ? "" : SxmlMisc.getXmlContent(family_doctor, "rdohip" );
        prop.setProperty( "rdocn", r_doctor_ohip );
        prop.setProperty( "rdocc", r_doctor      );

        
        String tempStr = "<a href=# onClick='preventEventPropagation(event); popupPage(700,1000, \"billingOB.jsp?billForm=" 
                + URLEncoder.encode(oscarVariables.getProperty("default_view")) + "&hotclick=&appointment_no="
                + apt.getId() + "&demographic_name=" + URLEncoder.encode(apt.getName())
				+ "&demographic_no=" + apt.getDemographicNo() + "&user_no=" + apt.getProviderNo() 
				+ "&apptProvider_no=" + providerview + "&appointment_date=" + apt.getAppointmentDate().toString() 
				+ "&start_time=" + apt.getStartTime().toString() + "&bNewForm=1\"); return false;'>Bill</a> ";
		
        prop.setProperty("COMMENTS", tempStr);
        vecValue.add(prop);
        
        List<BillingClaimHeader1> bills = billingClaimDAO.getInvoices(new Integer(apt.getDemographicNo()).toString(), apt.getId().toString());
        vecBills.add(bills);
        
        vecDemographicNo.add( "" + apt.getDemographicNo() );
        vecAppointmentNo.add( "" + apt.getId() );
        vecProviderNo.add( "" + apt.getProviderNo() );
    }
    
    //MiscUtils.getLogger().info("nvb: " + vecBills.size());

}

// handle loading of billed items
if("billed".equals(action)) {
	response.sendRedirect("billingONNewReport.jsp?reportAction=" + action + "&providerview=" + providerview + "&xml_vdate=" + xml_vdate + "&xml_appointment_date=" + xml_appointment_date);
	
	editable = false;
	
    vecHeader.add("Service Date");
    vecHeader.add("Time");
    vecHeader.add("Patient Name");
    vecHeader.add("DOB");
    vecHeader.add("Service Description");
    vecHeader.add("ACCOUNT");
    
    vecHeaderWidths.add("10%");
	vecHeaderWidths.add("10%");
	vecHeaderWidths.add("20%");
	vecHeaderWidths.add("10%");
	vecHeaderWidths.add("10%");
	vecHeaderWidths.add("15%");
	
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
    
    Date startTime = (Date)formatter.parse(xml_vdate);
    Date endTime = (Date)formatter.parse(xml_appointment_date);
	
	totalResults = billingClaimDAO.getBilledInvoicesCount(providerview, startTime, endTime);
    totalNumberOfPages = (int)Math.ceil( (double)totalResults / (double)maxPerPage);
    if (currentPage > totalNumberOfPages)
		currentPage = totalNumberOfPages;
		
	firstResult = currentPage * maxPerPage - maxPerPage;
	
	List<BillingClaimHeader1> bills = billingClaimDAO.getBilledInvoices(providerview, startTime, endTime, new Integer(firstResult), new Integer(maxPerPage));
    
    //sql = "select * from billing_on_cheader1 where provider_no='" + providerview + "' and billing_date >='" + xml_vdate 
    //        + "' and billing_date<='" + xml_appointment_date + "' and (status<>'D' and status<>'S' and status<>'B')" 
    //        + " order by billing_date , billing_time ";
    //rs = dbObj.searchDBRecord(sql);
    
    for (BillingClaimHeader1 bill : bills) {
		//String status = bill.getStatus();
		//if (status.equals("D") || status.equals("S") || status.equals("B"))
		//	continue;
		
    	if (bMultisites) {
			String clinic = bill.getClinic();
    		// skip record if clinic is not match the selected site, blank clinic always gets displayed for backward compatible
    		if (StringUtils.isNotBlank(clinic) && !clinic.equals(request.getParameter("site"))) 
    			continue; 
    	}
    	
    	Demographic demo = demographicDao.getDemographic( "" + bill.getDemographic_no() );

		prop = new Properties();
		
    	prop.setProperty( "Service Date", bill.getBilling_date().toString() );
        prop.setProperty( "Time", bill.getBilling_time().toString() );        
        prop.setProperty( "Patient Name", bill.getDemographic_name() );
        
        prop.setProperty( "DOB", demo.getYearOfBirth() + "-" + demo.getMonthOfBirth() + "-" + demo.getDateOfBirth() );

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

var fullContextPath = "<%= request.getContextPath() %>/billing/CA/ON/reports";

</script>
<script type="text/javascript" src="<%= request.getContextPath() %>/billing/CA/ON/reports/billingONNewReport.js"></script>

<script src="<%= request.getContextPath() %>/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/additional-methods.js"></script>
<script>
$(document).ready(function() {
	$("#serviceform").validate();
	$("#submitbillingform").validate({
		ignore: ":not(:visible)"
			
	});
	
	$.validator.addMethod("currency", function(value, element) { 
		var re = /^\\$?[0-9][0-9\,]*(\.\d{1,2})?$|^\\$?[\.]([\d][\d]?)$/;
		return this.optional(element) || re.test(value); 
	}, "Must be a valid amount.");

	setBillingProvider( "<%=billingProvider%>" );

});
</script>

<title>ON Billing Report</title>
<!-- <link rel="stylesheet" href="<%= request.getContextPath() %>/web.css" > -->
<link rel="stylesheet" type="text/css" media="all" href="<%= request.getContextPath() %>/share/css/extractedFromPages.css"  >
<link rel="stylesheet" type="text/css" media="all" href="<%= request.getContextPath() %>/billing/CA/ON/reports/billingONNewReport.css"  >
<!-- calendar stylesheet -->
<link rel="stylesheet" type="text/css" media="all" href="<%= request.getContextPath() %>/share/calendar/calendar.css" title="win2k-cold-1" >
<!-- main calendar program -->
<script type="text/javascript" src="<%= request.getContextPath() %>/share/calendar/calendar.js"></script>
<!-- language for the calendar -->
<script type="text/javascript" src="<%= request.getContextPath() %>/share/calendar/lang/calendar-en.js"></script>
<!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
<script type="text/javascript" src="<%= request.getContextPath() %>/share/calendar/calendar-setup.js"></script>
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

<body text="#000000" style="margin: 0 0 0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr bgcolor="#aabcfe">
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

<form id="serviceform" name="serviceform" method="post" action="<%= request.getContextPath() %>/billing/CA/ON/billingONReport.jsp">
<%
    //if action is not set (first time on page), default to unbilled
    if (action == ""){ action = "unbilled"; }
%>
<table width="100%" border="0" bgcolor="#b9c9fe">
    <tr>
        <td width="30%" align="center">
            <font size="2"> 
                <input type="radio" name="reportAction" value="unbilled" <%="unbilled".equals(action)? "checked" : "" %>>Unbilled 
                <input type="radio" name="reportAction" value="billed" <%="billed".equals(action)? "checked" : "" %>>Billed 
                <input type="radio" name="reportAction" value="offsite" <%="offsite".equals(action)? "checked" : "" %> disabled>Offsite 
            </font>
        </td>
        <td width="20%" align="right" nowrap><b>Provider </b>

<% String providerSelectionList = ""; %>		
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
			providerSelectionList += "<option value='"+p.getProviderNo()+"'>"+p.getLastName()+", "+p.getFirstName()+"</option>";
		}
	}
	%> 
	<%=providerSelectionList%> 	
	<%
} %>
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
			class="dropdown" id="providerview" name="providerview" onchange="setBillingProvider( $('#providerview option:selected').val() ); return true;" >
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
	
	providerSelectionList += "<option value='"+proOHIP+"'" + (providerview.equals(proOHIP)? " selected " : "") + ">";
	providerSelectionList += proLast+","+proFirst;
	providerSelectionList += "</option>";
}      
%>
			<%=providerSelectionList%>
		</select>
<% } %>
	</td>

<%
boolean isMaxPerPageValid = true;
if ((maxPerPage != 0 && maxPerPage != 25 && maxPerPage != 50 && maxPerPage != 75 && maxPerPage != 100) || maxPerPage < 0)
	isMaxPerPageValid = false;
%>
		
		<td align="center" nowrap>
			<font size="1"> From:</font> 
			<input type="text" name="xml_vdate" id="xml_vdate" class="required date" size="10" value="<%=xml_vdate%>"> 
			
			<font size="1"> 				
				<img src="<%= request.getContextPath() %>/images/cal.gif" alt="" id="xml_vdate_cal"> To:
			</font> 
			
			<input type="text" name="xml_appointment_date" id="xml_appointment_date" class="required date" onDblClick="calToday(this)" size="10" value="<%=xml_appointment_date%>"> 
			<img src="<%= request.getContextPath() %>/images/cal.gif" alt="" id="xml_appointment_date_cal">
		</td>
		<td align="center">
			<span style="font-size: small;">Results per page:</span>
			<select class="dropdown" name="max_per_page">
				<option value="25" <%=(maxPerPage < 0 || maxPerPage == 25 ? "selected=\"selected\"" : "")%>>25</option>
				<option value="50" <%=(isMaxPerPageValid && maxPerPage == 50 ? "selected=\"selected\"" : "")%>>50</option>
				<option value="75" <%=(isMaxPerPageValid && maxPerPage == 75 ? "selected=\"selected\"" : "")%>>75</option>
				<option value="100" <%=(isMaxPerPageValid && maxPerPage == 100 ? "selected=\"selected\"" : "")%>>100</option>
				<option value="0" <%=(isMaxPerPageValid && maxPerPage == 0 ? "selected=\"selected\"" : "")%>>All</option>
			</select>
		</td>
		<td align="right"> <input type="submit" class="billing_button" name="Submit" value="Create Report"> </td>
	</tr>
</table>

<input type="hidden" name="current_page" value="<%=currentPage%>" >

</form>

<%
if (showBillSaveStatus) {
	String message = "No bills submitted!";
	String className = "oscar_warning";
	
	if (numBillsSubmitted > 0) {
		message = "";
		int numErrors = numBillsSubmitted - numBillsSaved;
		
		// if we have successfully saved bills, note how many
		if (numErrors != numBillsSubmitted) {
			message += numBillsSaved + " bill(s) saved successfully!<br>";
			className = "oscar_success";
		}
		
		// if we have errors during saving of bills, note how many bills encountered an error
		if (numErrors != 0) {
			message += numErrors + " bill(s) NOT saved successfully!";
			if (numErrors == numBillsSubmitted)
				className = "oscar_error";
			else 
				className = "oscar_warning";
		}
	}
	%>
<div class="<%=className%>"><%=message%></div>
<%
}
%>


<%
if (editable) {
%>
<form id="submitbillingform" name="submitbillingform" method="post" action="<%= request.getContextPath() %>/billing/CA/ON/billingONReport.jsp" onsubmit="">
<%

	if (request.getParameter("reportAction") != null) {
		%> 
			<input type="hidden" name="reportAction" value="<%=request.getParameter("reportAction")%>" > 
		<%
	}
	if (request.getParameter("providerview") != null) {
		%> 
			<input type="hidden" name="providerview" value="<%=request.getParameter("providerview")%>" > 
		<%
	}
	if (request.getParameter("site") != null) {
		%> 
			<input type="hidden" name="site" value="<%=request.getParameter("site")%>" > 
		<%
	}
	if (request.getParameter("xml_vdate") != null) {
		%> 
			<input type="hidden" name="xml_vdate" value="<%=request.getParameter("xml_vdate")%>" > 
		<%
	}
	if (request.getParameter("xml_appointment_date") != null) {
		%> 
			<input type="hidden" name="xml_appointment_date" value="<%=request.getParameter("xml_appointment_date")%>" > 
		<%
	}
	if (request.getParameter("max_per_page") != null) {
		%> 
			<input type="hidden" name="max_per_page" value="<%=request.getParameter("max_per_page")%>" > 
		<%
	}
	if (request.getParameter("current_page") != null) {
		%> 
			<input type="hidden" name="current_page" value="<%=request.getParameter("current_page")%>" > 
		<%
	}
}
%>

<table class="search_details">
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
			<td> <a class="billing_button" href="" tabindex="-1" onclick="setProviderDefault(); return false;">Set as Provider Default</a> </td>
			<%
			if (editable) {
			%>
				<td> Billing Provider &nbsp; 
					<select class="dropdown" id="billing_provider" name="billing_provider"> 
						<%=providerSelectionList%>
					</select>
				</td>
				<td>
					<!-- Stupid hack - need button before actual submit button to prevent enter key from submitting form -->
					<input type="submit" method="post" class="hide_element" onclick="return false;" name="submit_billing" value="Submit Billing" >
					<input type="submit" method="post" class="billing_button" onclick="return true;" id="submit_billing"  name="submit_billing" value="Submit Billing" > 
				</td>
			<%
			}
			%>
		</tr>
	</tbody>
</table>

<%
if (vecHeader != null && vecHeader.size() > 0) {
%>
<table width="80%">
	<tbody>
	<tr>
		<td class="hide_element"> <a class="billing_button" href="" tabindex="-1" onclick="return false;">Paste to selected</a> </td>
		<td class="hide_element"> <a class="billing_button" href="" tabindex="-1" onclick="return false;">Print selected</a> </td>
		<td width="80%">
			<!-- Pagination -->
			<%
			if (vecValue.size() > 0 && maxPerPage != 0) {				
				boolean[] visible = new boolean[totalNumberOfPages+1];
				int dotIndex1 = 0;
				int dotIndex2 = 0;
				for (int i=0; i < visible.length; i++) {
					visible[i] = true;
				}
				if (totalNumberOfPages > maxPaginationListSize) {
					// minimum # of pages to be visible at the beginning and the end of the page list
					int minVisibleFirstLast = 3;
					// minimum # of pages to be visible to the left and right of the current page
					int visiblePageBuffer = (maxPaginationListSize-minVisibleFirstLast)/2;
					
					// set pages that are outside the visiblePageBuffer radius from the currentPage to not be visible
					for (int i=1; i < visible.length; i++) {
						if (i < currentPage - visiblePageBuffer || i > currentPage + visiblePageBuffer)
							visible[i] = false;
					}
					
					// first and last few page numbers should be visisble
					for (int i=1; i < visible.length && i < minVisibleFirstLast; i++) {
						visible[i] = true;
					}
					for (int i=visible.length-1; i > 0 && i > visible.length-1 - minVisibleFirstLast; i--) {
						visible[i] = true;
					}
					
					// find indices where we want to place the '...'s
					for (int i=1; i < visible.length; i++) {
						if (!visible[i]) {
							dotIndex1 = i;
							break;
						}
					}
					for (int i=visible.length-1; i > 0; i--) {
						if (visible[i]) {
							if (i-1 > 0 && !visible[i-1]) {
								dotIndex2 = i-1;
								break;
							}
						}
					}
				}
				
				boolean canGoPrevious = true;
				boolean canGoNext = true;
				
				if (currentPage == 1)
					canGoPrevious = false;
				if (currentPage == totalNumberOfPages)
					canGoNext = false;
				
				%>
				<ul class="pagination-clean">
					<li class="<%=canGoPrevious ? "previous" : "previous-off"%>"> <a href="#" onclick="<%=canGoPrevious ? "previousPage(); " : ""%>return false;">Previous</a> </li>
					<%
						
					for (int i=1; i < totalNumberOfPages+1; i++) {
						if (!visible[i] && i != dotIndex1 && i != dotIndex2)
							continue;
						
						String liClass = "";
						String pageLink = "<a href='#' onclick='jumpToPage("+i+"); return false;'>"+i+"</a>";
						
						if (i == dotIndex1 || i == dotIndex2) {
							pageLink = "<a href='#' onclick='return false;'>...</a>";			
						} else {
							if (i == currentPage) {
								liClass="class='active'";
								pageLink = "" +i;
							}
						}
						
						%> 
						
						<li <%=liClass%>> <%=pageLink%> </li> 
						
						<%
					}
					%>
					<li class="<%=canGoNext ? "next" : "next-off"%>"> <a href="#" onclick="<%=canGoNext ? "nextPage(); " : ""%>return false;">Next</a> </li>
					<li class="pagination-clean" valign="center"> Showing results <%=firstResult%>-<%=Math.min(firstResult+maxPerPage-1, totalResults)%> of <%=totalResults%> </li>
				</ul>
			<% 
			} 
			%>
		</td>
	</tr>
	</tbody>
</table>

<%
}
%>

<table class="bill-list">
<thead>
	<tr>
		<th> <input type="checkbox" class="checkbox" name="select_all_bills" id="select_all_bills" onclick="toggleSelectAllBills();"> </th>
		<% for (int i=0; i<vecHeader.size(); i++) { %>
			<th width="<%=vecHeaderWidths.get(i)%>"><%=vecHeader.get(i) %></th>
		<% } %>
		<th></th>
	</tr>
</thead>
<tbody>
	<%	int uniqueId = 0;
		for (int i=0; i < vecValue.size(); i++) {
			boolean hasBills = true;
			double billTotal = 0.0;
			String style = "";
			String billId = "";
			BillingClaimHeader1 currentBill = null;
			if ( vecBills.get(i) == null || vecBills.get(i).size() == 0 ) {
				hasBills = false;
				style = "class=\"no-bills\"";
			} else {
				currentBill = (BillingClaimHeader1)vecBills.get(i).get(0);
				billId = currentBill.getId().toString();
			}
			String appointmentNo = "-1";
			prop = (Properties)vecValue.get(i);
			%>
			<tr id="bill<%=i%>" onclick="showBillDetails(<%=i%>);">
				<td width="10px"> <input type="checkbox" class="checkbox" name="select_bill" id="select_bill<%=i%>" onclick="preventEventPropagation(event);"> </td>
				<% for (int j=0; j < vecHeader.size(); j++) {
					String propertyValue = prop.getProperty((String)vecHeader.get(j), "&nbsp;");
					
					if (((String)vecHeader.get(j)).equals("Patient Name")) {
						String  eURL = "../../../oscarEncounter/IncomingEncounter.do?providerNo="+user_no+"&appointmentNo="+vecAppointmentNo.get(i)+"&demographicNo="+vecDemographicNo.get(i)+"&curProviderNo="+user_no+"&providerview=" + user_no;
				        String windowProperties = "height=710,width=1024,location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes,screenX=50,screenY=50,top=0,left=0";
				        
				        String mURL = "../../../demographic/demographiccontrol.jsp?demographic_no="+vecDemographicNo.get(i)+"&apptProvider="+vecProviderNo.get(i)+"&appointment="+vecAppointmentNo.get(i)+"&displaymode=edit&dboperation=search_detail";
				        
				        propertyValue += " | <a class=\"encounter_button\" href=# onclick=\"preventEventPropagation(event); window.open('" + eURL + "', '', '"+windowProperties+"');\">E</a>";
				        propertyValue += " | <a class=\"encounter_button\" href=# onclick=\"preventEventPropagation(event); window.open('" + mURL + "', '', '"+windowProperties+"');\">M</a>";
				    }
				    
					%>
					<td <%=style%>><%=propertyValue %>&nbsp;</td>
				<% } %>
				<td width="10px"> <a class="billing_button hide_element" href="" tabindex="-1" onclick="preventEventPropagation(event); return false;">Copy</a> </td>
			</tr>
			<tr id="bill_details<%=i%>" class="bill hide_bill">
				<td colspan="5">
					<% 
					if (editable) {
						
						String onkeydown = "onkeydown=\"";
						//onkeydown+= "if (isTabKey(event)) {";
						//onkeydown+= "	hideAllLookups("+i+"); ";
						//onkeydown+= "	return true; ";
						//onkeydown+= "}";
						onkeydown+= "var lookupIsOpen = isLookupOpen("+i+");";
						onkeydown+= "if (lookupIsOpen) {";
						onkeydown+= "	if (isMoveBetweenLookupItems(event)) {";
						onkeydown+= "		moveBetweenLookupItems(event, "+i+");";
						onkeydown+= "	}";
						onkeydown+= "	if (isSelectLookupItem(event)) {";
						onkeydown+= "		selectLookupItem("+i+");";
						onkeydown+= "		if (isTabKey(event))";
						onkeydown+= "			return false;";
						onkeydown+= "	}";
						onkeydown+= "	if (isEscapeKey(event)) {";
						onkeydown+= "		hideAllLookups("+i+");";
						onkeydown+= "	}";
						onkeydown+= "}";
						onkeydown+= "return true;\"";
						
						String onkeyup = "onkeyup=\"";
						onkeyup+= "if (this.value.length == 0) {";
						onkeyup+= "	hideAllLookups("+i+");";
						onkeyup+= "} else { ";
						onkeyup+= "	if (isAlphaNumericKey(event) || isBackspaceKey(event) || isDeleteKey(event)) {";
						onkeyup+= "		showAvailableReferralDoctors("+i+", this.value);";
						onkeyup+= "	}";
						onkeyup+= "}";
						onkeyup+= "return true; \"";
						%>
						<div class="extras_container">
							<div id="bill_notes_container<%=i%>">
								Bill Notes:<br>
								<textarea rows="6" cols="30" id="bill_notes<%=i%>" name="bill_notes<%=i%>"></textarea>
							</div>
							<div id="referral_doc_container<%=i%>" class="hide_element">
								Referral Doctor:<br>
																
								Name: <input type="text" id="referral_lookup_data<%=i%>" name="referral_lookup_data<%=i%>" value="<%=prop.getProperty( "rdocc", "" )%>" autocomplete="off" <%=onkeydown%> <%=onkeyup%>>
								<div id='referral_doc_lookup<%=i%>' class='lookup_box' style='display:none;'></div>
								<br>
								Format is <i>'lastname, firstname'</i>
							</div>
						</div>
					<% } %>
				
					<%
					if (editable) {
						String sliCode = (currentBill == null ? "" : currentBill.getLocation());
						String admissionDate = (currentBill == null ? "" : currentBill.getAdmission_date());
					%>
						<a class="billing_button" href="" tabindex="-1" onclick="addBillingItem(<%=i%>); return false;">Add Item</a>
						<select id="super_code<%=i%>" name="super_code<%=i%>" class="dropdown" onchange="">
							<option>1</option>
							<option>2</option>
							<option>3</option>
						</select>
						<a class="billing_button" href="" tabindex="-1" onclick="return false;">Add Super Code</a>
						
						<b>SLI Code</b>:
						<select class="dropdown" name="sli_code<%=i%>" onchange="">
							<option value="<%=OscarProperties.getInstance().getProperty("clinic_no", "")%>"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.NA" /></option>
                                <option value="HDS" <%=sliCode.equals("HDS") ? "selected" : ""%> ><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HDS" /></option>
                                <option value="HED" <%=sliCode.equals("HED") ? "selected" : ""%> ><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HED" /></option>
                                <option value="HIP" <%=sliCode.equals("HIP") ? "selected" : ""%> ><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HIP" /></option>
                                <option value="HOP" <%=sliCode.equals("HOP") ? "selected" : ""%> ><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HOP" /></option>
                                <option value="HRP" <%=sliCode.equals("HRP") ? "selected" : ""%> ><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HRP" /></option>
                                <option value="IHF" <%=sliCode.equals("IHF") ? "selected" : ""%> ><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.IHF" /></option>
                                <option value="OFF" <%=sliCode.equals("OFF") ? "selected" : ""%> ><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.OFF" /></option>
                                <option value="OTN" <%=sliCode.equals("OTN") ? "selected" : ""%> ><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.OTN" /></option>
						</select>
						
						<b>Admission date</b>:
						<input type="text" name="admission_date<%=i%>" id="admission_date<%=i%>" class="dateCA" value="<%=admissionDate%>"<%=getAdmissionDateOnKeydownString(i, vecDemographicNo.get(i), vecAppointmentNo.get(i))%> size="10" > 
						<img src="<%= request.getContextPath() %>/images/cal.gif" alt="" id="admission_date<%=i%>_cal">
						<!-- Disable calendar functionality for admission date (at least for now)
						<script>
							Calendar.setup( { inputField : "admission_date<%=i%>", ifFormat : "%Y-%m-%d", showsTime :false, button : "admission_date<%=i%>_cal", singleClick : true, step : 1,
								onUpdate: 
										function() { 
											var isValid = $('#submitbillingform').validate().element( '#admission_date<%=i%>');
											if (isValid) {
												setFocusOnInputField(<%=i%>);
											}
											
										}
							} );
						</script>
						-->
						<input type="checkbox" class="checkbox" name="manual_checkbox<%=i%>" value="yes" onclick="return !isElementReadOnly(this);" onkeydown="return !isElementReadOnly(this);"> <span class="input_element_label">Manual</span>
						<input type="checkbox" class="checkbox" name="referral_doc_checkbox<%=i%>" onclick="if (isElementReadOnly(this)) { return false; } toggleReferralDoctorVisible(<%=i%>); if (this.checked) setFocusOnReferralDoctorInput(<%=i%>);" onkeydown="return !isElementReadOnly(this);" > <span class="input_element_label">Referral Doctor</span>
						<input type="hidden" name="bill_id<%=i%>" value="<%=billId%>" >
						<input type="hidden" name="manual_checkbox<%=i%>" value="yes" >
						<input type="hidden" name="bill_date<%=i%>" value="<%=prop.getProperty("Service Date", "")%>" >
						<input type="hidden" name="bill_time<%=i%>" value="<%=prop.getProperty("Time", "")%>" >
						<input type="hidden" name="demo_name<%=i%>" value="<%=prop.getProperty("Patient Name", "")%>" >
						<input type="hidden" name="appt_no<%=i%>" value="<%=vecAppointmentNo.get(i)%>" >
						<input type="hidden" name="demo_no<%=i%>" value="<%=vecDemographicNo.get(i)%>" >
						<input type="hidden" name="prov_no<%=i%>" value="<%=vecProviderNo.get(i)%>" >
						<input type="hidden" id="referral_doc_no<%=i%>" name="referral_doc_no<%=i%>" value="<%=prop.getProperty( "rdocn", "" )%>" >
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
								<td>Percent</td>
								<td>Dx Code</td>
								<td>Dx Description</td>
								<td>Total</td>
								<!-- <td>SLI Code</td> -->
							</tr>
						</thead>
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
									<%=getUneditableBillingItemText(i, uniqueId, null)%>
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
										values.add("1.0"); // percent
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
											<%=getUneditableBillingItemText(i, uniqueId, values)%>
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
						<tbody>
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
									<%
									if (hasEChartPermission) {
									%>
										<table class="appointment_notes" id="appointment_notes<%=i%>" >
											<tbody><tr><td>Loading...Please wait.</td></tr></tbody>
										</table>
									<%
									} else {
									%>
										<div>You do not have sufficient priveleges to view the encounter notes.</div>
									<%
									}
									%>
								</div>
							</td>
						</tr>
					</tbody>
					</table>
				</td>
			</tr>
		<%}%>
	
	<% if(vecTotal.size() > 0) { %>
		<tr bgcolor="silver">
		<% for (int j=0; j < vecTotal.size(); j++) {%>
			<th><%=vecTotal.get(j) %>&nbsp;</th>
		<% } %>
		</tr>
	<%}%>

</tbody>
</table>


<br>

<hr width="100%">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tbody>
	<tr>
		<td>
			<a href=# onClick="javascript:history.go(-1);return false;">
				<img src="<%= request.getContextPath() %>/images/leftarrow.gif" alt="" border="0" width="25" height="20" align="absmiddle"> Back 
			</a>
		</td>
		<td align="right">
			<a href="" onClick="self.close();">
				Close the Window <img src="<%= request.getContextPath() %>/images/rightarrow.gif" alt="" border="0" width="25" height="20" align="absmiddle">
			</a>
		</td>
	</tr>
</tbody>
</table>

<%
if (editable) {
%>
<input type="hidden" name="number_of_bills" value="<%=vecValue.size()%>" >
</form>
<%
}
%>


<script type="text/javascript">
Calendar.setup( { inputField : "xml_vdate", ifFormat : "%Y/%m/%d", showsTime :false, button : "xml_vdate_cal", singleClick : true, step : 1,
	onUpdate: function() { $('#serviceform').validate().element( '#xml_vdate') }
} );
Calendar.setup( { inputField : "xml_appointment_date", ifFormat : "%Y/%m/%d", showsTime :false, button : "xml_appointment_date_cal", singleClick : true, step : 1,
	onUpdate: function() { $('#serviceform').validate().element( '#xml_appointment_date') }
} );
</script>

<script type="text/javascript">

totalNumberOfBills = <%=vecValue.size()%>;
incrementingId = <%=uniqueId%>;

</script>

</body>
</html>

<%! 
String getFormatDateStr(String str) {
    String ret = str;
	if(str.length() == 8) {
	    ret = str.substring(0,4) + "/" + str.substring(4,6) + "/" + str.substring(6);
	}
	return ret;
}

String getAdmissionDateOnKeydownString(int i, String demoNo, String apptNo) {
	String onkeydown = "onkeydown=\"";
	//onkeydown+= "if (isTabKey(event)) {";
	//onkeydown+= "	hideAllLookups("+i+"); ";
	//onkeydown+= "	return true; ";
	//onkeydown+= "}";
	onkeydown+= "var lookupIsOpen = isLookupOpen("+i+");";
	onkeydown+= "if (!lookupIsOpen) {";
	onkeydown+= "	if (isMoveBetweenBills(event) && isCtrlKey(event)) {";
	onkeydown+= "		moveBetweenBills(event, "+i+"); ";
	onkeydown+= "	}";
	onkeydown+= "} else {";
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

String getOnKeydownString(int i, String demoNo, String apptNo) {
	String onkeydown = "onkeydown=\"";
	//onkeydown+= "if (isTabKey(event)) {";
	//onkeydown+= "	hideAllLookups("+i+"); ";
	//onkeydown+= "	return true; ";
	//onkeydown+= "}";
	onkeydown+= "if (isDeleteBillingItemKey(event)) {";
	//onkeydown+= "	deleteBillingItem("+i+", "+uniqueId+");";
	onkeydown+= "";
	onkeydown+= "}";
	onkeydown+= "var lookupIsOpen = isLookupOpen("+i+");";
	onkeydown+= "if (!lookupIsOpen) {";
	onkeydown+= "	if (isSaveBill(event)) {";
	onkeydown+= "		if (saveBill("+i+")) { ";
	onkeydown+= "			moveToNextBill("+i+"); ";
	onkeydown+= "		}";
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
	onkeydown+= "		if (isTabKey(event))";
	onkeydown+= "			return false;";
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
	totalOnkeydown+= "	if (saveBill("+i+")) { ";
	totalOnkeydown+= "		moveToNextBill("+i+"); ";
	totalOnkeydown+= "	}";
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
	onkeyup+= "		else if (this.id.indexOf('amount') == 0 || this.id.indexOf('units') == 0 || this.id.indexOf('percent') == 0) {";
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
	
	while (values.size() < 8) {
		// 'units' should default to '1'
		if (values.size() == 2)
			values.add("1");
		// 'percent' should default to '1.0' (i.e. 100%)
		if (values.size() == 3)
			values.add("1.0");
		// everything else defaults to an empty string
		else 
			values.add("");
	}
	
	String html = "";
	html += "<tr id='billing_item"+i+"_"+uniqueId+"'>";
	html += "	<td> <a class='billing_button' href='' tabindex='-1' onclick='deleteBillingItem("+i+", "+uniqueId+"); updateBillTotal("+i+"); return false;' >X</a></td>";
	html += "	<td> <input type='text' size='6' name='bill_code"+i+"' id='bill_code"+i+"_"+uniqueId+"' value='"+values.get(0)+"' autocomplete='off' "+onkeydown+" "+onkeyup+" > <div id='service_code_lookup"+i+"_"+uniqueId+"' class='lookup_box' style='display:none;'></div> </td>";
	html += "	<td> <input type='text' size='6' name='amount"+i+"' id='amount"+i+"_"+uniqueId+"' class='currency' value='"+values.get(1)+"' "+onkeydown+" "+onkeyup+" > </td>";
	html += "	<td> <input type='text' size='3' name='units"+i+"' id='units"+i+"_"+uniqueId+"' value='"+values.get(2)+"' "+onkeydown+" "+onkeyup+" > </td>";
	html += "	<td> <input type='text' size='3' name='percent"+i+"' id='percent"+i+"_"+uniqueId+"' value='"+values.get(3)+"' "+onkeydown+" "+onkeyup+" > </td>";
	html += "	<td> <input type='text' size='6' name='dx_code"+i+"' id='dx_code"+i+"_"+uniqueId+"' value='"+values.get(4)+"' autocomplete='off' "+onkeydown+" "+onkeyup+" > <div id='diagnostic_code_lookup"+i+"_"+uniqueId+"' class='lookup_box' style='display:none;'></div> </td>";
	html += "	<td> <input type='text' size='12' name='dx_desc"+i+"' id='dx_desc"+i+"_"+uniqueId+"' value='"+values.get(5)+"' autocomplete='off' "+onkeydown+" "+onkeyup+" > <div id='diagnostic_desc_lookup"+i+"_"+uniqueId+"' class='lookup_box' style='display:none;'></div> </td>";
	html += "	<td> <input type='text' size='6' name='total"+i+"' id='total"+i+"_"+uniqueId+"' class='currency' value='"+values.get(6)+"' "+totalOnkeydown+" "+totalOnKeyup+" > </td>";
	//html += "	<td> <input type='text' size='6' name='sli_code"+i+"' id='sli_code"+i+"_"+uniqueId+"' disabled='disabled' value='"+values.get(7)+"' > </td>";
	html += "</tr>";
	
	return html;
}

String getUneditableBillingItemText(int i, int uniqueId, List<String> values) {	
	if (values == null) 
		values = new ArrayList<String>();
	
	while (values.size() < 8) {
		// 'units' should default to '1'
		if (values.size() == 2)
			values.add("1");
		// 'percent' should default to '1.0' (i.e. 100%)
		if (values.size() == 3)
			values.add("1.0");
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
	html += "	<td> <span>"+values.get(7)+"</span> </td>";
	html += "</tr>";
	
	return html;
}

int[] saveSubmittedBills(HttpServletRequest request, OscarAppointmentDao appointmentDao, BillingClaimDAO billingClaimDAO, BillingServiceDao billingServiceDao, DiagnosticCodeDao diagnosticCodeDao, DemographicDao demographicDao, ProviderDao providerDao ) {
	String tempNumberOfBills = request.getParameter("number_of_bills");
	int numBills = 0;
	try {
		numBills = Integer.parseInt(tempNumberOfBills);
	} catch (Exception e) {
	}
	
	int numBillsSubmitted = 0;
	int numBillsSaved = 0;
	
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
		provNo = (request.getParameter("billing_provider") == null? provNo : request.getParameter("billing_provider"));
		
		boolean isBillSaved = (request.getParameter("bill_saved"+i) != null);
		String billDate = request.getParameter("bill_date"+i);
		String billTime = request.getParameter("bill_time"+i);
		String admissionDate = request.getParameter("admission_date"+i);
		
		if (admissionDate == null)
			admissionDate = "";
		
		boolean isManuallyReviewed = (request.getParameter("manual_checkbox"+i) != null);
		String billNotes = request.getParameter("bill_notes"+i);
		String demoName = request.getParameter("demo_name"+i);
		boolean isReferralDocSelected = (request.getParameter("referral_doc_checkbox"+i) != null);
		String referralNo = request.getParameter("referral_doc_no"+i);		
		String sliCode = request.getParameter("sli_code"+i);
		String[] billCodes = request.getParameterValues("bill_code"+i);
		String[] amounts = request.getParameterValues("amount"+i);
		String[] units = request.getParameterValues("units"+i);
		String[] percents = request.getParameterValues("percent"+i);
		String[] dxCodes = request.getParameterValues("dx_code"+i);
		String[] dxDescs = request.getParameterValues("dx_desc"+i);
		String[] totals = request.getParameterValues("total"+i);
		//String[] sliCodes = request.getParameterValues("sli_code"+i);
		
		if (billId != null && isBillSaved) {
			numBillsSubmitted++;
			
			BillingClaimHeader1 newBill = null;
			BillingClaimHeader1 oldBill = null;
			
			// format/parse some of our input
			admissionDate = admissionDate.replace('/', '-');
			admissionDate = admissionDate.replace('\\', '-');
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date billDateAsDate = null;
			Date billTimeAsDate = null;
			
			try {
				billDateAsDate = (Date)formatter.parse(billDate);
			} catch (Exception e) {}
			
			formatter = new SimpleDateFormat("HH:mm:ss");
			try {
				billTimeAsDate = (Date)formatter.parse(billTime);
			} catch (Exception e) {}
			
			formatAmounts(amounts);
			formatPercents(percents);
			String total = formatAndCalculateTotal(totals);
						
			if (billId.equals("")) {
				Demographic demo = demographicDao.getDemographic(demoNo.toString());
				Provider prov = providerDao.getProvider(provNo);

				// create new bill
				newBill = new BillingClaimHeader1();
				
				newBill.setDemographic_no(demoNo);
				newBill.setProvider_no(provNo);
				newBill.setAppointment_no(apptNo);
				newBill.setBilling_date(billDateAsDate);
				newBill.setBilling_time(billTimeAsDate);
				newBill.setDemographic_name(demoName);
				//newBill.setStatus("W");
				newBill.setStatus("O");
				newBill.setApptProvider_no("none");
				if (isReferralDocSelected)
					newBill.setRef_num(referralNo);
		        newBill.setComment1(billNotes);
		        newBill.setAdmission_date(admissionDate);
		        newBill.setMan_review( (isManuallyReviewed ? "Y" : "") );
				
				String payProg = demo.getHcType().equals("ON") ? "HCP" : "RMB";
		        newBill.setPay_program(payProg);
				newBill.setHin(demo.getHin());
		        newBill.setVer(demo.getVer());
		        newBill.setDob(demo.getYearOfBirth() + demo.getMonthOfBirth() + demo.getDateOfBirth());
				newBill.setFacilty_num( "0000" );
				newBill.setLocation(sliCode);
				newBill.setSex(demo.getSex());
				newBill.setProvince(demo.getHcType());
				newBill.setProvider_ohip_no(prov.getOhipNo());
				newBill.setProvider_rma_no(prov.getRmaNo());
				newBill.setCreator( (String) request.getSession().getAttribute("user") );
				newBill.setTotal(total);
			} else {
				Integer billIdAsInteger = null;
			
				try {
					billIdAsInteger = Integer.parseInt(billId);
				} catch (Exception e) {
					MiscUtils.getLogger().error("Error while parsing bill Id.", e);
					continue;
				}
				
				oldBill = billingClaimDAO.getInvoice(billIdAsInteger);
				newBill = BillingClaimHeader1.copy(oldBill);
				
				//String apptProvNo = newBill.getApptProvider_no();
				
				// create new bill to replace old bill
				//bill = new BillingClaimHeader1();
				newBill.setDemographic_no(demoNo);
				newBill.setProvider_no(provNo);
				newBill.setAppointment_no(apptNo);
				newBill.setBilling_date(billDateAsDate);
				newBill.setBilling_time(billTimeAsDate);
				newBill.setDemographic_name(demoName);
				newBill.setLocation(sliCode);
				newBill.setStatus("W");
				
				if (admissionDate.length() > 0)
					newBill.setAdmission_date(admissionDate);
				
				//newBill.setApptProvider_no(apptProvNo);
				
				newBill.getBillingItems().clear();
			}
			
			// set values for billing items
			for (int j=0; j < billCodes.length; j++) {
						
				// skip 'empty' billing items
				//if (billCodes[j].length() == 0 && amounts[j].equals("0.00") && (units[j].length() == 0 || units[j].equals("1")) && dxCodes[j].length() == 0)
				//	continue;
				
		        BillingItem item = new BillingItem();
	            item.setCh1_id(newBill.getId());
	            item.setTransc_id(BillingDataHlp.ITEM_TRANSACTIONIDENTIFIER);
	            item.setRec_id(BillingDataHlp.ITEM_REORDIDENTIFICATION);
	            item.setService_code(billCodes[j]);
				
				double amount = Double.parseDouble(amounts[j]);
				double percent = Double.parseDouble(percents[j]);
				
	            item.setFee( String.format("%1$,.2f", amount * percent) );
	            item.setSer_num(units[j]);
	            item.setStatus("W");
				
	            item.setService_date(billDateAsDate);
				
				item.setDx(dxCodes[j]);
				item.setDx1("");
                item.setDx2("");
	
	            newBill.getBillingItems().add(item);
			}
			
			//boolean saveSuccessful = false;
			try {
			    // Validate
			    validate(newBill, billingServiceDao, diagnosticCodeDao);
				
				billingClaimDAO.createBill(newBill);
				numBillsSaved++;
				
				// set old bills' status as 'D' for deleted
				if (oldBill != null) {
					oldBill.setStatus("D");
					billingClaimDAO.updateBill(oldBill);
				}
				
				// update appointment status to be 'B' for billed
				Appointment appointment = appointmentDao.getAppointment(new Integer(apptNo));
				
				if (appointment != null) {
					appointment.setStatus("B");
					appointmentDao.updateAppointment(appointment);
				}
			} catch (Exception e) {
				MiscUtils.getLogger().error("Error while creating/updating bill:", e);
			}
		}
	}
	
	return new int[]{ numBills, numBillsSubmitted, numBillsSaved };
}

void formatAmounts(String[] amounts) {
	try {
		for (int j = 0; j < amounts.length; j++) {
			amounts[j] = amounts[j].replace("$", "");
			amounts[j] = amounts[j].replace(",", "");
			if (amounts[j].length() == 0)
				amounts[j] = "0";
				
			amounts[j] = "" + Double.parseDouble(amounts[j]);
		}
	} catch (Exception e) {
		MiscUtils.getLogger().error("error formatting amount:", e);
	}
}

void formatPercents(String[] percents) {
	try {
		for (int j = 0; j < percents.length; j++) {
			percents[j] = percents[j].replace("%", "");
			if (percents[j].length() == 0)
				percents[j] = "1";
				
			percents[j] = "" + Double.parseDouble(percents[j]);
		}
	} catch (Exception e) {
		MiscUtils.getLogger().error("error formatting percent:", e);
	}
}

String formatAndCalculateTotal(String[] totals) {
	double tempTotal = 0;
	String total = "";
	try {
		for (int j = 0; j < totals.length; j++) {
			totals[j] = totals[j].replace("$", "");
			totals[j] = totals[j].replace(",", "");

			if (totals[j].length() == 0)
				totals[j] = "0";
			tempTotal += Double.parseDouble(totals[j]);
		}
		total = String.format("%1$,.2f", tempTotal);
	} catch (Exception e) {
		MiscUtils.getLogger().error("total calc error:", e);
	}
	
	return total;
}

void validate(BillingClaimHeader1 newBill, BillingServiceDao billingServiceDao, DiagnosticCodeDao diagnosticCodeDao) throws ValidationException, ConstraintViolationException {
    // Validate
    Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
    Set<ConstraintViolation<BillingClaimHeader1>>  constraintViolations = validator.validate(newBill);
    
    // if there are validation errors, throw exception
    if (constraintViolations.size() > 0) {
		MiscUtils.getLogger().info("validation errors: " + constraintViolations.size());
		
		for (ConstraintViolation violation : constraintViolations) {
			MiscUtils.getLogger().info("validation error: " + violation.toString());
		}
		// error in ConstraintViolationException definition, so we need to create an intermediate collection
		// see: https://forum.hibernate.org/viewtopic.php?f=26&t=998831
		throw new ConstraintViolationException(new HashSet<ConstraintViolation<?>>(constraintViolations));
	}
	
	
	List<BillingItem> billingItems = newBill.getBillingItems();
	List<String> serviceCodes = new ArrayList<String>();
	List<String> diagnosticCodes = new ArrayList<String>();
	
	for (BillingItem item : billingItems) {
	
		Set<ConstraintViolation<BillingItem>> constraintViolationsBillingItems = validator.validate(item);
	    
	    // if there are validation errors, throw exception
	    if (constraintViolationsBillingItems.size() > 0) {
			MiscUtils.getLogger().info("validation errors: " + constraintViolationsBillingItems.size());
			
			for (ConstraintViolation violation : constraintViolationsBillingItems) {
				MiscUtils.getLogger().info("validation error: " + violation.toString());
			}
			// error in ConstraintViolationException definition, so we need to create an intermediate collection
			// see: https://forum.hibernate.org/viewtopic.php?f=26&t=998831
			throw new ConstraintViolationException(new HashSet<ConstraintViolation<?>>(constraintViolationsBillingItems));
		}
		
		serviceCodes.add(item.getService_code());
		diagnosticCodes.add(item.getDx());
	}
	
	// validate the service codes
	List<BillingService> billingServices = billingServiceDao.findBillingCodesByCode(serviceCodes, "ON");
	List<String> matchedServiceCodes = new ArrayList<String>();
	
	for (BillingService code : billingServices) {
		matchedServiceCodes.add(code.getServiceCode());
	}
	
	for (String code : serviceCodes) {
		if ( !matchedServiceCodes.contains(code) ) {
			throw new ValidationException(code + " is not a valid Billing Service Code!");
		}
	}
	
	// validate the diagnostic codes
	List<DiagnosticCode> diagnosticCodeList = diagnosticCodeDao.findDiagnosticCodesByCode(diagnosticCodes);
	List<String> matchedDiagnosticCodes = new ArrayList<String>();
	
	for (DiagnosticCode code : diagnosticCodeList) {
		matchedDiagnosticCodes.add(code.getDiagnosticCode());
	}
	
	for (String code : diagnosticCodes) {
		if ( code.length() != 0 && !matchedDiagnosticCodes.contains(code) ) {
			throw new ValidationException(code + " is not a valid Diagnostic Service Code!");
		}
	}
}
%>
