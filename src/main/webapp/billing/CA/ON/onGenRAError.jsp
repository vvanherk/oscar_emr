<!-- 
 *
 * Copyright (c) 2006-. OSCARservice, OpenSoft System. All Rights Reserved. *
 * This software is published under the GPL GNU General Public License.
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version. *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *
 *
 * Yi Li
 */
-->
<% 
    if(session.getAttribute("user") == null) response.sendRedirect("../../../logout.jsp");
%>

<%@ page
	import="java.math.*, java.util.*, java.io.*, java.sql.*, oscar.*, java.net.*,oscar.MyDateFormat"
	errorPage="errorpage.jsp"%>
<%@ page import="oscar.oscarBilling.ca.on.pageUtil.*"%>

<%@page import="org.oscarehr.PMmodule.dao.ProviderDao"%>
<%@page import="org.oscarehr.common.model.Provider"%>
<%@page import="org.oscarehr.util.SpringUtils"%>
<%@page import="org.oscarehr.util.MiscUtils"%>

<% 
String raNo = "", flag="", plast="", pfirst="", pohipno="", proNo="", proGrpBillingNo="";
String filepath="", filename = "", header="", headerCount="", total="", paymentdate="", payable="", totalStatus="", deposit=""; //request.getParameter("filename");
String transactiontype="", providerno="", specialty="", account="", patient_last="", patient_first="", provincecode="", hin="", ver="", billtype="", location="";
String servicedate="", serviceno="", servicecode="", amountsubmit="", amountpay="", amountpaysign="", explain="", error="";
String proFirst="", proLast="", demoFirst="", demoLast="", apptDate="", apptTime="", checkAccount="";

proNo = request.getParameter("proNo")!=null? request.getParameter("proNo") : "";
proGrpBillingNo = request.getParameter("group_billing_no")!=null? request.getParameter("group_billing_no") : "";
raNo = request.getParameter("rano");
if (raNo == null || raNo.compareTo("") == 0) return;
%>

<%
BillingRAPrep obj = new BillingRAPrep();

List<String> providerNumbers = new ArrayList<String>();
List aL = obj.getProviderListFromRAErrorReport(raNo);

boolean generateForAll = proNo.compareTo("all") == 0;



for(int i=0; i<aL.size(); i++) {
	Properties prop = (Properties) aL.get(i);
	providerNumbers.add( prop.getProperty("provider_no", "") );
	MiscUtils.getLogger().info("here1: " + prop.getProperty("provider_no", ""));
}


ProviderDao providerDao =(ProviderDao)SpringUtils.getBean("providerDao");
List<Provider> providerList = providerDao.getProvidersByProviderNo(providerNumbers);
List<Provider> providers = new ArrayList<Provider>();

// error check
if (providerList == null)
	providerList = new ArrayList<Provider>();

if (generateForAll) {
	for(int i=0; i < providerList.size(); i++) {
		providers.add( providerList.get(i) );
	}
}
else {
	for(int i=0; i < providerList.size(); i++) {
		Provider p = providerList.get(i);
		if (p.getProviderNo().equals(proNo)) {
			providers.add( p );
			break;
		}
	}
	
	filterByGroupBillingNumber(providers, proGrpBillingNo);
}

%>

<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/tablefilter_all_min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>

<script>
$(document).ready(function() {
	// on page load, set the initial value for the provider group billing number
	setProviderGroupBillingNo( $("#proNo option:selected").val() );
});
</script>

<script>
var provGroupBillingNoMap = new Object();

<%
	// print out the mapping from provider # to group billing number
	for(int i=0; i< providerList.size(); i++) {
		Provider p = providerList.get(i);
		String groupBillingNo = SxmlMisc.getXmlContent(p.getComments(), "<xml_p_billinggroup_no>", "</xml_p_billinggroup_no>");
		
		%> 
		provGroupBillingNoMap['<%=p.getProviderNo()%>'] = '<%=groupBillingNo%>'; <%
	}
%>

/**
 * Set the group billing number field based on the provided providerNo.
 */ 
function setProviderGroupBillingNo(providerNo) {
	var groupBillingNo = provGroupBillingNoMap[providerNo];
	//alert(providerNo + " " + groupBillingNo);
	
	if (groupBillingNo != null && groupBillingNo != undefined)
		document.getElementById("group_billing_no").value = groupBillingNo;
}
</script>

