<!DOCTYPE html>
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

<%@page import="java.util.List, java.util.Set, java.util.Collections, java.util.Comparator, java.util.Date, java.util.Calendar, java.text.SimpleDateFormat" %>
										<%-- General imports--%>
<%@page import="oscar.OscarProperties" %>
<%@page import="org.oscarehr.util.SpringUtils" %>
										<%-- required imports for Provider-based queries--%>
<%@page import="org.oscarehr.PMmodule.dao.ProviderDao" %>
<%@page import="org.oscarehr.common.model.Provider" %>
<%@page import="org.oscarehr.common.dao.ProviderBillCenterDao" %>
<%@page import="org.oscarehr.common.model.ProviderBillCenter" %>

										<%-- required imports for billing-based queries--%>
<%@page import="org.oscarehr.common.dao.ProfessionalSpecialistDao" %>
<%@page import="org.oscarehr.common.model.ProfessionalSpecialist" %>
<%@ page import="org.oscarehr.billing.CA.ON.model.BillingONFavourite" %>
<%@ page import="org.oscarehr.billing.CA.ON.dao.BillingONFavouriteDao" %>
<%@page import="org.oscarehr.common.dao.DiagnosticCodeDao" %>
<%@page import="org.oscarehr.common.model.DiagnosticCode" %>
										<%-- required imports for location-based queries--%>
<%@page import="org.oscarehr.common.model.ClinicLocation"%>
<%@page import="org.oscarehr.common.dao.ClinicLocationDao"%>





										<%-- DAO initialization --%>

<% ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
   ProviderBillCenterDao providerBillCenterDao = (ProviderBillCenterDao)SpringUtils.getBean("providerBillCenterDao");
   ClinicLocationDao clinicLocationDao = (ClinicLocationDao)SpringUtils.getBean("clinicLocationDao");
   BillingONFavouriteDao superCodeDao = (BillingONFavouriteDao)SpringUtils.getBean("billingONFavouriteDao");
   DiagnosticCodeDao diagnosticCodeDao = (DiagnosticCodeDao)SpringUtils.getBean("diagnosticCodeDao");

   ProfessionalSpecialistDao prSpecialistDao = (ProfessionalSpecialistDao)SpringUtils.getBean("professionalSpecialistDao");
%>



											<%-- security checks required for every page--%>


<%@ taglib uri="/WEB-INF/security.tld" prefix="security"%>
<%
    if(session.getAttribute("userrole") == null )  response.sendRedirect("../logout.jsp"); 
    String roleName$ = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
	boolean isTeamBillingOnly=false; 
%>											<%-- you best be checking for authentificaion --%>
<security:oscarSec objectName="_team_billing_only" roleName="<%= roleName$ %>" rights="r" reverse="false">
		<% isTeamBillingOnly=true; %>
</security:oscarSec>

<%    
if(session.getAttribute("user") == null) response.sendRedirect("../logout.jsp");
oscar.OscarProperties oscarVariables = oscar.OscarProperties.getInstance();
%>



											<%-- Session information --%>

<%
String user_no = (String) session.getAttribute("user"); 
%>

