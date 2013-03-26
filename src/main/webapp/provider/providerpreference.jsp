<%
  if(session.getValue("user") == null) response.sendRedirect("../logout.jsp");
  String provider_name = (String) session.getAttribute("userlastname")+", "+(String) session.getAttribute("userfirstname");
  String deepcolor = "#CCCCFF", weakcolor = "#EEEEFF" ;
  LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();
  String providerNo=loggedInInfo.loggedInProvider.getProviderNo();

  String roleName$ = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
%>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/security.tld" prefix="security"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/caisi-tag.tld" prefix="caisi" %>
<%@ taglib uri="/WEB-INF/oscar-tag.tld" prefix="oscar" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ page import="java.util.*,java.text.*,java.sql.*,java.net.*" errorPage="errorpage.jsp" %>
<%@ page import="oscar.OscarProperties" %>
<%@ page import="org.oscarehr.common.dao.UserPropertyDAO"%>
<%@ page import="org.oscarehr.common.dao.ClinicNbrDao"%>
<%@ page import="org.oscarehr.PMmodule.dao.ProviderDao"%>
<%@ page import="org.oscarehr.common.dao.ClinicLocationDao"%>
<%@ page import="org.oscarehr.common.model.UserProperty"%>
<%@ page import="org.oscarehr.common.model.ClinicNbr"%>
<%@page import="org.oscarehr.common.model.Provider"%>
<%@page import="org.oscarehr.common.model.ClinicLocation"%>
<%@ page import="org.oscarehr.util.SpringUtils"%>
<%@ page import="oscar.SxmlMisc" %>
<%@ include file="/common/webAppContextAndSuperMgr.jsp"%>
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

<%@page import="org.oscarehr.common.model.ProviderPreference"%>
<%@page import="org.oscarehr.web.admin.ProviderPreferencesUIBean"%>
<%@page import="org.oscarehr.util.LoggedInInfo"%>
<%@page import="org.oscarehr.web.PrescriptionQrCodeUIBean"%>
<%@page import="org.oscarehr.common.model.EForm"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.oscarehr.common.model.EncounterForm"%><html:html locale="true">

<head>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title><bean:message key="provider.providerpreference.title" /></title>
<script type="text/javascript" src="../share/javascript/prototype.js"></script>
<script language="JavaScript">

function setfocus() {
  this.focus();
  document.UPDATEPRE.mygroup_no.focus();
  document.UPDATEPRE.mygroup_no.select();
}
function upCaseCtrl(ctrl) {
	ctrl.value = ctrl.value.toUpperCase();
}

function checkTypeNum(typeIn) {
	var typeInOK = true;
	var i = 0;
	var length = typeIn.length;
	var ch;
	// walk through a string and find a number
	if (length>=1) {
	  while (i <  length) {
		ch = typeIn.substring(i, i+1);
		if (ch == ".") { i++; continue; }
		if ((ch < "0") || (ch > "9") ) {
			typeInOK = false;
			break;
		}
	    i++;
      }
	} else typeInOK = false;
	return typeInOK;
}

function checkTypeIn(obj) {
    if(!checkTypeNum(obj.value) ) {
	  alert ("<bean:message key="provider.providerpreference.msgMustBeNumber"/>");
	}
}

function checkTypeInAll() {
  var checkin = false;
  var s=0;
  var e=0;
  var i=0;
  if(isNumeric(document.UPDATEPRE.start_hour.value) && isNumeric(document.UPDATEPRE.end_hour.value) && isNumeric(document.UPDATEPRE.every_min.value)) {
    s=eval(document.UPDATEPRE.start_hour.value);
    e=eval(document.UPDATEPRE.end_hour.value);
    i=eval(document.UPDATEPRE.every_min.value);
    if(e < 24){
      if(s < e){
        if(i <= (e - s)*60 && i > 0){
          checkin = true;
        }else{
          alert ("<bean:message key="provider.providerpreference.msgPositivePeriod"/>");
          this.focus();
          document.UPDATEPRE.every_min.focus();
         }
      }else{
        alert ("<bean:message key="provider.providerpreference.msgStartHourErlierEndHour"/>");
        this.focus();
        document.UPDATEPRE.start_hour.focus();
       }
    }else{
      alert ("<bean:message key="provider.providerpreference.msgHourLess24"/>");
      this.focus();
      document.UPDATEPRE.end_hour.focus();
     }
  } else {
     alert ("<bean:message key="provider.providerpreference.msgTypeNumbers"/>");
  }
	return checkin;
}

