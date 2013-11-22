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
	import="org.springframework.web.context.*,org.springframework.web.context.support.*, org.oscarehr.PMmodule.service.ProviderManager, org.oscarehr.casemgmt.model.CaseManagementNote"%>
<%
    WebApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
    ProviderManager pMgr = (ProviderManager)ctx.getBean("providerManager");
 %>
<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/share/javascript/jquery/jquery-1.4.2.js"></script>
<script>	
	function addNote(){
		$.ajax({
			type: "POST",
			url: "<%=request.getContextPath()%>/CaseManagementEntry.do?method=issueNoteSaveJson&demographic_no=<%=request.getParameter("demographicNo")%>&noteId=0&json=true&issue_id=<%=request.getParameter("issueI")%>",
			data: "value=" + $("#noteText").val() + "&issue_code=PatientLog&sign=true",
			dataType: "json",
			success: function(data) {
				window.close();
			}
		});
	}
	
	function sendTickler(){
		$.ajax({
			type: "POST",
			url: "<%=request.getContextPath()%>/CaseManagementEntry.do?method=issueNoteSaveJson&demographic_no=<%=request.getParameter("demographicNo")%>&noteId=0&json=true&issue_id=<%=request.getParameter("issueI")%>",
			data: "value=" + $("#noteText").val() + "&issue_code=PatientLog&sign=true",
			dataType: "json",
			success: function(data) {
				location.reload();
			}
		});
	}

</script>
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
<h3 style="text-align: center;"><nested:write name="title" /></h3>
<div id="newNote" style="text-align:center">
	<form>
		<textarea id="noteText" rows="5" cols="75" style="align:center">Enter New Note</textarea> <br />
		<input type="button" onclick="addNote()" style="margin-left:285px" value="Save & Exit">
		<input type="button" onclick="window.close()" value="Discard & Exit">
		<input type="button" onclick="document.getElementById('newNote').style.display='none';window.print();document.getElementById('newNote').style.display='block'" value="Print" >
	</form>
</div>
<nested:iterate indexId="idx" id="note" name="history">
	<div
		style="width: 99%; background-color: #EFEFEF; font-size: 12px; border-left: thin groove #000000; border-bottom: thin groove #000000; border-right: thin groove #000000;">
	<pre><nested:write name="note" property="note" /></pre>
	<div style="color: #0000FF;"><nested:notEmpty name="current">
		<c:if test="${current[idx] == false}">
			<div style="color: #FF0000;">REMOVED</div>
		</c:if>
	</nested:notEmpty>
        <c:if test="${note.archived == true}">
                <div style="color: #336633;">ARCHIVED</div>
        </c:if>
        
        Documentation Date: <nested:write name="note"
		property="observation_date" format="dd-MMM-yyyy H:mm" /><br>
	<nested:equal name="note" property="signed" value="true"> 
                             Signed by 
                             <%                               
                               CaseManagementNote n = (CaseManagementNote)note;
                               out.println(pMgr.getProvider(n.getSigning_provider_no()).getFormattedName());
                             %>
	</nested:equal> <nested:notEqual name="note" property="signed" value="true"> 
                             Saved by 
                             <nested:write name="note"
			property="provider.formattedName" />:
                         </nested:notEqual> <nested:write name="note"
		property="update_date" format="dd-MMM-yyyy H:mm" /></div>
	</div>
</nested:iterate>
</body>
</html>
