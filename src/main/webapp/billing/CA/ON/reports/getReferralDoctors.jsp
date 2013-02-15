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

boolean isValidNumericInput(String input) {
	if (input == null)
		return false;
		
	return input.matches("^\\d*$");
}

String tokenize(String input) {
	if (input == null)
		input = "";
		
	return input.trim();
}

String[] parseFullName(String lookupData) {
	if (lookupData == null)
		return null;
	
	String[] flName = lookupData.split(",");
	String[] retValue = new String[2];
	
	if (flName != null) {
		if (flName.length == 1) {
			retValue[1] = "";
			retValue[0] = flName[0];
		} else if (flName.length == 2) {
			retValue[1] = flName[1];
			retValue[0] = flName[0];
		}
	}
	
	return retValue;
}
%>

<%

BillingreferralDao billingReferralDao = (BillingreferralDao)SpringUtils.getBean("BillingreferralDAO");

String specialty = request.getParameter("specialty");
// lookupData in the format 'lastname, firstname' OR as digits (for a referral number)
String lookupData = request.getParameter("lookup_data");

String firstName = "";
String lastName = "";

MiscUtils.getLogger().info("lookupData: " + lookupData);

List<Billingreferral> billingReferrals = null;

if (isValidStringInput(lookupData)) {
	if (isValidNumericInput(lookupData)) {
		// Query for referral doctor by referral number
		List<Billingreferral> billingReferral = billingReferralDao.getBillingreferral(lookupData, true);
		billingReferrals = new ArrayList<Billingreferral>();
		if (billingReferral != null)
			billingReferrals.addAll(billingReferral);
	} else {
		// Query for referral doctor by referral first and last name
		String[] flName = parseFullName( lookupData );
		firstName = flName[1];
		lastName = flName[0];

		MiscUtils.getLogger().info("firstName: " + firstName);
		MiscUtils.getLogger().info("lastName: " + lastName);
	
		if ( isValidStringInput(firstName)  || isValidStringInput(lastName) )
			billingReferrals = billingReferralDao.getBillingreferral( tokenize(lastName), tokenize(firstName) );
	}
} else if (isValidStringInput(specialty)) {
	// Query for referral doctor by specialty
	billingReferrals = billingReferralDao.getBillingreferralBySpecialty(specialty);
}


// return empty json array if no data
if (billingReferrals == null || billingReferrals.size() == 0) {
	response.setContentType("application/json");
	response.getWriter().write( (new JSONArray()).toString() );
	return;
}


JSONArray jsonArray = new JSONArray();

// parse results into json array
for (Billingreferral billingReferral : billingReferrals) {
	JSONObject obj = new JSONObject();
	
	obj.put( "referral_no", billingReferral.getReferralNo() );
	obj.put( "last_name", billingReferral.getLastName() );
	obj.put( "first_name", billingReferral.getFirstName() );
	obj.put( "specialty", billingReferral.getSpecialty() );
	
	jsonArray.add(obj);
}

response.setContentType("application/json");
response.getWriter().write(jsonArray.toString());
%>