function popupPage(vheight,vwidth,varpage) { //open a new popup window
  var page = "" + varpage;
  windowprops = "height="+vheight+",width="+vwidth+",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes,top=5,left=5";//360,680
  var popup=window.open(page, "<bean:message key="provider.providerpreference.titlePopup"/>", windowprops);
  if (popup != null) {
    if (popup.opener == null) {
      popup.opener = self;
    }
  }
}

function isNumeric(strString) {
    var validNums = "0123456789";
    var strChar;
    var retval = true;
    if(strString.length == 0){
    retval = false;
    }
    for (i = 0; i < strString.length && retval == true; i++){
	strChar = strString.charAt(i);
	if (validNums.indexOf(strChar) == -1){
	    retval = false;
	}
    }
    return retval;
}

function showHideBillPref() {
    $("billingONpref").toggle();
}

function showHideRxPrintPref() {
    $("rxPrintPrefs").toggle();
}

</script>
<style type="text/css">
	.preferenceTable td
	{
		border: solid white 2px;
	}

	.preferenceLabel
	{
		text-align:right;
		width:25%;
		padding-right:8px;
		font-size:13px;
		font-weight:bold;
		vertical-align:top;
	}

	.preferenceUnits
	{
		font-size:9px;
		font-weight:normal;
	}

	.preferenceValue
	{
		font-size:12px;
	}
</style>
</head>

<%
	ProviderPreference providerPreference=ProviderPreferencesUIBean.getLoggedInProviderPreference();

	if (providerPreference == null) {
	    providerPreference = new ProviderPreference();
	}
%>

