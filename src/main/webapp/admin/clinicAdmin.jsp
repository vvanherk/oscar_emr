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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%-- This JSP is the first page you see when you enter 'report by template' --%>
<%@ taglib uri="/WEB-INF/security.tld" prefix="security"%>
<%@ include file="/taglibs.jsp"%>
<%
    if(session.getAttribute("userrole") == null )  response.sendRedirect("../logout.jsp");
    String roleName$ = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
%>
<security:oscarSec roleName="<%=roleName$%>"
	objectName="_admin,_admin.misc" rights="r" reverse="<%=true%>">
	<%response.sendRedirect("../logout.jsp");%>
</security:oscarSec>

<%@ page import="java.util.*,oscar.oscarReport.reportByTemplate.*"%>

<%
String clinicNo = request.getParameter("clinicNo");
if (clinicNo == null)
	clinicNo = (String) request.getAttribute("clinicNo");
if (clinicNo == null)	
	clinicNo = "";
%>

<html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<script src="<c:out value="../js/jquery.js"/>"></script>

<script>
jQuery.noConflict();	
</script>

<title>Clinic</title>
<link rel="stylesheet" type="text/css"
	href="../share/css/OscarStandardLayout.css">

<script type="text/javascript" language="JavaScript"
	src="../share/javascript/prototype.js"></script>
<script type="text/javascript" language="JavaScript"
	src="../share/javascript/Oscar.js"></script>

<style type="text/css">
table.outline {
	margin-top: 50px;
	border-bottom: 1pt solid #888888;
	border-left: 1pt solid #888888;
	border-top: 1pt solid #888888;
	border-right: 1pt solid #888888;
}

table.grid {
	border-bottom: 1pt solid #888888;
	border-left: 1pt solid #888888;
	border-top: 1pt solid #888888;
	border-right: 1pt solid #888888;
}

td.gridTitles {
	border-bottom: 2pt solid #888888;
	font-weight: bold;
	text-align: center;
}

td.gridTitlesWOBottom {
	font-weight: bold;
	text-align: center;
}

td.middleGrid {
	border-left: 1pt solid #888888;
	border-right: 1pt solid #888888;
	text-align: center;
}

label {
	float: left;
	width: 120px;
	font-weight: bold;
}

label.checkbox {
	float: left;
	width: 116px;
	font-weight: bold;
}

label.fields {
	float: left;
	width: 80px;
	font-weight: bold;
}

span.labelLook {
	font-weight: bold;
}

input,textarea,select { //
	margin-bottom: 5px;
}

textarea {
	width: 450px;
	height: 100px;
}

.boxes {
	width: 1em;
}

#submitbutton {
	margin-left: 120px;
	margin-top: 5px;
	width: 90px;
}

br {
	clear: left;
}
</style>
</head>

<body vlink="#0000FF" class="BodyStyle">

<table class="MainTable">
	<tr class="MainTableTopRow">
		<td class="MainTableTopRowLeftColumn">admin</td>
		<td class="MainTableTopRowRightColumn">
		<table class="TopStatusBar" style="width: 100%;">
			<tr>
				<td>Manage Clinic Details</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="MainTableLeftColumn" valign="top" width="160px;">		
			<form id="viewForm" name="viewForm" action="<%= request.getContextPath()%>/admin/ManageClinic.do">
				<input type="hidden" name="method" value="view" />
				<label>Clinic: </label>
				<select id="clinicNo" name="clinicNo" onChange="jQuery('#viewForm').submit();">
					<logic:iterate name="clinics" id="cl">
						<option <logic:equal name="cl" property="id" value="<%=clinicNo%>"> selected </logic:equal> value="<bean:write name="cl" property="id"/>"> <bean:write name="cl" property="clinicName"/> </option>
					</logic:iterate>
				</select>
			</form>
		</td>
		
		<td class="MainTableRightColumn" valign="top">
			<c:if test="%{clinic==null}">
				<div>
					No Clinic was found.
				</div>
			</c:if>
		
			<logic:notEmpty name="actionResult">
				<div>
					<b>Action 
					<logic:equal name="actionResult" value="0">Succeeded</logic:equal>
					<logic:notEqual name="actionResult" value="0">Failed</logic:notEqual>
					with message</b>:
					<br>
					<bean:write name="actionResultMessage" />
					<br><br>
				</div>
			</logic:notEmpty>
			
			<fieldset><legend>Clinic Details</legend> 
				<html:form action="/admin/ManageClinic">
					<input type="hidden" name="clinicNo" value="<%=clinicNo%>" />
					<html:hidden property="clinic.id" />
					<input type="hidden" name="method" value="update" />
		
					<label for="clinic.clinicName">Clinic Name</label>
					<html:text property="clinic.clinicName" />
					<br />
					<label for="clinic.clinicAddress">Clinic Address</label>
					<html:text property="clinic.clinicAddress" />
					<br />
					<label for="clinic.clinicCity">Clinic City</label>
					<html:text property="clinic.clinicCity" />
					<br />
					<label for="clinic.clinicPostal">Clinic Postal</label>
					<html:text property="clinic.clinicPostal" />
					<br />
					<label for="clinic.clinicPhone">Clinic Phone</label>
					<html:text property="clinic.clinicPhone" />
					<br />
					<label for="clinic.clinicFax">Clinic Fax</label>
					<html:text property="clinic.clinicFax" />
					<br />
					<label for="clinic.clinicLocationCode">Clinic Location Code</label>
					<html:text property="clinic.clinicLocationCode" />
					<br />
					<html:hidden property="clinic.status" value="A" />
					<br />
					<label for="clinic.clinicProvince">Clinic Province</label>
					<html:text property="clinic.clinicProvince" />
					<br />
					<label for="clinic.clinicDelimPhone">multi phone</label>
					<html:text property="clinic.clinicDelimPhone" /> (Delimited by |) <br />
					<label for="clinic.clinicDelimFax">multi fax</label>
					<html:text property="clinic.clinicDelimFax" />  (Delimited by |)<br />
					
					<input type="submit" value="submit" />
					<input type="button" name="deleteButton" value="delete" onClick="jQuery('#deleteForm').submit();" />
					<input type="button" name="newButton" value="new" onClick="jQuery('#newForm').submit();" />
				</html:form>
				
				<form id="deleteForm" name="deleteForm" action="<%=request.getContextPath()%>/admin/ManageClinic.do">
					<input type="hidden" name="clinicNo" value="<%=clinicNo%>" />
					<input type="hidden" name="method" value="delete" />
				</form>
				
				<form id="newForm" name="newForm" action="<%=request.getContextPath()%>/admin/ManageClinic.do">
					<input type="hidden" name="method" value="newClinic" />
				</form>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td class="MainTableBottomRowLeftColumn">&nbsp;</td>

		<td class="MainTableBottomRowRightColumn">&nbsp;</td>
	</tr>
</table>

</html:html>
