<%@page import="java.util.List" %>
<%@page import="java.lang.Exception" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>

<%@page import="org.oscarehr.casemgmt.dao.CaseManagementNoteDAO" %>

<%@page import="org.oscarehr.casemgmt.model.CaseManagementNote" %>

<%@page import="org.oscarehr.util.SpringUtils" %>

<%!
boolean isValidId(String input) {
	try  {
		Integer.parseInt( input );  
	} catch(Exception e) {
		return false;
	}
	
	if (input.equals(""))
		return false;
      
	return true;
}
%>

<%

CaseManagementNoteDAO caseManagementNoteDAO = (CaseManagementNoteDAO)SpringUtils.getBean("caseManagementNoteDAO");

String appointmentNo = request.getParameter("appointmentNo");

//appointmentNo = "1437734";

if (!isValidId(appointmentNo)) {
	response.setContentType("application/json");
	response.getWriter().write( (new JSONArray()).toString() );
	return;
}

List<CaseManagementNote> notes = caseManagementNoteDAO.getMostRecentNotesByAppointmentNo( Integer.parseInt(appointmentNo) );

JSONArray jsonArray = new JSONArray();

for (CaseManagementNote note : notes) {
	JSONObject obj = new JSONObject();
	
	obj.put( "observation_date", note.getObservation_date().toString() );
	obj.put( "note", note.getNote() );
	
	jsonArray.add(obj);
}

response.setContentType("application/json");
response.getWriter().write(jsonArray.toString());
%>