<body bgproperties="fixed"  onLoad="setfocus();showHideBillPref();showHideRxPrintPref();" topmargin="0"leftmargin="0" rightmargin="0" style="font-family:sans-serif">
	<FORM NAME = "UPDATEPRE" METHOD="post" ACTION="providerupdatepreference.jsp" onSubmit="return(checkTypeInAll())">

		<div style="background-color:<%=deepcolor%>;text-align:center;font-weight:bold">
			<bean:message key="provider.providerpreference.description"/>
		</div>

		<table class="preferenceTable" style="width:100%;border-collapse:collapse;background-color:<%=weakcolor%>;">
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.preference.formStartHour" />
					<span class="preferenceUnits">(0-23)</span>
				</td>
				<td class="preferenceValue">
					<INPUT TYPE="TEXT" NAME="start_hour" VALUE='<%=request.getParameter("start_hour")%>' size="2" maxlength="2">
				</td>
			</tr>
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.preference.formEndHour" />
					<span class="preferenceUnits">(0-23)</span>
				</td>
				<td class="preferenceValue">
					<INPUT TYPE="TEXT" NAME="end_hour" VALUE='<%=request.getParameter("end_hour")%>' size="2" maxlength="2">
				</td>
			</tr>
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.preference.formPeriod" />
					<span class="preferenceUnits"><bean:message key="provider.preference.min" /></span>
				</td>
				<td class="preferenceValue">
					<INPUT TYPE="TEXT" NAME="every_min" VALUE='<%=request.getParameter("every_min")%>' size="2" maxlength="2">
				</td>
			</tr>
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.preference.formGroupNo" />
				</td>
				<td class="preferenceValue">
					<INPUT TYPE="TEXT" NAME="mygroup_no" VALUE='<%=request.getParameter("mygroup_no")%>' size="12" maxlength="10">
					<input type="button" value="<bean:message key="provider.providerpreference.viewedit" />" onClick="popupPage(360,680,'providercontrol.jsp?displaymode=displaymygroup&dboperation=searchmygroupall' );return false;" />
				</td>
			</tr>
			<caisi:isModuleLoad moduleName="ticklerplus">
				<tr>
					<!-- check box of new-tickler-warnning-windows -->
					<td class="preferenceLabel">
						New Tickler Warning Window
					</td>
					<td class="preferenceValue">
						<%
							String myCheck1 = "";
							String myCheck2 = "";
							String myValue ="";
							if("enabled".equals(request.getParameter("new_tickler_warning_window"))) {
								myCheck1 = "checked";
								myCheck2 = "unchecked";
							}
							else {
								myCheck1 = "unchecked";
								myCheck2 = "checked";
							}
						%>
			            <input type="radio" name="new_tickler_warning_window" value="enabled" <%= myCheck1 %>> Enabled
			            <br>
						<input type="radio" name="new_tickler_warning_window" value="disabled" <%= myCheck2 %>> Disabled
					</td>
				</tr>

				<!-- check box of the default PMM window -->
				<tr>
					<td class="preferenceLabel">
						Default PMM
					</td>
					<td class="preferenceValue">
						<%
							String myCheck3 = "";
							String myCheck4 = "";
							if("enabled".equals(request.getParameter("default_pmm"))) {
								myCheck3 = "checked";
								myCheck4 = "unchecked";
							}
							else {
								myCheck3 = "unchecked";
								myCheck4 = "checked";
							}
						%>
			            <input type="radio" name="default_pmm" value="enabled" <%= myCheck3 %>> Enabled
			            <br>
						<input type="radio" name="default_pmm" value="disabled" <%= myCheck4 %>> Disabled
					</td>
				</tr>

				 <tr>
		            <td class="preferenceLabel">
		            <bean:message key="provider.btnCaisiBillPreferenceNotDelete"/>
		            </td>
		            <td class="preferenceValue">

		             <%  String myCheck5 = "";
		                 String myCheck6 = "";
		                 String value1 = request.getParameter("caisiBillingPreferenceNotDelete");
		                  if(value1!=null && value1.equals("1"))
		                  { 	myCheck5 = "checked";
		                        myCheck6 = "unchecked";}
		                  else
		                  { 	myCheck5 = "unchecked";
		                  		myCheck6 = "checked";}

		               %>

		                                <input type="radio" name="caisiBillingPreferenceNotDelete" value="1" <%= myCheck5 %> > Enabled
		                                <br>
		                                <input type="radio" name="caisiBillingPreferenceNotDelete" value="0" <%= myCheck6 %> > Disabled

		            </td>
		          </tr>

			</caisi:isModuleLoad>

			<!-- QR Code on prescriptions setting -->
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.providerpreference.qrCodeOnPrescriptions" />
				</td>
				<td class="preferenceValue">
					<%
	            		boolean checked=PrescriptionQrCodeUIBean.isPrescriptionQrCodeEnabledForCurrentProvider();
	            	%>
	            	<input type="checkbox" name="prescriptionQrCodes" <%=checked?"checked=\"checked\"":""%> />
	            </td>
			</tr>

			<%-- links to display on the appointment screen --%>
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.providerpreference.appointmentScreenLinkNameDisplayLength" />
				</td>
				<td class="preferenceValue">
					<input type="text" name="appointmentScreenFormsNameDisplayLength" value='<%=providerPreference.getAppointmentScreenLinkNameDisplayLength()%>' size="2">
	            </td>
			</tr>
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.providerpreference.formsToDisplayOnAppointmentScreen" />
				</td>
				<td class="preferenceValue">
					<div style="height:10em;border:solid grey 1px;overflow:auto;white-space:nowrap;width:45em">
					<%
						List<EncounterForm> encounterForms=ProviderPreferencesUIBean.getAllEncounterForms();
						Collection<String> checkedEncounterFormNames=ProviderPreferencesUIBean.getCheckedEncounterFormNames();
						for(EncounterForm encounterForm : encounterForms)
						{
							String nameEscaped=StringEscapeUtils.escapeHtml(encounterForm.getFormName());
							String checkedString=(checkedEncounterFormNames.contains(encounterForm.getFormName())?"checked=\"checked\"":"");
							%>
								<input type="checkbox" name="encounterFormName" value="<%=nameEscaped%>" <%=checkedString%> /> <%=nameEscaped%>
								<br />
							<%
						}
	            	%>
					</div>
	            </td>
			</tr>
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.providerpreference.eFormsToDisplayOnAppointmentScreen" />
				</td>
				<td class="preferenceValue">
					<div style="height:10em;border:solid grey 1px;overflow:auto;white-space:nowrap;width:45em">
					<%
						List<EForm> eforms=ProviderPreferencesUIBean.getAllEForms();
						Collection<Integer> checkedEFormIds=ProviderPreferencesUIBean.getCheckedEFormIds();
						for(EForm eform : eforms)
						{
							String checkedString=(checkedEFormIds.contains(eform.getId())?"checked=\"checked\"":"");
							%>
								<input type="checkbox" name="eformId" value="<%=eform.getId()%>" <%=checkedString%> /> <%=StringEscapeUtils.escapeHtml(eform.getFormName())%>
								<br />
							<%
						}
	            	%>
					</div>
	            </td>
			</tr>
			<tr>
				<td class="preferenceLabel">
					<bean:message key="provider.providerpreference.quickLinksToDisplayOnAppointmentScreen" />
				</td>
				<td class="preferenceValue">
					<div style="height:10em;border:solid grey 1px;overflow:auto;white-space:nowrap;width:45em">
					<%
						Collection<ProviderPreference.QuickLink> quickLinks=ProviderPreferencesUIBean.getQuickLinks();
						for(ProviderPreference.QuickLink quickLink : quickLinks)
						{
							%>
								<input type="button" value="<bean:message key="REMOVE"/>" onclick="document.location='providerPreferenceQuickLinksAction.jsp?action=remove&name='+escape('<%=StringEscapeUtils.escapeHtml(quickLink.getName())%>')" />
								<%=StringEscapeUtils.escapeHtml(quickLink.getName())%> : <%=StringEscapeUtils.escapeHtml(quickLink.getUrl())%>
								<br />
							<%
						}
	            	%>
					</div>
					<table style="border:none;border-collapse:collapse">
						<tr>
							<td style="border:none;text-align:right"><bean:message key="NAME"/></td>
							<td style="border:none"><input type="text" name="quickLinkName" /></td>
						</tr>
						<tr>
							<td style="border:none;text-align:right;vertical-align:top"><bean:message key="URL"/></td>
							<td style="border:none">
								<input type="text" name="quickLinkUrl" />
								<div style="font-size:9px">(expanded tokens in the url are ${contextPath} and ${demographicId})</div>
							</td>
						</tr>
						<tr>
							<td style="border:none"></td>
							<td style="border:none">
								<script type="text/javascript">
									function addQuickLink()
									{
										name=escape(document.UPDATEPRE.quickLinkName.value);
										url=escape(document.UPDATEPRE.quickLinkUrl.value);
										document.location="providerPreferenceQuickLinksAction.jsp?action=add&name="+name+"&url="+url;
									}
								</script>
								<input type="button" value="<bean:message key="ADD"/>" onclick="addQuickLink()" />
							</td>
						</tr>
					</table>
	            </td>
			</tr>

			<tr>
				<%
					UserPropertyDAO propertyDao = (UserPropertyDAO)SpringUtils.getBean("UserPropertyDAO");
					UserProperty prop = propertyDao.getProp(providerNo,"rxInteractionWarningLevel");
					String warningLevel = "0";
					if(prop!=null) {
						warningLevel = prop.getValue();
					}
				%>
				<td class="preferenceLabel">
					<bean:message key="provider.providerpreference.rxInteractionWarningLevel" />
				</td>
				<td class="preferenceValue">
					<select id="rxInteractionWarningLevel">
						<option value="0" <%=(warningLevel.equals("0")?"selected=\"selected\"":"") %>>Not Specified</option>
						<option value="1" <%=(warningLevel.equals("1")?"selected=\"selected\"":"") %>>Low</option>
						<option value="2" <%=(warningLevel.equals("2")?"selected=\"selected\"":"") %>>Medium</option>
						<option value="3" <%=(warningLevel.equals("3")?"selected=\"selected\"":"") %>>High</option>
						<option value="4" <%=(warningLevel.equals("4")?"selected=\"selected\"":"") %>>None</option>
					</select>
	            </td>
        <script>
