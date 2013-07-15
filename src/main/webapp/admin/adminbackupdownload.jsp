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
	objectName="_admin,_admin.backup" rights="r" reverse="<%=true%>">
	<%response.sendRedirect("../logout.jsp");%>
</security:oscarSec>

<%
  //if(session.getValue("user") == null || !((String) session.getValue("userprofession")).equalsIgnoreCase("admin"))
  //  response.sendRedirect("../logout.jsp");
  boolean bodd = false;
  String deepcolor = "#CCCCFF", weakcolor = "#EEEEFF" ;
%>
<%@ page import="java.util.*,oscar.*,java.io.*,java.net.*,oscar.util.*,org.apache.commons.io.FileUtils"
	errorPage="errorpage.jsp"%>
<% java.util.Properties oscarVariables = OscarProperties.getInstance(); %>

<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title>ADMIN PAGE</title>
<link rel="stylesheet" href="../web.css">
<script LANGUAGE="JavaScript">
    <!--
		
    //-->
</script>
</head>

<body background="../images/gray_bg.jpg" bgproperties="fixed"
	onLoad="setfocus()" topmargin="0" leftmargin="0" rightmargin="0">
<center>
<table cellspacing="0" cellpadding="2" width="100%" border="0">
	<tr>
		<th align="CENTER" bgcolor="<%=deepcolor%>">BACKUP DOWNLOAD PAGE</th>
	</tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="90%">
	<tr>
		<td></td>
		<td align="right"><a href="#" onClick='window.close()'> Close
		</a></td>
	</tr>
</table>

<table cellspacing="1" cellpadding="2" width="90%" border="0">
	<tr bgcolor='<%=deepcolor%>'>
		<th>File Name</th>
		<th>Size</th>
	</tr>
	<%
    String backuppath = oscarVariables.getProperty("backup_path") ; //"c:\\root";
    if ( backuppath == null || backuppath.equals("") ) {
        Exception e = new Exception("Unable to find the key backup_path in the properties file.  Please check the value of this key or add it if it is missing.");
        throw e;
    }
    session.setAttribute("backupfilepath", backuppath);

    File f = new File(backuppath);
    File[] contents = f.listFiles(); 
    
    Arrays.sort(contents,new FileSortByDate());
    if (contents == null) {
        Exception e = new Exception("Unable to find any files in the directory "+backuppath+".  (If this is the incorrect directory, please modify the value of backup_path in your properties file to reflect the correct directory).");
        throw e;
    }
    for(int i=0; i<contents.length; i++) {
      bodd = bodd?false:true ;
      if(contents[i].isDirectory() || contents[i].getName().equals("BackupClient.class")  || contents[i].getName().startsWith(".")) continue;
      out.println("<tr bgcolor='"+ (bodd?weakcolor:"white") +"'><td><a HREF='../servlet/BackupDownload?filename="+URLEncoder.encode(contents[i].getName())+"'>"+contents[i].getName()+"</a></td>") ;
      long bytes = contents[i].length( );
      String display = FileUtils.byteCountToDisplaySize( bytes );

      out.println("<td align='right' title=\""+bytes+" by\">"+display+"</td></tr>"); //+System.getProperty("file.separator")
    }
%>
</table>
</body>
</html>
