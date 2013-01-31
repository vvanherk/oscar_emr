
<%@page import="org.oscarehr.util.LoggedInInfo"%>
<%@page import="org.oscarehr.common.model.OcanStaffForm"%>
<%@page import="org.oscarehr.common.model.OcanStaffFormData"%>
<%@page import="org.oscarehr.PMmodule.web.OcanForm"%>
<%@page import="org.oscarehr.PMmodule.web.OcanFormAction"%>
<%@page import="org.oscarehr.util.WebUtils"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.commons.lang.ArrayUtils"%>
<%
	@SuppressWarnings("unchecked")
	HashMap<String,String[]> parameters=new HashMap(request.getParameterMap());

	if(request.getParameter("ocanType")!=null && request.getParameter("ocanType").equalsIgnoreCase("full")) {
		if(parameters.get("1_where_live")[0].equals("024-01") || parameters.get("1_where_live")[0].equals("024-02") ||
				parameters.get("1_where_live")[0].equals("024-05") || parameters.get("1_where_live")[0].equals("024-06") ||
				parameters.get("1_where_live")[0].equals("024-08") || parameters.get("1_where_live")[0].equals("024-09") ) {
			parameters.remove("1_any_support");
			parameters.put("1_any_support", parameters.get("1_any_support_hidden"));
		}
		boolean var4 = false;
		boolean var3 = false;
		int length = 0;
		
		if(!ArrayUtils.isEmpty(parameters.get("immigration_issues"))) {
			length = parameters.get("immigration_issues").length;
		
			String[] immi = new String[length+1];	
			int i=0;
			for(String ii : parameters.get("immigration_issues")) {
				immi[i] = ii;
				if(ii.equalsIgnoreCase("4")) var4 = true;
				if(ii.equalsIgnoreCase("3")) var3 = true;
				i++;
			}
			if(var4 && !var3) {
				immi[length] = "3"; 
				parameters.put("immigration_issues", immi);
			}
		}
		
	}	
	
	// for these values get them and pop them from map so subsequent iterating through map doesn't process these parameters again.
	//Integer admissionId=Integer.valueOf(parameters.get("admissionId")[0]);	
	//parameters.remove("admissionId");
	Integer admissionId=0;   //useless default value.
	
	
	//Integer clientAge=Integer.valueOf(parameters.get("age")[0]);	
	parameters.remove("age");

	Integer clientId=Integer.valueOf(parameters.get("clientId")[0]);	
	parameters.remove("clientId");

	boolean signed=WebUtils.isChecked(request, "signed");	
	parameters.remove("signed");

	String assessmentStatus = request.getParameter("assessment_status");
	String startDate = parameters.get("startDate")[0];
	String completionDate = parameters.get("completionDate")[0];
	String reasonForAssessment = parameters.get("reasonForAssessment")[0];
	String gender = parameters.get("gender")[0];	
	String ocanStaffFormId = parameters.get("ocanStaffFormId")[0];
	String consent = parameters.get("consent")[0];
	
	OcanStaffForm ocanStaffForm=OcanFormAction.createOcanStaffForm(ocanStaffFormId, clientId, signed);
	
	int prepopulate = 0;
	prepopulate = Integer.parseInt(request.getParameter("prepopulate")==null?"0":request.getParameter("prepopulate"));
	
	
	ocanStaffForm.setLastName(request.getParameter("lastName")==null?"":request.getParameter("lastName"));
	ocanStaffForm.setFirstName(request.getParameter("firstName")==null?"":request.getParameter("firstName"));
	ocanStaffForm.setAddressLine1(request.getParameter("addressLine1")==null?"":request.getParameter("addressLine1"));
	ocanStaffForm.setAddressLine2(request.getParameter("addressLine2")==null?"":request.getParameter("addressLine2"));
	ocanStaffForm.setCity(request.getParameter("city")==null?"":request.getParameter("city"));
	ocanStaffForm.setProvince(request.getParameter("province")==null?"":request.getParameter("province"));
	ocanStaffForm.setPostalCode(request.getParameter("postalCode")==null?"":request.getParameter("postalCode"));
	ocanStaffForm.setPhoneNumber(request.getParameter("phoneNumber")==null?"":request.getParameter("phoneNumber"));
	ocanStaffForm.setEmail(request.getParameter("email")==null?"":request.getParameter("email"));
	ocanStaffForm.setHcNumber(request.getParameter("hcNumber")==null?"":request.getParameter("hcNumber"));
	ocanStaffForm.setHcVersion(request.getParameter("hcVersion")==null?"":request.getParameter("hcVersion"));
	ocanStaffForm.setDateOfBirth(request.getParameter("date_of_birth")==null?"":request.getParameter("date_of_birth"));
	ocanStaffForm.setClientDateOfBirth(request.getParameter("client_date_of_birth")==null?"":request.getParameter("client_date_of_birth"));
	ocanStaffForm.setGender(gender==null?"":gender);
	//ocanStaffForm.setAdmissionId(admissionId);
	ocanStaffForm.setOcanType(request.getParameter("ocanType")==null?"":request.getParameter("ocanType"));
	ocanStaffForm.setConsent(request.getParameter("consent")==null?"NOT_SPECIFIED":request.getParameter("consent"));
	
	//Once ocan assessment was completed, it can not be changed to other status.
	if(!"Completed".equals(ocanStaffForm.getAssessmentStatus())) {	
		ocanStaffForm.setAssessmentStatus(assessmentStatus);
	}
	
	ocanStaffForm.setReasonForAssessment(reasonForAssessment);
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
	try {
		if(!StringUtils.isBlank(startDate))
			ocanStaffForm.setStartDate(formatter.parse(startDate));
		if(!StringUtils.isBlank(request.getParameter("clientStartDate")))
			ocanStaffForm.setClientStartDate(formatter.parse(request.getParameter("clientStartDate")));
	}catch(java.text.ParseException e){}
	try {
		if(!StringUtils.isBlank(completionDate))
			ocanStaffForm.setCompletionDate(formatter.parse(completionDate));
		
		if(!StringUtils.isBlank(request.getParameter("clientCompletionDate")))
			ocanStaffForm.setClientCompletionDate(formatter.parse(request.getParameter("clientCompletionDate")));
	}catch(java.text.ParseException e){}
	
	ocanStaffForm.setCreated(new Date());
	LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();
	ocanStaffForm.setProviderNo(loggedInInfo.loggedInProvider.getProviderNo());
	ocanStaffForm.setProviderName(loggedInInfo.loggedInProvider.getFormattedName());		
	
	OcanFormAction.saveOcanStaffForm(ocanStaffForm);	
	
	parameters.remove("lastName");
	parameters.remove("firstName");
	parameters.remove("addressLine1");
	parameters.remove("addressLine2");
	parameters.remove("city");
	parameters.remove("province");
	parameters.remove("postalCode");
	parameters.remove("phoneNumber");
	parameters.remove("email");
	parameters.remove("hcNumber");
	parameters.remove("hcVersion");
	parameters.remove("date_of_birth");
	parameters.remove("startDate");
	parameters.remove("completionDate");
	parameters.remove("reasonForAssessment");
	parameters.remove("gender");
	parameters.remove("consent");
	
	Integer ocanStaffFormId_Int=0;
	if(ocanStaffFormId!=null && !"".equals(ocanStaffFormId) && !"null".equals(ocanStaffFormId)) {
		ocanStaffFormId_Int = Integer.parseInt(ocanStaffFormId);
	}		
	
	List<OcanStaffFormData> oldData = OcanForm.getOcanFormDataByFormId(ocanStaffFormId_Int);
	if(oldData.size()>0) {
		for(OcanStaffFormData d : oldData) {	
			if(d.getQuestion().contains("client_"))
				OcanFormAction.addOcanStaffFormData(ocanStaffForm.getId(),d.getQuestion(),d.getAnswer());
		}
	
	} 
	
		for (Map.Entry<String, String[]> entry : parameters.entrySet())
		{
			if (entry.getValue()!=null)
			{
				for (String value : entry.getValue())
				{
					OcanFormAction.addOcanStaffFormData(ocanStaffForm.getId(), entry.getKey(), value);				
				}
			}
		}
	
	response.sendRedirect(request.getContextPath()+"/PMmodule/ClientManager.do?id="+clientId);
%>
