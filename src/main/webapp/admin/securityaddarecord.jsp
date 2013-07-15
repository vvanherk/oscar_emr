<%--

    Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
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

    This software was written for the
    Department of Family Medicine
    McMaster University
    Hamilton
    Ontario, Canada

--%>

<%@ taglib uri="/WEB-INF/security.tld" prefix="security"%>
<%
    if(session.getAttribute("userrole") == null )  response.sendRedirect("../logout.jsp");
    String roleName$ = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
%>
<security:oscarSec roleName="<%=roleName$%>"
	objectName="_admin,_admin.userAdmin,_admin.torontoRfq" rights="r"
	reverse="<%=true%>">
	<%response.sendRedirect("../logout.jsp");%>
</security:oscarSec>

<%
    if(session.getAttribute("user") == null ) response.sendRedirect("../logout.jsp");
    String curProvider_no = (String) session.getAttribute("user");

    boolean isSiteAccessPrivacy=false;
%>

<security:oscarSec objectName="_site_access_privacy" roleName="<%=roleName$%>" rights="r" reverse="false">
	<%isSiteAccessPrivacy=true; %>
</security:oscarSec>


<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ page
	import="java.lang.*, java.util.*, java.text.*,java.sql.*, oscar.*"
	errorPage="errorpage.jsp"%>
<%@ include file="/common/webAppContextAndSuperMgr.jsp"%>

<%!
	OscarProperties op = OscarProperties.getInstance();
%>

<html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/checkPassword.js.jsp"></script>
<title><bean:message key="admin.securityaddarecord.title" /></title>
<!-- calendar stylesheet -->
<link rel="stylesheet" type="text/css" media="all"
	href="../share/calendar/calendar.css" title="win2k-cold-1" />

<!-- main calendar program -->
<script type="text/javascript" src="../share/calendar/calendar.js"></script>

<!-- language for the calendar -->
<script type="text/javascript"
	src="../share/calendar/lang/<bean:message key="global.javascript.calendar"/>"></script>

<!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
<script type="text/javascript" src="../share/calendar/calendar-setup.js"></script>
<link rel="stylesheet" href="../web.css">
<script type="text/javascript">
<!--
	function setfocus(el) {
		this.focus();
		document.searchprovider.elements[el].focus();
		document.searchprovider.elements[el].select();
	}
	function onsub() {
		if (document.searchprovider.user_name.value=="") {
			alert('<bean:message key="admin.securityrecord.formUserName" /> <bean:message key="admin.securityrecord.msgIsRequired"/>');
			setfocus('user_name');
			return false;
		}
		if (document.searchprovider.password.value=="") {
			alert('<bean:message key="admin.securityrecord.formPassword" /> <bean:message key="admin.securityrecord.msgIsRequired"/>');
			setfocus('password');
			return false;
		}

		<%
			boolean ignorePasswordReq=Boolean.parseBoolean(op.getProperty("IGNORE_PASSWORD_REQUIREMENTS"));
			if (!ignorePasswordReq)
			{
				%>
					if (!validatePassword(document.searchprovider.password.value)) {
						setfocus('password');
						return false;
					}
				<%
			}
		%>
		if (document.forms[0].password.value != document.forms[0].conPassword.value) {
			alert('<bean:message key="admin.securityrecord.msgPasswordNotConfirmed" />');
			setfocus('conPassword');
			return false;
		}
		if (document.searchprovider.provider_no.value=="") {
			alert('<bean:message key="admin.securityrecord.formProviderNo" /> <bean:message key="admin.securityrecord.msgIsRequired"/>');
			return false;
		}
		if (document.forms[0].b_ExpireSet.checked && document.forms[0].date_ExpireDate.value.length<10) {
			alert('<bean:message key="admin.securityrecord.formDate" /> <bean:message key="admin.securityrecord.msgIsRequired"/>');
			setfocus('date_ExpireDate');
			return false;
		}
		if (document.forms[0].pinIsRequired.value == 1 || document.forms[0].b_RemoteLockSet.checked || document.forms[0].b_LocalLockSet.checked) {
			if (document.forms[0].pin.value=="") {
				alert('<bean:message key="admin.securityrecord.formPIN" /> <bean:message key="admin.securityrecord.msgIsRequired"/>');
				setfocus('pin');
				return false;
			}
		}
		if (document.forms[0].pin.value != "" && !validatePin(document.forms[0].pin.value)) {
			setfocus('pin');
			return false;
		}
		if (document.forms[0].pin.value != document.forms[0].conPin.value) {
			alert('<bean:message key="admin.securityrecord.msgPinNotConfirmed" />');
			setfocus('conPin');
			return false;
		}
		return true;
	}
//-->
</script>
</head>

<body background="../images/gray_bg.jpg" bgproperties="fixed"
	onLoad="setfocus('user_name')" topmargin="0" leftmargin="0" rightmargin="0">
<center>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#486ebd">
		<th align="CENTER"><font face="Helvetica" color="#FFFFFF"><bean:message
			key="admin.securityaddarecord.description" /></font></th>
	</tr>
