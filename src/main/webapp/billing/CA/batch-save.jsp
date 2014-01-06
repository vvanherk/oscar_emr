<%--
  Copyright (c) 2013-2014 Prylynx Corporation
 
  This software is made available under the terms of the
  GNU General Public License, Version 2, 1991 (GPLv2).
  License details are available via "gnu.org/licenses/gpl-2.0.html".
--%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@page import="java.util.List, java.util.Set, java.util.Collections, java.util.Comparator, java.util.Date, java.util.Calendar, java.text.SimpleDateFormat, java.util.HashSet, java.util.ArrayList" %>
<%@page import="javax.validation.Validator, javax.validation.Validation, javax.validation.ValidationException, javax.validation.ConstraintViolation, javax.validation.ConstraintViolationException" %>
<%@page import="net.sf.json.JSONArray, net.sf.json.JSONObject, net.sf.json.JSONSerializer" %>
<%@page import="oscar.OscarProperties, org.oscarehr.util.SpringUtils" %>

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

<% 	ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
	OscarAppointmentDao appointmentDao = (OscarAppointmentDao)SpringUtils.getBean("oscarAppointmentDao");
	DemographicDao demographicDao = (DemographicDao)SpringUtils.getBean("demographicDao");
	DiagnosticCodeDao diagnosticCodeDao = (DiagnosticCodeDao)SpringUtils.getBean("diagnosticCodeDao");
	BillingServiceDao billingServiceDao = (BillingServiceDao)SpringUtils.getBean("billingServiceDao");
	BillingClaimDAO billingClaimDao = (BillingClaimDAO)SpringUtils.getBean("billingClaimDAO");

	/*	To become server .java page function. Save a batch from batch billing pages.
	 * */
	
	JSONArray invoices = (JSONArray) JSONSerializer.toJSON(request.getParameter("invoicesData")); 	// array of invoices 
	JSONObject batch = (JSONObject) JSONSerializer.toJSON(request.getParameter("batchData"));		// general batch information
	String invType = request.getParameter("invoicesType");  										// what page the batch was generated from: clinical, hospital, offsite
	
	Provider provider = providerDao.getProvider(batch.optString("b_provider"));						//start by singling out billing provider for batch.
	int saved = 0;
	
	for(int i = 0; i < invoices.size(); i++){							// invoice iteration
		
		JSONObject newInvoiceData = invoices.getJSONObject(i);
		JSONArray newInvItemsData = newInvoiceData.getJSONArray("items");
		String curuser = (String) session.getAttribute("user");
		BillingClaimHeader1 newInvoice = new BillingClaimHeader1();
		
		//Defaults
		Demographic demographic;
		Date service_date = new SimpleDateFormat("yyyy/MM/dd").parse(batch.optString("billDate")); 
		String 	sli = newInvoiceData.optString("sli_code").trim();
				sli = sli.equals("") ? "Not" : sli.substring(0,3);
		
		if(invType.equals("clinical")){
			Appointment appointment = appointmentDao.getAppointment(Integer.parseInt(newInvoiceData.optString("id")));
			demographic = demographicDao.getDemographic(appointment.getDemographicNo() + "");
			service_date = appointment.getAppointmentDate();
			
			// update appointment status to be 'B' for billed
			appointment.setStatus("B");
			appointmentDao.updateAppointment(appointment);
			
			newInvoice.setAppointment_no(appointment.getId() + "");	
			newInvoice.setApptProvider_no(batch.optString("provider"));
		} else{
			JSONObject jsonDemo = newInvoiceData.getJSONObject("demo");
			demographic = demographicDao.getDemographic(jsonDemo.optString("id"));

			if(invType.equals("hospital")){
				if(sli.equals("HOP")){
					newInvoice.setVisittype("01");
				} else if (sli.equals("HED") ){
					newInvoice.setVisittype("03");
				} else {
					newInvoice.setVisittype("02");
				}
				//newInvoice.setAdmission_date();					//only hospital inpatient, not ER or outpatient
			}
			 else if(invType.equals("offsite")){
				newInvoice.setVisittype("05");
			}
		}
		newInvoice.setDemographic_no(demographic.getDemographicNo());
		newInvoice.setProvider_no(provider.getProviderNo());
		newInvoice.setBilling_date(new SimpleDateFormat("yyyy/MM/dd").parse(batch.optString("billDate")));
		newInvoice.setBilling_time(new SimpleDateFormat("HH:mm:ss").parse(batch.optString("billTime")));
		newInvoice.setDemographic_name(demographic.getFormattedName());
		if(newInvoiceData.optString("status").equals("Ready")){		// feeds directly into "Ready" table in workbench
			newInvoice.setStatus("O");
		} else if(newInvoiceData.optString("status").equals("Hold")){
			newInvoice.setStatus("Z");								// feeds into "In Progress" table in workbench
		}
		if(!newInvoiceData.optString("rdocNum").equals("0")){	newInvoice.setRef_num(newInvoiceData.optString("rdocNum")); }
		newInvoice.setComment1(newInvoiceData.optString("notes"));
		newInvoice.setMan_review( (!newInvoiceData.optString("manual").equals("") ? "Y" : "") );		//requires testing
		if(newInvoiceData.optString("btype").equals("OHIP")){
			newInvoice.setPay_program("HCP");		//only RMB or HCP for clinical, offsite and hospital. PAT is for Cash Register
		}else{
			newInvoice.setPay_program(newInvoiceData.optString("btype"));
		}
		newInvoice.setHin(demographic.getHin());
		newInvoice.setVer(demographic.getVer());
		newInvoice.setDob(demographic.getYearOfBirth() +""+ demographic.getMonthOfBirth() +""+ demographic.getDateOfBirth());
		newInvoice.setFacilty_num(batch.optString("location"));
		if(sli.equals("Not") || sli.equals("")){
			newInvoice.setLocation("3821"); 
		} else {
			newInvoice.setLocation(sli);
		}
		newInvoice.setSex(demographic.getSex());
		newInvoice.setProvince(demographic.getHcType());
		newInvoice.setProvider_ohip_no(provider.getOhipNo());
		newInvoice.setProvider_rma_no(provider.getRmaNo());
		newInvoice.setCreator(curuser);
		
		double total = 0;
		for (int j = 0; j < newInvItemsData.size(); j++) {
			JSONObject itemData = newInvItemsData.getJSONObject(j);
			BillingItem item = new BillingItem();
			item.setCh1_id(newInvoice.getId());
			item.setTransc_id(BillingDataHlp.ITEM_TRANSACTIONIDENTIFIER);
			item.setRec_id(BillingDataHlp.ITEM_REORDIDENTIFICATION);
			item.setService_code(itemData.optString("code"));
			
				double amount = Double.parseDouble(itemData.optString("amount"));
				double percent = Double.parseDouble(itemData.optString("percent"));
			
			item.setFee( String.format("%1$,.2f", amount * percent) );
			item.setDx(itemData.optString("dx_code"));
			item.setSer_num(itemData.optString("units"));
			item.setStatus("O");
			item.setService_date(service_date);		//should be appointment date for clinical, manually set for offsite
			total += amount;
			newInvoice.getBillingItems().add(item);
		}
		newInvoice.setTotal(String.format("%1$,.2f", total));
		
		try{
			//validate(newInvoice, billingServiceDao, diagnosticCodeDao);
			billingClaimDao.createBill(newInvoice);
			saved ++;

		} catch (Exception e) {
			MiscUtils.getLogger().error("Error while creating/updating bill:", e);
		}
	}
	%><%= saved %> Bills Saved<%!
	
/*
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
*/
%>

