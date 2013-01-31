<%@page import="java.util.List" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="java.lang.Exception" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>

<%@page import="org.oscarehr.billing.CA.ON.dao.BillingClaimDAO" %>
<%@page import="org.oscarehr.common.dao.BillingServiceDao" %>

<%@page import="org.oscarehr.billing.CA.ON.model.BillingClaimHeader1" %>
<%@page import="org.oscarehr.billing.CA.ON.model.BillingItem" %>
<%@page import="org.oscarehr.common.model.BillingService" %>

<%@page import="org.oscarehr.util.SpringUtils" %>
<%@page import="org.oscarehr.util.MiscUtils"%>

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

BillingClaimDAO billingClaimDAO = (BillingClaimDAO)SpringUtils.getBean("billingClaimDAO");
BillingServiceDao billingServiceDao = (BillingServiceDao)SpringUtils.getBean("billingServiceDao");

String demographicNo = request.getParameter("demographicNo");
String appointmentNo = request.getParameter("appointmentNo");

if (!isValidId(demographicNo)) {
	response.setContentType("application/json");
	response.getWriter().write( (new JSONArray()).toString() );
	return;
}

List<BillingClaimHeader1> bills = null;
if (!isValidId(appointmentNo)) {
	Date endDate = new Date();

	// Use the Calendar class to subtract 2 years
	Calendar calendar = Calendar.getInstance();
	calendar.setTime(endDate);
	calendar.add(Calendar.YEAR, -2);

	Date startDate = calendar.getTime();
	
	//MiscUtils.getLogger().info("startDate: " + startDate);
	//MiscUtils.getLogger().info("endDate: " + endDate);
	
	bills = billingClaimDAO.getInvoicesByDemographic(demographicNo, startDate, endDate);
} else {
	bills = billingClaimDAO.getInvoices(demographicNo, appointmentNo);
}

JSONArray jsonArray = new JSONArray();

for (BillingClaimHeader1 bill : bills) {
	JSONObject obj = new JSONObject();
	
	obj.put( "id", bill.getId() );
	obj.put( "billing_date", bill.getBilling_date().toString() );
	obj.put( "billing_time", bill.getBilling_time().toString() );
	obj.put( "total", bill.getTotal() );
	obj.put( "paid", bill.getPaid() );
	obj.put( "status", bill.getStatus() );
	
	
	List<BillingItem> billingItems = bill.getBillingItems();
	for (BillingItem item : billingItems) {		
		String serviceDesc = "";

		List<BillingService> billingServices = billingServiceDao.findBillingCodesByCode(item.getService_code(), "ON");
		if (billingServices.size() > 0) {
			BillingService billingService = billingServices.get(0);
			if (billingService != null) {
				serviceDesc = billingService.getDescription();
			}
		}
		
		String fee = item.getFee();
		String units = item.getSer_num();
		Double feeAsDouble = new Double(0.0);
		Double unitsAsDouble = new Double(0.0);
		if (fee != null) {
			feeAsDouble = Double.valueOf( fee );
		}
		if (units != null) {
			unitsAsDouble = Double.valueOf( units );
		}
		double tempTotal = feeAsDouble.doubleValue() * unitsAsDouble.doubleValue();
		String total = String.format("%1$,.2f", (new Double(tempTotal)).doubleValue());
		
		JSONObject jsonBillingItem = new JSONObject();
		jsonBillingItem.put( "item", item.getService_code() );
		jsonBillingItem.put( "fee", fee );
		jsonBillingItem.put( "units", units );
		jsonBillingItem.put( "dx", item.getDx() );
		jsonBillingItem.put( "description", serviceDesc );
		jsonBillingItem.put( "total", total );
		
		obj.accumulate( "bill", jsonBillingItem );
	}
	
	jsonArray.add(obj);
}

response.setContentType("application/json");
response.getWriter().write(jsonArray.toString());
%>
