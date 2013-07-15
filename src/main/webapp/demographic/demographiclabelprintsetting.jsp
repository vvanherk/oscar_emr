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
  if(session.getValue("user") == null)  response.sendRedirect("../logout.jsp");
  String curProvider_no = (String) session.getAttribute("user");
%>
<%@ page import="java.util.*, java.sql.*, java.net.*, oscar.*"
	errorPage="../appointment/errorpage.jsp"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
  "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="../admin/dbconnection.jsp"%>
<%//operation available to the client - dboperation
  String [][] dbQueries=new String[][] {
    {"search_detail", "select * from demographic where demographic_no=?"},
    {"search_provider", "select p.last_name, p.first_name from demographic d, provider p where d.demographic_no=? and p.provider_no=d.provider_no"},
  };
  //associate each operation with an output JSP file - displaymode
  String[][] responseTargets=new String[][] {  };
  apptMainBean.doConfigure(dbQueries,responseTargets);
%>

<html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title><bean:message
	key="demographic.demographiclabelprintsetting.title" /></title>
<!-- RJ added 07/06/2006 -->
<script src="../share/javascript/prototype.js" language="javascript"
	type="text/javascript"></script>

<script type="text/javascript">

function onNewPatient() {
  document.labelprint.label1no.value="1";
  document.labelprint.label1checkbox.checked=true;
  document.labelprint.label2checkbox.checked=true;
  document.labelprint.label3checkbox.checked=true;
  document.labelprint.label2no.value="6";
  document.labelprint.label3no.value="0";
}
function checkTotal() {
  var total = 0+ document.labelprint.label1no.value + document.labelprint.label2no.value + document.labelprint.label3no.value + document.labelprint.label4no.value + document.labelprint.label5no.value;
  if(total>7) return false;
  return true;
}

<%-- RJ added code to copy text to clipboard in firefox 07/06/2006 --%>
function ClipBoard1(spanId) {

	var browser = navigator.userAgent.toLowerCase();

	if( browser.indexOf('msie') > -1 )
	{			
		document.getElementById("text1").innerText = document.getElementById(spanId).innerText;
		//alert("clip");
		Copied = document.getElementById("text1").createTextRange();
		//alert("clip");
		Copied.execCommand("RemoveFormat");
		Copied.execCommand("Copy");
	}
	else if( browser.indexOf('safari') > -1 )
	{
		alert("Copy to clipboard is not supported in Safari");
	}
	else if( browser.indexOf('firefox') > -1 )
	{

		//need privelege to access clipboard
		//We'll catch exception if security prevents access and tell user how to correct the problem
		try
		{
			netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');
		}
		catch(ex)
		{
			alert("Your browser has restricted access to clipboard\n" + 
			       "Please type \"about:config\" in location bar\n" + 
			       "and search for \"signed.applets.codebase_principal_support\"\n" +
			       "then set value to true.  You will then be able to copy to clipboard");
			return;
		}

		var strText = document.getElementById(spanId).innerHTML;
		
		//we want to keep line format so replace <br> with \r\n
		strText = strText.replace(/\t/g, "");
		strText = strText.replace(/<br>/g,"\r\n");
		
		//get rid of html tags and &nbsp;
		strText = strText.stripTags();
		strText = strText.replace(/&nbsp;/g," ");

		//object to hold copy of string 
		var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
		str.data = strText;

		//transfer object holds string. xfer obj is placed on clipboard
		var trans = Components.classes["@mozilla.org/widget/transferable;1"].createInstance(Components.interfaces.nsITransferable);
		trans.addDataFlavor("text/unicode");
		trans.setTransferData("text/unicode",str,strText.length * 2); 

		//xfer object to clipboard
		var clipid = Components.interfaces.nsIClipboard;
		var clip = Components.classes["@mozilla.org/widget/clipboard;1"].getService(clipid);
		clip.setData(trans,null,clipid.kGlobalClipboard);

	}
}
function ClipBoard2() {
	document.getElementById("text1").innerText = document.getElementById("copytext").innerText;
	//alert("cl ip");
	Copied = document.getElementById("text1").createTextRange();
	//alert("clip");
	Copied.execCommand("RemoveFormat");
	Copied.execCommand("Copy");
}
function ClipBoard3() {
	document.getElementById("text1").innerText = document.getElementById("copytext").innerText;
	//alert("cl ip");
	Copied = document.getElementById("text1").createTextRange();
	//alert("clip");
	Copied.execCommand("RemoveFormat");
	Copied.execCommand("Copy");
}
function ClipBoard4() {
	document.getElementById("text1").innerText = document.getElementById("copytext").innerText;
	//alert("cl ip");
	Copied = document.getElementById("text1").createTextRange();
	//alert("clip");
	Copied.execCommand("RemoveFormat");
	Copied.execCommand("Copy");
}