<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="bootstrap-responsive.css" />
	<link rel="stylesheet" href="add-ons.css"/>
	<link rel="stylesheet" href="main.css"/>
		
        <title>Billing Bootstrapped</title>

    	<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
	<script type="text/javascript" src="add-ons.js"></script>
	<script type="text/javascript" src="main.js"></script>
	<script type="text/javascript" src="objects.js"></script>

	<script>
	
	var providers = [];
	var superCodes = [];
	var dxCodes = [];
	var billCtrCodeKeyVal = {G:"Hamilton", J:"Kingston", P:"London", E:"Mississauga", F:"Oshawa",
		D:"Ottawa", R:"Sudbury", U:"Thunder Bay", N:"Toronto", Z:"Error"};	
	
	//define your dropdown lists here
	<%		//Provider info: list of providers and group numbers/Billing Location
		String  providerSelectionList = "";				

		List<Provider> prList = providerDao.getProviders(true);
		for(int i=0; i < prList.size(); i++){	
			Provider curr = prList.get(i);
			int provNo;
			try{
				provNo = Integer.parseInt(curr.getProviderNo());
			} catch ( Exception e){
				continue;
			}
			if(provNo > 0 && provNo != 999998){			//do not include sysadmin or oscardoc
				providerSelectionList += "<option value='"+ provNo +"'>";
				providerSelectionList += curr.getFormattedName();
				providerSelectionList += "</option>";
								//group number needs to be parsed from xml formatted comments
				String comment = curr.getComments();		
				String groupNo = "00000";
				String xml_parse = "<xml_p_billinggroup_no>";

				ProviderBillCenter pbc =  providerBillCenterDao.find(provNo+"");
				String bc_code = (pbc != null && pbc.getBillCenterCode().length()==1)? pbc.getBillCenterCode(): "Z";

				if(comment != null && comment.indexOf(xml_parse) >= 0){ //if it exists
					groupNo = comment.substring(comment.indexOf(xml_parse) + xml_parse.length(),
							 comment.indexOf("</xml_p_billinggroup_no>"));
				}
		%>
			
			providers [<%= provNo %>] = new provider("<%= curr.getFormattedName() %>", "<%= groupNo %>", billCtrCodeKeyVal['<%= bc_code %>']);	

		<%		
			} 	
		}
		String clinicSelectionList = "";				//Clinic info: list of clinic locations
		List<ClinicLocation> clList = clinicLocationDao.findByClinicNo(1);
		for(int i=0; i < clList.size(); i++){	
			ClinicLocation curr = clList.get(i);
			int clLocNo = Integer.parseInt(curr.getClinicLocationNo());
			clinicSelectionList += "<option value='"+ clLocNo +"'>";
			clinicSelectionList += curr.getClinicLocationName();
			clinicSelectionList += "</option>";	
		} 	

		String superCodeSelectionList = "";
		List<BillingONFavourite> SCList = superCodeDao.findAllBillingONFav();
		for(int i=0; i < SCList.size(); i++){	
			BillingONFavourite curr = SCList.get(i);
			int SCNo = i+1;
			superCodeSelectionList += "<option value='"+ SCNo +"'>";
			superCodeSelectionList += curr.getName();
			superCodeSelectionList += "</option>";	
	%>
			superCodes["<%=curr.getName()%>"]= "<%=curr.getServiceDx()%>";
	<%
		} 	

		String dxCodeSelectionList = "[";
		List<DiagnosticCode> dxList = diagnosticCodeDao.search("%");
		for(int i=0; i < dxList.size(); i++){	
			DiagnosticCode curr = dxList.get(i);
	%>
			dxCodes["<%=curr.getDiagnosticCode()%>"]= "<%=curr.getDescription().trim()%>";
	<%
		} 

		String pSpecSelectionList = "<option value ='0'> N/A </option>";
		List<ProfessionalSpecialist> spList = prSpecialistDao.findAll();
		for(int i=0; i < spList.size(); i++){	
			ProfessionalSpecialist curr = spList.get(i);
			String pName = (curr.getProfessionalLetters() == null) ? "" : curr.getProfessionalLetters();
			if(curr.getReferralNo() != null){
				pName+= " " + curr.getLastName() + ", " + curr.getFirstName();
				pSpecSelectionList += "<option value='"+ curr.getReferralNo() +"'>";
				pSpecSelectionList += pName;
				pSpecSelectionList += "</option>";	
			}
		}

		String sliCodeSelectionList = "<option value='0'> Not Applicable </option><option value='HDS'> HDS | Hospital Day Surgery </option><option value='HED'> HED | Hospital Emergency Department </option><option value='HIP'> HIP | Hospital In-Patient </option><option value='HOP'> HOP | Hospital Out-Patient </option><option value='HRP'> HRP | Hospital Referred Patient </option><option value='IHF'> IHF |Independant Health Facility </option><option value='OFF'> OFF | Office of community Physician </option><option value='OTRN'> OTN | Ontario Telemedicine Network </option>";

	%>
	$(function(){
		var address = window.location + '';
		var contentID = '#' + address.split('#')[1]; // drops everything before #
		
		
		$('#billingNav').tab();
		$('#billingNav').bind("click", function(e){
			
			contentID = $(e.target).attr("href");
 			window.location = address.split('#')[0] + contentID;
			location.reload();
			
		});
		
		if(contentID === "#workbench"){
			$(contentID).load("wbforms.jsp");
		} else {
			$(contentID).load("forms.jsp " + contentID,{ 
				'providers': "<%=providerSelectionList%>",
				'locations': "<%=clinicSelectionList%>",
				'superCodes': "<%= superCodeSelectionList %>",
				'rDoctors' : "<%= pSpecSelectionList %>",
				'sliCodes' : "<%= sliCodeSelectionList %>"
			},	function(){
				$.getScript(contentID.slice(1) +".js");
			});
		}
		
		$('#billingNav a[href="'+ contentID + '"]').tab("show");
	});

	</script>

    </head>
    <body>
	<div class="alert warning" style="display:none;">
    		<button type="button" class="close" data-dismiss="alert">&times;</button>
   			<strong>Warning!</strong><span id='text-here'></span>
    	</div>
    	<div class="alert alert-error" style="display:none;">
    		<button type="button" class="close" data-dismiss="alert">&times;</button>
   			<strong>Error!</strong><span id='text-here'></span>
    	</div>
    	<div class="alert alert-success" style="display:none;">
    		<button type="button" class="close" data-dismiss="alert">&times;</button>
   			<strong>Success!</strong><span id='text-here'></span>
    	</div>
	<h3 align="center"> Oscar Billing </h3>	
	<div class="tabbable">
		<ul class="nav nav-tabs" id="billingNav">
			<li><a href="#clinical" data-toggle="tab">Clinical</a></li>
			<li><a href="#offsite" data-toggle="tab">Off-site</a></li>
			<li><a href="#hospital" data-toggle="tab">Hospital</a></li>
			<li><a href="#workbench" data-toggle="tab">OHIP Workbench</a></li>
			<li><a href="#register" data-toggle="tab">Cash Register</a></li>
			<li><a href="#settings" data-toggle="tab">Settings</a></li>
		</ul>
		
		<div class="tab-content">
			<div class="tab-pane" id="clinical"></div>
			<div class="tab-pane" id="offsite"></div>
			<div class="tab-pane" id="hospital"></div>
			<div class="tab-pane" id="workbench"></div>
			<div class="tab-pane" id="register"></div>
		  	<div class="tab-pane" id="settings"></div>
		</div>
	</div>
	<script>

	</script>	

    </body>
</html>
