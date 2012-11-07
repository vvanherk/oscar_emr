
<%      
if(session.getValue("user") == null) response.sendRedirect("../../../logout.jsp");
String user_no = (String) session.getAttribute("user");
String asstProvider_no = "";
String color ="";
String premiumFlag="";
String service_form="", service_name="";
%>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ page import="java.util.*, java.sql.*, oscar.*, java.net.*"
	errorPage="errorpage.jsp"%>
<%@ page import="org.oscarehr.util.SpringUtils"%>
<%@ page import="org.oscarehr.common.dao.ClinicNbrDao"%>
<%@ page import="org.oscarehr.PMmodule.dao.ProviderDao"%>
<%@ page import="org.oscarehr.common.dao.ClinicLocationDao"%>
<%@ page import="org.oscarehr.common.model.ClinicNbr"%>
<%@ page import="org.oscarehr.common.model.Provider"%>
<%@ page import="org.oscarehr.common.model.ClinicLocation"%>
<%@ include file="../../../admin/dbconnection.jsp"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />


<%
String clinicview = request.getParameter("billingform")==null?oscarVariables.getProperty("default_view"):request.getParameter("billingform");
String reportAction=request.getParameter("reportAction")==null?"":request.getParameter("reportAction");

ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");
%>
<!--  
/*
 * 
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved. *
 * This software is published under the GPL GNU General Public License. 
 * This program is free software; you can redistribute it and/or 
 * modify it under the terms of the GNU General Public License 
 * as published by the Free Software Foundation; either version 2 
 * of the License, or (at your option) any later version. * 
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
 * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License 
 * along with this program; if not, write to the Free Software 
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. * 
 * 
 * <OSCAR TEAM>
 * 
 * This software was written for the 
 * Department of Family Medicine 
 * McMaster University 
 * Hamilton 
 * Ontario, Canada 
 */
-->
<html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title><bean:message key="billing.manageBillingform.title" /></title>
<link rel="stylesheet" href="billing.css">

<link rel="stylesheet" type="text/css" media="all" href="../share/css/extractedFromPages.css"  />

<style>

span.title {
    width: 90px;
    height: 25px;
	display:-moz-inline-block; 
	display:-moz-inline-box; 
	display:inline-block;
}

span.small_comment {
	font-size:9px;
	vertical-align: 4px;
}

div.left {
    float: left;
}

div.first {
    margin-top: 20px;
    margin-left: 5px;
}

div.bottom_bar {
	margin-top: 10px;
	clear: both;
}

div.bottom_buttons {
	margin-top: 140px;
	margin-left: 400px;
	clear: both;
}
</style>

<script type="text/javascript"
	src="../../../share/javascript/prototype.js"></script>

</head>

<body leftmargin="0" topmargin="5" rightmargin="0" >

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr bgcolor="#000000">
		<td height="40" width="10%"></td>
		<td width="90%" align="left">
		<p><font face="Verdana, Arial, Helvetica, sans-serif"
			color="#FFFFFF"><b><font
			face="Arial, Helvetica, sans-serif" size="4">oscar<font
			size="3"><bean:message
			key="billing.manageBillingform.msgBilling" /></font></font></b></font></p>
		</td>
	</tr>
</table>

<div class="left first">
<span class="title">
	Provider:
</span>

<select name="xml_provider">
<% //
List<Provider> providers = providerDao.getProviders();

String strProviderNo = request.getParameter("xml_provider") != null ? request.getParameter("xml_provider") : "";

for (Provider provider : providers) {

%>
	<option value="<%=provider.getProviderNo() + "|" + provider.getFormattedName()%>" <%=strProviderNo.startsWith(provider.getProviderNo())?"selected":""%>>
		<%=provider.getFormattedName()%>
	</option>
<% } %>
</select>

<a href="#" onclick="return false;">Reset</a>


<br>

<%
String visitType = "";
%>

<span class="title">
	Visit Type:
</span>

<select name="xml_visittype">
	<% if (OscarProperties.getInstance().getBooleanProperty("rma_enabled", "true")) { %>
	<% 
	ClinicNbrDao cnDao = (ClinicNbrDao) SpringUtils.getBean("clinicNbrDao"); 
	ArrayList<ClinicNbr> nbrs = cnDao.findAll();									            
	
	String providerSearch = user_no;
	Provider p = providerDao.getProvider(providerSearch);
	String providerNbr = SxmlMisc.getXmlContent(p.getComments(),"xml_p_nbr");
	for (ClinicNbr clinic : nbrs) {
		String valueString = String.format("%s | %s", clinic.getNbrValue(), clinic.getNbrString());
		%>
    	<option value="<%=valueString%>" <%=providerNbr.startsWith(clinic.getNbrValue())?"selected":""%>><%=valueString%></option>
    <%}%>
    <% } else { %>
    <option value="00| Clinic Visit" <%=visitType.startsWith("00")?"selected":""%>>00 | Clinic Visit</option>
    <option value="01| Outpatient Visit" <%=visitType.startsWith("01")?"selected":""%>>01 | Outpatient Visit</option>
    <option value="02| Hospital Visit" <%=visitType.startsWith("02")?"selected":""%>>02 | Hospital Visit</option>
    <option value="03| ER" <%=visitType.startsWith("03")?"selected":""%>>03 | ER</option>
    <option value="04| Nursing Home" <%=visitType.startsWith("04")?"selected":""%>>04 | Nursing Home</option>
    <option value="05| Home Visit" <%=visitType.startsWith("05")?"selected":""%>>05 | Home Visit</option>
    <% } %>
</select>


<br>

<span class="title">
	Location:
</span>

<select name="xml_location">
<% //
ClinicLocationDao clinicLocationDao = (ClinicLocationDao) SpringUtils.getBean("clinicLocationDao"); 
List<ClinicLocation> clinicLocations = clinicLocationDao.getAll();
String billLocationNo="";
String billLocation="";

for (ClinicLocation location : clinicLocations) {
	billLocationNo = location.getClinicLocationNo();
	billLocation = location.getClinicLocationName();


String strLocation = request.getParameter("xml_location") != null ? request.getParameter("xml_location") : clinicview;
%>
	<option value="<%=billLocationNo + "|" + billLocation%>" <%=strLocation.startsWith(billLocationNo)?"selected":""%>>
		<%=billLocation%>
	</option>
<% } %>
</select>


<br>
	
<%
String clinicNo = oscarVariables.getProperty("clinic_no", "").trim();
%>

<span class="title">
	SLI Code:
</span>

<select name="xml_slicode">
	<option value="<%=clinicNo%>"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.NA" /></option>
	<option value="HDS"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HDS" /></option>
	<option value="HED"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HED" /></option>
	<option value="HIP"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HIP" /></option>
	<option value="HOP"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HOP" /></option>
	<option value="HRP"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.HRP" /></option>
	<option value="IHF"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.IHF" /></option>
	<option value="OFF"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.OFF" /></option>
	<option value="OTN"><bean:message key="oscar.billing.CA.ON.billingON.OB.SLIcode.OTN" /></option>
</select>


<br>


<span class="title">
	
</span>

<input type="checkbox">
<span class="small_comment">
Only use SLI if required</span>
</div>


<br>

<div class="bottom_buttons">
	<a href="#" onclick="return false;">Save</a>
	&nbsp; &nbsp;
	<a href="#" onclick="window.close();">Close</a>
</div>

<div class="bottom_bar">
	<%@ include file="zfooterbackclose.jsp"%>
</div>

</body>
</html:html>
