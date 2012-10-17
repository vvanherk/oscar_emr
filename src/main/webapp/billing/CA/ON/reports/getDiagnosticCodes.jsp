<%@page import="java.util.List" %>
<%@page import="java.lang.Exception" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>

<%@page import="org.oscarehr.common.dao.DiagnosticCodeDao" %>

<%@page import="org.oscarehr.common.model.DiagnosticCode" %>

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

DiagnosticCodeDao diagnosticCodeDao = (DiagnosticCodeDao)SpringUtils.getBean("diagnosticCodeDao");

String diagnosticCode = request.getParameter("diagnosticCode");
String diagnosticDescription = request.getParameter("diagnosticDescription");

//diagnosticCode = "216";
//diagnosticDescription = "Skin rash";

if (!isValidId(diagnosticCode) && (diagnosticDescription == null || diagnosticDescription.length() == 0)) {
	response.setContentType("application/json");
	response.getWriter().write( (new JSONArray()).toString() );
	return;
}

List<DiagnosticCode> diagnosticCodes = null;
if (!isValidId(diagnosticCode)) {
	diagnosticCodes = diagnosticCodeDao.findDiagnosticCodesByDescription(diagnosticDescription);
} else {
	diagnosticCodes = diagnosticCodeDao.findDiagnosticCodesByCode(diagnosticCode);
}
 
 
JSONArray jsonArray = new JSONArray();

for (DiagnosticCode diagCode : diagnosticCodes) {
	JSONObject obj = new JSONObject();
	
	obj.put( "diagnostic_code", diagCode.getDiagnosticCode() );
	obj.put( "description", diagCode.getDescription() );
	
	jsonArray.add(obj);
}

response.setContentType("application/json");
response.getWriter().write(jsonArray.toString());
%>
