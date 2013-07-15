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
  if(session.getValue("user") == null)
     response.sendRedirect("../logout.jsp");
  String user_no;
  user_no = (String) session.getAttribute("user");
  int  nItems=0;
  String strLimit1="0";
  String strLimit2="5";
  if(request.getParameter("limit1")!=null) strLimit1 = request.getParameter("limit1");
  if(request.getParameter("limit2")!=null) strLimit2 = request.getParameter("limit2");
  String providerview = request.getParameter("providerview")==null?"all":request.getParameter("providerview") ;
%>
<%@ page
	import="java.math.*, java.util.*, java.sql.*, oscar.*, java.net.*"
	errorPage="errorpage.jsp"%>
<%@ include file="../admin/dbconnection.jsp"%>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />
<jsp:useBean id="SxmlMisc" class="oscar.SxmlMisc" scope="session" />
<%@ include file="dbReport.jspf"%>
<%@page import="org.oscarehr.util.SpringUtils" %>
<%@page import="org.oscarehr.common.dao.ClinicLocationDao" %>
<%@page import="org.oscarehr.common.model.ClinicLocation" %>
<%
	ClinicLocationDao clinicLocationDao = (ClinicLocationDao)SpringUtils.getBean("clinicLocationDao");
%>
<%
GregorianCalendar now=new GregorianCalendar();
   int curYear = now.get(Calendar.YEAR);
   int curMonth = (now.get(Calendar.MONTH)+1);
   int curDay = now.get(Calendar.DAY_OF_MONTH);
   String clinic="";
   String clinicview = oscarVariables.getProperty("clinic_view");

   String visitLocation = clinicLocationDao.searchVisitLocation(clinicview);
   if(visitLocation!=null) {
  	 clinic = visitLocation;
   }

   //String providerview=request.getParameter("provider")==null?"":request.getParameter("provider");
   String reportAction=request.getParameter("reportAction")==null?"":request.getParameter("reportAction");
   String xml_vdate=request.getParameter("xml_vdate") == null?"":request.getParameter("xml_vdate");
   String xml_appointment_date = request.getParameter("xml_appointment_date")==null?"":request.getParameter("xml_appointment_date");

%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>

<%@page import="org.oscarehr.util.MiscUtils"%><html:html locale="true">
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title><bean:message key="oscarReport.oscarReportAgeSex.title" /></title>
<link rel="stylesheet" href="oscarReport.css">
<link rel="stylesheet" type="text/css" media="all" href="../share/css/extractedFromPages.css"  />
<script language="JavaScript">
<!--


function selectprovider(s) {
  if(self.location.href.lastIndexOf("&providerview=") > 0 ) a = self.location.href.substring(0,self.location.href.lastIndexOf("&providerview="));
  else a = self.location.href;
	self.location.href = a + "&providerview=" +s.options[s.selectedIndex].value ;
}