Event.observe('rxInteractionWarningLevel', 'change', function(event) {
	var value = $('rxInteractionWarningLevel').getValue();

	new Ajax.Request('<c:out value="${ctx}"/>/provider/rxInteractionWarningLevel.do?method=update&value='+value, {
		  method: 'get',
		  onSuccess: function(transport) {
		  }
		});

});

</script>
			</tr>


		</table>

		<div style="background-color:<%=deepcolor%>;text-align:center;font-weight:bold">
			<INPUT TYPE="submit" VALUE='<bean:message key="provider.providerpreference.btnSubmit"/>' SIZE="7">
			<INPUT TYPE = "RESET" VALUE ='<bean:message key="global.btnClose"/>' onClick="window.close();">
  		</div>

		<INPUT TYPE="hidden" NAME="color_template" VALUE='deepblue'>


<table width="100%" BGCOLOR="eeeeee">

<caisi:isModuleLoad moduleName="NEW_CME_SWITCH">
  <oscar:oscarPropertiesCheck property="TORONTO_RFQ" value="no">
	<tr>
    <TD align="center"><a href=# onClick ="popupPage(230,600,'../casemgmt/newCaseManagementEnable.jsp');return false;">Enable OSCAR CME UI</a> &nbsp;&nbsp;&nbsp;
    </tr>
  </oscar:oscarPropertiesCheck>
  </caisi:isModuleLoad>

  <tr>
	<td align="center"><a href=# onClick ="popupPage(230,600,'providerDefaultDxCode.jsp?provider_no=<%=request.getParameter("provider_no") %>');return false;">Edit Default Billing Diagnostic Code</a>&nbsp;&nbsp;&nbsp; </td>
	</tr>
  <tr>

    <TD align="center"><a href=# onClick ="popupPage(230,600,'providerchangepassword.jsp');return false;"><bean:message key="provider.btnChangePassword"/></a> &nbsp;&nbsp;&nbsp; <!--| a href=# onClick ="popupPage(350,500,'providercontrol.jsp?displaymode=savedeletetemplate');return false;"><bean:message key="provider.btnAddDeleteTemplate"/></a> | <a href=# onClick ="popupPage(200,500,'providercontrol.jsp?displaymode=savedeleteform');return false;"><bean:message key="provider.btnAddDeleteForm"/></a></td>
  </tr>
   <tr>
    <TD align="center">  <a href="#" ONCLICK ="popupPage(550,800,'../schedule/scheduletemplatesetting1.jsp?provider_no=<%=providerNo%>&provider_name=<%=URLEncoder.encode(provider_name)%>');return false;" title="Holiday and Schedule Setting" ><bean:message key="provider.btnScheduleSetting"/></a>
      &nbsp;&nbsp;&nbsp; | <a href="#" ONCLICK ="popupPage(550,800,'http://oscar1.mcmaster.ca:8888/oscarResource/manage?username=oscarfp&pw=oscarfp');return false;" title="Resource Management" ><bean:message key="provider.btnManageClinicalResource"/></a--> </td>
  </tr>
  <tr>
      <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewDefaultSex');return false;"><bean:message key="provider.btnSetDefaultSex" /></a></td>
      </tr>
  <tr>
    <td align="center"><a href=# onClick ="popupPage(230,860,'providerSignature.jsp');return false;"><bean:message key="provider.btnEditSignature"/></a>
    </td>
  </tr>
  <oscar:oscarPropertiesCheck property="TORONTO_RFQ" value="no" defaultVal="true">
  <security:oscarSec roleName="<%=roleName$%>" objectName="_billing" rights="r">
  <tr>
    <td align="center">
