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
	objectName="_admin,_admin.misc" rights="r" reverse="<%=true%>">
	<%response.sendRedirect("../logout.jsp");%>
</security:oscarSec>

<%
  //if(session.getValue("user") == null || !((String) session.getValue("userprofession")).equalsIgnoreCase("admin")) response.sendRedirect("../logout.jsp");
  String deepcolor = "#CCCCFF", weakcolor = "#EEEEFF";
%>
<%@ page
	import="java.util.*, java.sql.*, oscar.*, java.text.*, java.lang.*,java.net.*"
	errorPage="../appointment/errorpage.jsp"%>
<jsp:useBean id="updatedpBean" class="oscar.AppointmentMainBean"
	scope="page" />
<jsp:useBean id="namevector" class="java.util.Vector" scope="page" />
<jsp:useBean id="novector" class="java.util.Vector" scope="page" />
<%@page import="org.oscarehr.util.SpringUtils" %>
<%@page import="org.oscarehr.common.model.DemographicCust" %>
<%@page import="org.oscarehr.common.dao.DemographicCustDao" %>
<%
	DemographicCustDao demographicCustDao = (DemographicCustDao)SpringUtils.getBean("demographicCustDao");
%>
<% // table demographiccust: cust1 = nurse   cust2 = resident   cust4 = midwife

  String [][] dbQueries = new String[1][1];
  String strDbType = oscar.OscarProperties.getInstance().getProperty("db_type").trim();

  if (strDbType.trim().equalsIgnoreCase("mysql")) {;
  		dbQueries=new String[][] {
		    {"select_demoname", "select d.demographic_no from demographic d, demographiccust c where c.cust2=? and d.demographic_no=c.demographic_no and d.last_name REGEXP ? " },
		    {"search_provider", "select provider_no, last_name, first_name from provider order by last_name"},
		    {"select_demoname1", "select d.demographic_no from demographic d, demographiccust c where c.cust1=? and d.demographic_no=c.demographic_no and d.last_name REGEXP ? " },
		    {"select_demoname2", "select d.demographic_no from demographic d, demographiccust c where c.cust4=? and d.demographic_no=c.demographic_no and d.last_name REGEXP ? " },
		  };
  }else if (strDbType.trim().equalsIgnoreCase("postgresql"))  {
  		dbQueries=new String[][] {
		    {"select_demoname", "select d.demographic_no from demographic d, demographiccust c where c.cust2=? and d.demographic_no=c.demographic_no and d.last_name ~* ? " },
		    {"search_provider", "select provider_no, last_name, first_name from provider order by last_name"},
		    {"select_demoname1", "select d.demographic_no from demographic d, demographiccust c where c.cust1=? and d.demographic_no=c.demographic_no and d.last_name ~* ? " },
		    {"select_demoname2", "select d.demographic_no from demographic d, demographiccust c where c.cust4=? and d.demographic_no=c.demographic_no and d.last_name ~* ? " },
		  };
  }
  String[][] responseTargets=new String[][] {  };
  updatedpBean.doConfigure(dbQueries,responseTargets);
%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title><bean:message key="admin.updatedemographicprovider.title" />
</title>
</head>
<script language="javascript">
<!-- start javascript ---- check to see if it is really empty in database

function setregexp() {
	var exp = "^[" +document.ADDAPPT.last_name_from.value + "-" +document.ADDAPPT.last_name_to.value + "]" ;
	document.ADDAPPT.regexp.value = exp ;
	//alert(document.ADDAPPT.regexp.value);
}
function setregexp1() {
	var exp = "^[" +document.ADDAPPT1.last_name_from.value + "-" +document.ADDAPPT1.last_name_to.value + "]" ;
	document.ADDAPPT1.regexp.value = exp ;
	//alert(document.ADDAPPT1.regexp.value);
}
function setregexp2() {
	var exp = "^[" +document.ADDAPPT2.last_name_from.value + "-" +document.ADDAPPT2.last_name_to.value + "]" ;
	document.ADDAPPT2.regexp.value = exp ;
	//alert(document.ADDAPPT2.regexp.value);
}
// stop javascript -->
</script>