function openBrWindow(theURL,winName,features) {
  window.open(theURL,winName,features);
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

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" rightmargin="0"
	topmargin="10">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr bgcolor="#000000">
		<td height="40" width="10%"><input type='button' name='print'
			value='<bean:message key="global.btnPrint"/>'
			onClick='window.print()'></td>
		<td width="90%" align="left">
		<p><font face="Verdana, Arial, Helvetica, sans-serif"
			color="#FFFFFF"><b><font
			face="Arial, Helvetica, sans-serif" size="4"><bean:message
			key="oscarReport.oscarReportAgeSex.msgOscarReport" /></font></b></font></p>
		</td>
	</tr>
</table>

<table width="100%" border="0" bgcolor="#EEEEFF">
	<form name="serviceform" method="get" action="oscarReportAgeSex.jsp">
	<tr>
		<td colspan="3">
		<div align="center"><font face="Arial, Helvetica, sans-serif"
			size="2"><b><bean:message
			key="oscarReport.oscarReportAgeSex.msgAgeSexRep" /><font
			color="#333333"></font></b></font></div>
		</td>
	</tr>
	<tr>
		<td width="40%">
		<div align="right"><font color="#003366"><font size="1"
			color="#333333" face="Verdana, Arial, Helvetica, sans-serif">
		<input type="radio" name="reportAction" value="RO"
			<%=reportAction.equals("RO")?"checked":""%>> <bean:message
			key="oscarReport.oscarReportAgeSex.formRostered" /> <input
			type="radio" name="reportAction" value="NR"
			<%=reportAction.equals("NR")?"checked":""%>> <bean:message
			key="oscarReport.oscarReportAgeSex.formNotRostered" /> <input
			type="radio" name="reportAction" value="TO"
			<%=reportAction.equals("TO")?"checked":""%>> <bean:message
			key="oscarReport.oscarReportAgeSex.formTotal" /></font> <font
			face="Arial, Helvetica, sans-serif" size="1"><b> </b></font></font></div>
		</td>
		<td width="40%">
		<div align="right"></div>
		<div align="center"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#333333"><b><bean:message
			key="oscarReport.oscarReportAgeSex.formSelectProvider" /> </b></font> <select
			name="providerview">
			<option value="" <%=providerview.equals("all")?"selected":""%>>-------<bean:message
				key="oscarReport.oscarReportAgeSex.formSelectProvider" /> ----------</option>
			<%   String proFirst="";
               String proLast="";
               String proOHIP="";
               String specialty_code;
               String billinggroup_no;
               int Count = 0;
               ResultSet rslocal = null;
               rslocal = apptMainBean.queryResults("%", "search_provider_all_dt");
               while(rslocal.next()){
                  proFirst = rslocal.getString("first_name");
                  proLast = rslocal.getString("last_name");
                  proOHIP = rslocal.getString("provider_no");
                  billinggroup_no= SxmlMisc.getXmlContent(rslocal.getString("comments"),"<xml_p_billinggroup_no>","</xml_p_billinggroup_no>");
                  specialty_code = SxmlMisc.getXmlContent(rslocal.getString("comments"),"<xml_p_specialty_code>","</xml_p_specialty_code>");
          %>
			<option value="<%=proOHIP%>"
				<%=providerview.equals(proOHIP)?"selected":""%>><%=proLast%>,<%=proFirst%></option>
			<%   }   %>
		</select></div>
		</td>
		<td width="20%"><font color="#333333" size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <input
			type="submit" name="Submit"
			value="<bean:message key="oscarReport.oscarReportAgeSex.btnCreate"/>">
		</font></td>
	</tr>
	<tr>
		<td width="50%">
		<div align="left"><font color="#003366"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1"><b>

		<font color="#333333"><bean:message
			key="oscarReport.oscarReportAgeSex.msgServiceDate" /></font></b></font></font> &nbsp; &nbsp; <font
			size="1" face="Arial, Helvetica, sans-serif"><a href="#"
			onClick="openBrWindow('../billing/billingCalendarPopup.jsp?type=admission&amp;year=<%=curYear%>&amp;month=<%=curMonth%>','','width=300,height=300')"><bean:message
			key="oscarReport.oscarReportAgeSex.btnBegin" />:</a></font> <input type="text"
			name="xml_vdate" value="<%=xml_vdate%>"></div>
		</td>
		<td colspan='2'>
		<div align="left"><font size="1"
			face="Arial, Helvetica, sans-serif"><a href="#"
			onClick="openBrWindow('../billing/billingCalendarPopup.jsp?type=end&amp;year=<%=curYear%>&amp;month=<%=curMonth%>','','width=300,height=300')"><bean:message
			key="oscarReport.oscarReportAgeSex.btnEnd" />:</a></font> <input type="text"
			name="xml_appointment_date" value="<%=xml_appointment_date%>">


		</div>
		</td>
	</tr>
	</form>
</table>



<% if (reportAction.compareTo("") == 0 || reportAction == null){%>

<p>&nbsp;</p>
<% } else {

      String Total="0", mNum="", fNum="";
      String dateBegin = request.getParameter("xml_vdate");
      String dateEnd = request.getParameter("xml_appointment_date");
      if (dateEnd.compareTo("") == 0) dateEnd = MyDateFormat.getMysqlStandardDate(curYear, curMonth, curDay);
      if (dateBegin.compareTo("") == 0) dateBegin="1950-01-01"; // set to any early date to start search from beginning

      ResultSet rs;
      ResultSet rs2;
      String[] param = new String[7];
      String queryName = "count_reportagesex";
      if (reportAction.compareTo("NR") == 0) {
         queryName = "count_reportagesex_noroster";
      }
      if (reportAction.compareTo("RO") == 0 || reportAction.compareTo("NR") == 0) {
         param[0] = "RO";
      } else {
         param[0] = "%";
      }

      param[1] = "%";
      param[2] = providerview;
      param[3] = "0";
      param[4] = "200";
      param[5] = dateBegin;
      param[6] = dateEnd ;
      rs = null;
      rs = apptMainBean.queryResults(param, queryName);
      while(rs.next()){
         Total = apptMainBean.getString(rs,"n");
      }

      BigDecimal percent = new BigDecimal(100).setScale(2, BigDecimal.ROUND_HALF_UP);
      BigDecimal mdNum = new BigDecimal(0).setScale(2, BigDecimal.ROUND_HALF_UP);
      BigDecimal fdNum = new BigDecimal(0).setScale(2, BigDecimal.ROUND_HALF_UP);
      BigDecimal mPercId = new BigDecimal(0).setScale(0, BigDecimal.ROUND_HALF_UP);
      BigDecimal fPercId = new BigDecimal(0).setScale(0, BigDecimal.ROUND_HALF_UP);
      BigDecimal mPerc = new BigDecimal(0).setScale(2, BigDecimal.ROUND_HALF_UP);
      BigDecimal fPerc = new BigDecimal(0).setScale(2, BigDecimal.ROUND_HALF_UP);
      BigDecimal mPercTotal = new BigDecimal(0).setScale(1, BigDecimal.ROUND_HALF_UP);
      BigDecimal fPercTotal = new BigDecimal(0).setScale(1, BigDecimal.ROUND_HALF_UP);

      BigDecimal mTotal = new BigDecimal(0).setScale(0, BigDecimal.ROUND_HALF_UP);
      BigDecimal fTotal= new BigDecimal(0).setScale(0, BigDecimal.ROUND_HALF_UP);
      BigDecimal BigTotal= new BigDecimal(0).setScale(0, BigDecimal.ROUND_HALF_UP);
      BigDecimal BigTotalPerc= new BigDecimal(0).setScale(1, BigDecimal.ROUND_HALF_UP);
      BigDecimal LineTotal= new BigDecimal(0).setScale(0, BigDecimal.ROUND_HALF_UP);
      BigDecimal LinePerc= new BigDecimal(0).setScale(2, BigDecimal.ROUND_HALF_UP);
   %>
<pre><font face="Arial, Helvetica, sans-serif" size="2"> <bean:message
	key="oscarReport.oscarReportAgeSex.msgDate" />: <%=curYear%>-<%=curMonth%>-<%=curDay%>                          <bean:message
	key="oscarReport.oscarReportAgeSex.msgUnit" />: <%=clinic%>                                              <bean:message
	key="oscarReport.oscarReportAgeSex.msgPhysician" />: <%=providerview%></font></pre>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr bgcolor="#CCCCFF">
		<td>
		<div align="center"><bean:message
			key="oscarReport.oscarReportAgeSex_noroster.msgAge" /></div>
		</td>
		<td colspan='12'>
		<div align="center">---------------------------<bean:message
			key="oscarReport.oscarReportAgeSex_noroster.msgFemale" />
		---------------------------------</div>
		</td>
		<td>
		<div align="center"></div>
		</td>
		<td colspan='12'>
		<div align="center">----------------------------<bean:message
			key="oscarReport.oscarReportAgeSex_noroster.msgMale" />
		----------------------------------</div>
		</td>
		<td colspan='2'>
		<div align="center">---<bean:message
			key="oscarReport.oscarReportAgeSex_noroster.msgTotal" /> ---</div>

		</td>
	</tr>
	<tr bgcolor="#CCCCFF">
		<td width="10%">
		<div align="center"><bean:message
			key="oscarReport.oscarReportAgeSex_noroster.msgGroup" /></div>
		</td>
		<td width="8%">
		<div align="right">####</div>
		</td>
		<td width="8%">
		<div align="right">%%%%</div>
		</td>
		<td width="2%">
		<div align="center">+</div>
		</td>
		<td width="2%">
		<div align="center">9</div>
		</td>
		<td width="2%">
		<div align="center">8</div>
		</td>
		<td width="2%">
		<div align="center">7</div>
		</td>
		<td width="2%">
		<div align="center">6</div>
		</td>
		<td width="2%">
		<div align="center">5</div>
		</td>
		<td width="2%">
		<div align="center">4</div>
		</td>
		<td width="2%">
		<div align="center">3</div>
		</td>
		<td width="2%">
		<div align="center">2</div>
		</td>
		<td width="2%">
		<div align="center">1</div>
		</td>
		<td width="2%">
		<div align="center">0</div>
		</td>
		<td width="2%">
		<div align="center">1</div>
		</td>
		<td width="2%">
		<div align="center">2</div>
		</td>
		<td width="2%">
		<div align="center">3</div>
		</td>
		<td width="2%">
		<div align="center">4</div>
		</td>
		<td width="2%">
		<div align="center">5</div>
		</td>
		<td width="2%">
		<div align="center">6</div>
		</td>
		<td width="2%">
		<div align="center">7</div>
		</td>
		<td width="2%">
		<div align="center">8</div>
		</td>
		<td width="2%">
		<div align="center">9</div>
		</td>
		<td width="2%">
		<div align="center">+</div>
		</td>
		<td width="8%">
		<div align="right">%%%%</div>
		</td>
		<td width="8%">
		<div align="right">####</div>
		</td>
		<td width="8%">
		<div align="right">####</div>
		</td>
		<td width="8%">
		<div align="right">%%%%</div>
		</td>
	</tr>
	<% String[][] AgeMatrix = new String[20][2];
     AgeMatrix[0][0] = "0";
     AgeMatrix[0][1] = "4";
     AgeMatrix[1][0] = "5";
     AgeMatrix[1][1] = "9";
     AgeMatrix[2][0] = "10";
     AgeMatrix[2][1] = "14";
     AgeMatrix[3][0] = "15";
     AgeMatrix[3][1] = "19";
     AgeMatrix[4][0] = "20";
     AgeMatrix[4][1] = "24";
     AgeMatrix[5][0] = "25";
     AgeMatrix[5][1] = "29";
     AgeMatrix[6][0] = "30";
     AgeMatrix[6][1] = "34";
     AgeMatrix[7][0] = "35";
     AgeMatrix[7][1] = "39";
     AgeMatrix[8][0] = "40";
     AgeMatrix[8][1] = "44";
     AgeMatrix[9][0] = "45";
     AgeMatrix[9][1] = "49";
     AgeMatrix[10][0] = "50";
     AgeMatrix[10][1] = "54";
     AgeMatrix[11][0] = "55";
     AgeMatrix[11][1] = "59";
     AgeMatrix[12][0] = "60";
     AgeMatrix[12][1] = "64";
     AgeMatrix[13][0] = "65";
     AgeMatrix[13][1] = "69";
     AgeMatrix[14][0] = "70";
     AgeMatrix[14][1] = "74";
     AgeMatrix[15][0] = "75";
     AgeMatrix[15][1] = "79";
     AgeMatrix[16][0] = "80";
     AgeMatrix[16][1] = "84";
     AgeMatrix[17][0] = "85";
     AgeMatrix[17][1] = "89";
     AgeMatrix[18][0] = "90";
     AgeMatrix[18][1] = "94";
     AgeMatrix[19][0] = "95";
     AgeMatrix[19][1] = "200";



     for (int i=0;i<20; i++){
        param[1] = "M%";
        param[2] = providerview;
        param[3] = AgeMatrix[i][0];
        param[4] = AgeMatrix[i][1];
        //param[5] = dateBegin;
        //param[6] = dateEnd ;
        rs = null;
        rs = apptMainBean.queryResults(param, queryName);
        while(rs.next()){
           mNum = apptMainBean.getString(rs,"n");
        }

        param[1] = "F%";
        //param[2] = providerview;
        //param[3] = AgeMatrix[i][0];
        //param[4] = AgeMatrix[i][1];
        //param[5] = dateBegin;
        //param[6] = dateEnd ;
        rs2 = null;
        rs2 = apptMainBean.queryResults(param, queryName);
        while(rs2.next()){
           fNum = rs2.getString("n");
        }
        if (Total ==null || Total.compareTo("") == 0 || Total.compareTo("0") ==0){Total = "9999";}
        if (mNum ==null || mNum.compareTo("") == 0 || mNum.compareTo("0") ==0){mNum="0";}
        mdNum = new BigDecimal(Double.parseDouble(mNum)).setScale(2, BigDecimal.ROUND_HALF_UP);
        BigTotal = new BigDecimal(Double.parseDouble(Total)).setScale(2, BigDecimal.ROUND_HALF_UP);
        // mPerc = mdNum.divide(BigTotal, BigDecimal.ROUND_HALF_UP);
        mPerc = mdNum.multiply(percent).divide(BigTotal, BigDecimal.ROUND_HALF_UP).setScale(1, BigDecimal.ROUND_HALF_UP);
        mPercId = mPerc.setScale(0, BigDecimal.ROUND_HALF_UP);
        fdNum = new BigDecimal(Double.parseDouble(fNum)).setScale(2, BigDecimal.ROUND_HALF_UP);
        // fPerc = fdNum.divide(BigTotal, BigDecimal.ROUND_HALF_UP);
        fPerc = fdNum.multiply(percent).divide(BigTotal, BigDecimal.ROUND_HALF_UP).setScale(1, BigDecimal.ROUND_HALF_UP);
        fPercId = fPerc.setScale(0, BigDecimal.ROUND_HALF_UP);

        LineTotal = fdNum.add(mdNum).setScale(0, BigDecimal.ROUND_HALF_UP);
        LinePerc = fPerc.add(mPerc);
  %>

	<tr>
		<td>
		<div align="center"><%=AgeMatrix[i][0]%>-<%=AgeMatrix[i][1]%></div>
		</td>
		<td>
		<div align="right"><%=fNum%></div>
		</td>
		<td>
		<div align="right"><%=fPerc%></div>
		</td>
		<%=WriteFemaleBar(Integer.parseInt(fPercId.toString()))%>
		<td bgcolor="#000000">
		<div align="center"><font color="#CCCCCC">|</font></div>
		</td>
		<%=WriteMaleBar(Integer.parseInt(mPercId.toString()))%>

		<td>
		<div align="right"><%=mPerc%></div>
		</td>
		<td>
		<div align="right"><%=mNum%></div>
		</td>
		<td>
		<div align="right"><%=LineTotal%></div>
		</td>
		<td>
		<div align="right"><%=LinePerc%></div>
		</td>
	</tr>
	<%

        mPercTotal = mPercTotal.add(mPerc);
        fPercTotal = fPercTotal.add(fPerc);
        mTotal = mTotal.add(mdNum);
        fTotal = fTotal.add(fdNum);
        BigTotalPerc = BigTotalPerc.add(LinePerc);
  } %>
	<tr bgcolor="#CCCCFF">
		<td width="10%">
		<div align="center"><bean:message
			key="oscarReport.oscarReportAgeSex_noroster.msgTotal" /></div>
		</td>
		<td width="8%">
		<div align="right"><%=fTotal.toString().substring(0, fTotal.toString().indexOf("."))%></div>
		</td>
		<td width="8%">
		<div align="right"><%=fPercTotal%></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="2%">
		<div align="center"></div>
		</td>
		<td width="8%">
		<div align="right"><%=mPercTotal%></div>
		</td>
		<td width="8%">
		<div align="right"><%=mTotal.toString().substring(0, mTotal.toString().indexOf("."))%></div>
		</td>
		<td width="8%">
		<div align="right"><%=BigTotal.toString().substring(0, BigTotal.toString().indexOf("."))%></div>
		</td>
		<td width="8%">
		<div align="right"><%=BigTotalPerc%></div>
		</td>
	</tr>
</table>

<% } // reportAction != null %>

<%@ include file="../demographic/zfooterbackclose.jsp"%>
</body>
</html:html>

<%! public String WriteMaleBar(int x){
   String content="";
   try{
	   if (x > 10){x = 10;}
	   for (int i=0;i<x; i++){
         content = content + "<td bgcolor='orange'> <div align='center'><font color='orange'>M<font></div></td>";
	   }
	   for(int j=0;j<10-x;j++){
         content = content +    "<td> <div align='center'></div></td>";
	   }

   }catch(Exception e){
      MiscUtils.getLogger().error("Error", e);
   }
   return content;
   }
public String WriteFemaleBar(int x){
   String content="";
   try{
      if (x > 10){x = 10;}
	   for(int j=0;j<10-x;j++){
         content = content +    "<td> <div align='center'></div></td>";
	   }
	   for (int i=0;i<x; i++){
         content = content + "<td bgcolor='navy blue'> <div align='center'><font color='navy blue'>F<font></div></td>";
	   }

	}catch(Exception e){
      MiscUtils.getLogger().error("Error", e);
   }
   return content;
}

    %>