<% String br = OscarProperties.getInstance().getProperty("billregion");
   if (br.equals("BC")) { %>
	<a href=# onClick ="popupPage(230,400,'../billing/CA/BC/viewBillingPreferencesAction.do?providerNo=<%=providerNo%>');return false;"><bean:message key="provider.btnBillPreference"/></a>
<% } else { %>
	<a href=# onClick ="showHideBillPref();return false;"><bean:message key="provider.btnBillPreference"/></a>
<% } %>
    </td>
  </tr>
  <tr>
      <td align="center">
	  <div id="billingONpref">
          <bean:message key="provider.labelDefaultBillForm"/>:
	  <select name="default_servicetype">
	      <option value="no">-- no --</option>
<%
	if (providerPreference!=null) {
		String def = providerPreference.getDefaultServiceType();
		List<Map<String,Object>> resultList = oscarSuperManager.find("providerDao", "list_bills_servicetype", new Object[] {});
		for (Map bill : resultList) {
%>
				<option value="<%=bill.get("servicetype")%>"
					<%=bill.get("servicetype").equals(def)?"selected":""%>>
					<%=bill.get("servicetype_name")%></option>
<%
		}
	} else {
		List<Map<String,Object>> resultList = oscarSuperManager.find("providerDao", "list_bills_servicetype", new Object[] {});
		for (Map bill : resultList) {
%>
		<option value="<%=bill.get("servicetype")%>"><%=bill.get("servicetype_name")%></option>
<%
		}
	}
