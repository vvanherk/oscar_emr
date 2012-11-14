
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
<%@page import="org.oscarehr.util.MiscUtils"%>
<%@ page import="org.oscarehr.common.dao.ClinicNbrDao"%>
<%@ page import="org.oscarehr.PMmodule.dao.ProviderDao"%>
<%@ page import="org.oscarehr.common.dao.ClinicLocationDao"%>
<%@ page import="org.oscarehr.billing.dao.BillingDefaultDao"%>
<%@ page import="org.oscarehr.common.model.ClinicNbr"%>
<%@ page import="org.oscarehr.common.model.Provider"%>
<%@ page import="org.oscarehr.common.model.ClinicLocation"%>
<%@ page import="org.oscarehr.billing.model.BillingDefault"%>
<%@ include file="../../../admin/dbconnection.jsp"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />


<%
String clinicview = request.getParameter("billingform")==null?oscarVariables.getProperty("default_view"):request.getParameter("billingform");
String reportAction=request.getParameter("reportAction")==null?"":request.getParameter("reportAction");
String clinicNo = oscarVariables.getProperty("clinic_no", "").trim();

int nextPriorityValue = 0;

ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");
BillingDefaultDao billingDefaultDao = (BillingDefaultDao) SpringUtils.getBean("billingDefaultDao");
%>


<%
// Setup values for visit types and SLI codes
Map<String, String> visitTypeHashMap = new LinkedHashMap<String, String>(); 
visitTypeHashMap.put( "00", "Clinic Visit");
visitTypeHashMap.put( "01", "Outpatient Visit");
visitTypeHashMap.put( "02", "Hospital Visit");
visitTypeHashMap.put( "03", "ER");
visitTypeHashMap.put( "04", "Nursing Home");
visitTypeHashMap.put( "05", "Home Visit");



Map<String, String> sliCodeHashMap = new LinkedHashMap<String, String>(); 
ResourceBundle bundle = ResourceBundle.getBundle("oscarResources");

