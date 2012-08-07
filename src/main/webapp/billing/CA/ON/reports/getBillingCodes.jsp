<%@page import="java.util.List" %>
<%@page import="java.lang.Exception" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>

<%@page import="org.oscarehr.common.dao.BillingServiceDao" %>

<%@page import="org.oscarehr.common.model.BillingService" %>

<%@page import="org.oscarehr.util.SpringUtils" %>

<%

BillingServiceDao billingServiceDao = (BillingServiceDao)SpringUtils.getBean("billingServiceDao");

String serviceCode = request.getParameter("serviceCode");

//serviceCode = "A00";

List<BillingService> billingServices = billingServiceDao.findBillingCodesByCode(serviceCode, "ON");


JSONArray jsonArray = new JSONArray();

for (BillingService billingService : billingServices) {
	JSONObject obj = new JSONObject();
	
	obj.put( "service_code", billingService.getServiceCode() );
	obj.put( "description", billingService.getDescription() );
	obj.put( "value", billingService.getValue() );
	
	jsonArray.add(obj);
}

response.setContentType("application/json");
response.getWriter().write(jsonArray.toString());
%>
