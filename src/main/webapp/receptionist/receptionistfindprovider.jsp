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

<%@page import="org.oscarehr.util.SessionConstants"%>
<%@page import="org.oscarehr.common.model.ProviderPreference"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/caisi-tag.tld" prefix="caisi"%>

<%
  if(session.getValue("user") == null ) response.sendRedirect("../logout.jsp");
%>

<%@ page
	import="java.util.*, java.sql.*, oscar.*, java.text.*, java.lang.*,java.net.*"
	errorPage="../appointment/errorpage.jsp"%>
<%@ include file="/common/webAppContextAndSuperMgr.jsp"%>

<%
  String providername = request.getParameter("providername")!=null?request.getParameter("providername"):"";
  String year = request.getParameter("pyear")!=null?request.getParameter("pyear"):"2002";
  String month = request.getParameter("pmonth")!=null?request.getParameter("pmonth"):"5";
  String day = request.getParameter("pday")!=null?request.getParameter("pday"):"8";

  String curUser_no = (String) session.getAttribute("user");
  ProviderPreference providerPreference=(ProviderPreference)session.getAttribute(SessionConstants.LOGGED_IN_PROVIDER_PREFERENCE); 
  int startHour = providerPreference.getStartHour();
  int endHour = providerPreference.getEndHour();
  int everyMin = providerPreference.getEveryMin();
  String n_t_w_w = null;

  if (org.oscarehr.common.IsPropertiesOn.isCaisiEnable() && org.oscarehr.common.IsPropertiesOn.isTicklerPlusEnable()) {
	n_t_w_w = (String) session.getAttribute("newticklerwarningwindow");
  }

  boolean caisi = Boolean.valueOf(request.getParameter("caisi")).booleanValue();
%>
<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title><bean:message
	key="receptionist.receptionistfindprovider.title" /></title>
<link rel="stylesheet" href="../web.css">
<script language="JavaScript">


function selectProvider(p,pn) {
	  newGroupNo = p;
<%if (org.oscarehr.common.IsPropertiesOn.isCaisiEnable() && org.oscarehr.common.IsPropertiesOn.isTicklerPlusEnable()){%>
	  this.location.href = "receptionistcontrol.jsp?provider_no=<%=curUser_no%>&start_hour=<%=startHour%>&end_hour=<%=endHour%>&every_min=<%=everyMin%>&new_tickler_warning_window=<%=n_t_w_w%>&color_template=deepblue&dboperation=updatepreference&displaymode=updatepreference&mygroup_no="+newGroupNo ;
<%}else{%>
	  this.location.href = "receptionistcontrol.jsp?provider_no=<%=curUser_no%>&start_hour=<%=startHour%>&end_hour=<%=endHour%>&every_min=<%=everyMin%>&color_template=deepblue&dboperation=updatepreference&displaymode=updatepreference&mygroup_no="+newGroupNo;
<%}%>
}

function selectProviderCaisi(p,pn) {
	opener.document.ticklerForm.elements['tickler.task_assigned_to_name'].value=pn;
	opener.document.ticklerForm.elements['tickler.task_assigned_to'].value=p;
	self.close();
}

</SCRIPT>
</head>

<body bgcolor="ivory" bgproperties="fixed" onLoad="setfocus()"
	topmargin="0" leftmargin="0" rightmargin="0">

<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<th NOWRAP bgcolor="#CCCCFF"><font face="Helvetica"><bean:message
			key="receptionist.receptionistfindprovider.2ndtitle" /></font></th>
	</tr>
</table>

<table width="100%" border="0">
	<tr>
		<td align="left"><i><bean:message
			key="receptionist.receptionistfindprovider.keywords" /></i> <%=providername%></td>
		<td align="right"><INPUT TYPE="SUBMIT" NAME="displaymode"
			VALUE="<bean:message key="receptionist.receptionistfindprovider.btnExit"/>"
			SIZE="17" onClick="window.close();"></td>
	</tr>
</table>

<CENTER>
<table width="100%" border="1" bgcolor="#ffffff" cellspacing="1"
	cellpadding="0">
	<tr bgcolor="#CCCCFF">
		<TH width="20%"><bean:message
			key="receptionist.receptionistfindprovider.no" /></TH>
		<TH width="40%"><bean:message
			key="receptionist.receptionistfindprovider.lastname" /></TH>
		<TH width="40%"><bean:message
			key="receptionist.receptionistfindprovider.firstname" /></TH>
	</tr>
<%
  boolean bGrpSearch = providername.startsWith(".")?true:false ;
  String dboperation = bGrpSearch?"search_providersgroup":"search_active_provider" ;
  String field1 = bGrpSearch?"mygroup_no":"provider_no" ;
  providername = bGrpSearch?providername.substring(1):providername ;

  String bgcolordef = "#EEEEFF" ;
  boolean bColor = true;
  String [] param = new String[2];
  if (providername.indexOf(",")>0) {
    param[0]= providername.substring(0,providername.indexOf(",")).trim() + "%";
    param[1]= providername.substring(providername.indexOf(",")+1).trim() + "%";
  } else {
    param[0]= providername.trim() + "%";
    param[1]= "%" ;
  }

  int nItems = 0;
  String sp = null, spnl = null, spnf = null;
  List<Map<String,Object>> resultList = oscarSuperManager.find("receptionistDao", dboperation, param);

  for (Map provider : resultList) {
    bColor = bColor?false:true ;
    sp = String.valueOf(provider.get(field1));
    spnl = String.valueOf(provider.get("last_name"));
    spnf = String.valueOf(provider.get("first_name"));
%>
	<tr bgcolor="<%=bColor?bgcolordef:"white"%>">
		<td>
		<%if(caisi) { %> <a href=#
			onClick="selectProviderCaisi('<%=sp%>','<%=spnl+", "+spnf%>')"><%=sp%></a></td>
		<%} else { %>
		<a href=#
			onClick="selectProvider('<%=sp%>','<%=URLEncoder.encode(spnl+", "+spnf)%>')"><%=sp%></a>
		</td>
		<%} %>
		<td><%=spnl%></td>
		<td><%=spnf%></td>
	</tr>
<%
    nItems++;
  }

  //find a group name only if there is no ',' in the search word 
  if (providername.indexOf(',') == -1 ) {
	resultList = oscarSuperManager.find("receptionistDao", "search_mygroup", new String[] {providername + "%"});

	for (Map group : resultList) {
      sp = String.valueOf(group.get("mygroup_no"));
%>
	<tr bgcolor="#CCCCFF">
		<td colspan='3'>
		<%if(caisi) { %> <a href=# onClick="selectProviderCaisi('<%=sp%>','')"><%=sp%></a>
		<%} else { %>
		<a href=# onClick="selectProvider('<%=sp%>','')"><%=sp%></a>
		<%} %>
		</td>
	</tr>
<%
      nItems++;
    }
  }

  if (nItems == 1) { //if there is only one search result, it should go to the appoint page directly.
%>
<script language="JavaScript">
<!--
  <%if(caisi) {%>
  selectProviderCaisi('<%=sp%>','<%=spnl+", "+spnf%>') ;
  <%} else {%>
  selectProvider('<%=sp%>','') ;
  <%}%>
//-->
</script>
<%
  }
%>
</table>
<br>

<p><bean:message
	key="receptionist.receptionistfindprovider.msgSelect" /></p>
</center>
</body>
</html>
