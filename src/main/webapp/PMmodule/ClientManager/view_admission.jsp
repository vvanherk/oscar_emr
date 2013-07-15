<%@ page import="org.apache.struts.validator.DynaValidatorForm"%>
<%@ page import="org.oscarehr.PMmodule.model.Admission"%>
<%@ page import="org.oscarehr.PMmodule.model.DischargeReason"%>

<%--


    Copyright (c) 2005-2012. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved.
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

    This software was written for
    Centre for Research on Inner City Health, St. Michael's Hospital,
    Toronto, Ontario, Canada

--%>


<%@ include file="/taglibs.jsp"%>
<html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title>Admission Details</title>

<link rel="stylesheet" type="text/css" media="all" href="../share/css/extractedFromPages.css"  />
<body>
<html:form action="/PMmodule/ClientManager.do">

	<html:hidden property="admission.id" />

	<table width="100%" border="1" cellspacing="2" cellpadding="3">
		<tr class="b">
			<td width="20%">Client name:</td>
			<td><bean:write name="clientManagerForm"
				property="client.formattedName" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Provider name:</td>
			<td><bean:write name="clientManagerForm"
				property="provider.formattedName" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Program name:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.programName" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Team name:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.teamName" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Program type:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.programType" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Client status:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.clientStatus" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Admission status:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.admissionStatus" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Admission notes:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.admissionNotes" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Admission date:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.admissionDate" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Temporary admission?</td>
			<td><bean:write name="clientManagerForm"
				property="admission.temporaryAdmission" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Discharge date:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.dischargeDate" /></td>
		</tr>
		<tr class="b">
			<td width="20%">Discharge reason:</td>
			<td>
			<%
                        DynaValidatorForm form = (DynaValidatorForm)session.getAttribute("clientManagerForm");

                        Admission admission = (Admission) form.get("admission");
                        String dischargeReason = admission.getRadioDischargeReason();
                        if(dischargeReason==null || dischargeReason=="" || "".equals(dischargeReason) || "NULL".equals(dischargeReason)) 
                        	dischargeReason="0";
                        DischargeReason reason = DischargeReason.values()[Integer.valueOf(dischargeReason)];
                    %> <bean:message bundle="pmm"
				key='<%="discharge.reason." + reason.toString()%>' /></td>
		</tr>
		<tr class="b">
			<td width="20%">Discharge notes:</td>
			<td><bean:write name="clientManagerForm"
				property="admission.dischargeNotes" /></td>
		</tr>

	</table>



</html:form>
</body>
</html:html>