<link rel="stylesheet" type="text/css" href="billingON.css" />
<title>Billing Reconcilliation</title>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<form action="onGenRAError.jsp">
	<tr class="myDarkGreen">
		<th align='LEFT'><font color="#FFFFFF"> Billing
		Reconcilliation - Error Report</font></th>
		<th align='RIGHT'><select name="proNo" onchange="setProviderGroupBillingNo(this.value); return true;">
			<option value="all" <%=proNo.equals("all")?"selected":""%>>All
			Providers</option>

			<%   

for(int i=0; i<aL.size(); i++) {
	Properties prop = (Properties) aL.get(i);
	String providerNo = prop.getProperty("provider_no", "");
	String providerOhipNo = prop.getProperty("providerohip_no", "");
	String pgrpbillno = prop.getProperty("providergroup_billing_no", "");
	plast = prop.getProperty("last_name", "");
	pfirst = prop.getProperty("first_name", "");
%>
			<option value="<%=providerNo%>" <%=proNo.equals(providerNo) && proGrpBillingNo.equals(pgrpbillno)?"selected":""%>><%=plast%>,<%=pfirst%></option>
			<%
}
%>
		</select><input type=submit name='submit' value='Generate'> <input
			type="hidden" name="rano" value="<%=raNo%>"> <input
			type='button' name='print' value='Print' onClick='window.print()'>
		<input type='button' name='close' value='Close'
			onClick='window.close()'></th>
	</tr>
	<input type="hidden" name="group_billing_no" id="group_billing_no">
	</form>
</table>


<% 
if (proNo.compareTo("") == 0){ 
%>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
	<tr class="myYellow">
		<th width="10%">Billing No</th>
		<th width="15%">Demographic</th>
		<th width="10%">Service Date</th>
		<th width="10%">Service Code</th>
		<th width="15%">Count</th>
		<th width="15%">Claim</th>
		<th width="15%">Pay</th>
		<th>Error</th>
	</tr>

	<%
/*
	String[] param = new String[3];
	param[0] = raNo;
	param[1] = "I2";
	param[2] = "%";

	while (rsdemo.next()) {   
		account = rsdemo.getString("billing_no");
		param0[0]=raNo;
		param0[1]=account;
		demoLast = "";
		rsdemo3 =apptMainBean.queryResults(param0[1],"search_bill_short");
		while (rsdemo3.next()) {
			demoLast = rsdemo3.getString("demographic_name");
		}
		rsdemo2 = apptMainBean.queryResults(param0,"search_rabillno");
		while (rsdemo2.next()) {   
			servicecode = rsdemo2.getString("service_code");
			servicedate = rsdemo2.getString("service_date");
			serviceno = rsdemo2.getString("service_count");
			explain = rsdemo2.getString("error_code");
			amountsubmit = rsdemo2.getString("amountclaim");
			amountpay = rsdemo2.getString("amountpay");
			if (explain == null || explain.compareTo("") == 0){
				explain = "**";
			}    
*/
%>
	<tr>
		<td><%=account%></td>
		<td><%=demoLast%></td>
		<td><%=servicedate%></td>
		<td><%=servicecode%></td>
		<td><%=serviceno%></td>
		<td align=right><%=amountsubmit%></td>
		<td align=right><%=amountpay%></td>
		<td align=right><%=explain%></td>
	</tr>

	<%
//		}
//	} 
} else {
%>

<%	
	for (Provider p : providers) {
%>
		
		<br>
		<div style="font-size: large; margin: 4px 0 4px 0;"> <%=p.getFormattedName()%> </div>
		<table id="ra_table_<%=p.getProviderNo()%>" width="100%" border="0" cellspacing="1" cellpadding="0" class="myIvory">
			<tr class="myYellow">
				<th width="10%">Billing No</th>
				<th width="25%">Demographic</th>
				<th width="10%">Service Date</th>
				<th width="10%">Service Code</th>
				<th width="10%">Count</th>
				<th width="15%">Claim</th>
				<th width="15%">Pay</th>
				<th>Error</th>
			</tr>
	
			<%
		String grpBillNo = SxmlMisc.getXmlContent(p.getComments(), "<xml_p_billinggroup_no>", "</xml_p_billinggroup_no>");
		if (grpBillNo != null && grpBillNo.equals(""))
			grpBillNo = null;
		
		aL = obj.getRAErrorReport(raNo, p.getOhipNo(), grpBillNo ,"'I2'");
		for(int i=0; i<aL.size(); i++) {
			Properties prop = (Properties) aL.get(i);
			account = prop.getProperty("account", "");
			demoLast = prop.getProperty("demoLast", "");
			servicecode = prop.getProperty("servicecode", "");
			servicedate = prop.getProperty("servicedate", "");
			serviceno = prop.getProperty("serviceno", "");
			explain = prop.getProperty("explain", "");
			amountsubmit = prop.getProperty("amountsubmit", "");
			amountpay = prop.getProperty("amountpay", "");
	%>
			<tr <%=i%2==0? "class='myGreen'" : "" %>>
				<td align="center"><%=account%></td>
				<td><%=demoLast%></td>
				<td align="center"><%=servicedate%></td>
				<td align="center"><%=servicecode%></td>
				<td align="center"><%=serviceno%></td>
				<td align="right"><%=amountsubmit%></td>
				<td align="right"><%=amountpay%></td>
				<td align="right"><%=explain%></td>
			</tr>
	
			<%
		}
		%>
		
		<!-- added another TR for table-filter js to automatically calculate totals based on filters -->
		<tr class="myYellow">
					<td align="center"></td>
					<td align="center"></td>
					<td align="center"></td>
					<td align="center">Total:</td>
					<td id="count_<%=p.getProviderNo()%>" align=right></td>
					<td id="amountClaim_<%=p.getProviderNo()%>" align=right></td>
					<td id="amountPay_<%=p.getProviderNo()%>" align=right></td>
					<td align=right>&nbsp;</td>
		
		</tr>
		
		</table>
		<br>
	<%
	}
%>


	<%
}
%>

