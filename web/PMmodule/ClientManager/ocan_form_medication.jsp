<%@page import="org.oscarehr.common.model.OcanStaffForm"%>
<%@page import="org.oscarehr.PMmodule.model.Admission"%>
<%@page import="org.oscarehr.common.model.Demographic"%>
<%@page import="org.oscarehr.PMmodule.web.OcanForm"%>
<%@page import="org.oscarehr.util.LoggedInInfo"%>

<%
	int currentDemographicId=Integer.parseInt(request.getParameter("demographicId"));	
	int prepopulationLevel = OcanForm.PRE_POPULATION_LEVEL_ALL;
	
	OcanStaffForm ocanStaffForm=OcanForm.getOcanStaffForm(currentDemographicId, prepopulationLevel);		

	int medicationNumber = Integer.parseInt(request.getParameter("medication_num"));
%>
<div id="medication_<%=medicationNumber%>">
	<table>
		<tr>
			<td class="genericTableHeader">Medication</td>
			<td class="genericTableData">
				<%=OcanForm.renderAsTextField(ocanStaffForm.getId(), "medication_"+medicationNumber+"_medication", 25,prepopulationLevel)%>	
			</td>								
		</tr>
		<tr>
			<td class="genericTableHeader">Dosage</td>
			<td class="genericTableData">
				<%=OcanForm.renderAsTextField(ocanStaffForm.getId(), "medication_"+medicationNumber+"_dosage", 25,prepopulationLevel)%>	
			</td>								
		</tr>
		<tr>
			<td class="genericTableHeader">Taken as prescribed?</td>
			<td class="genericTableData">
				<select name="medication_<%=medicationNumber%>_taken_as_prescribed">
					<%=OcanForm.renderAsSelectOptions(ocanStaffForm.getId(), "medication_"+medicationNumber+"_taken_as_prescribed", OcanForm.getOcanFormOptions("Taking as Prescribed"),prepopulationLevel)%>
				</select>					
			</td>
		</tr>
		<tr>
			<td class="genericTableHeader">Help is provided?</td>
			<td class="genericTableData">
				<select name="medication_<%=medicationNumber%>_help_provided">
					<%=OcanForm.renderAsSelectOptions(ocanStaffForm.getId(), "medication_"+medicationNumber+"_help_provided", OcanForm.getOcanFormOptions("Help Provided Needed"),prepopulationLevel)%>
				</select>					
			</td>
		</tr>						
		<tr>
			<td class="genericTableHeader">Help is needed?</td>
			<td class="genericTableData">
				<select name="medication_<%=medicationNumber%>_help_needed">
					<%=OcanForm.renderAsSelectOptions(ocanStaffForm.getId(), "medication_"+medicationNumber+"_help_needed", OcanForm.getOcanFormOptions("Help Provided Needed"),prepopulationLevel)%>
				</select>					
			</td>
		</tr>
		<tr>
			<td class="genericTableHeader">Reports Side Effects?</td>
			<td class="genericTableData">
				<select name="medication_<%=medicationNumber%>_se_reported">
					<%=OcanForm.renderAsSelectOptions(ocanStaffForm.getId(), "medication_"+medicationNumber+"_se_reported", OcanForm.getOcanFormOptions("Side Effects Reported Ability"),prepopulationLevel)%>
				</select>					
			</td>
		</tr>
		<tr>
			<td class="genericTableHeader">Do these side effects affect your daily living?</td>
			<td class="genericTableData">
				<select name="medication_<%=medicationNumber%>_se_affects">
					<%=OcanForm.renderAsSelectOptions(ocanStaffForm.getId(), "medication_"+medicationNumber+"_se_affects", OcanForm.getOcanFormOptions("Side Effects Reported Ability"),prepopulationLevel)%>
				</select>					
			</td>
		</tr>																		
		<tr>
			<td class="genericTableHeader">Description of side effects</td>
			<td class="genericTableData">
				<%=OcanForm.renderAsCheckBoxOptions(ocanStaffForm.getId(), "medication_"+medicationNumber+"_se_description", OcanForm.getOcanFormOptions("Side Effects Description List"),prepopulationLevel)%>						
			</td>
		</tr>
		<tr>
			<td class="genericTableHeader">Other</td>
			<td class="genericTableData">
				<%=OcanForm.renderAsTextArea(ocanStaffForm.getId(),"medication_"+medicationNumber+"_se_description_other",5,30,prepopulationLevel)%>
			</td>
		</tr>										
	</table>
</div>