sliCodeHashMap.put( clinicNo + "", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.NA") );
sliCodeHashMap.put( "HDS", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.HDS") );
sliCodeHashMap.put( "HED", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.HED") );
sliCodeHashMap.put( "HIP", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.HIP") );
sliCodeHashMap.put( "HOP", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.HOP") );
sliCodeHashMap.put( "HRP", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.HRP") );
sliCodeHashMap.put( "IHF", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.IHF") );
sliCodeHashMap.put( "OFF", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.OFF") );
sliCodeHashMap.put( "OTN", bundle.getString("oscar.billing.CA.ON.billingON.OB.SLIcode.OTN") );


ClinicLocationDao clinicLocationDao = (ClinicLocationDao) SpringUtils.getBean("clinicLocationDao"); 
List<ClinicLocation> clinicLocations = clinicLocationDao.getAll();
String billLocationNo="";
String billLocation="";

Map<String, String> locationHashMap = new LinkedHashMap<String, String>(); 
for (ClinicLocation location : clinicLocations) {
	locationHashMap.put( location.getClinicLocationNo(), location.getClinicLocationName() );
}


List<Provider> providers = providerDao.getActiveProviders();
Map<String, String> providerHashMap = new LinkedHashMap<String, String>(); 

for (Provider provider : providers) {
	providerHashMap.put( provider.getProviderNo(), provider.getFormattedName() );
}
%>


<%
// Handle form submission
String actionResult = "";
boolean actionSuccessful = true;

if (request.getParameter("provider") != null) {
	// saving or updating a billing default
	actionResult = "Successfully saved billing defaults!";
	
	String billing_default_id = request.getParameter("billing_default_id");
	Integer billingDefaultId = new Integer( -1 );
	String provider = request.getParameter("provider");
	String location = request.getParameter("location");
	String sli_code = request.getParameter("sli_code");
	String visit_type = request.getParameter("visit_type");
	String billing_default_priority = request.getParameter("billing_default_priority");
	
	if (billing_default_id != null && !billing_default_id.equals("")) {
		try {
			billingDefaultId = new Integer( billing_default_id );
		} catch (Exception e) {
			MiscUtils.getLogger().error("Error", e);
		}
	}
	
	if (billingDefaultId.intValue() != -1) {
		BillingDefault billingDefault = billingDefaultDao.findById( billingDefaultId );
		try {
			billingDefault.setProviderNo( provider );
			billingDefault.setLocationNo( location );
			billingDefault.setSliCode( sli_code );
			billingDefault.setVisitTypeNo( visit_type );
			billingDefault.setPriority( new Integer(billing_default_priority) );
			
			billingDefaultDao.updateBillingDefault( billingDefault );
		} catch (Exception e) {
			actionResult = "Error saving billing defaults";
			actionSuccessful = false;
			MiscUtils.getLogger().error("Error", e);
		}
	} else {
		BillingDefault billingDefault = new BillingDefault();
		billingDefault.setProviderNo( provider );
		billingDefault.setLocationNo( location );
		billingDefault.setSliCode( sli_code );
		billingDefault.setVisitTypeNo( visit_type );
		//billingDefault.setPriority( new Integer(billing_default_priority) );
		
		billingDefaultDao.saveBillingDefault( billingDefault );
	}
	
} else if (request.getParameter("action") != null && request.getParameter("action").equals("delete")) {
	// Delete a billing default
	actionResult = "Successfully deleted billing default!";
	
	try {
		billingDefaultDao.deleteById( new Integer(request.getParameter("billing_default_id").trim()) );	
	} catch (Exception e) {
		actionResult = "Error deleting billing default";
		actionSuccessful = false;
		MiscUtils.getLogger().error("Error", e);
	}
	
} else if (request.getParameter("priorities_form_billing_default_id") != null) {
	// Update priorities for billing defaults
	actionResult = "Successfully updated billing defaults' priorities!";
	
	String[] billingDefaultIds = request.getParameterValues("priorities_form_billing_default_id");
	String[] billingDefaultPriorities = request.getParameterValues("priorities_form_billing_default_priority");
	
	for (int i=0; i < billingDefaultIds.length; i++) {
		try {			
			BillingDefault billingDefault = billingDefaultDao.findById( new Integer(billingDefaultIds[i]) );
			billingDefault.setPriority( new Integer(billingDefaultPriorities[i]) );
			billingDefaultDao.updateBillingDefault( billingDefault );
		} catch (Exception e) {
			actionResult = "Error updating billing defaults' priorities";
			actionSuccessful = false;
			MiscUtils.getLogger().error("Error", e);
		}
	}
}
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
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

.clear {
	clear: both;
}

.hidden {
	visibility: hidden;
}

th.priority_list {
	text-align:left;
	font-weight:bold;
}

.success {
	margin-top: 10px;
	margin-left: 5px;
	font-weight:bold;
	color:green;
}

.error {
	margin-top: 10px;
	margin-left: 5px;
	font-weight:bold;
	color:red;
}
</style>

<script type="text/javascript"
	src="../../../share/javascript/prototype.js">
</script>

<script type="text/javascript">
var billingDefaults = new Array();
var defaults = new Object();

<%
	List<BillingDefault> billingDefaults = billingDefaultDao.getAll();
	for (BillingDefault billingDefault : billingDefaults) {
		if (billingDefault.getPriority() != null && billingDefault.getPriority().intValue() > nextPriorityValue)
			nextPriorityValue = billingDefault.getPriority().intValue();
%>
		defaults = new Object();
		defaults['id']						= <%=billingDefault.getId()%>;
		defaults['provider_no']				= <%=billingDefault.getproviderNo()%>;
		defaults['visit_type_no']			= "<%=billingDefault.getVisitTypeNo()%>";
		defaults['location_no']				= "<%=billingDefault.getLocationNo()%>";
		defaults['sli_code']				= "<%=billingDefault.getSliCode()%>";
		defaults['priority']				= "<%=billingDefault.getPriority()%>";
		defaults['sli_only_if_required']	= <%=billingDefault.getSliOnlyIfRequired()%>;

		billingDefaults.push( defaults );
<%
	}
%>
</script>


<script type="text/javascript">
	$(document).ready(function() {
	    $(".up,.down").click(function() {
	        var row = $(this).parents("tr:first");
	        if ($(this).is(".up")) {
	            var id1 = row.find("td").eq(1).html();
	            var id2 = row.prev().find("td").eq(1).html();
		        if (id1 != undefined && id2 != undefined) {
		            swapPriorities(id1, id2);            
				}
				
	            row.insertBefore(row.prev());
	        } else {
	            var id1 = row.find("td").eq(1).html();
	            var id2 = row.next().find("td").eq(1).html();
		        if (id1 != undefined && id2 != undefined) {    
		            swapPriorities(id1, id2);
				}
				
	            row.insertAfter(row.next());
	        }
	    });
	});
	
	function swapPriorities(id1, id2) {
		var elem1 = $('input[id^="billing_default_priority'+$.trim(id1)+'"]');
		var elem2 = $('input[id^="billing_default_priority'+$.trim(id2)+'"]');
		
		var value1 = elem1.val();
		var value2 = elem2.val();
		//alert(value1 + " " + value2);
		
		elem1.val( value2 );
		elem2.val( value1 );
		
		//alert(elem1.val() + " " + elem2.val());
	}
	
	function setPriority(id, priority) {
		var elem = $('input[id^="billing_default_priority"'+id+']');
		
		elem.val(priority);
	}
	
	function setBillingDefaultsById(id) {
		for (var i = 0; i < billingDefaults.length; i++) {
		    if (billingDefaults[i]['id'] == id) {
				setBillingDefaults( billingDefaults[i] );
				break;
			}
		}
	}

	function setBillingDefaults(defaults) {
		var elem = $('input[name="billing_default_id"]');
		elem.val( defaults['id'] );
		
		elem = $('select[name="provider"]');
		elem.val( defaults['provider_no'] ).attr('selected',true);
		
		elem = $('select[name="location"]');
		elem.val( defaults['location_no'] ).attr('selected',true);
		
		elem = $('select[name="sli_code"]');
		elem.val( defaults['sli_code'] ).attr('selected',true);
		
		elem = $('select[name="visit_type"]');
		elem.val( defaults['visit_type_no'] ).attr('selected',true);
		
		elem = $('input[name="billing_default_priority"]');
		elem.val( defaults['priority'] );
		
		elem = $('input[name="sli_only_if_required"]');
		elem.attr('checked',true);
	}
	
	function saveBillingDefaults(defaults) {
		
	}
	
	function resetBillingDefaults() {
		$('select[name="provider"]').find('option:first').attr('selected', 'selected');
		$('select[name="location"]').find('option:first').attr('selected',true);
		$('select[name="sli_code"]').find('option:first').attr('selected',true);
		$('select[name="visit_type"]').find('option:first').attr('selected',true);
		$('input[name="billing_default_id"]').attr('value','');
		$('input[name="billing_default_priority"]').attr('value','<%=nextPriorityValue%>');
	}
	
	function submitForm() {
	  document.forms["billing_page_defaults"].submit();
	}
	
	function submitUpdatePriorityForm() {
		document.forms["update_priorities_form"].submit();
	}
	
	function submitDeleteBillingDefault(element) {
		var row = $(element).parents("tr:first");
		var id = row.find("td").eq(1).html();
		//alert(row + " " + id);
		if (id != undefined) {
			document.location.href='billingPageDefaults.jsp?action=delete&billing_default_id='+id;
		}
	}
	
	function setEditBillingDefault(element) {
		var row = $(element).parents("tr:first");
		var id = row.find("td").eq(1).html();
		
		setBillingDefaultsById(id);
	}
</script>

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

<%
if (actionResult.length() > 0) {
	String cssClass = (actionSuccessful? "success" : "error");
%>
<div class="<%=cssClass%>">
	<%=actionResult%>
</div>
<%
}
%>

<form id="billing_page_defaults" action="billingPageDefaults.jsp">

<input type="hidden" name="billing_default_id">
<input type="hidden" name="billing_default_priority" value="<%=nextPriorityValue%>">

<div class="left first">
<span class="title">
	Provider:
</span>

<select name="provider" id="provider">
<% //
String strProviderNo = request.getParameter("xml_provider") != null ? request.getParameter("xml_provider") : "";

for (Map.Entry<String, String> entry : providerHashMap.entrySet()) {
		    String key = entry.getKey();
		    String value = entry.getValue();
%>
	<option value="<%=key%>" <%=strProviderNo.startsWith(key)?"selected":""%>>
		<%=value%>
	</option>
<% } %>
</select>

<a href="#" onclick="resetBillingDefaults(); return false;">Reset</a>


<br>

<%
String visitType = "";
%>

<span class="title">
	Visit Type:
</span>

<select name="visit_type" id="visit_type">
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
    <% } else { 
		for (Map.Entry<String, String> entry : visitTypeHashMap.entrySet()) {
		    String key = entry.getKey();
		    String value = entry.getValue();
		    %>
		    <option value="<%=key%>" <%=visitType.startsWith(key)?"selected":""%>><%=key%> | <%=value%></option>
		    <%
		}
	} %>
</select>


<br>

<span class="title">
	Location:
</span>

<select name="location" id="location">
<%
for (Map.Entry<String, String> entry : locationHashMap.entrySet()) {
    String key = entry.getKey();
    String value = entry.getValue();
	String strLocation = request.getParameter("xml_location") != null ? request.getParameter("xml_location") : clinicview;
%>
	<option value="<%=key%>" <%=strLocation.startsWith(key)?"selected":""%>>
		<%=value%>
	</option>
<% } %>
</select>


<br>

<span class="title">
	SLI Code:
</span>

<select name="sli_code" id="sli_code">

<%
for (Map.Entry<String, String> entry : sliCodeHashMap.entrySet()) {
    String key = entry.getKey();
    String value = entry.getValue();
    %>
    <option value="<%=key%>"><%=value%></option>
    <%
}
%>
	
</select>


<br>

<!--
<span class="title">
	
</span>

<input type="checkbox" name="use_sli_if_required" id="use_sli_if_required">
<span class="small_comment">
	Only use SLI if required
</span>
-->


</div>


<br>

<div class="bottom_buttons">
	<a href="#" onclick="submitForm(); return false;">Add/Update</a>
	&nbsp; &nbsp;
	<a href="#" onclick="window.close();">Close</a>
</div>

</form>


<br>
<br>


<form id="update_priorities_form" action="billingPageDefaults.jsp">

<a href="#" onclick="submitUpdatePriorityForm(); return false;">Update Priorities</a>
<br>
<br>

<%
	for (BillingDefault billingDefault : billingDefaults) {
%>
	<input type="hidden" name="priorities_form_billing_default_id" value="<%=billingDefault.getId()%>">
	<input type="hidden" id="billing_default_priority<%=billingDefault.getId()%>" name="priorities_form_billing_default_priority" value="<%=billingDefault.getPriority()%>">
<%
	}
%>

<table class="clear">
<tr>
	<th>  </th>
	<th>  </th>
	<th class="priority_list"> Provider </th>
	<th class="priority_list"> Visit Type </th>
	<th class="priority_list"> Location </th>
	<th class="priority_list"> SLI Code </th>
	<th>  </th>
	<th>  </th>
</tr>
<%
	for (BillingDefault billingDefault : billingDefaults) {
%>
    <tr>
		<td> <a href="#" onclick="submitDeleteBillingDefault(this); return false;">D</a> <a href="#" onclick="setEditBillingDefault(this); return false;">E</a> </td>
		<td class="hidden"> <%=billingDefault.getId()%> </td>
        <td> <%=providerHashMap.get( billingDefault.getproviderNo() )%> </td>
        <td> <%=visitTypeHashMap.get( billingDefault.getVisitTypeNo() )%> </td>
        <td> <%=locationHashMap.get( billingDefault.getLocationNo() )%></td>
        <td> <%=sliCodeHashMap.get( billingDefault.getSliCode() )%> </td>
        <td> <%=billingDefault.getPriority()%> </td>
        <td>
            <a href="#" class="up">Up</a>
            <a href="#" class="down">Down</a>
        </td>
    </tr>
<%
	}
%>
</table>

</form>

</body>
</html:html>