<script language="javascript" type="text/javascript">
	
	<%
	for (Provider p : providers) {
	%>
		var totRowIndex_<%=p.getProviderNo()%> = tf_Tag(tf_Id('ra_table_<%=p.getProviderNo()%>'),"tr").length;
		var table_Props_<%=p.getProviderNo()%> = 	{	
						col_0: "none",
						col_1: "none",
						col_2: "none",
						col_3: "none",
						col_4: "none",
						col_5: "none",
						col_6: "none",
						col_7: "none",
						col_8: "none",
						
						
						display_all_text: " [ Show all clinics ] ",
						flts_row_css_class: "dummy",
						flt_css_class: "positionFilter",
						sort_select: true,
						rows_always_visible: [totRowIndex_<%=p.getProviderNo()%>],
						col_operation: { 
									id: ["count_<%=p.getProviderNo()%>","amountClaim_<%=p.getProviderNo()%>","amountPay_<%=p.getProviderNo()%>"],
									col: [4,5,6],
									operation: ["sum","sum","sum"],
									write_method: ["innerHTML","innerHTML","innerHTML"],
									exclude_row: [totRowIndex_<%=p.getProviderNo()%>],
									decimal_precision: [0,2,2],
									tot_row_index: [totRowIndex_<%=p.getProviderNo()%>]
								}
					};
		var tf_<%=p.getProviderNo()%> = setFilterGrid( "ra_table_<%=p.getProviderNo()%>",table_Props_<%=p.getProviderNo()%> );
		
		//alert(totRowIndex_<%=p.getProviderNo()%>);
	<%
	}
	%>
</script>

</body>
</html>


<%!
public void filterByGroupBillingNumber(List<Provider> providers, String groupBillingNo) {
	Iterator<Provider> it = providers.iterator();
	
	while(it.hasNext()) {
		Provider p = (Provider)it.next();
		String comments = p.getComments();
		String grpBillNo = SxmlMisc.getXmlContent(comments, "<xml_p_billinggroup_no>", "</xml_p_billinggroup_no>");
		
		if (!grpBillNo.equals(groupBillingNo)) {
			it.remove();
		}
	}
}
%>
