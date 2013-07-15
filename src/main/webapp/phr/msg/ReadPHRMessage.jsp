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

<%@page import="oscar.util.DateUtils"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.oscarehr.myoscar_server.ws.MessageTransfer"%>
<%@page import="org.oscarehr.phr.web.MyOscarMessagesHelper"%>
<%@page import="oscar.oscarDemographic.data.*, java.util.Enumeration" %>
<%@page import="oscar.util.UtilDateUtilities,java.util.*" %>
<%@page import="org.oscarehr.phr.util.MyOscarUtils,org.oscarehr.common.model.Demographic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html-el" prefix="html-el" %>

<%
	Long messageId=new Long(request.getParameter("messageId"));
	String demographicNo = request.getParameter("demographicNo");
	MessageTransfer messageTransfer=MyOscarMessagesHelper.readMessage(session, messageId);
%>

<html:html locale="true">
<head>
<link rel="stylesheet" type="text/css" href="../oscarMessenger/encounterStyles.css" media="screen">
<link rel="stylesheet" type="text/css" href="../oscarMessenger/printable.css" media="print">    

<title>
<%-- bean:message key="indivoMessenger.ViewIndivoMessage.title"/--%>View Message
</title>

<script type="text/javascript" src="../share/javascript/Oscar.js"></script>
<script type="text/javascript">
function BackToOscar()
{
       window.close();
}

function gotoEchart3(demoNo) {
    var url = '<%=request.getContextPath()%>/oscarEncounter/IncomingEncounter.do?demographicNo='+ demoNo+'&reason=&appointmentDate=<%=UtilDateUtilities.DateToString(new Date())%>';
    openedWindow = popup(755,1048,url,'apptProvider');
}

</script>

</head>

<body class="BodyStyle" vlink="#0000FF" >

    <table  class="MainTable" id="scrollNumber1" name="encounterTable">
        <tr class="MainTableTopRow">
            <td class="MainTableTopRowLeftColumn">
                <%-- bean:message key="indivoMessenger.ViewIndivoMessage.msgMessenger"/ --%>View Message
            </td>
            <td class="MainTableTopRowRightColumn">
                <table class="TopStatusBar">
                    <tr>
                        <td >
                            <bean:message key="oscarMessenger.ViewMessage.msgViewMessage"/>
                        </td>
                        <td  >
                        </td>
                        <td style="text-align:right">
                                <oscar:help keywords="myoscar message" key="app.top1"/> | <a href="javascript:popupStart(300,400,'About.jsp')" ><bean:message key="global.about"/></a> | <a href="javascript:popupStart(300,400,'License.jsp')" ><bean:message key="global.license"/></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="MainTableLeftColumn">
                &nbsp;
            </td>
            <td class="MainTableRightColumn Printable">
                <table>
                    <tr>
                        <td>
                            <table  cellspacing=3>
                                <tr>
                                    <td>
                                        <table class=messButtonsA cellspacing=0 cellpadding=3 ><tr><td class="messengerButtonsA">
                                            <a href="javascript:window.print()" class="messengerButtons"><bean:message key="oscarMessenger.ViewMessage.btnPrint"/></a>
                                        </td></tr></table>
                                    </td>   
                                  
                                    <td>
                                        <table class=messButtonsA cellspacing=0 cellpadding=3 ><tr><td class="messengerButtonsA">
                                           <a href="#" class="messengerButtons" onclick="history.go(-1)">
                                             Back
                                           </a>
                                        </td></tr></table>
                                    </td>                                    
                                    <td>
                                        <table class=messButtonsA cellspacing=0 cellpadding=3 ><tr><td class="messengerButtonsA">
                                            <a href="javascript:BackToOscar()" class="messengerButtons"><%-- bean:message key="indivoMessenger.ViewMessage.btnExit"/ --%>Exit</a>
                                        </td></tr></table>
                                    </td>                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="Printable">
                            <table border="0" cellspacing="1" valign="top">
                                <tr>
                                    <td class="Printable" bgcolor="#DDDDFF" align="right">
                                    <bean:message key="oscarMessenger.ViewMessage.msgFrom"/>:
                                    </td>
                                    <td class="Printable" bgcolor="#CCCCFF">
                                    	<%=StringEscapeUtils.escapeHtml(messageTransfer.getSenderPersonLastName()+", "+messageTransfer.getSenderPersonFirstName())%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Printable" bgcolor="#DDDDFF" align="right">
                                    <bean:message key="oscarMessenger.ViewMessage.msgTo"/>:
                                    </td>
                                    <td class="Printable" bgcolor="#BFBFFF">
                                    	<%=StringEscapeUtils.escapeHtml(messageTransfer.getRecipientPersonLastName()+", "+messageTransfer.getRecipientPersonFirstName())%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Printable" bgcolor="#DDDDFF" align="right">
                                        <bean:message key="oscarMessenger.ViewMessage.msgSubject"/>:
                                    </td>
                                    <td class="Printable" bgcolor="#BBBBFF">
                                    	<%=StringEscapeUtils.escapeHtml(messageTransfer.getSubject())%>
                                    </td>
                                </tr>
                                <tr>
                                  <td class="Printable" bgcolor="#DDDDFF" align="right">
                                      <bean:message key="oscarMessenger.ViewMessage.msgDate"/>:
                                  </td>
                                  <td  class="Printable" bgcolor="#B8B8FF">
                                   	<%=StringEscapeUtils.escapeHtml(DateUtils.formatDateTime(messageTransfer.getSendDate(), request.getLocale()))%>
                                  </td>
                                </tr>
                                <tr>
                                    
                                    <td bgcolor="#EEEEFF" ></td>
                                    <td bgcolor="#EEEEFF" >
                                        <textarea name="msgBody" wrap="hard" readonly="true" rows="18" cols="60" ><%=StringEscapeUtils.escapeHtml(messageTransfer.getContents())%></textarea><br>
                                        <input class="ControlPushButton" type="button" value="<bean:message key="oscarMessenger.ViewMessage.btnReply"/>" onclick="window.location.href='<%=request.getContextPath()%>/phr/msg/CreatePHRMessage.jsp?replyToMessageId=<%=messageId%>&demographicNo=<%=demographicNo%>'"/>
                                        <%String myOscarUserName=messageTransfer.getSenderPersonUserName();
		                                Demographic demographic=MyOscarUtils.getDemographicByMyOscarUserName(myOscarUserName);
		                                %>
                                        
                                        
                                    	<input 
                                    	<%if (demographic == null){%>
		                                   disabled="disabled"
		                                   title="<bean:message key="global.no.myoscar.account.registered"/>"
		                                <%}%> 
                                    	class="ControlPushButton" type="button" onclick="gotoEchart3('<%=demographicNo%>');" value="<bean:message key="oscarMessenger.CreateMessage.btnOpenEchart"/>" >
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#EEEEFF" ></td>
                                    <td bgcolor="#EEEEFF" >&nbsp;</td>
                                </tr>
                            </table>
                        </td>                        
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="MainTableBottomRowLeftColumn">

            </td>
            <td class="MainTableBottomRowRightColumn">

            </td>
        </tr>
    </table>
</body>

</html:html>
