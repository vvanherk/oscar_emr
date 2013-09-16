<!doctype html>
<%--

    Copyright (c) 2006-. OSCARservice, OpenSoft System. All Rights Reserved.
    This software is published under the GPL GNU General Public License.
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

--%>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@page import="java.util.List, java.util.Set, java.util.Collections, java.util.Comparator, java.util.Date, java.util.Calendar, java.text.SimpleDateFormat, java.util.HashSet, java.util.ArrayList" %>
<%@page import="javax.validation.Validator, javax.validation.Validation, javax.validation.ValidationException, javax.validation.ConstraintViolation, javax.validation.ConstraintViolationException" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONSerializer" %>

<%@page import="oscar.OscarProperties" %>
<%@page import="org.oscarehr.util.SpringUtils" %>

<%@page import="org.oscarehr.common.dao.OscarAppointmentDao" %>
<%@page import="org.oscarehr.common.model.Appointment"%>
<%@page import="org.oscarehr.common.dao.DemographicDao" %>
<%@page import="org.oscarehr.common.model.Demographic" %>
<%@page import="org.oscarehr.PMmodule.dao.ProviderDao" %>
<%@page import="org.oscarehr.common.model.Provider" %>
<%@page import="org.oscarehr.common.dao.BillingServiceDao" %>
<%@page import="org.oscarehr.common.model.BillingService" %>
<%@page import="org.oscarehr.billing.CA.ON.dao.BillingClaimDAO" %>
<%@page import="org.oscarehr.billing.CA.ON.model.BillingClaimHeader1" %>
<%@page import="org.oscarehr.common.dao.DiagnosticCodeDao" %>
<%@page import="org.oscarehr.common.model.DiagnosticCode" %>

<%@page import="org.oscarehr.util.MiscUtils"%>
<%@page import="org.oscarehr.billing.CA.ON.model.BillingItem" %>
<%@page import="oscar.oscarBilling.ca.on.data.BillingDataHlp" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<% ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
   OscarAppointmentDao appointmentDao = (OscarAppointmentDao)SpringUtils.getBean("oscarAppointmentDao");
   DemographicDao demographicDao = (DemographicDao)SpringUtils.getBean("demographicDao");
   DiagnosticCodeDao diagnosticCodeDao = (DiagnosticCodeDao)SpringUtils.getBean("diagnosticCodeDao");
   BillingServiceDao billingServiceDao = (BillingServiceDao)SpringUtils.getBean("billingServiceDao");
   BillingClaimDAO billingClaimDao = (BillingClaimDAO)SpringUtils.getBean("billingClaimDAO");
%>


<html>
<head>

<title>Billing Submission</title>

</head>
<body>

<script>

<% 
 String invType = request.getParameter("invoicesType"); 
 JSONArray invoices = (JSONArray) JSONSerializer.toJSON(request.getParameter("invoicesData")); 
 JSONObject batch = (JSONObject) JSONSerializer.toJSON(request.getParameter("batchData"));

 Provider provider = providerDao.getProvider(batch.optString("b_provider"));

for(JSONObject newInvoiceData : invoices){

	JSONArray newInvBillsData = newInvoiceData.optJSONArray("bills");
	String curuser = (String) session.getAttribute("user");

	Demographic demographic;
	String code = newInvBillsData.getJSONObject(0).optString("code");

	BillingClaimHeader1 newInvoice = new BillingClaimHeader1();

	if(invType.equals('clinical')){
		Appointment appointment = appointmentDao.getAppointment(Integer.parseInt(newInvoiceData.optString("id")));
		demographic = demographicDao.getDemographic(appointment.getDemographicNo() + "");

		newInvoice.setAppointment_no(appointment.getId() + "");	
		newInvoice.setApptProvider_no(batch.optString("provider"));
	} else{
		JSONObject jsonDemo = (JSONObject) JSONSerializaer.toJSON(newInvoice.optString("demo"));
		demographic = demographicDao.getDemographic(jsonDemo.optString("id"));
		
		if(invType.equals('hospital')){
			newInvoice.setAdmission_date();					//only hospital inpatient, not ER or outpatient
		}
	}

	newInvoice.setDemographic_no(demographic.getDemographicNo());
	newInvoice.setProvider_no(provider.getProviderNo());
	newInvoice.setBilling_date(new SimpleDateFormat("yyyy/MM/dd").parse(batch.optString("billDate")));
	newInvoice.setBilling_time(new SimpleDateFormat("HH:mm:ss").parse(batch.optString("billTime")));
	newInvoice.setDemographic_name(demographic.getFormattedName());
	newInvoice.setStatus("O");						//Incorporate hold
	if (!newInvoiceData.optString("rdoctor").equals("0"))
		newInvoice.setRef_num(newInvoiceData.optString("rdoctor"));
	newInvoice.setComment1(newInvoiceData.optString("notes"));
	newInvoice.setMan_review( (!newInvoiceData.optString("manual").equals("") ? "Y" : "") );

	newInvoice.setPay_program(batch.optString("btype"));		//only RMB or OHIP for clinical, offsite and hospital. PAT is for Cash Register
	newInvoice.setHin(demographic.getHin());
	newInvoice.setVer(demographic.getVer());
	newInvoice.setDob(demographic.getYearOfBirth() +"/"+ demographic.getMonthOfBirth() +"/"+ demographic.getDateOfBirth());
	newInvoice.setFacilty_num( clinic_ref_code );
	//newInvoice.setLocation("3821"); 			// potentially for multisite
	newInvoice.setSex(demographic.getSex());
	newInvoice.setProvince(demographic.getHcType());
	newInvoice.setProvider_ohip_no(provider.getOhipNo());
	newInvoice.setProvider_rma_no(provider.getRmaNo());
	newInvoice.setCreator(curuser);

	double total = 0;

	for (JSONObject itemData : newInvBillsData) {
		BillingItem item = new BillingItem();
		item.setCh1_id(newInvoice.getId());
		item.setTransc_id(BillingDataHlp.ITEM_TRANSACTIONIDENTIFIER);
		item.setRec_id(BillingDataHlp.ITEM_REORDIDENTIFICATION);
		item.setService_code(itemData.optString("code"));
		
			double amount = Double.parseDouble(itemData.optString("amount"));
			double percent = Double.parseDouble(itemData.optString("percent"));
		
		item.setFee( String.format("%1$,.2f", amount * percent) );
		item.setSer_num(itemData.optString("units"));
		item.setStatus("W");
		
		item.setService_date(new SimpleDateFormat("yyyy/MM/dd").parse(batch.optString("billDate")));		//should be appointment date for clinical, manually set for offsite

		total += amount;

		newInvoice.getBillingItems().add(item);
	}

	newInvoice.setTotal(String.format("%1$,.2f", total));

	try{

		//validate(newInvoice, billingServiceDao, diagnosticCodeDao);
		billingClaimDao.createBill(newInvoice);

		// update appointment status to be 'B' for billed

		appointment.setStatus("B");
		appointmentDao.updateAppointment(appointment);

	} catch (Exception e) {
				MiscUtils.getLogger().error("Error while creating/updating bill:", e);
			}
}

