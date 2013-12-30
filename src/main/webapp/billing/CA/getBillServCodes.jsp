<%--
  Copyright (c) 2013-2014 Prylynx Corporation
 
  This software is made available under the terms of the
  GNU General Public License, Version 2, 1991 (GPLv2).
  License details are available via "gnu.org/licenses/gpl-2.0.html".
--%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%><%@page import="java.util.List, java.util.Set, java.util.Collections, java.util.Comparator, java.util.Date" %><%@page import="org.oscarehr.util.SpringUtils" %><%@ page import="org.oscarehr.common.dao.BillingServiceDao" %><%@ page import="org.oscarehr.common.model.BillingService"%>
<%
 BillingServiceDao billingServiceDao = (BillingServiceDao)SpringUtils.getBean("billingServiceDao");

String source= request.getParameter("source");
String query = request.getParameter("query");
List<BillingService>  bSCList = null;

if(source.equals("code")){
	bSCList = billingServiceDao.findBillingCodesByCode(query, "ON");
}else{
	bSCList = billingServiceDao.search(query, "ON", new Date());
}
%>[<%
for(int i=0; i < bSCList.size(); i++){
	BillingService bsc = bSCList.get(i);

	if(!bsc.getValue().equals(".00")){
%>
	{  "code": "<%= bsc.getServiceCode() %>",
	   "desc": "<%= bsc.getDescription() %>",
	   "value": "<%= bsc.getValue() %>",
	   "percent" : "1.0"
	 }<%
	} else {
%>
	{  "code": "<%= bsc.getServiceCode() %>",
	   "desc": "<%= bsc.getDescription() %>",
	   "value": ".00",
	   "percent" : "<%= bsc.getPercentage() %>"
	 }<%}	if( i + 1 < bSCList.size() ){ %>, <% }
}
%>]

