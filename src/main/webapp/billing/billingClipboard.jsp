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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%      
  if(session.getValue("user") == null)
      response.sendRedirect("../logout.jsp");
  String user_no; 
  user_no = (String) session.getAttribute("user");
  String asstProvider_no = "";
  String color ="";
  String premiumFlag="";
String service_form="", service_name="";
%>
<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title>oscarBilling :: Clip Board ::</title>
<link rel="stylesheet" href="billing.css">

<link rel="stylesheet" type="text/css" media="all" href="../share/css/extractedFromPages.css"  />
<script language="JavaScript">
<!--

function selectprovider(s) {
  if(self.location.href.lastIndexOf("&providerview=") > 0 ) a = self.location.href.substring(0,self.location.href.lastIndexOf("&providerview="));
  else a = self.location.href;
	self.location.href = a + "&providerview=" +s.options[s.selectedIndex].value ;
}

function refresh() {
  var u = self.location.href;
  if(u.lastIndexOf("view=1") > 0) {
    self.location.href = u.substring(0,u.lastIndexOf("view=1")) + "view=0" + u.substring(eval(u.lastIndexOf("view=1")+6));
  } else {
    history.go(0);
  }
}


//-->
</script>
</head>

<body leftmargin="0" topmargin="5" rightmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr bgcolor="#000000">
		<td height="40" width="10%"></td>
		<td width="90%" align="left" bgcolor="#000000">
		<p><font face="Verdana, Arial, Helvetica, sans-serif"
			color="#FFFFFF"><b><font
			face="Arial, Helvetica, sans-serif" size="4">oscar<font
			size="3">Billing</font></font></b></font> <font color="#CCCCCC">Ciipboard </font></p>
		</td>
	</tr>
</table>
<table width="100%" border="0" bgcolor="#EEEEFF">
	<form name="serviceform" method="post"
		action="printBillingClipboard.jsp">
	<tr>
		<td height="40"><input type="submit" name="Submit"
			value="Print Preview"></td>
	</tr>
	<tr>
		<td align="right"><textarea name="textfield" cols="71" rows="10"></textarea>

		</td>
	</tr>
	<tr>
		<td align="right">
		<div align="left">
		<p><textarea name="textfield1" cols="71" rows="30"></textarea></p>
		<p></p>
		</div>
		</td>
	</tr>
	</form>
</table>
</body>
</html>