</table>
<form method="post" action="admincontrol.jsp" name="searchprovider"
	onsubmit="return onsub()">

<table cellspacing="0" cellpadding="2" width="90%" border="0">
	<tr>
		<td>
		<div align="right"><bean:message
			key="admin.securityrecord.formUserName" />:
		</div>
		</td>
		<td><input type="text" name="user_name" size="20" maxlength="30">
		</td>
	</tr>
	<tr>
		<td>
		<div align="right"><bean:message
			key="admin.securityrecord.formPassword" />:
		</div>
		</td>
		<td><input type="password" name="password" size="20" maxlength="32"> <font size="-2">(<bean:message
			key="admin.securityrecord.msgAtLeast" />
			<%=op.getProperty("password_min_length")%> <bean:message
			key="admin.securityrecord.msgSymbols" />)</font></td>
	</tr>
	<tr>
		<td>
		<div align="right"><bean:message
			key="admin.securityrecord.formConfirm" />:</div>
		</td>
		<td><input type="password" name="conPassword" size="20" maxlength="32"></td>
	</tr>
	<tr>
		<td width="50%" align="right"><bean:message
			key="admin.securityrecord.formProviderNo" />:
		</td>
		<td><select name="provider_no">
			<option value="">-- select one --</option>
<%
	List<Map<String,Object>> resultList ;
    if (isSiteAccessPrivacy) {
    	Object[] param =new Object[1];
    	param[0] = curProvider_no;
    	resultList = oscarSuperManager.find("adminDao", "site_provider_search_providerno", param);
    }
    else {
    	resultList = oscarSuperManager.find("adminDao", "provider_search_providerno", new Object[] {});
    }
	for (Map provider : resultList) {
%>
			<option value="<%=provider.get("provider_no")%>"><%=provider.get("last_name")+", "+provider.get("first_name")%></option>
<%
	}
%>
		</select></td>
	</tr>
	<!-- new security -->
	<tr>
		<td align="right" nowrap><bean:message
			key="admin.securityrecord.formExpiryDate" />:</td>
		<td><input type="checkbox" name="b_ExpireSet" value="1" <%="checked" %>" /> <bean:message
			key="admin.securityrecord.formDate" />: <input type="text" name="date_ExpireDate" id="date_ExpireDate"
			value="" size="10" readonly /> <img src="../images/cal.gif"
			id="date_ExpireDate_cal" /></td>
	</tr>
<%
	if (op.getBooleanProperty("NEW_USER_PIN_CONTROL","yes")) {
%>
	<input type="hidden" name="pinIsRequired" value="0" />
	<tr>
		<td align="right" nowrap><bean:message
			key="admin.securityrecord.formRemotePIN" />:</td>
		<td><input type="checkbox" name="b_RemoteLockSet"
			value="1" <%=op.getBooleanProperty("caisi","on")?"":"checked" %> />
		<bean:message
			key="admin.securityrecord.formLocalPIN" />: <input type="checkbox" name="b_LocalLockSet"
			value="1" <%=op.getBooleanProperty("caisi","on")?"checked":"" %> /></td>
	</tr>
<%
	} else {
%>
	<input type="hidden" name="pinIsRequired" value="1" />
	<input type="hidden" name="b_RemoteLockSet" value="1" />
	<input type="hidden" name="b_LocalLockSet" value="1" />
<%
	}
%>
	<!-- new security -->
	<tr>
		<td>
		<div align="right"><bean:message
			key="admin.securityrecord.formPIN" />:</div>
		</td>
		<td><input type="password" name="pin" size="6" maxlength="6" /> <font size="-2">(<bean:message
			key="admin.securityrecord.msgAtLeast" />
			<%=op.getProperty("password_pin_min_length")%> <bean:message
			key="admin.securityrecord.msgDigits" />)</font>
		</td>
	</tr>
	<tr>
		<td>
		<div align="right"><bean:message
			key="admin.securityrecord.formConfirm" />:</div>
		</td>
		<td><input type="password" name="conPin" size="6" maxlength="6" /></td>
	</tr>
	<tr>
		<td colspan="2">
		<div align="center">
		<input type="hidden" name="displaymode" value="Security_Add_Record">
		<input type="submit" name="subbutton" value='<bean:message key="admin.securityaddarecord.btnSubmit"/>'>
		</div>
		</td>
	</tr>
</table>
</form>

<p></p>
<hr width="100%" color="orange">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td><a href="admin.jsp"> <img src="../images/leftarrow.gif"
			border="0" width="25" height="20" align="absmiddle"><bean:message
			key="global.btnBack" /></a></td>
		<td align="right"><a href="../logout.jsp"><bean:message
			key="global.btnLogout" /><img src="../images/rightarrow.gif"
			border="0" width="25" height="20" align="absmiddle"></a></td>
	</tr>
</table>

</center>
<script type="text/javascript">
Calendar.setup({ inputField : "date_ExpireDate", ifFormat : "%Y-%m-%d", showsTime :false, button : "date_ExpireDate_cal" });
</script>
</body>
</html:html>
