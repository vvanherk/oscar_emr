
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


<%@page import="org.oscarehr.PMmodule.model.VacancyTemplate"%>
<%@page import="org.oscarehr.PMmodule.model.Criteria"%>
<%@page import="org.oscarehr.PMmodule.model.CriteriaType"%>
<%@page import="org.oscarehr.PMmodule.service.VacancyTemplateManager"%>
<%@page import="org.oscarehr.PMmodule.model.Program"%>
<%@page import="org.oscarehr.util.LoggedInInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.List"%>
<%@ include file="/taglibs.jsp"%>

<%
// is only populated if it's an existing form, i.e. new one off existing form
	

	// must be populated some how
	int currentDemographicId=0;
	
	// must be populated some how
	VacancyTemplate template = null;
	String templateId = (String) request.getAttribute("vacancyOrTemplateId");
	boolean dontSave = false;
	
	if (!StringUtils.isBlank(templateId) && !templateId.equalsIgnoreCase("null"))	{				
		template=VacancyTemplateManager.getVacancyTemplateByTemplateId(Integer.parseInt(templateId));	
		dontSave = true;
	}	else	{	
		template= new VacancyTemplate();		
	}
%>
<script type="text/javascript">
	function save() {
		document.programManagerForm.method.value='save_vacancy_template';
		document.programManagerForm.submit()
	}    
</script>

<div class="tabs" id="tabs">
<input type="hidden" name="vacancyOrTemplateId" id="vacancyOrTemplateId" value="<%=template.getId()%>" />
<input type="hidden" name="programId" id="programId" value="<%=request.getAttribute("id")%>" />
	<table cellpadding="3" cellspacing="0" border="0">
		<tr>
			<th title="Programs" class="nofocus"><a
				onclick="javascript:clickTab2('General', 'General');return false;"
				href="javascript:void(0)">General Information</a></th>
			<th title="Templates">Vacancy Templates</th>
		</tr>
	</table>
</div>

<table width="100%" border="1" cellspacing="2" cellpadding="3">
	<tr class="b">
		<td width="30%" class="beright">Template is active:</td>
		<td><input type="checkbox" value="on" <%=template.getActive()==true?"checked":"" %>
			name="templateActive"></td>
	</tr>
	<tr class="b">
		<td class="beright">Template Name:</td>
		<td><input type="text" size="50" maxlength="50" value="<%=template.getName()==null?"":template.getName() %>"
			name="templateName"></td>
	</tr>
	<tr class="b">
		<td class="beright">Associated Program:</td>
		<td><select name="associatedProgramId">
		<% 
			List<Program> programs = VacancyTemplateManager.getPrograms(LoggedInInfo.loggedInInfo.get().currentFacility.getId());
			for(Program p : programs) {
				String selectedOrNot = "";
				Integer programIdFromTemplate = template.getProgramId();
				if(programIdFromTemplate !=null && programIdFromTemplate.intValue()==p.getId().intValue())
					selectedOrNot = "selected";
		%>				
			<option value="<%=p.getId()%>" <%=selectedOrNot%> ><%=p.getName() %></option>
		<%} %>
		</select></td>
	</tr>
</table>

<fieldset>
	<legend>Criteria Required For this Template</legend>	
	
	<% 
		
		List<CriteriaType> typeList = VacancyTemplateManager.getAllCriteriaTypes();
		for(CriteriaType criteriaType : typeList) {
	%>
			<%=VacancyTemplateManager.renderAllSelectOptions(template.getId(), null, criteriaType.getId())%>
	<%	}			
	%>
	
	
</fieldset>
<table width="100%" border="1" cellspacing="2" cellpadding="3">
	<tr>
	<% if(!dontSave) {%>
		 <td colspan="2"><input type="button" value="Save" onclick="return save()" /> 
	<% } %>
		 <html:cancel /></td>
	</tr>
</table>

