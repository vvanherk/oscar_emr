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
<%@ page import="org.oscarehr.PMmodule.model.DischargeReason"%>
<%@ include file="/taglibs.jsp"%>

<script>
	function select_program(id) {
		document.clientManagerForm.elements['program.id'].value = id;
		document.clientManagerForm.method.value = 'discharge_select_program';
		document.clientManagerForm.submit();
	}
	
	function select_program_community() {
		var communityCtl = document.getElementById('community_id');
		var id = communityCtl.options[communityCtl.selectedIndex].value;
		document.clientManagerForm.elements['program.id'].value = id;
		document.clientManagerForm.method.value = 'discharge_community_select_program';
		document.clientManagerForm.submit();
	}
	
	function do_discharge() {
		<c:if test="${empty requestScope.community_discharge}">						
			document.clientManagerForm.method.value = 'discharge';
		</c:if>
		<c:if test="${not empty requestScope.community_discharge}">			
			document.clientManagerForm.method.value = 'discharge_community';
		</c:if>
		document.clientManagerForm.submit();
	}
	
	function nestedReason() {
		<c:if test="${empty requestScope.community_discharge}">			
			document.clientManagerForm.method.value = 'nested_discharge_select_program';
			document.clientManagerForm.submit();
		</c:if>
		<c:if test="${not empty requestScope.community_discharge}">
			var communityCtl = document.getElementById('community_id');
			var id = communityCtl.options[communityCtl.selectedIndex].value;
			document.clientManagerForm.elements['program.id'].value = id;
			document.clientManagerForm.method.value = 'nested_discharge_community_select_program';
			document.clientManagerForm.submit();
		</c:if>					
	}
</script>

<html:hidden property="program.id" />

<p>This page is for discharging clients from:
<ol>
	<li>bed programs to non-CAISI community bed programs</li>
	<li>service programs</li>
	<li>temporary admissions in bed programs</li>
</ol>
To discharge clients from a bed program to a CAISI bed program, you must
make a referral to that bed program. The client can then be admitted to
that bed program from the queue.
</p>
<br />

<div class="tabs" id="tabs">
<table cellpadding="3" cellspacing="0" border="0">
	<tr>
		<th title="Programs">Discharge to non-CAISI community bed program</th>
	</tr>
</table>
</div>
Community Program:&nbsp;
<select id='community_id'>
	<c:forEach var="communityProgram" items="${communityPrograms}">
		<c:choose>
			<c:when
				test="${clientManagerForm.map.program.id == communityProgram.id}">
				<option value="<c:out value="${communityProgram.id}"/>"
					selected="true"><c:out value="${communityProgram.name}" /></option>
			</c:when>
			<c:otherwise>
				<option value="<c:out value="${communityProgram.id}"/>"><c:out
					value="${communityProgram.name}" /></option>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</select>

<caisi:isModuleLoad moduleName="TORONTO_RFQ" reverse="true">
&nbsp;<input type="button" value="Discharge"
		onclick="select_program_community()" />
</caisi:isModuleLoad>

<caisi:isModuleLoad moduleName="TORONTO_RFQ" reverse="false">
	<c:if test="${sessionScope.performDischargeBed=='true'}">
&nbsp;<input type="button" value="Discharge"
			onclick="select_program_community()" />
	</c:if>
</caisi:isModuleLoad>


<br />
<br />

<div class="tabs" id="tabs">
<table cellpadding="3" cellspacing="0" border="0">
	<tr>
		<th title="Programs">Discharge - Service Programs</th>
	</tr>
</table>
</div>
<display:table class="simple" name="serviceAdmissions" uid="admission"
	requestURI="/PMmodule/ClientManager.do">
	<display:setProperty name="paging.banner.placement" value="bottom" />
	<display:setProperty name="basic.msg.empty_list"
		value="This client is not currently admitted to any programs." />

	<caisi:isModuleLoad moduleName="TORONTO_RFQ" reverse="true">
		<display:column sortable="false">
			<input type="button" value="Discharge"
				onclick="select_program('<c:out value="${admission.programId}"/>')" />
		</display:column>
	</caisi:isModuleLoad>

	<caisi:isModuleLoad moduleName="TORONTO_RFQ" reverse="false">
		<c:if test="${sessionScope.performDischargeService=='true'}">
			<display:column sortable="false">
				<input type="button" value="Discharge"
					onclick="select_program('<c:out value="${admission.programId}"/>')" />
			</display:column>
		</c:if>
	</caisi:isModuleLoad>

	<display:column sortable="true" title="Program Name">
		<c:out value="${admission.programName}" />
	</display:column>
	<display:column property="admissionDate" sortable="true"
		title="Admission Date" />
	<display:column property="admissionNotes" sortable="true"
		title="Admission Notes" />