%>
	  </select>
	  
	  <br>
	  
	  <%if (OscarProperties.getInstance().getBooleanProperty("rma_enabled", "true")) { %> Clinic Nbr <% } else { %> <bean:message key="billing.billingCorrection.formVisitType"/> <% } %>:
	  <select name="default_bill_visit_type">
			<%
				String visitType = providerPreference.getBillingVisitTypeDefault();				
			%>
	      <option value="" <%=visitType.length()==0?"selected":""%>>-- None --</option>
						<% if (OscarProperties.getInstance().getBooleanProperty("rma_enabled", "true")) { %>
					    <% 
					    ClinicNbrDao cnDao = (ClinicNbrDao) SpringUtils.getBean("clinicNbrDao"); 
						ArrayList<ClinicNbr> nbrs = cnDao.findAll();	            
	                    for (ClinicNbr clinic : nbrs) {
							String valueString = String.format("%s | %s", clinic.getNbrValue(), clinic.getNbrString());
							%>
					    	<option value="<%=valueString%>" <%=visitType.startsWith(clinic.getNbrValue())?"selected":""%>><%=valueString%></option>
					    <%}%>
					    <% } else { %>
							<option value="00| Clinic Visit"
								<%=visitType.startsWith("00")?"selected":""%>><bean:message key="billing.billingCorrection.formClinicVisit"/>
							</option>
							<option value="01| Outpatient Visit"
								<%=visitType.startsWith("01")?"selected":""%>><bean:message key="billing.billingCorrection.formOutpatientVisit"/>
							</option>
							<option value="02| Hospital Visit"
								<%=visitType.startsWith("02")?"selected":""%>><bean:message key="billing.billingCorrection.formHospitalVisit"/>
							</option>
							<option value="03| ER"
								<%=visitType.startsWith("03")?"selected":""%>><bean:message key="billing.billingCorrection.formER"/></option>
							<option value="04| Nursing Home"
								<%=visitType.startsWith("04")?"selected":""%>><bean:message key="billing.billingCorrection.formNursingHome"/>
							</option>
							<option value="05| Home Visit"
								<%=visitType.startsWith("05")?"selected":""%>><bean:message key="billing.billingCorrection.formHomeVisit"/>
							</option>
							<% } %>
	  </select>
	  
	  <br>
	  
	  <%if (OscarProperties.getInstance().getBooleanProperty("rma_enabled", "true")) { %> Clinic Nbr <% } else { %> <bean:message key="billing.billingCorrection.msgVisitLocation"/> <% } %>:
	  <select name="default_bill_visit_location">
			<%
				String selectedVisitLocation = providerPreference.getBillingVisitLocationDefault();
				ClinicLocationDao clinicLocationDao = (ClinicLocationDao) SpringUtils.getBean("clinicLocationDao"); 
				List<ClinicLocation> clinicLocations = clinicLocationDao.findAll();			
			%>
	      <option value="" <%=selectedVisitLocation.length()==0?"selected":""%>>-- None --</option>
				<%	for(int i=0; i<clinicLocations.size(); i++) {
						ClinicLocation clinicLocation = clinicLocations.get(i);
						String strLocation = clinicLocation.getClinicLocationNo();
				%>
							<option
								value="<%=clinicLocation.getClinicLocationNo()%>"
								<%=selectedVisitLocation.length() != 0 && strLocation.startsWith(selectedVisitLocation)?"selected":""%>>
							<%=clinicLocation.getClinicLocationName()%></option>
							<%
				}
				%>
	  </select>
	  
	  </div>
      </td>
  </tr>