</SCRIPT>
</head>
<body background="../images/gray_bg.jpg" bgcolor="white"
	bgproperties="fixed" onLoad="setfocus()" topmargin="0" leftmargin="0"
	rightmargin="0">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#486ebd">
		<th align=CENTER NOWRAP><font face="Helvetica" color="#FFFFFF"><bean:message
			key="demographic.demographiclabelprintsetting.msgMainLabel" /></font></th>
	</tr>
</table>

<%
	GregorianCalendar now=new GregorianCalendar();  int curYear = now.get(Calendar.YEAR);  int curMonth = (now.get(Calendar.MONTH)+1);  int curDay = now.get(Calendar.DAY_OF_MONTH);
	int age=0, dob_year=0, dob_month=0, dob_date=0;
  String first_name="",last_name="",chart_no="",address="",city="",province="",postal="",phone="",phone2="",dob="",sex="",hin="";
	String refDoc = "";
  int param = Integer.parseInt(request.getParameter("demographic_no"));

  // find the family doctor's name
  String providername = "";
  ResultSet rs = apptMainBean.queryResults(param, "search_provider");
  while (rs.next()) {
    providername = apptMainBean.getString(rs,"last_name") +","+ apptMainBean.getString(rs,"first_name");
  }

  rs = apptMainBean.queryResults(param, "search_detail");
  if(rs==null) {
%><bean:message key="demographic.demographiclabelprintsetting.msgFailed" />
<%
   // out.println("failed!!!");
  } else {
    while (rs.next()) {
      dob_year = Integer.parseInt(apptMainBean.getString(rs,"year_of_birth"));
      dob_month = Integer.parseInt(apptMainBean.getString(rs,"month_of_birth"));
      dob_date = Integer.parseInt(apptMainBean.getString(rs,"date_of_birth"));
      if(dob_year!=0) age=MyDateFormat.getAge(dob_year,dob_month,dob_date);

      first_name = Misc.JSEscape(apptMainBean.getString(rs,"first_name"));
      last_name = Misc.JSEscape(apptMainBean.getString(rs,"last_name"));
      chart_no = apptMainBean.getString(rs,"chart_no");
      address = Misc.JSEscape(apptMainBean.getString(rs,"address"));
      city = apptMainBean.getString(rs,"city");
      province = apptMainBean.getString(rs,"province");
      postal = apptMainBean.getString(rs,"postal");
      phone = apptMainBean.getString(rs,"phone");
      phone2 = apptMainBean.getString(rs,"phone2");
      dob=dob_year+"/"+apptMainBean.getString(rs,"month_of_birth")+"/"+apptMainBean.getString(rs,"date_of_birth");
      sex = apptMainBean.getString(rs,"sex");
      hin = "HN "+ apptMainBean.getString(rs,"hc_type") +" "+apptMainBean.getString(rs,"hin")+ " " +apptMainBean.getString(rs,"ver");
      refDoc = SxmlMisc.getXmlContent(apptMainBean.getString(rs,"family_doctor"),"rd");
    }
  }
  phone2 = phone2.equals("")?"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;":(phone2+"&nbsp;") ;
/*  String label1 = "<font face=\"Courier New, Courier, mono\" size=\"2\"><b>" +last_name+ ", " +first_name+ "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;" +hin+ "<br>&nbsp;&nbsp;&nbsp;&nbsp;" +dob+ " " +sex+ "<br><br><b>" +last_name+ ", " +first_name+ "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;" +hin+ "<br>&nbsp;&nbsp;&nbsp;&nbsp;" +dob+ " " +sex+ "<br></font>";
  String label2 = "<font face=\"Courier New, Courier, mono\" size=\"2\"><b>" +last_name+ ", " +first_name+ "  &nbsp;" +chart_no+ "</b><br>" +address+ "<br>" +city+ ", " +province+ ", " +postal+ "<br>Home: " +phone+ "<br>" +dob+ " " +sex+ "<br>" +hin+ "<br>Bus:" +phone2+ "Dr."+  providername+ "<br></font>";
  String label3 = "<font face=\"Courier New, Courier, mono\" size=\"2\">" +last_name+ ", " +first_name+ "<br>" +address+ "<br>" +city+ ", " +province+ ", " +postal+ "<br></font>";
  String label4 = "<font face=\"Courier New, Courier, mono\" size=\"2\">" +first_name+ " " +last_name+ "<br>" +address+ "<br>" +city+ ", " +province+ ", " +postal+ "<br></font>";
  String label5 = "<font face=\"Courier New, Courier, mono\" size=\"2\">" +chart_no+ " " +last_name+ " " +first_name+ "<br>" +address+ "<br>" +city+ ", " +province+ ", " +postal+ "<br> +dob+ "  " +age+ " " +sex+ "  " +hin+ " " +province+ "<br> +phone+ "<br></font>";
*/
%>