</display:table>
<br />
<br />

<div class="tabs" id="tabs">
<table cellpadding="3" cellspacing="0" border="0">
	<tr>
		<th title="Programs">Discharge - Temporary Program</th>
	</tr>
</table>
</div>
<display:table class="simple" name="temporaryAdmissions" uid="admission"
	requestURI="/PMmodule/ClientManager.do">
	<display:setProperty name="paging.banner.placement" value="bottom" />
	<display:setProperty name="basic.msg.empty_list"
		value="This client is not currently admitted to any programs." />

	<display:column sortable="false">
		<input type="button" value="Discharge"
			onclick="select_program('<c:out value="${admission.programId}"/>')" />
	</display:column>
	<display:column sortable="true" title="Program Name">
		<c:out value="${admission.programName}" />
	</display:column>
	<display:column property="admissionDate" sortable="true"
		title="Admission Date" />
	<display:column property="admissionNotes" sortable="true"
		title="Admission Notes" />
</display:table>

<c:if test="${requestScope.do_discharge != null}">
	<br />
	<br />
	<table width="100%" border="1" cellspacing="2" cellpadding="3">
		<caisi:isModuleLoad moduleName="ALT_DISCHARGE_REASON" reverse="true">
			<%if(request.getAttribute("nestedReason")!=null && request.getAttribute("nestedReason").equals("true")){%>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.MEDICAL_NEEDS_EXCEED_PROVISION.ordinal()%>' /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.MEDICAL_NEEDS_EXCEED_PROVISION" /></td>
			</tr>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.SOCIAL_BEHAVIOUR_NEEDS_EXCEED_PROVISION.ordinal()%>' /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.SOCIAL_BEHAVIOUR_NEEDS_EXCEED_PROVISION" /></td>
			</tr>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.WITHDRAWAL_NEEDS_EXCEED_PROVISION.ordinal()%>' /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.WITHDRAWAL_NEEDS_EXCEED_PROVISION" /></td>
			</tr>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.MENTAL_HEALTH_NEEDS_EXCEED_PROVISION.ordinal()%>' /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.MENTAL_HEALTH_NEEDS_EXCEED_PROVISION" /></td>
			</tr>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.OTHER_NEEDS_EXCEED_PROVISION.ordinal()%>' /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.OTHER_NEEDS_EXCEED_PROVISION" /></td>
			</tr>
			<%}else{ %>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.REQUIRES_ACUTE_CARE.ordinal()%>' /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.REQUIRES_ACUTE_CARE" /></td>
			</tr>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.NOT_INTERESTED.ordinal()%>' /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.NOT_INTERESTED" /></td>
			</tr>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.DOES_NOT_FIT_CRITERIA.ordinal()%>'
					onclick="nestedReason()" /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.DOES_NOT_FIT_CRITERIA" /></td>
			</tr>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.NO_SPACE_AVAILABLE.ordinal()%>' /></td>
				<td><bean:message bundle="pmm"
					key="discharge.reason.NO_SPACE_AVAILABLE" /></td>
			</tr>
			<tr>
				<td width="5%"><html:radio
					property="admission.radioDischargeReason"
					value='<%="" + DischargeReason.OTHER.ordinal()%>' /></td>
				<td><bean:message bundle="pmm" key="discharge.reason.OTHER" /></td>
			</tr>
			<%} %>
		</caisi:isModuleLoad>
		<caisi:isModuleLoad moduleName="SHERBOURNE_HEALTH_CENTER"
			reverse="true">
			<c:forEach var="dischargeReason" items="${dischargeReasons}">
				<tr>
					<td width="5%"><html-el:radio
						property="admission.radioDischargeReason"
						value="${dischargeReason.code}" /></td>
					<td><bean:write name="dischargeReason" property="description" /></td>
				</tr>
			</c:forEach>
		</caisi:isModuleLoad>
		<tr class="b">
			<td width="20%">Discharge Notes:</td>
			<td><html:textarea cols="50" rows="7"
				property="admission.dischargeNotes" /></td>
		</tr>
		<tr class="b">
			<td colspan="2"><input type="button" value="Process Discharge"
				onclick="do_discharge();" /> <input type="button" value="Cancel"
				onclick="document.clientManagerForm.submit()" /></td>
		</tr>
	</table>
</c:if>