</security:oscarSec>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'providerPhone.jsp');return false;"><bean:message key="provider.btnEditPhoneNumber"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'providerFax.jsp');return false;"><bean:message key="provider.btnEditFaxNumber"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'providerColourPicker.jsp');return false;"><bean:message key="provider.btnEditColour"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewRxPageSize');return false;"><bean:message key="provider.btnSetRxPageSize"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewUseRx3');return false;"><bean:message key="provider.btnSetRx3"/></a></td>
      </tr>
      
      <tr>
	    <td align="center">
			<a href=# onClick ="showHideRxPrintPref();return false;"><bean:message key="provider.btnRxPrintingPreferences"/></a>
	    </td>
	  </tr>
	
	  <tr>
	      <td align="center">
		  <div id="rxPrintPrefs">
				<%
				boolean printDateOnRx = false;
				boolean printPharmacyOnRx = false;
		      
				if (providerPreference != null) {
					printDateOnRx = providerPreference.isPrintDateOnRxSet();
					printPharmacyOnRx = providerPreference.isPrintPharmacyOnRxSet();
				}
				%>
	      
				<bean:message key="provider.labelRxPrintPharmacy"/>:
				<input type="checkbox" name="rx_print_pharmacy" <%=printPharmacyOnRx? "checked" : ""%>>
				<br>
				<bean:message key="provider.labelRxPrintDates"/>:
				<input type="checkbox" name="rx_print_dates" <%=printDateOnRx? "checked" : ""%>>
		
		  </div>
	      </td>
	  </tr>
      
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewCppSingleLine');return false;"><bean:message key="provider.btnSetCppSingleLine"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewShowPatientDOB');return false;"><bean:message key="provider.btnSetShowPatientDOB"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewDefaultQuantity');return false;"><bean:message key="provider.SetDefaultPrescriptionQuantity"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=view&provider_no=<%=providerNo%>');return false;"><bean:message key="provider.btnEditStaleDate"/></a></td>
      </tr>

      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewMyDrugrefId');return false;"><bean:message key="provider.btnSetmyDrugrefID"/></a></td>
      </tr>

      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewConsultationRequestCuffOffDate');return false;"><bean:message key="provider.btnSetConsultationCutoffTimePeriod"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewConsultationRequestTeamWarning');return false;"><bean:message key="provider.btnSetConsultationTeam"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewWorkLoadManagement');return false;"><bean:message key="provider.btnSetWorkLoadManagement"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewConsultPasteFmt');return false;"><bean:message key="provider.btnSetConsultPasteFmt"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewFavouriteEformGroup');return false;"><bean:message key="provider.btnSetEformGroup"/></a></td>
      </tr>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewHCType');return false;"><bean:message key="provider.btnSetHCType" /></a></td>
      </tr>
      <% if(OscarProperties.getInstance().hasProperty("ONTARIO_MD_INCOMINGREQUESTOR")){%>
      <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewOntarioMDId');return false;"><bean:message key="provider.btnSetmyOntarioMD"/></a></td>
      </tr>
      <%}%>
  </oscar:oscarPropertiesCheck>
  <oscar:oscarPropertiesCheck property="MY_OSCAR" value="yes">
        <tr>
            <td align="center"><a href=# onClick ="popupPage(230,860,'providerIndivoIdSetter.jsp');return false;"><bean:message key="provider.btnSetIndivoId"/></a></td>
        </tr>
        <tr>
            <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewUseMyMeds');return false;"><bean:message key="provider.btnSetUseMyMeds"/></a></td>
        </tr>
  </oscar:oscarPropertiesCheck>
  		<tr>
          <td align="center"><a href=# onClick ="popupPage(400,860,'../provider/CppPreferences.do');return false;"><bean:message key="provider.cppPrefs" /></a></td>
      	</tr>

      	<tr>
          <td align="center"><a href=# onClick ="popupPage(400,860,'../provider/OlisPreferences.do');return false;"><bean:message key="provider.olisPrefs" /></a></td>
      	</tr>
      	<tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewCommentLab');return false;"><bean:message key="provider.btnDisableAckCommentLab"/></a></td>
      </tr>
       <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewEncounterWindowSize');return false;"><bean:message key="provider.btnEditDefaultEncounterWindowSize"/></a></td>
      </tr>
       <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'../setProviderStaleDate.do?method=viewQuickChartSize');return false;"><bean:message key="provider.btnEditDefaultQuickChartSize"/></a></td>
      </tr>
	  <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'providerNewDemographicDefaultProvider.jsp');return false;">Set Default Provider for New Demographic</a></td>
      </tr>
	  <tr>
          <td align="center"><a href=# onClick ="popupPage(230,860,'providerBillingDefaultProvider.jsp');return false;">Set Default Provider for Billing</a></td>
      </tr>
</table>
</FORM>

</body>
</html:html>