%>

<%!

void validate(BillingClaimHeader1 newBill, BillingServiceDao billingServiceDao, DiagnosticCodeDao diagnosticCodeDao) throws ValidationException, ConstraintViolationException {
    // Validate
    Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
    Set<ConstraintViolation<BillingClaimHeader1>>  constraintViolations = validator.validate(newBill);
    
    // if there are validation errors, throw exception
    if (constraintViolations.size() > 0) {
		MiscUtils.getLogger().info("validation errors: " + constraintViolations.size());
		
		for (ConstraintViolation violation : constraintViolations) {
			MiscUtils.getLogger().info("validation error: " + violation.toString());
		}
		// error in ConstraintViolationException definition, so we need to create an intermediate collection
		// see: https://forum.hibernate.org/viewtopic.php?f=26&t=998831
		throw new ConstraintViolationException(new HashSet<ConstraintViolation<?>>(constraintViolations));
	}
	
	
	List<BillingItem> billingItems = newBill.getBillingItems();
	List<String> serviceCodes = new ArrayList<String>();
	List<String> diagnosticCodes = new ArrayList<String>();
	
	for (BillingItem item : billingItems) {
	
		Set<ConstraintViolation<BillingItem>> constraintViolationsBillingItems = validator.validate(item);
	    
	    // if there are validation errors, throw exception
	    if (constraintViolationsBillingItems.size() > 0) {
			MiscUtils.getLogger().info("validation errors: " + constraintViolationsBillingItems.size());
			
			for (ConstraintViolation violation : constraintViolationsBillingItems) {
				MiscUtils.getLogger().info("validation error: " + violation.toString());
			}
			// error in ConstraintViolationException definition, so we need to create an intermediate collection
			// see: https://forum.hibernate.org/viewtopic.php?f=26&t=998831
			throw new ConstraintViolationException(new HashSet<ConstraintViolation<?>>(constraintViolationsBillingItems));
		}
		
		serviceCodes.add(item.getService_code());
		diagnosticCodes.add(item.getDx());
	}
	
	// validate the service codes
	List<BillingService> billingServices = billingServiceDao.findBillingCodesByCode(serviceCodes, "ON");
	List<String> matchedServiceCodes = new ArrayList<String>();
	
	for (BillingService code : billingServices) {
		matchedServiceCodes.add(code.getServiceCode());
	}
	
	for (String code : serviceCodes) {
		if ( !matchedServiceCodes.contains(code) ) {
			throw new ValidationException(code + " is not a valid Billing Service Code!");
		}
	}
	
	// validate the diagnostic codes
	List<DiagnosticCode> diagnosticCodeList = diagnosticCodeDao.findDiagnosticCodesByCode(diagnosticCodes);
	List<String> matchedDiagnosticCodes = new ArrayList<String>();
	
	for (DiagnosticCode code : diagnosticCodeList) {
		matchedDiagnosticCodes.add(code.getDiagnosticCode());
	}
	
	for (String code : diagnosticCodes) {
		if ( code.length() != 0 && !matchedDiagnosticCodes.contains(code) ) {
			throw new ValidationException(code + " is not a valid Diagnostic Service Code!");
		}
	}
}
%>

</body>

</html>
