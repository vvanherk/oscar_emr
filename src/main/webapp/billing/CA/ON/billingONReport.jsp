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
<%    
if(session.getAttribute("user") == null) response.sendRedirect("../logout.jsp");
String user_no = (String) session.getAttribute("user");


int nItems=0;
String strLimit1=request.getParameter("limit1")!=null?"0":request.getParameter("limit1");
String strLimit2=request.getParameter("limit2")!=null?"25":request.getParameter("limit2");
String providerview = request.getParameter("providerview")==null?"all":request.getParameter("providerview") ;
OscarProperties props = OscarProperties.getInstance();
if(props.getProperty("isNewONbilling", "").equals("true")) {
%>
<script> window.location.href = "batch_billing/index.jsp"; </script>
<% } %>


<%@ page
	import="java.util.*, java.sql.*, oscar.login.*, oscar.*, java.net.*"
	errorPage="errorpage.jsp"%>
<%@ include file="../../../admin/dbconnection.jsp"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />
<jsp:useBean id="SxmlMisc" class="oscar.SxmlMisc" scope="session" />
<%@ include file="dbBilling.jspf"%>

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
Vector vecHeader = new Vector();
Vector vecValue = new Vector();
Vector vecTotal = new Vector();
Properties prop = null;
DBHelp dbObj = new DBHelp();
ResultSet rs = null;
String sql = null;

String action = request.getParameter("reportAction") == null ? "" : request.getParameter("reportAction");
if("unbilled".equals(action)) {
    vecHeader.add("SERVICE DATE");
    vecHeader.add("TIME");
    vecHeader.add("PATIENT");
    vecHeader.add("DESCRIPTION");
    vecHeader.add("COMMENTS");
    sql = "select * from appointment where provider_no='" + providerview + "' and appointment_date >='" + xml_vdate 
            + "' and appointment_date<='" + xml_appointment_date + "' and (status='P' or status='H' or status='HS' or status='PV' or status='PS' or status='E' or status='ES' or status='EV')" 
            + " and demographic_no != 0 order by appointment_date , start_time ";
    rs = dbObj.searchDBRecord(sql);
    while (rs.next()) {
        prop = new Properties();
        prop.setProperty("SERVICE DATE", rs.getString("appointment_date"));
        prop.setProperty("TIME", rs.getString("start_time").substring(0,5));
        prop.setProperty("PATIENT", rs.getString("name"));
        prop.setProperty("DESCRIPTION", rs.getString("reason"));
        String tempStr = "<a href=# onClick='popupPage(700,1000, \"billingOB.jsp?billForm=" 
                + URLEncoder.encode(oscarVariables.getProperty("default_view")) + "&hotclick=&appointment_no="
                + rs.getString("appointment_no") + "&demographic_name=" + URLEncoder.encode(rs.getString("name"))
				+ "&demographic_no=" + rs.getString("demographic_no") + "&user_no=" + rs.getString("provider_no") 
				+ "&apptProvider_no=" + providerview + "&appointment_date=" + rs.getString("appointment_date") 
				+ "&start_time=" + rs.getString("start_time") + "&bNewForm=1\"); return false;'>Bill ";
        prop.setProperty("COMMENTS", tempStr);
        vecValue.add(prop);
    }

}