<%
  ResultSet rsgroup =null;
  rsgroup = updatedpBean.queryResults("search_provider");
 	while (rsgroup.next()) {
 	  namevector.add(rsgroup.getString("provider_no"));
 	  namevector.add(rsgroup.getString("last_name")+", "+rsgroup.getString("first_name"));
 	}
%>
<body background="../images/gray_bg.jpg" bgproperties="fixed"
	onLoad="setfocus()" topmargin="0" leftmargin="0" rightmargin="0">
<table border=0 cellspacing=0 cellpadding=0 width="100%">
	<tr bgcolor="<%=deepcolor%>">
		<th><font face="Helvetica"><bean:message
			key="admin.updatedemographicprovider.msgTitle" /></font></th>
	</tr>
</table>
<%
  if(request.getParameter("update")!=null && request.getParameter("update").equals(" Go ") ) {
    String [] param1 = new String[2] ;
    param1[0] = request.getParameter("oldcust2") ;
    param1[1] = request.getParameter("regexp") ;
    rsgroup = updatedpBean.queryResults(param1, "select_demoname");
    while (rsgroup.next()) {
        novector.add(rsgroup.getString("demographic_no"));
    }
    int nosize = novector.size();
    int rowsAffected = 0;
    if(nosize != 0) {
      String [] param = new String[nosize+2] ;
      param[0] = request.getParameter("newcust2") ;
      param[1] = request.getParameter("oldcust2") ;
      StringBuffer sbtemp = new StringBuffer("?") ;
      param[0+2] = (String) novector.get(0);

      if(nosize>1) {
          for(int i=1; i<nosize; i++) {
 	      sbtemp = sbtemp.append(",?");
              param[i+2] = (String) novector.get(i);
 	  }
      }
      String instrdemo = sbtemp.toString();
      dbQueries[0][1] = dbQueries[0][1] + "("+ instrdemo +")" ;
      updatedpBean.doConfigure(dbQueries,responseTargets);

      List<Integer> demoList= new ArrayList<Integer>();
      for(int x=2;x<param.length;x++) {
    	  demoList.add(Integer.parseInt(param[x]));
      }
      List<DemographicCust> demographicCusts = demographicCustDao.findMultipleResident(demoList, param[1]);
      for(DemographicCust demographicCust:demographicCusts) {
    	  demographicCust.setResident(param[0]);
    	  demographicCustDao.merge(demographicCust);
      }
      rowsAffected = demographicCusts.size();
    } %>
<%=rowsAffected %>
<bean:message key="admin.updatedemographicprovider.msgRecords" />
<br>
<%}

  if(request.getParameter("update")!=null && request.getParameter("update").equals(" Submit ") ) {
    String [] param1 = new String[2] ;
    param1[0] = request.getParameter("oldcust1") ;
    param1[1] = request.getParameter("regexp") ;
    rsgroup = updatedpBean.queryResults(param1, "select_demoname1");

    while (rsgroup.next()) {
 	    novector.add(rsgroup.getString("demographic_no"));
    }
    int nosize = novector.size();
    int rowsAffected = 0;

    if(nosize != 0) {
      String [] param = new String[nosize+2] ;
      param[0] = request.getParameter("newcust1") ;
      param[1] = request.getParameter("oldcust1") ;

      StringBuffer sbtemp = new StringBuffer("?") ;
      param[0+2] = (String) novector.get(0);

      if(nosize>1) {
          for(int i=1; i<nosize; i++) {
 	      sbtemp = sbtemp.append(",?");
              param[i+2] = (String) novector.get(i);
 	  }
      }
      String instrdemo = sbtemp.toString();
      dbQueries[1][1] += "("+ instrdemo +")" ;
      updatedpBean.doConfigure(dbQueries,responseTargets);

      List<Integer> demoList= new ArrayList<Integer>();
      for(int x=2;x<param.length;x++) {
    	  demoList.add(Integer.parseInt(param[x]));
      }
      List<DemographicCust> demographicCusts = demographicCustDao.findMultipleNurse(demoList, param[1]);
      for(DemographicCust demographicCust:demographicCusts) {
    	  demographicCust.setNurse(param[0]);
    	  demographicCustDao.merge(demographicCust);
      }
      rowsAffected = demographicCusts.size();
    } %>
<%=rowsAffected %>
<bean:message key="admin.updatedemographicprovider.msgRecords" />
<br>
<%}

  if(request.getParameter("update")!=null && request.getParameter("update").equals("UpdateMidwife") ) {
    String [] param1 = new String[2] ;
    param1[0] = request.getParameter("oldcust4") ;
    param1[1] = request.getParameter("regexp") ;
    rsgroup = updatedpBean.queryResults(param1, "select_demoname2");

    while (rsgroup.next()) {
 	    novector.add(rsgroup.getString("demographic_no"));
    }
    int nosize = novector.size();
    int rowsAffected = 0;

    if(nosize != 0) {
      String [] param = new String[nosize+2] ;
      param[0] = request.getParameter("newcust4") ;
      param[1] = request.getParameter("oldcust4") ;

      StringBuffer sbtemp = new StringBuffer("?") ;
      param[0+2] = (String) novector.get(0);

      if(nosize>1) {
          for(int i=1; i<nosize; i++) {
 	      sbtemp = sbtemp.append(",?");
              param[i+2] = (String) novector.get(i);
 	  }
      }
      String instrdemo = sbtemp.toString();
      dbQueries[2][1] += "("+ instrdemo +")" ;
      updatedpBean.doConfigure(dbQueries,responseTargets);

      List<Integer> demoList= new ArrayList<Integer>();
      for(int x=2;x<param.length;x++) {
    	  demoList.add(Integer.parseInt(param[x]));
      }
      List<DemographicCust> demographicCusts = demographicCustDao.findMultipleMidwife(demoList, param[1]);
      for(DemographicCust demographicCust:demographicCusts) {
    	  demographicCust.setMidwife(param[0]);
    	  demographicCustDao.merge(demographicCust);
      }
      rowsAffected = demographicCusts.size();

    } %>
<%=rowsAffected %>
<bean:message key="admin.updatedemographicprovider.msgRecords" />
<br>
<%
  }