<form method="post" name="labelprint"
	action="demographicprintdemographic.jsp">
<table border="0" cellpadding="0" cellspacing="3" width="100%">
	<tr bgcolor="gold" align="center">
		<td><bean:message
			key="demographic.demographiclabelprintsetting.msgLabel" /></td>
		<td><bean:message
			key="demographic.demographiclabelprintsetting.msgNumeberOfLabel" />
		<td><bean:message
			key="demographic.demographiclabelprintsetting.msgLocation" /> <input
			type="hidden" name="address" value="<%=address%>"> <input
			type="hidden" name="chart_no" value="<%=chart_no%>"> <input
			type="hidden" name="city" value="<%=city%>"> <input
			type="hidden" name="dob" value="<%=dob%>"> <input
			type="hidden" name="first_name" value="<%=first_name%>"> <input
			type="hidden" name="hin" value="<%=hin%>"> <input
			type="hidden" name="last_name" value="<%=last_name%>"> <input
			type="hidden" name="phone" value="<%=phone%>"> <input
			type="hidden" name="phone2" value="<%=phone2%>"> <input
			type="hidden" name="postal" value="<%=postal%>"> <input
			type="hidden" name="providername" value="<%=providername%>">
		<input type="hidden" name="province" value="<%=province%>"> <input
			type="hidden" name="sex" value="<%=sex%>"> <input
			type="hidden" name="age" value="<%=age%>"></td>
	</tr>
	<tr>
		<td align="center">
		<table width="90%" border="1" cellspacing="0" cellpadding="0"
			bgcolor="#FFFFFF">
			<tr>
				<%--<td><%=label1%></td>--%>
				<td><font face="Courier New, Courier, mono" size="2"><SPAN
					ID="copytext1"> <b><%=last_name%>,&nbsp;<%=first_name%></b><br>
				&nbsp;&nbsp;&nbsp;&nbsp;<%=hin%><br>
				&nbsp;&nbsp;&nbsp;&nbsp;<%=dob%>&nbsp;<%=sex%><br>
				<br>
				<b><%=last_name%>,&nbsp;<%=first_name%></b><br>
				&nbsp;&nbsp;&nbsp;&nbsp;<%=hin%><br>
				&nbsp;&nbsp;&nbsp;&nbsp;<%=dob%>&nbsp;<%=sex%><br>
				</span></font></td>
			</tr>
		</table>
		</td>
		<td align="center" bgcolor="#CCCCCC"><a href="#"
			onClick="onNewPatient()"><bean:message
			key="demographic.demographiclabelprintsetting.btnNewPatientLabel" /></a><br>
		<input type="button" onClick="ClipBoard1('copytext1');"
			value="Copy to Clipboard" /> <input type="checkbox"
			name="label1checkbox" value="checked"> <input type="text"
			name="label1no" size="2" maxlength="2"
			value="<%= oscarVariables.getProperty("label.1no","1") %>" /></td>
		<td bgcolor="#999999" rowspan="5" valign="middle" align="right">
		<p><bean:message
			key="demographic.demographiclabelprintsetting.formLeft" />: <input
			type="text" name="left" size="3" maxlength="3"
			value="<%= oscarVariables.getProperty("label.left","200") %>" /> <bean:message
			key="demographic.demographiclabelprintsetting.msgPx" /></p>
		<p><bean:message
			key="demographic.demographiclabelprintsetting.formTop" />: <input
			type="text" name="top" size="3" maxlength="3"
			value="<%= oscarVariables.getProperty("label.top","0")%>" /> <bean:message
			key="demographic.demographiclabelprintsetting.msgPx" /></p>
		<p><bean:message
			key="demographic.demographiclabelprintsetting.formHeight" />: <input
			type="text" name="height" size="3" maxlength="3"
			value="<%= oscarVariables.getProperty("label.height","145")%>" /> <bean:message
			key="demographic.demographiclabelprintsetting.msgPx" /></p>
		<p><bean:message
			key="demographic.demographiclabelprintsetting.formGap" />: <input
			type="text" name="gap" size="3" maxlength="3"
			value="<%= oscarVariables.getProperty("label.gap","0")%>" /> <bean:message
			key="demographic.demographiclabelprintsetting.msgPx" /></p>
		</td>
	</tr>
	<tr>
		<td align="center">
		<table width="90%" border="1" cellspacing="0" cellpadding="0"
			bgcolor="#FFFFFF">
			<tr>
				<%--<td><%=label2%></td>--%>
				<td><font face="Courier New, Courier, mono" size="2"><span
					id="copytext2"> <b><%=last_name%>,&nbsp;<%=first_name%>&nbsp;<%=chart_no%></b><br><%=address%><br><%=city%>,&nbsp;<%=province%>,&nbsp;<%=postal%><br>
				<bean:message key="demographic.demographiclabelprintsetting.msgHome" />:&nbsp;<%=phone%><br><%=dob%>&nbsp;<%=sex%><br><%=hin%><br>
				<bean:message key="demographic.demographiclabelprintsetting.msgBus" />:<%=phone2%>&nbsp;<bean:message
					key="demographic.demographiclabelprintsetting.msgDr" />&nbsp;<%=providername%><br>
				</span></font></td>
			</tr>
		</table>
		</td>
		<td align="center" bgcolor="#CCCCCC"><input type="button"
			onClick="ClipBoard1('copytext2');" value="Copy to Clipboard" /> <input
			type="checkbox" name="label2checkbox" value="checked" checked>
		<input type="text" name="label2no" size="2" maxlength="2"
			value="<%= oscarVariables.getProperty("label.2no","1") %>"></td>
	</tr>
	<tr>
		<td align="center">
		<table width="90%" border="1" cellspacing="0" cellpadding="0"
			bgcolor="#FFFFFF">
			<tr>
				<%--            <td><%=label3%></td>
