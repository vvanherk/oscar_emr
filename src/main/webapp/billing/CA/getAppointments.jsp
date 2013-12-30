<%--
  Copyright (c) 2013-2014 Prylynx Corporation
 
  This software is made available under the terms of the
  GNU General Public License, Version 2, 1991 (GPLv2).
  License details are available via "gnu.org/licenses/gpl-2.0.html".
--%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@page import="java.util.List, java.util.Set, java.util.Collections, java.util.Comparator, java.util.Date, java.util.Calendar, java.text.SimpleDateFormat" %>
<%@page import="org.oscarehr.util.SpringUtils" %>
<%@ page import="org.oscarehr.common.dao.OscarAppointmentDao" %>
<%@ page import="org.oscarehr.common.model.Appointment"%>
<%@page import="org.oscarehr.common.dao.DemographicDao" %>
<%@page import="org.oscarehr.common.model.Demographic" %>
<%@page import="org.oscarehr.common.dao.ProfessionalSpecialistDao" %>
<%@page import="org.oscarehr.common.model.ProfessionalSpecialist" %>
<%
OscarAppointmentDao appointmentDao = (OscarAppointmentDao)SpringUtils.getBean("oscarAppointmentDao");
DemographicDao demographicDao = (DemographicDao)SpringUtils.getBean("demographicDao");
ProfessionalSpecialistDao prSpecialistDao = (ProfessionalSpecialistDao)SpringUtils.getBean("professionalSpecialistDao");

String providerno = request.getParameter("providerno");
String from_date = request.getParameter("from_date");
String to_date = request.getParameter("to_date");

Date start = new SimpleDateFormat("yyyy-MM-dd").parse(from_date);
Date end = new SimpleDateFormat("yyyy-MM-dd").parse(to_date);
List<Appointment> appList = null;

appList = appointmentDao.getBilledByDateRangeAndProvider(start, end, providerno, null, null);
%>[<%
for(int i=0; i < appList.size(); i++){
	Appointment apmt = appList.get(i);
	Demographic demo = demographicDao.getDemographicById(apmt.getDemographicNo());

	String hin = !demo.getHin().equals("") ? demo.getHin() : "HIN not Set";
	String desc = "";
	if(!apmt.getType().equals("")){
		desc += apmt.getType();
		if(!apmt.getReason().equals("")){ desc += ", " + apmt.getReason(); }
	} else if(!apmt.getReason().equals("")){ desc += apmt.getReason(); }

	String rdoc = "0";
	String refDoc = "";
	String family_doctor= demo.getFamilyDoctor();
	String xml_parse = "<rdohip>";
	if(family_doctor != null &&family_doctor.indexOf(xml_parse) >= 0){ //if it exists
		rdoc = family_doctor.substring(family_doctor.indexOf(xml_parse) + xml_parse.length(),
		 family_doctor.indexOf("</rdohip>"));
		List<ProfessionalSpecialist> temp = prSpecialistDao.findByReferralNo(rdoc);
		refDoc = temp.get(0).getFormattedName();
	}
%>
	{ "demo": 
		{"id": "<%= apmt.getDemographicNo() %>",
		 "name": "<%= demo.getDisplayName().trim() %>",
		 "dob" : "<%= demo.getBirthDayAsString() %>", 
		 "health_card":"<%= hin %>",
		 "gender": "<%= demo.getSex() %>" },
	   "id": <%= apmt.getId() %>,
	   "time": "<%= apmt.getStartTime() %>",
	   "date": "<%= apmt.getAppointmentDate() %>",
	   "description": "<%= desc.trim() %>",
	   "status" : "Ready",
	   "rdoctor": "<%= refDoc %>",
	   "sli_code":"",
	   "dx_codes": [],
	   "items":[],
	   "manual":"",
	   "notes":"<%= apmt.getNotes().trim() %>",
	   "inv_amount":"0.00"
	 }<%	if( i + 1 < appList.size() ){ %>, <% }
}
%>]

<%/*       Sample code to use later

Integer parseId(String input) {
	Integer result = null;
	try  {
		result = Integer.parseInt( input );  
	} catch(Exception e) {
	}
      
	return result;
}


CaseManagementNoteDAO caseManagementNoteDAO = (CaseManagementNoteDAO)SpringUtils.getBean("caseManagementNoteDAO");

Integer appointmentNo = parseId( request.getParameter("appointmentNo") );

if (appointmentNo == null || appointmentNo.intValue() == 0) {
	response.setContentType("application/json");
	response.getWriter().write( (new JSONArray()).toString() );
	return;
}

List<CaseManagementNote> notes = caseManagementNoteDAO.getMostRecentNotesByAppointmentNo( appointmentNo );

JSONArray jsonArray = new JSONArray();

for (CaseManagementNote note : notes) {
	JSONObject obj = new JSONObject();
	
	obj.put( "observation_date", note.getObservation_date().toString() );
	obj.put( "note", note.getNote() );
	
	jsonArray.add(obj);
}

response.setContentType("application/json");
response.getWriter().write(jsonArray.toString());
*/
%>