%>

<center>
<table border="0" cellpadding="0" cellspacing="2" width="90%"
	bgcolor="<%=weakcolor%>">
	<FORM NAME="ADDAPPT" METHOD="post"
		ACTION="updatedemographicprovider.jsp" onsubmit="return(setregexp())">
	<tr>
		<td><b><bean:message
			key="admin.updatedemographicprovider.msgResident" /></b></td>
	</tr>
	<tr>
		<td><bean:message key="admin.updatedemographicprovider.formUse" />
		<select name="newcust2">
			<%
 	 for(int i=0; i<namevector.size(); i=i+2) {
%>
			<option value="<%=namevector.get(i)%>"><%=namevector.get(i+1)%></option>
			<%
 	 }
%>
		</select> <bean:message key="admin.updatedemographicprovider.formReplace" /> <select
			name="oldcust2">
			<%
 	 for(int i=0; i<namevector.size(); i=i+2) {
%>
			<option value="<%=namevector.get(i)%>"><%=namevector.get(i+1)%></option>
			<%
 	 }
%>
		</select><br>
		<bean:message key="admin.updatedemographicprovider.formCondition" /> <select
			name="last_name_from">
			<%
   char cletter = 'A';
 	 for(int i=0; i<26; i++) {
%>
			<option value="<%=(char) (cletter+i) %>"><%=(char) (cletter+i)%></option>
			<%
 	 }
%>
		</select> <bean:message key="admin.updatedemographicprovider.formTo" /> <select
			name="last_name_to">
			<%
   cletter = 'A';
 	 for(int i=0; i<26; i++) {
%>
			<option value="<%=(char) (cletter+i) %>"><%=(char) (cletter+i)%></option>
			<%
 	 }
%>
		</select> <br>
		<INPUT TYPE="hidden" NAME="regexp" VALUE=""> <input
			type="hidden" name="update" value=" Go "> <INPUT
			TYPE="submit"
			VALUE="<bean:message key="admin.updatedemographicprovider.btnGo"/>">


		</td>
	</tr>
	</form>
</table>

