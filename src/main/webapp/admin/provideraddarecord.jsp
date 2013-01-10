<%@ taglib uri="/WEB-INF/security.tld" prefix="security"%>
<%
    if(session.getAttribute("userrole") == null )  response.sendRedirect("../logout.jsp");
    String roleName$ = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
    
    if(session.getAttribute("user") == null ) response.sendRedirect("../logout.jsp");
    String curProvider_no = (String) session.getAttribute("user");
    
    boolean isSiteAccessPrivacy=false;
%>
<security:oscarSec roleName="<%=roleName$%>"
	objectName="_admin,_admin.userAdmin,_admin.torontoRfq" rights="r"
	reverse="<%=true%>">
	<%response.sendRedirect("../logout.jsp");%>
</security:oscarSec>

<security:oscarSec objectName="_site_access_privacy" roleName="<%=roleName$%>" rights="r" reverse="false">
	<%isSiteAccessPrivacy=true; %>
</security:oscarSec>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ page import="java.sql.*, java.util.*, oscar.*"
	errorPage="errorpage.jsp"%>
<%@ page import="oscar.log.LogAction,oscar.log.LogConst"%>
<%@ page import="oscar.log.*, oscar.oscarDB.*"%>

<%@page import="org.oscarehr.common.dao.SiteDao"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.oscarehr.common.model.Site"%>

<%@ page
	import="org.apache.commons.lang.StringEscapeUtils,oscar.oscarProvider.data.ProviderBillCenter,oscar.util.SqlUtils"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />
<!--
/*
 *
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved. *
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
 * <OSCAR TEAM>
 *
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */
-->
<html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title><bean:message key="admin.provideraddrecord.title" /></title>
<link rel="stylesheet" href="../web.css">
</head>

<body bgproperties="fixed" topmargin="0" leftmargin="0" rightmargin="0">
<center>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#486ebd">
		<th><font face="Helvetica" color="#FFFFFF"><bean:message
			key="admin.provideraddrecord.description" /></font></th>
	</tr>
</table>
<%
boolean isOk = false;
int retry = 0;
String curUser_no = (String)session.getAttribute("user");
String [] param = new String[21];
  param[0]=request.getParameter("provider_no");
  param[1]=request.getParameter("last_name");
  param[2]=request.getParameter("first_name");
  param[3]=request.getParameter("provider_type");
  if (!OscarProperties.getInstance().isTorontoRFQ()) {
  param[4]=request.getParameter("specialty");
  param[5]=request.getParameter("team");
  param[6]=request.getParameter("sex");
  
//  param[7]=request.getParameter("dob");
  
  param[8]=request.getParameter("address");
  param[9]=request.getParameter("phone");
  param[10]=request.getParameter("workphone");
  param[11]=request.getParameter("email");
  param[12]=request.getParameter("ohip_no");
  param[13]=request.getParameter("rma_no");
  param[14]=request.getParameter("billing_no");
  param[15]=request.getParameter("hso_no");
  param[16]=request.getParameter("status");
  param[17]=SxmlMisc.createXmlDataString(request,"xml_p");
  param[18]=request.getParameter("provider_activity");
  param[19]=request.getParameter("practitionerNo");
  param[20]=(String)session.getAttribute("user");
}
  
//multi-office provide id formalize check, can be turn off on properties multioffice.formalize.provider.id
boolean isProviderFormalize = true;
String  errMsgProviderFormalize = "admin.provideraddrecord.msgAdditionFailure";
Integer min_value = 0;
Integer max_value = 0;

if (org.oscarehr.common.IsPropertiesOn.isProviderFormalizeEnable()) {

	String StrProviderId = request.getParameter("provider_no");
	OscarProperties props = OscarProperties.getInstance();

	String[] provider_sites = {};
	
	// get provider id ranger
	if (request.getParameter("provider_type").equalsIgnoreCase("doctor")) {
		//provider is doctor, get provider id range from Property
		min_value = new Integer(props.getProperty("multioffice.formalize.doctor.minimum.provider.id", ""));
		max_value = new Integer(props.getProperty("multioffice.formalize.doctor.maximum.provider.id", ""));
	}
	else {
		//non-doctor role
		provider_sites = request.getParameterValues("sites");
		provider_sites = (provider_sites == null ? new String[] {} : provider_sites);
		
		if (provider_sites.length > 1) {
			//non-doctor can only have one site
			isProviderFormalize = false;
			errMsgProviderFormalize = "admin.provideraddrecord.msgFormalizeProviderIdMultiSiteFailure";
		}
		else {
			if (provider_sites.length == 1) {
				//get provider id range from site
				String provider_site_id =  provider_sites[0];
				SiteDao siteDao = (SiteDao)WebApplicationContextUtils.getWebApplicationContext(application).getBean("siteDao");
				Site provider_site = siteDao.getById(new Integer(provider_site_id));
				min_value = provider_site.getProviderIdFrom();
				max_value = provider_site.getProviderIdTo();
			}
		}
	}
	if (isProviderFormalize) {
		try {
			    Integer providerId = Integer.parseInt(StrProviderId);
			    if (request.getParameter("provider_type").equalsIgnoreCase("doctor") ||  provider_sites.length == 1) {
				    if  (!(providerId >= min_value && providerId <=max_value)) {
				    	// providerId is not in the range
						isProviderFormalize = false;
						errMsgProviderFormalize = "admin.provideraddrecord.msgFormalizeProviderIdFailure";
				    }
			    }
		} catch(NumberFormatException e) {
			//providerId is not a number
			isProviderFormalize = false;
			errMsgProviderFormalize = "admin.provideraddrecord.msgFormalizeProviderIdFailure";
		}
	}
}

