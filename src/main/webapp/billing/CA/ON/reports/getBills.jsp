<%@page import="java.util.List" %>
<%@page import="org.oscarehr.billing.CA.ON.dao.BillingClaimDAO" %>
<%@page import="org.oscarehr.billing.CA.ON.model.BillingClaimHeader1" %>

<% 
BillingClaimDAO billingClaimDAO = (BillingClaimDAO)SpringUtils.getBean("billingClaimDAO");

List<BillingClaimHeader1> bills = billingClaimDAO.getInvoices(new Integer(apt.getDemographicNo()).toString(), new Integer(30));
%>
