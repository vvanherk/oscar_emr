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

<%
  if (session.getValue("user") == null)
    response.sendRedirect("../logout.htm");
  String curUser_no, userfirstname, userlastname;
  curUser_no = (String) session.getAttribute("user");
  userfirstname = (String) session.getAttribute("userfirstname");
  userlastname = (String) session.getAttribute("userlastname");
%>
<%@page
	import="java.util.*, java.sql.*, oscar.*, java.net.*,oscar.oscarBilling.ca.bc.pageUtil.*"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />
<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title>Billing Summary</title>
<script LANGUAGE="JavaScript">
<!--
<%
      boolean multipage = false;
      String formName = request.getParameter("formName");
      String formElement = request.getParameter("formElement");
      if ( formName != null && !formName.equals("") && formElement != null && !formElement.equals("") ){
         multipage = true;
      }

      if (multipage){%>
function CodeAttach(File0, File1, File2) {

      self.close();
      self.opener.document.<%=formName%>.<%=formElement%>.value = File0;
}
      <%}else{%>
function CodeAttach(File0, File1, File2,dx1,dx2,dx3) {

      self.close();
      self.opener.document.BillingCreateBillingForm.xml_other1.value = File0;
      self.opener.document.BillingCreateBillingForm.xml_other2.value = File1;
      self.opener.document.BillingCreateBillingForm.xml_other3.value = File2;
      self.opener.document.BillingCreateBillingForm.xml_diagnostic_detail1.value =dx1;
      self.opener.document.BillingCreateBillingForm.xml_diagnostic_detail2.value =dx2;
      self.opener.document.BillingCreateBillingForm.xml_diagnostic_detail3.value =dx3;
}
    <%}%>

-->
</script>
</head>
<body>
<%
  if (request.getParameter("update").equals("Confirm")) {
    String temp = "";
    String[] param = new String[10];
    param[0] = "";
    param[1] = "";
    param[2] = "";
    int Count = 0;
    for (Enumeration e = request.getParameterNames(); e.hasMoreElements(); ) {
      temp = e.nextElement().toString();
      if (temp.indexOf("code_") == -1)continue;
      param[Count] = temp.substring(5).toUpperCase(); // + " |" + request.getParameter("codedesc_" + temp.substring(5));
      Count = Count + 1;
    }
    if (Count == 1) {
      param[1] = "";
      param[2] = "";
    }
    if (Count == 2) {
      param[2] = "";
    }
    if (Count == 0) {
%>
<p>No input selected</p>
<input type="button" name="back" value="back"
	onClick="javascript:history.go(-1);return false;">
<%
  } else {
    String[] diags = {"","",""};
    BillingAssociationPersistence per = new BillingAssociationPersistence();
    for (int i = 0; i < param.length; i++) {
      ServiceCodeAssociation assoc = per.getServiceCodeAssocByCode(param[i]);
      List dxcodes = assoc.getDxCodes();
      if(!dxcodes.isEmpty()){
        diags[i]=(String)dxcodes.get(0);
      }
    }
%>
<script LANGUAGE="JavaScript">
    <!--
     CodeAttach('<%=param[0]%>','<%=param[1]%>', '<%=param[2]%>', '<%=diags[0]%>', '<%=diags[1]%>', '<%=diags[2]%>' );
    -->

</script>
<%
  }
  } else {
%>
<%
  String code = request.getParameter("update");
  code = code.substring(code.length() - 5);
  int rowsAffected = 0;
  String[] param1 = new String[2];
  param1[0] = request.getParameter(code);
  param1[1] = code;
  //	  param1[1]=request.getParameter("apptProvider_no"); param1[2]=request.getParameter("appointment_date"); param1[3]=MyDateFormat.getTimeXX_XX_XX(request.getParameter("start_time"));
  rowsAffected = apptMainBean.queryExecuteUpdate(param1, "updatebillservice");
%>

<p>
<h1>Successful Addition of a billing Record.</h1>
</p>
<script LANGUAGE="JavaScript">
    history.go(-1);return false;
    self.opener.refresh();
</script>
<%}%>
</body>
</html>
