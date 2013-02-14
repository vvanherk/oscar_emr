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

<%@ page language="java"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ page import="oscar.oscarProvider.data.*"%>
<%@ page import="org.oscarehr.common.dao.UserPropertyDAO"%>
<%@ page import="org.oscarehr.common.model.UserProperty"%>
<%@ page import="org.oscarehr.util.SpringUtils"%>
<%@ page import="org.oscarehr.PMmodule.dao.ProviderDao" %>
<%@ page import="org.oscarehr.common.model.Provider" %>
<%@ page import="java.util.List" %>


<%
	UserPropertyDAO propertyDao = (UserPropertyDAO)SpringUtils.getBean("UserPropertyDAO");
%>
<%
  if(session.getValue("user") == null) response.sendRedirect("../logout.htm");
  String curUser_no = (String) session.getAttribute("user");
%>
<html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>

<html:base />
<link rel="stylesheet" type="text/css"
	href="../oscarEncounter/encounterStyles.css">

<title>Set Default Provider for New Demographic</title>

<script type="text/javascript">
    function validate() {       
        return true;        
    }
</script>

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

<body class="BodyStyle" vlink="#0000FF">

<table class="MainTable" id="scrollNumber1" name="encounterTable">
	<tr class="MainTableTopRow">
		<td class="MainTableTopRowLeftColumn">Preferences</td>
		<td style="color: white" class="MainTableTopRowRightColumn">Set Default Provider for New Demographics</td>
	</tr>
	<tr>
		<td class="MainTableLeftColumn">&nbsp;</td>
		<td class="MainTableRightColumn">
		<%
			String provno = "";
			ProviderDao providerDao = SpringUtils.getBean(ProviderDao.class);
			List<Provider> activeDoctors = providerDao.getActiveProvidersByType("doctor");
			
			UserProperty prop = null;
            prop = propertyDao.getProp(curUser_no,"newDemDefPrv");
            if(prop!=null) { provno = prop.getValue(); }
	           if( request.getAttribute("status") == null ){
            %> 
            
            <html:form action="/SetNewDemDefPrv.do">

			<span style="color:blue">
				Select the default selected provider for new demographics. 
				<br/>
				<% if( provno.equals("") ){
					%>There is currently no default set<%
				} else {
					Provider selprov = providerDao.getProvider( provno );
					%>Current default provider: <%=selprov.getFormattedName()%><%
				}
				%>
			</span>
            <br/>
       
			
			<label for="provno">Provider Number</label>
			<html:select property="provno">
				<html:option value=""></html:option>
				<% 
				for (Provider p : activeDoctors) {
					if( provno.equals(p.getProviderNo()) ){
						%><html:option value="<%=p.getProviderNo()%>"><%=p.getFormattedName()%></html:option><%
					}else {
						%><html:option value="<%=p.getProviderNo()%>"><%=p.getFormattedName()%></html:option><%
					}
				} 
				%>
			</html:select>
			<br />
			
			<input type="submit" onclick="return validate();"
				value="Submit" />
		</html:form> <%
               }
               else if( ((String)request.getAttribute("status")).equals("complete") ) {
            %> Success! <br>
			<%
			if(provno.equals("")){
				%>Default provider unset.<%
			}else{
				Provider selprov = providerDao.getProvider( provno );
				%>Default provider set to <%=selprov.getFormattedName()%><%
			}
			%>
			<%=provno%> <%
               }
            %>
		</td>
	</tr>
	<tr>
		<td class="MainTableBottomRowLeftColumn"></td>
		<td class="MainTableBottomRowRightColumn"></td>
	</tr>
</table>
</body>
</html:html>
