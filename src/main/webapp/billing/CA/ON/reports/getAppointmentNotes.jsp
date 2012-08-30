<%@page import="java.util.List" %>
<%@page import="java.lang.Exception" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>

<%@page import="org.oscarehr.casemgmt.dao.CaseManagementNoteDAO" %>

<%@page import="org.oscarehr.casemgmt.model.CaseManagementNote" %>

<%@page import="org.oscarehr.util.SpringUtils" %>

<%!
Integer parseId(String input) {
	Integer result = null;
	try  {
		result = Integer.parseInt( input );  
	} catch(Exception e) {
	}
      
	return result;
}
%>

<%

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
%>
