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

<%@ include file="/casemgmt/taglibs.jsp"%>
<%@ page
	import="org.springframework.web.context.*,org.springframework.web.context.support.*, org.oscarehr.PMmodule.service.ProviderManager, org.oscarehr.util.SpringUtils, java.util.List" %>
<%@ page
	import="org.oscarehr.casemgmt.model.CaseManagementNoteExt, org.oscarehr.casemgmt.model.CaseManagementNote, org.oscarehr.casemgmt.dao.CaseManagementNoteDAO, org.oscarehr.casemgmt.dao.CaseManagementNoteExtDAO"%>
<%
    WebApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
    ProviderManager pMgr = (ProviderManager)ctx.getBean("providerManager");
    CaseManagementNoteExtDAO caseManagementNoteExtDao = (CaseManagementNoteExtDAO) SpringUtils.getBean("CaseManagementNoteExtDAO");
 %>
<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/share/javascript/jquery/jquery-1.4.2.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/eyeform.css" />
<style>
	#menu {
		background-color: lightgrey;
		font-size: xx-small;
		text-align: right;
		text-color: white;
	}
</style>
<title>Note History</title>
</head>
<body>
<div id="menu">
<h2 style="text-align:left"><nested:write name="demoName" /> | DOB: <nested:write name="demoDOB" /> (<nested:write name="demoAge" /> yrs), <nested:write name="demoSex" /> </h2>
<a href="<%=request.getContextPath()%>/tickler/ticklerAdd.jsp?demographic_no=<%=request.getParameter("demographicNo")%>&name=<nested:write name="demoName" />&chart_no=&bFirstDisp=false&messageID=0"> Send Tickler </a>
</div>
<h3 style="text-align: center;">Past Office Communications</h3>
<nested:iterate indexId="idx" id="note" name="history">
	<div
		style="width: 99%; background-color: #EFEFEF; font-size: 12px; border-left: thin groove #000000; border-bottom: thin groove #000000; border-right: thin groove #000000;">
		<pre><nested:write name="note" property="note" /></pre>
		<div style="color: #0000FF;">
        
        Creation Date: <nested:write name="note" property="createDate" format="dd-MMM-yyyy H:mm" /><br>
		Last update: <nested:write name="note"
		property="updateDate" format="dd-MMM-yyyy H:mm" /></div>
	</div>
</nested:iterate>
</body>
</html>