if("billed".equals(action)) {
    vecHeader.add("SERVICE DATE");
    vecHeader.add("TIME");
    vecHeader.add("PATIENT");
    vecHeader.add("DESCRIPTION");
    vecHeader.add("ACCOUNT");
    sql = "select * from billing where provider_no='" + providerview + "' and billing_date >='" + xml_vdate 
            + "' and billing_date<='" + xml_appointment_date + "' and (status<>'D' and status<>'S' and status<>'B')" 
            + " order by billing_date , billing_time ";
    rs = dbObj.searchDBRecord(sql);
    while (rs.next()) {
        prop = new Properties();
        prop.setProperty("SERVICE DATE", rs.getString("billing_date"));
        prop.setProperty("TIME", rs.getString("billing_time").substring(0,5));
        prop.setProperty("PATIENT", rs.getString("demographic_name"));
        
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

    	prop.setProperty("DESCRIPTION", reason + "(" + note + ")");
        String tempStr = "<a href=# onClick='popupPage(700,720, \"../../../billing/CA/BC/billingView.do?billing_no="
                + rs.getString("billing_no") + "&dboperation=search_bill&hotclick=0\"); return false;' title="
                + reason + ">" + rs.getString("billing_no") + "</a>";
  	    prop.setProperty("ACCOUNT", tempStr);
        vecValue.add(prop);
    }
    
    
}

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
    Vector vecBillingNo = new Vector();
    Properties propTotal = new Properties();
    sql = "select billing_no,total from billing where provider_no='" + providerview 
    + "' and billing_date>='" + xml_vdate + "' and billing_date<='" + xml_appointment_date 
    + "' and status ='S' order by billing_date, billing_time";
    
    // change 'S' to 'O' for testing
    
    rs = dbObj.searchDBRecord(sql);
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
    rs = dbObj.searchDBRecord(sql);
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
			float fAmountclaim = Float.parseFloat(sAmountclaim);
			fAmountclaim = fAmountclaim + Float.parseFloat(rs.getString("amountclaim"));
			sAmountclaim = "" + Math.round(fAmountclaim*100)/100.00;
			float fAmountpay = Float.parseFloat(sAmountpay);
			fAmountpay = fAmountpay + Float.parseFloat(rs.getString("amountpay"));
			sAmountpay = "" + Math.round(fAmountpay*100)/100.00;
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
	rs = dbObj.searchDBRecord(sql);
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

<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title>ON Billing Report</title>
<link rel="stylesheet" href="../../web.css">
<link rel="stylesheet" type="text/css" media="all" href="../share/css/extractedFromPages.css"  />
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
			<%="billed".equals(action)? "checked" : "" %>>Billed <input
			type="radio" name="reportAction" value="paid"
			<%="paid".equals(action)? "checked" : "" %>>Paid <input
			type="radio" name="reportAction" value="unpaid"
			<%="unpaid".equals(action)? "checked" : "" %>>Unpaid </font></td>
		<td width="20%" align="right" nowrap><b>Provider </b></font> <select
			name="providerview">
			<% 
String proFirst="";
String proLast="";
String proOHIP="";
String specialty_code; 
String billinggroup_no;
int Count = 0;

ResultSet rslocal = apptMainBean.queryResults("billingreport", "search_reportprovider");
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
		</select></td>
		<td align="center" nowrap><font size="1"> From:</font> <input
			type="text" name="xml_vdate" id="xml_vdate" size="10"
			value="<%=xml_vdate%>"> <font size="1"> <img
			src="../../../images/cal.gif" id="xml_vdate_cal"> To:</font> <input
			type="text" name="xml_appointment_date" id="xml_appointment_date"
			onDblClick="calToday(this)" size="10"
			value="<%=xml_appointment_date%>"> <img
			src="../../../images/cal.gif" id="xml_appointment_date_cal"></td>
		<td align="right"><input type="submit" name="Submit"
			value="Create Report"> </font></td>
	</tr>
	<tr>
		</form>
</table>

<table border="1" cellspacing="0" cellpadding="0" width="100%"
	bordercolorlight="#99A005" bordercolordark="#FFFFFF" bgcolor="#FFFFFF">
	<tr bgcolor=<%="#ccffcc" %>>
		<% for (int i=0; i<vecHeader.size(); i++) {%>
		<th><%=vecHeader.get(i) %></th>
		<% } %>
		<% for (int i=0; i<vecValue.size(); i++) {%>
	
	<tr bgcolor="<%=i%2==0? "ivory" : "#EEEEFF" %>">
		<% for (int j=0; j<vecHeader.size(); j++) {
	    prop = (Properties)vecValue.get(i);
	%>
		<td align="center"><%=prop.getProperty((String)vecHeader.get(j), "&nbsp;") %>&nbsp;</td>
		<% } %>
	</tr>
	<% } %>

	<% if(vecTotal.size() > 0) { %>
	<tr bgcolor="silver">
		<% for (int i=0; i < vecTotal.size(); i++) {%>
		<th><%=vecTotal.get(i) %>&nbsp;</th>
		<% } %>
	</tr>
	<% } %>

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

</body>
<script type="text/javascript">
Calendar.setup( { inputField : "xml_vdate", ifFormat : "%Y/%m/%d", showsTime :false, button : "xml_vdate_cal", singleClick : true, step : 1 } );
Calendar.setup( { inputField : "xml_appointment_date", ifFormat : "%Y/%m/%d", showsTime :false, button : "xml_appointment_date_cal", singleClick : true, step : 1 } );
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
%>
