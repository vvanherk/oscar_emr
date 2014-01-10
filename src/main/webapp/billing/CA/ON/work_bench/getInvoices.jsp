<%--
  Copyright (c) 2013-2014 Prylynx Corporation
 
  This software is made available under the terms of the
  GNU General Public License, Version 2, 1991 (GPLv2).
  License details are available via "gnu.org/licenses/gpl-2.0.html".
--%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%><%@page import="java.util.List, java.util.Set, java.util.Collections, java.util.Comparator, java.util.Date, java.util.Calendar, java.text.SimpleDateFormat" %><%@page import="org.oscarehr.util.SpringUtils" %>
<%@page import="org.oscarehr.billing.CA.ON.dao.BillingClaimDAO" %><%@page import="org.oscarehr.billing.CA.ON.model.BillingClaimHeader1" %>
<%
BillingClaimDAO billingClaimDao = (BillingClaimDAO)SpringUtils.getBean("billingClaimDAO");

String provider_no = request.getParameter("provider_no");
List<String> statuses = new ArrayList<String>();
statuses.add(request.getParameter("status"));

List<BillingClaimHeader1> invList = null;

invList = billingClaimDao.getInvoicesByProviderAndStatuses(provider_no, statuses);

%>[<%
for(int i=0; i < invList.size(); i++){
	BillingClaimHeader1 inv = invList.get(i);

	String hin = !demo.getHin().equals("") ? demo.getHin() : "HIN not Set";

	String rdoc = "0";
	String rdocno = "0";
	String family_doctor= demo.getFamilyDoctor();
	String rdoc_xmlparse = "<rd>";
	String rdocno_xmlparse = "<rdohip>";
	if(family_doctor != null && family_doctor.indexOf(rdoc_xmlparse) >= 0){ //if it exists
		rdoc = family_doctor.substring(family_doctor.indexOf(rdoc_xmlparse) + rdoc_xmlparse.length(),
		 family_doctor.indexOf("</rd>"));
		rdocno = family_doctor.substring(family_doctor.indexOf(rdocno_xmlparse) + rdocno_xmlparse.length(),
		 family_doctor.indexOf("</rdohip>"));
	}
%>

	{"demo":
		{"id": "<%= apmt.getDemographicNo() %>",
		 "name": "<%= demo.getDisplayName().trim() %>",
		 "dob" : "<%= demo.getBirthDayAsString() %>", 
		 "health_card":"<%= hin %>",
		 "gender": "<%= demo.getSex() %>" },
	 "date": "",
	 "admission_date" : "",
	 "btype" : "OHIP",
	 "status" : "",
	 "rdoctor" : "",
	 "rdocNum" : "",
	 "sli_code" : "",
	 "items":
		[
			{"code" : "",
			 "amount" : 0,
			 "units" : 0,
			 "percent" : 0.0,
			 "total" : 0,
			 "dx_code": ""}
			
			],
	 "manual" : "", 
	 "notes" : "",
	 "inv_amount" : "" }	<%	if( i + 1 < invList.size() ){ %>, <% }
}
%>]