<hr width=90% color='<%=deepcolor%>'>
<!-- for nurse -->
<table border="0" cellpadding="0" cellspacing="2" width="90%"
	bgcolor="<%=weakcolor%>">
	<FORM NAME="ADDAPPT1" METHOD="post"
		ACTION="updatedemographicprovider.jsp" onsubmit="return(setregexp1())">
	<tr>
		<td><b><bean:message
			key="admin.updatedemographicprovider.msgNurse" /></b></td>
	</tr>
	<tr>
		<td><bean:message key="admin.updatedemographicprovider.formUse" />
		<select name="newcust1">
			<%
 	 for(int i=0; i<namevector.size(); i=i+2) {
%>
			<option value="<%=namevector.get(i)%>"><%=namevector.get(i+1)%></option>
			<%
 	 }
%>
		</select> <bean:message key="admin.updatedemographicprovider.formReplace" /> <select
			name="oldcust1">
			<%
 	 for(int i=0; i<namevector.size(); i=i+2) {
%>
			<option value="<%=namevector.get(i)%>"><%=namevector.get(i+1)%></option>
			<%
 	 }
%>
		</select><br>
		<bean:message key="admin.updatedemographicprovider.formCondition" /> <select
			name="last_name_from">
			<%
   cletter = 'A';
 	 for(int i=0; i<26; i++) {
%>
			<option value="<%=(char) (cletter+i) %>"><%=(char) (cletter+i)%></option>
			<%
 	 }
%>
		</select> <bean:message key="admin.updatedemographicprovider.formTo" /> <select
			name="last_name_to">
			<%
   cletter = 'A';
 	 for(int i=0; i<26; i++) {
%>
			<option value="<%=(char) (cletter+i) %>"><%=(char) (cletter+i)%></option>
			<%
 	 }
%>
		</select> <br>
		<INPUT TYPE="hidden" NAME="regexp" VALUE=""> <input
			type="hidden" name="update" value=" Submit "> <INPUT
			TYPE="submit"
			VALUE="<bean:message key="admin.updatedemographicprovider.btnGo"/>">
		</td>
	</tr>
	</form>
</table>

<hr width=90% color='<%=deepcolor%>'>
<!-- for midwife -->
<table border="0" cellpadding="0" cellspacing="2" width="90%"
	bgcolor="<%=weakcolor%>">
	<FORM NAME="ADDAPPT2" METHOD="post"
		ACTION="updatedemographicprovider.jsp" onsubmit="return(setregexp2())">
	<tr>
		<td><b><bean:message
			key="admin.updatedemographicprovider.msgMidwife" /></b></td>
	</tr>
	<tr>
		<td><bean:message key="admin.updatedemographicprovider.formUse" />
		<select name="newcust4">
			<%
 	 for(int i=0; i<namevector.size(); i=i+2) {
%>
			<option value="<%=namevector.get(i)%>"><%=namevector.get(i+1)%></option>
			<%
 	 }
%>
		</select> <bean:message key="admin.updatedemographicprovider.formReplace" /> <select
			name="oldcust4">
			<%
 	 for(int i=0; i<namevector.size(); i=i+2) {
%>
			<option value="<%=namevector.get(i)%>"><%=namevector.get(i+1)%></option>
			<%
 	 }
%>
		</select><br>
		<bean:message key="admin.updatedemographicprovider.formCondition" /> <select
			name="last_name_from">
			<%
   cletter = 'A';
 	 for(int i=0; i<26; i++) {
%>
			<option value="<%=(char) (cletter+i) %>"><%=(char) (cletter+i)%></option>
			<%
 	 }
%>
		</select> <bean:message key="admin.updatedemographicprovider.formTo" /> <select
			name="last_name_to">
			<%
   cletter = 'A';
 	 for(int i=0; i<26; i++) {
%>
			<option value="<%=(char) (cletter+i) %>"><%=(char) (cletter+i)%></option>
			<%
 	 }
%>
		</select> <br>
		<INPUT TYPE="hidden" NAME="regexp" VALUE=""> <input
			type="hidden" name="update" value="UpdateMidwife"> <INPUT
			TYPE="submit"
			VALUE="<bean:message key="admin.updatedemographicprovider.btnGo"/>">
		</td>
	</tr>
	</form>
</table>

</center>
</body>
</html:html>