if (!org.oscarehr.common.IsPropertiesOn.isProviderFormalizeEnable() || isProviderFormalize) {
for(int i=0; i< param.length; i++)
{
	if (param[i] == null) param[i] = "";
}
DBPreparedHandler dbObj = new DBPreparedHandler();
while ((!isOk) && retry < 3) {
  // check if the provider no need to be auto generated
  if (OscarProperties.getInstance().isProviderNoAuto()) 
  {
  	param[0]= dbObj.getNewProviderNo();
  }
  String	sql   = "insert into provider (provider_no,last_name,first_name,provider_type,specialty,team,sex,dob,address,phone,work_phone,email,ohip_no,rma_no,billing_no,hso_no,status,comments,provider_activity,practitionerNo,lastUpdateUser,lastUpdateDate) values (";
	sql += "'" + param[0] + "',";
	sql += "'" + StringEscapeUtils.escapeSql(param[1]) + "',";
	sql += "'" + StringEscapeUtils.escapeSql(param[2]) + "',";
	sql += "'" + StringEscapeUtils.escapeSql(param[3]) + "',";
	sql += "'" + param[4] + "',";
	sql += "'" + param[5] + "',";
	sql += "'" + param[6] + "',";
	sql += "?,";
	sql += "'" + param[8] + "',";
	sql += "'" + param[9] + "',";
	sql += "'" + param[10] + "',";
	sql += "'" + param[11] + "',";
	sql += "'" + param[12] + "',";
	sql += "'" + param[13] + "',";
	sql += "'" + param[14] + "',";
	sql += "'" + param[15] + "',";
	sql += "'" + param[16] + "',";
	sql += "'" + param[17] + "',";
	sql += "'" + param[18] + "',";
	sql += "'" + param[19] + "',";
	sql += "'" + param[20] + "',";
	sql += "now())";
	DBPreparedHandlerParam[] param2= new DBPreparedHandlerParam[1];
	param2[0]= new DBPreparedHandlerParam(MyDateFormat.getSysDate(request.getParameter("dob")));
	isOk = (dbObj.queryExecuteUpdate(sql, param2)>0);
	
	retry ++;
}

if (isOk && org.oscarehr.common.IsPropertiesOn.isMultisitesEnable()) {
	String[] sites = request.getParameterValues("sites");
	if (sites!=null)
		for (int i=0; i<sites.length; i++) {
			dbObj.queryExecuteUpdate("insert into providersite (provider_no, site_id) values (?,?)", new String[]{param[0], String.valueOf(sites[i])});
		}	
}

// patch for kanawaty - adds all new providers to a default program (10020) with a default role (1)
if (isOk) {
	dbObj.queryExecuteUpdate("insert into program_provider (program_id, provider_no, role_id, team_id) values (10020, ?, 1, NULL);", new String[]{param[0]});
}

if (isOk) {
	String proId = param[0];
	String ip = request.getRemoteAddr();
	LogAction.addLog(curUser_no, LogConst.ADD, "adminAddUser", proId, ip);

	ProviderBillCenter billCenter = new ProviderBillCenter();
	billCenter.addBillCenter(request.getParameter("provider_no"),request.getParameter("billcenter")); 

//  int rowsAffected = apptMainBean.queryExecuteUpdate(param, request.getParameter("dboperation"));
//  if (rowsAffected ==1) {
%>
<h1><bean:message key="admin.provideraddrecord.msgAdditionSuccess" />
</h1>
<%
  } else {
%>
<h1><bean:message key="admin.provideraddrecord.msgAdditionFailure" /></h1>
<%
  }
}
else {
		if 	(!isProviderFormalize) {
	%>
		<h1><bean:message key="<%=errMsgProviderFormalize%>" /> </h1>
		Provider # range from : <%=min_value %> To : <%=max_value %>
	<%		
		}
	}
  //apptMainBean.closePstmtConn();

%> <%@ include file="footer2htm.jsp"%></center>
</body>
</html:html>
