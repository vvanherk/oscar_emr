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

<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.oscarehr.phr.util.MyOscarUtils"%>
<%@page import="org.oscarehr.phr.PHRAuthentication"%>
<%@page import="org.oscarehr.phr.util.MyOscarMessageManager,org.oscarehr.phr.util.MyOscarServerRelationManager"%>
<%@page import="org.oscarehr.myoscar_server.ws.MessageTransfer"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="oscar.oscarDemographic.data.*,org.oscarehr.common.model.Demographic,org.oscarehr.common.dao.DemographicDao,org.oscarehr.util.SpringUtils" %>
<%@ page import="javax.servlet.http.HttpServletRequest.*" %>
<%@ page import="java.util.Iterator.*" %>
<%@ page import="java.util.Enumeration.*" %>
<%@ page import="org.apache.commons.collections.iterators.*" %>
<%@ page import="oscar.util.UtilDateUtilities,java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html-el" prefix="html-el" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request" />
<%
Demographic demographic= null;
String DemographicNo = null;
String myOscarUserName = null;
PHRAuthentication phrAuthentication=MyOscarUtils.getPHRAuthentication(session);
DemographicDao demographicDao = (DemographicDao) SpringUtils.getBean("demographicDao");

%>
<html:html locale="true">

<head>
    <html:base/>
    <link rel="stylesheet" type="text/css" href="../../oscarMessenger/encounterStyles.css">
<title>
<%--bean:message key="indivoMessenger.CreateIndivoMessage.title"/--%> Create Message
</title>

<style type="text/css">
    td.messengerButtonsA{
    /*background-color: #6666ff;*/
    /*background-color: #6699cc;*/
    background-color: #003399;
    }
    td.messengerButtonsD{
    /*background-color: #84c0f4;*/
    background-color: #555599;
    }
    a.messengerButtons{
    color: #ffffff;
    font-size: 9pt;
    text-decoration: none;
    }
    
    table.messButtonsA{
    border-top: 2px solid #cfcfcf;
    border-left: 2px solid #cfcfcf;
    border-bottom: 2px solid #333333;
    border-right: 2px solid #333333;
    }
    
    table.messButtonsD{
    border-top: 2px solid #333333;
    border-left: 2px solid #333333;
    border-bottom: 2px solid #cfcfcf;
    border-right: 2px solid #cfcfcf;
    }
</style>
<script type="text/javascript" src="../../share/javascript/Oscar.js"></script>
<script type="text/javascript" src="<c:out value="${ctx}"/>/js/jquery.js"></script>
<script language="javascript">

    var browserName=navigator.appName; 
    if (browserName=="Netscape"){ 

        if( document.implementation ){
            //this detects W3C DOM browsers (IE is not a W3C DOM Browser)
            if( Event.prototype && Event.prototype.__defineGetter__ ){
                //this detects Mozilla Based Browsers
                Event.prototype.__defineGetter__( "srcElement", function(){
                    var src = this.target;
                    if( src && src.nodeType == Node.TEXT_NODE )
                        src = src.parentNode;
                        return src;
                    }
                );
            }
        }
    }
    
    function setCpyToChart(){
    	document.getElementById("andPasteToEchart").value = "yes";
    }
    
    var openedWindow = null;
    function gotoEchart2(demoNo,myoscarmsg) {
        var url = '<%=request.getContextPath()%>/oscarEncounter/IncomingEncounter.do?demographicNo='+ demoNo+'&myoscarmsg='+myoscarmsg+'&appointmentDate=<%=UtilDateUtilities.DateToString(new Date())%>';
        openedWindow = popup(755,1048,url,'apptProvider');
    }
    
    function paste2Echart(){
       try{
          var text =document.getElementById('message').value+"\n";
          if( openedWindow.document.forms["caseManagementEntryForm"] != undefined ) {
             openedWindow.pasteToEncounterNote(text);
          }
       }catch (e){
          alert ("ERROR: could not paste to EMR");
       }
    }    
</script>
</head>