--%>
				<td><font face="Courier New, Courier, mono" size="2"><SPAN
					ID="copytext3"> <%=last_name%>,&nbsp;<%=first_name%><br><%=address%><br><%=city%>,&nbsp;<%=province%>,&nbsp;<%=postal%><br>
				</span></font></td>
			</tr>
		</table>
		</td>
		<td align="center" bgcolor="#CCCCCC"><input type="button"
			onClick="ClipBoard1('copytext3');" value="Copy to Clipboard" /> <input
			type="checkbox" name="label3checkbox" value="checked"> <input
			type="text" name="label3no" size="2" maxlength="2"
			value="<%= oscarVariables.getProperty("label.3no","1") %>"></td>
	</tr>
	<tr>
		<td align="center">
		<table width="90%" border="1" cellspacing="0" cellpadding="0"
			bgcolor="#FFFFFF">
			<tr>
				<td><font face="Courier New, Courier, mono" size="2"><SPAN
					ID="copytext4"> <%=first_name%>&nbsp;<%=last_name%><br><%=address%><br><%=city%>,&nbsp;<%=province%>,&nbsp;<%=postal%><br>
				</span></font></td>
			</tr>
		</table>
		</td>
		<td align="center" bgcolor="#CCCCCC"><TEXTAREA ID="text1"
			STYLE="display: none;">
		
		</TEXTAREA> <input type="button" onClick="ClipBoard1('copytext4');"
			value="Copy to Clipboard" /> <input type="checkbox"
			name="label4checkbox" value="checked"> <input type="text"
			name="label4no" size="2" maxlength="2"
			value="<%= oscarVariables.getProperty("label.4no","1") %>"></td>
	</tr>
	<tr>
		<td align="center">
		<table width="90%" border="1" cellspacing="0" cellpadding="0"
			bgcolor="#FFFFFF">
			<tr>
				<td><font face="Courier New, Courier, mono" size="2"><SPAN
					ID="copytext5"> <%=chart_no%> &nbsp;&nbsp;<%=last_name%>, <%=first_name%><br><%=address%>,
				<%=city%>, <%=province%>, <%=postal%><br>
				<%=dob%> &nbsp;&nbsp;&nbsp;<%=age%> <%=sex%> &nbsp;<%=hin%><br><%=phone%>&nbsp;&nbsp;&nbsp;<%=phone2%><br>
				<%=refDoc%></span></font></td>
			</tr>
		</table>
		</td>
		<td align="center" bgcolor="#CCCCCC"><TEXTAREA ID="text1"
			STYLE="display: none;">
		</TEXTAREA> <input type="button" onClick="ClipBoard1('copytext5');"
			value="Copy to Clipboard" /> <input type="checkbox"
			name="label5checkbox" value="checked"> <input type="text"
			name="label5no" size="2" maxlength="2"
			value="<%= oscarVariables.getProperty("label.5no","1") %>"></td>
	</tr>
	<tr bgcolor="#486ebd">
		<td align="center" colspan="3"><input type="submit" name="Submit"
			value="<bean:message key='demographic.demographiclabelprintsetting.btnPrintPreviewPrint'/>">
		<input type="button" name="button"
			value="<bean:message key='global.btnBack'/>"
			onClick="javascript:history.go(-1);return false;"></td>
	</tr>
</table>
</form>

</body>
</html:html>
