<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.lang.Exception" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>

<%@page import="org.oscarehr.common.dao.BillingreferralDao" %>

<%@page import="org.oscarehr.common.model.Billingreferral" %>

<%@page import="org.oscarehr.util.SpringUtils" %>
<%@page import="org.oscarehr.util.MiscUtils"%>

<%!
boolean isValidStringInput(String input) {
	return input != null && !input.equals("");
}

String tokenize(String input) {
	if (input == null)
		input = "";
		
	return input;
}
%>

<%

BillingreferralDao billingReferralDao = (BillingreferralDao)SpringUtils.getBean("BillingreferralDAO");

String referralNo = request.getParameter("referral_no");
String firstName = request.getParameter("first_name");
String lastName = request.getParameter("last_name");
String specialty = request.getParameter("specialty");

//firstName = "Public";

List<Billingreferral> billingReferrals = null;
if ( isValidStringInput(referralNo) ) {
	Billingreferral billingReferral = billingReferralDao.getByReferralNo(referralNo);
	billingReferrals = new ArrayList<Billingreferral>();
	billingReferrals.add(billingReferral);
} else if ( isValidStringInput(firstName)  || isValidStringInput(lastName) ) {
	
	MiscUtils.getLogger().info("lastName: " + lastName);
	MiscUtils.getLogger().info("firstName: " + firstName);
	billingReferrals = billingReferralDao.getBillingreferral( tokenize(lastName), tokenize(firstName) );
} else if (isValidStringInput(specialty)) {
	billingReferrals = billingReferralDao.getBillingreferralBySpecialty(specialty);
}


// return empty json array if no data
if (billingReferrals == null) {
	response.setContentType("application/json");
	response.getWriter().write( (new JSONArray()).toString() );
	return;
}


JSONArray jsonArray = new JSONArray();

for (Billingreferral billingReferral : billingReferrals) {
	JSONObject obj = new JSONObject();
	MiscUtils.getLogger().info("billingReferral.getReferralNo(): " + billingReferral.getReferralNo());
	
	obj.put( "referral_no", billingReferral.getReferralNo() );
	obj.put( "last_name", billingReferral.getLastName() );
	obj.put( "first_name", billingReferral.getFirstName() );
	obj.put( "specialty", billingReferral.getSpecialty() );
	
	jsonArray.add(obj);
}

response.setContentType("application/json");
response.getWriter().write(jsonArray.toString());
%>