<body class="BodyStyle" vlink="#0000FF" >

    <table  class="MainTable" id="scrollNumber1" name="encounterTable">
        <tr class="MainTableTopRow">
            <td class="MainTableTopRowLeftColumn">
                <%-- bean:message key="indivoMessenger.CreateMessage.msgMessenger"/ --%>Create Message
            </td>
            <td class="MainTableTopRowRightColumn">
                <table class="TopStatusBar">
                    <tr>
                        <td >
                            <bean:message key="oscarMessenger.CreateMessage.msgCreate"/>
                        </td>
                        <td  >
                            &nbsp;
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
            <td class="MainTableRightColumn">
                <table >

                    <tr>
                        <td>
                            <table cellspacing=3 >
                                <tr >
                                    <td >
                                        <table class=messButtonsA cellspacing=0 cellpadding=3><tr><td class="messengerButtonsA">
                                            <html:link action="/phr/PhrMessage.do?method=viewMessages" styleClass="messengerButtons">
                                             <bean:message key="oscarMessenger.ViewMessage.btnInbox"/>
                                            </html:link>
                                        </td></tr></table>
                                    </td>
                                    <td >
                                        <table class=messButtonsA cellspacing=0 cellpadding=3><tr><td class="messengerButtonsA">
                                            <a href="javascript:document.forms[0].body.value=''; return false;" class="messengerButtons"><bean:message key="oscarMessenger.CreateMessage.btnClear"/></a>
                                        </td></tr></table>
                                    </td>
                                    <td >
                                        <table class=messButtonsA cellspacing=0 cellpadding=3><tr><td class="messengerButtonsA">
                                            <a href="javascript:window.close()" class="messengerButtons"><bean:message key="oscarMessenger.ViewMessage.btnExit"/></a>
                                        </td></tr></table>
                                    </td>
                                 </tr>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <table> 
                            	<%
                            		Long replyToMessageId=null;
                            		MessageTransfer replyToMessage=null;
                            		try
                            		{
                            			replyToMessageId=new Long(request.getParameter("replyToMessageId"));
                            			
                            			replyToMessage=MyOscarMessageManager.getMessage(phrAuthentication.getMyOscarUserId(), phrAuthentication.getMyOscarPassword(), replyToMessageId);
                            			myOscarUserName=replyToMessage.getSenderPersonUserName();
                                		demographic=MyOscarUtils.getDemographicByMyOscarUserName(myOscarUserName);
                            		}
                            		catch (Exception e)
                            		{
                            			// this is okay, if the request is not a reply this will happen.
                            		}
                            		if (demographic == null){
                            			String demographcNo = request.getParameter("demographicNo");
                            			if(demographcNo != null && !demographcNo.equalsIgnoreCase("null")){
                            				demographic = demographicDao.getDemographic(demographcNo);
                            				myOscarUserName = demographic.getMyOscarUserName();
                            			}
                            		}
                            	%>
                                <html:form action="/phr/PhrMessage">
                                    <tr>
                                        <th align="left" bgcolor="#DDDDFF">
                                            <bean:message key="oscarMessenger.CreateMessage.msgMessage"/>
                                        </th>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#EEEEFF" valign=top>
                                            <table>
                                                <tr>
                                                    <td align="right">To :</td>
                                                    <td>
			                                        	<%
			                                        		if (replyToMessage!=null)
			                                        		{
			                                        			%>
			                                        				<input size="30" readonly="readonly" type="text" value="<%=StringEscapeUtils.escapeHtml(replyToMessage.getSenderPersonLastName()+", "+replyToMessage.getSenderPersonFirstName())%>" />
			                                        			<%
			                                        		}
			                                        		else
			                                        		{
			                                        			%>
			                                                    	<html-el:text readonly="readonly" name="to" property="to" size="30" value="${toName}"/>
			                                        			<%
			                                        		}
			                                        	%>    
			                                        	
			                                        	<%if(demographic!=null){ %>
														<div id="relationshipMessage"></div>    
														<script type="text/javascript">
														$.ajax({
														    url: '../PatientRelationship.jspf?demoNo=<%=demographic.getDemographicNo()%>&myOscarUserName=<%=myOscarUserName%>',
														    dataType: 'html',
														    timeout: 7000,
														    cache: false,
														    error: function() { alert("Error talking to server."); },
														    success: function(data) {
														      $("#relationshipMessage").html(data);
														    }
														  });
														<%}%>
														</script>                                
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right"><bean:message key="oscarMessenger.CreateMessage.formSubject"/> : </td>
                                                    <td>
			                                        	<%
			                                        		if (replyToMessage!=null)
			                                        		{
			                                        			%>
			                                        				<input size="67" readonly="readonly" type="text" value="Re: <%=StringEscapeUtils.escapeHtml(replyToMessage.getSubject())%>" />
			                                        			<%
			                                        		}
			                                        		else
			                                        		{
			                                        			%>
			                                                    	<html-el:text name="subject" property="subject" size="67" value="${subject}"/>
			                                        			<%
			                                        		}
			                                        	%>
                                                    </td>
                                                </tr>
	                                        	<%
	                                        		if (replyToMessage!=null)
	                                        		{
	                                        			%>
		                                                    <tr>
		                                                        <td style="text-align:right;vertical-align:top">Re:</td>
		                                                        <td >
		                                                            <textarea disabled="disabled" readonly="readonly" cols="60" rows="4" style="border: 1px solid black;color:black" ><%=StringEscapeUtils.escapeHtml(replyToMessage.getContents())%></textarea>
		                                                        </td>
		                                                    </tr>
	                                        			<%
	                                        		}
	                                        	%>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td><html:textarea value="" name="body" styleId="message" property="body" cols="60" rows="18"/></td>
                                                        
                                                </tr>
                                            </table>
                                           
                                            <input type="hidden" name="andPasteToEchart" id="andPasteToEchart"/>
                                            <input type="submit" class="ControlPushButton" value="<bean:message key="oscarMessenger.CreateMessage.btnSendMessage"/>" >
	                                     	<%
                                        		if (replyToMessage!=null)
                                        		{
                                        			%>
                                        				<input type="hidden" name="replyToMessageId" value="<%=replyToMessageId%>" />
                                        				<input type="hidden" name="method" value="sendReply" />
                                        				<input type="hidden" name="demographicNo" value="<%=request.getParameter("demographicNo")%>" />
                                        				
                                            			<input type="submit" 
                                            			<%if (demographic == null){%>
		                                   					disabled="disabled"
		                                   					title="<bean:message key="global.no.myoscar.account.registered"/>"
		                                				<%}%> 
                                            				class="ControlPushButton" value="<bean:message key="oscarMessenger.CreateMessage.btnSendMessageCpyToeChart"/>" onclick="setCpyToChart();" >
                                            			<input type="button" 
                                            				<%if (demographic == null){%>
		                                   						disabled="disabled"
		                                   						title="<bean:message key="global.no.myoscar.account.registered"/>"
		                                					<%}%> 
                                            				class="ControlPushButton" value="<bean:message key="oscarMessenger.CreateMessage.btnOpenEchart"/>" onclick="gotoEchart2('<%=request.getParameter("demographicNo")%>','<%=replyToMessageId%>');" />
                                            			<input type="button" 
                                            				<%if (demographic == null){%>
		                                   						disabled="disabled"
		                                   						title="<bean:message key="global.no.myoscar.account.registered"/>"
		                                					<%}%> 
                                            				class="ControlPushButton" value="<bean:message key="oscarMessenger.CreateMessage.btnPasteToEchart"/>" onclick="paste2Echart();"/>
                                        			<%
                                        		}
                                        		else
                                        		{
                                        			%>
			                                            <html-el:hidden property="demographicId" value="${toId}" />
			                                            <html-el:hidden property="method" value="sendPatient" />
                                        			<%
                                        		}
                                        	%>
                                        </td>
                                    </tr>
                                    </html:form>                                                                                                                                                                            
                                </table>                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <script language="JavaScript">
                            document.forms[0].message.focus();
                            </script>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
        <tr>
            <td class="MainTableBottomRowLeftColumn">
            &nbsp;
            </td>
            <td class="MainTableBottomRowRightColumn">
            &nbsp;
            </td>
        </tr>
    </table>
</body>
</html:html>
