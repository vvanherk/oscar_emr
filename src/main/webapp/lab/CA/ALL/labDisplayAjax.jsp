<%@page errorPage="../../../provider/errorpage.jsp" %>
<%@ page import="java.util.*,
		 java.sql.*,
		 java.text.SimpleDateFormat,
		 oscar.oscarDB.*,
		 oscar.util.UtilDateUtilities,
		 oscar.oscarLab.ca.all.*,
		 oscar.oscarLab.ca.all.util.*,org.oscarehr.util.SpringUtils,
		 oscar.oscarLab.ca.all.parsers.*,
		 oscar.oscarLab.LabRequestReportLink,
		 oscar.oscarMDS.data.ReportStatus,oscar.log.*,
         oscar.oscarDB.DBHandler,
         oscar.OscarProperties, 
		 org.apache.commons.codec.binary.Base64,org.oscarehr.common.dao.Hl7TextInfoDao,org.oscarehr.common.model.Hl7TextInfo" %>
<%@page import="org.oscarehr.util.MiscUtils"%>
<%@ page import="org.oscarehr.common.dao.UserPropertyDAO, org.oscarehr.common.model.UserProperty" %>
<%@ page import="org.oscarehr.common.dao.Hl7TextMessageDao, org.oscarehr.common.model.Hl7TextMessage"%>
<%@ page import="oscar.oscarEncounter.oscarMeasurements.dao.*,oscar.oscarEncounter.oscarMeasurements.model.Measurementmap" %>
<%@ page import="org.oscarehr.common.dao.SpireAccessionNumberMapDao" %>
<%@ page import="org.oscarehr.common.model.SpireAccessionNumberMap" %>
<%@ page import="org.oscarehr.common.model.SpireCommonAccessionNumber" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/oscar-tag.tld" prefix="oscar" %>
<%@ taglib uri="/WEB-INF/oscarProperties-tag.tld" prefix="oscarProperties"%>
<%@ taglib uri="/WEB-INF/indivo-tag.tld" prefix="indivo"%>
<%
oscar.OscarProperties props = oscar.OscarProperties.getInstance();
boolean skipComment = false;

String segmentID = request.getParameter("segmentID");
String providerNo = request.getParameter("providerNo");
String searchProviderNo = request.getParameter("searchProviderNo");
String patientMatched = request.getParameter("patientMatched");

UserPropertyDAO userPropertyDAO = (UserPropertyDAO)SpringUtils.getBean("UserPropertyDAO");
UserProperty uProp = userPropertyDAO.getProp(providerNo, UserProperty.LAB_ACK_COMMENT);


if (segmentID != null)
	segmentID = segmentID.trim();

if( uProp != null && uProp.getValue().equalsIgnoreCase("yes")) {
	skipComment = true;
}

String ackLabFunc;
if( skipComment ) {
	ackLabFunc = "handleLab('acknowledgeForm','" + segmentID + "','ackLab');";
}
else {
	ackLabFunc = "getComment('ackLab');";
}

int segmentIDAsInt = 0;
try {
	segmentIDAsInt = Integer.parseInt(segmentID);
} catch (Exception e) {
	MiscUtils.getLogger().error("Unable to parse segmentID to integer: " + segmentID);
}

//Need date lab was received by OSCAR
Hl7TextMessageDao hl7TxtMsgDao = (Hl7TextMessageDao)SpringUtils.getBean("hl7TextMessageDao");
Hl7TextInfoDao hl7TextInfoDao = (Hl7TextInfoDao)SpringUtils.getBean("hl7TextInfoDao");
MeasurementMapDao measurementMapDao = (MeasurementMapDao) SpringUtils.getBean("measurementMapDao");
Hl7TextMessage hl7TextMessage = hl7TxtMsgDao.find(Integer.parseInt(segmentID));
java.util.Date date = hl7TextMessage.getCreated();
String stringFormat = "yyyy-MM-dd HH:mm";
String dateLabReceived = UtilDateUtilities.DateToString(date, stringFormat);

boolean isLinkedToDemographic=false;
ArrayList<ReportStatus> ackList=null;
String multiLabId = "";
List<Hl7TextInfo> olderLabs = hl7TextInfoDao.getMatchingLabsByLabId( Integer.valueOf(segmentID) );
List<MessageHandler> handlers = new ArrayList<MessageHandler>();
Long reqIDL = 0L;
String hl7 = null;
String reqID = null, reqTableID = null;
String demographicID = "";
String remoteFacilityIdQueryString="";


Hl7TextInfo f = olderLabs.get(0);
for (Hl7TextInfo info : olderLabs) {
	//if (f == info) continue;
	
	if (multiLabId.length() > 0)
		multiLabId += ",";
	multiLabId += info.getLabNumber();
}



reqIDL = LabRequestReportLink.getIdByReport("hl7TextMessage",Long.valueOf(segmentID));
reqID = reqIDL==null ? "" : reqIDL.toString();
reqIDL = LabRequestReportLink.getRequestTableIdByReport("hl7TextMessage",Long.valueOf(segmentID));
reqTableID = reqIDL==null ? "" : reqIDL.toString();

String sql = "SELECT demographic_no FROM patientLabRouting WHERE lab_type='HL7' and lab_no='"+segmentID+"';";

ResultSet rs = DBHandler.GetSQL(sql);

while(rs.next()){
    demographicID = oscar.Misc.getString(rs,"demographic_no");
}
rs.close();

if(demographicID != null && !demographicID.equals("")&& !demographicID.equals("0")){
    isLinkedToDemographic=true;
    LogAction.addLog((String) session.getAttribute("user"), LogConst.READ, LogConst.CON_HL7_LAB, segmentID, request.getRemoteAddr(),demographicID);
}else{           
    LogAction.addLog((String) session.getAttribute("user"), LogConst.READ, LogConst.CON_HL7_LAB, segmentID, request.getRemoteAddr());
}



List<String> multiIdList = new ArrayList<String>();
multiIdList.add(segmentID);

String[] multiLabIdAsStrings = multiLabId.split(",");
for (int j=multiLabIdAsStrings.length-1; j >=0; j--) {
	multiIdList.add( multiLabIdAsStrings[j].trim() );
}

ackList = AcknowledgementData.getAcknowledgements(multiIdList);

MessageHandler h = Factory.getHandler(segmentID);

hl7 = Factory.getHL7Body(segmentID);
if (h instanceof OLISHL7Handler) { 
	// What should we do in this instance?
	// Should we do this?: <jsp:forward page="labDisplayOLIS.jsp" />
}
// get info for spire lab
else if (h instanceof SpireHandler) {
	int lab_no = Integer.parseInt(segmentID);
	Hl7TextInfo hl7Lab = hl7TextInfoDao.findLabId(lab_no);

	String accn = hl7Lab.getAccessionNumber();
	// get accession number mappings for spire labs
	SpireAccessionNumberMapDao accnDao = (SpireAccessionNumberMapDao)SpringUtils.getBean("spireAccessionNumberMapDao");
	SpireAccessionNumberMap map = accnDao.getFromCommonAccessionNumber(accn);
	
	if (map != null) {
		List<SpireCommonAccessionNumber> cAccns = map.getCommonAccessionNumbers();
		
		// filter out older versions of labs
		removeDuplicates(cAccns, hl7TextInfoDao, accn, lab_no);
		
		for (SpireCommonAccessionNumber commonAccessionNumber : cAccns) {
			handlers.add( Factory.getHandler(commonAccessionNumber.getLabNo().toString()) );
		}
	} else {
		handlers.add( Factory.getHandler("" + lab_no) );
	}
} else {
	handlers.add( h );
}

if (handlers.size() == 0)
	return;


boolean notBeenAcked = ackList.size() == 0;
boolean ackFlag = false;
String labStatus = "";

Map<String, ReportStatus> acknowledgmentInfo = new HashMap<String, ReportStatus>();

// Compile list of report status' that have a single entry per provider and that use
// reports that are unacknowledged/unfiled over ones that have been acknowledged/filed
// Note: This algorithm will capture the most recent ReportStatus object for an Acknowledged/Filed report
if (ackList != null) {
	for (int i=0; i < ackList.size(); i++) {
		ReportStatus report = (ReportStatus) ackList.get(i);
		ReportStatus r = acknowledgmentInfo.get( report.getProviderName() );
		
		if (r == null) {
			acknowledgmentInfo.put(report.getProviderName(), report);
		} else {
			// Reports that are unacknowledged/unfiled should be used over ones that have been acknowledged/filed
			if (!report.getStatus().equals("A") && !report.getStatus().equals("F") && (r.getStatus().equals("A") || r.getStatus().equals("F"))) {
				acknowledgmentInfo.put(report.getProviderName(), report);
			} else if (r.getStatus().equals("A") || r.getStatus().equals("F")) {
				// Use the most recent date for an Acknowledged/Filed report
				String t1 = report.getTimestamp();
				String t2 = r.getTimestamp();
				
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MMM-dd HH:mm", Locale.ENGLISH);
				java.util.Date date1 = df.parse(t1);
				java.util.Date date2 = df.parse(t2);
				
				if (date1.getTime() > date2.getTime())
					acknowledgmentInfo.put(report.getProviderName(), report);
			}
			
			
		}
	}
}

// Determine whether this lab (and all its parts) has been acknowledged
for (Map.Entry<String, ReportStatus> entry : acknowledgmentInfo.entrySet()) {
	ReportStatus report = entry.getValue();
	if (report.getProviderNo().equals(providerNo) ) {
		String ackStatus = report.getStatus();
		
		if( ackStatus.equals("A") ){        
			ackFlag = true; //lab has been ack by this provider.
			break;
		}
	}
    
}


int lab_no = Integer.parseInt(segmentID);
Hl7TextInfo hl7Lab = hl7TextInfoDao.findLabId(lab_no);
String label = "";
if (hl7Lab.getLabel()!=null) label = hl7Lab.getLabel();



// check for errors printing
if (request.getAttribute("printError") != null && (Boolean) request.getAttribute("printError")){
%>
<script language="JavaScript">
    alert("The lab could not be printed due to an error. Please see the server logs for more detail.");
</script>
<%}
%>
<script type="text/javascript" src="<%= request.getContextPath() %>/share/javascript/jquery/jquery-1.4.2.js"></script>
      
                <script language="JavaScript">
         popupStart=function(vheight,vwidth,varpage,windowname) {
            var page = varpage;
            windowprops = "height="+vheight+",width="+vwidth+",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes";
            var popup=window.open(varpage, windowname, windowprops);
        }
         getComment=function(labid) {
            var ret = true;
            var commentVal = prompt('<bean:message key="oscarMDS.segmentDisplay.msgComment"/>', '');

            if( commentVal == null ||commentVal.length==0)
                ret = false;
            else{
                document.forms['acknowledgeForm_'+labid].comment.value = commentVal;
            }
            if(ret)
                handleLab('acknowledgeForm_'+labid,labid,'ackLab');

            return ret;
        }

         printPDF=function(doclabid){
            document.forms['acknowledgeForm_'+doclabid].action="../lab/CA/ALL/PrintPDF.do";
            document.forms['acknowledgeForm_'+doclabid].submit();
        }

	 linkreq=function(rptId, reqId) {
	    var link = "../lab/LinkReq.jsp?table=hl7TextMessage&rptid="+rptId+"&reqid="+reqId;
	    window.open(link, "linkwin", "width=500, height=200");
	}

         sendToPHR=function(labId, demographicNo) {
            popup(300, 600, "<%=request.getContextPath()%>/phr/SendToPhrPreview.jsp?labId=" + labId + "&demographic_no=" + demographicNo, "sendtophr");
        }
        popupStart=function(vheight,vwidth,varpage,windowname) {
            var windowprops = "height="+vheight+",width="+vwidth+",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes";
            var popup=window.open(varpage, windowname, windowprops);
        }
        handleLab=function(formid,labid,action){
            var url='../dms/inboxManage.do';
                                           var data='method=isLabLinkedToDemographic&labid='+labid;
                                           new Ajax.Request(url, {method: 'post',parameters:data,onSuccess:function(transport){
                                                                    var json=transport.responseText.evalJSON();
                                                                    if(json!=null){
                                                                        var success=json.isLinkedToDemographic;
                                                                        var demoid='';
                                                                        //check if lab is linked to a provider
                                                                        if(success){
                                                                            if(action=='ackLab'){
                                                                                if(confirmAck()){
                                                                                    updateStatus(formid);
                                                                                }
                                                                            }else if(action=='msgLab'){
                                                                                demoid=json.demoId;
                                                                                if(demoid!=null && demoid.length>0) 
                                                                                    window.popup(700,960,'../oscarMessenger/SendDemoMessage.do?demographic_no='+demoid,'msg');
                                                                            }else if(action=='ticklerLab'){
                                                                                demoid=json.demoId;
                                                                                if(demoid!=null && demoid.length>0) 
                                                                                    window.popup(450,600,'../tickler/ForwardDemographicTickler.do?docType=HL7&docId='+labid+'&demographic_no='+demoid,'tickler')
                                                                            }
                                                                            
                                                                        }else{
                                                                            if(action=='ackLab'){
                                                                                if(confirmAckUnmatched())
                                                                                    updateStatus(formid);
                                                                                else{
                                                                                    var pn=$("demoName"+labid).value;
                                                                                    if(pn) popupStart(360, 680, '../oscarMDS/SearchPatient.do?labType=HL7&segmentID='+labid+'&name='+pn, 'searchPatientWindow');
                                                                                }
                                                                            }else{
                                                                                alert("Please relate lab to a demographic.");
                                                                                //pop up relate demo window
                                                                                var pn=$("demoName"+labid).value;
                                                                                if(pn) popupStart(360, 680, '../oscarMDS/SearchPatient.do?labType=HL7&segmentID='+labid+'&name='+pn, 'searchPatientWindow');
                                                                            }
                                                                        }
                                                                    }
                                                            }});
        }
       function confirmAck(){
		<% if (props.getProperty("confirmAck", "").equals("yes")) { %>
            		return confirm('<bean:message key="oscarMDS.index.msgConfirmAcknowledge"/>');
            	<% } else { %>
            		return true;
            	<% } %>
	}
        confirmAckUnmatched=function(){
            return confirm('<bean:message key="oscarMDS.index.msgConfirmAcknowledgeUnmatched"/>');
        }
        updateStatus=function(formid){
            var url='<%=request.getContextPath()%>'+"/oscarMDS/UpdateStatus.do";
            var data=$(formid).serialize(true);

            new Ajax.Request(url,{method:'post',parameters:data,onSuccess:function(transport){
                    var num=formid.split("_");
                 if(num[1]){
                     Effect.BlindUp('labdoc_'+num[1]);
                     updateDocLabData(num[1]);

                }
        }});

        }
        
        createTdisLabel=function(tdisformid,ackformid,labelspanid,labelid){
        	document.forms[tdisformid].label.value = document.forms[ackformid].label.value;
        	var url = '<%=request.getContextPath()%>'+"/lab/CA/ALL/createLabelTDIS.do";
        	var data=$(tdisformid).serialize(true);
        	new Ajax.Request(url,{method:'post', parameters:data
        		
        	});
        	document.getElementById(labelspanid).innerHTML= "<i> Label: "+document.getElementById(labelid).value+"</i>";
        	document.getElementById(labelid).value="";
        	
        };
        </script>

<style>

.TDISRes	{font-weight: bold; font-size: 10pt; color: black; font-family: 
               Verdana, Arial, Helvetica}

</style>
    <div id="labdoc_<%=segmentID%>">
        <!-- form forwarding of the lab -->
        <form name="reassignForm_<%=segmentID%>" >
            <input type="hidden" name="flaggedLabs" value="<%= segmentID %>" />
            <input type="hidden" name="selectedProviders" value="" />
            <input type="hidden" name="labType" value="HL7" />
            <input type="hidden" name="labType<%= segmentID %>HL7" value="imNotNull" />
            <input type="hidden" name="providerNo" value="<%= providerNo %>" />
            <input type="hidden" name="ajax" value="yes" />
        </form>
        <form name="TDISLabelForm" id="TDISLabelForm<%=segmentID%>" method='POST' onsubmit="createTdisLabel('TDISLabelForm<%=segmentID%>');" action="javascript:void(0);">
			<input type="hidden" id="labNum" name="lab_no" value="<%=lab_no%>">
			<input type="hidden" id="label" name="label" value="<%=label%>">
		</form>
        <form name="acknowledgeForm" id="acknowledgeForm_<%=segmentID%>" onsubmit="javascript:void(0);" method="post" action="javascript:void(0);">
            
            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr>
                                <td align="left" class="MainTableTopRowRightColumn" width="100%">
                                    <input type="hidden" name="segmentID" value="<%= segmentID %>"/>
                                    <input type="hidden" name="multiID" value="<%= multiLabId %>" />
                                    <input type="hidden" name="providerNo" value="<%= providerNo %>"/>
                                    <input type="hidden" name="status" value="A"/>
                                    <input type="hidden" name="comment" value=""/>
                                    <input type="hidden" name="labType" value="HL7"/>
                                    <input type="hidden" name="ajaxcall" value="yes"/>
                                    <input type="hidden" id="demoName<%=segmentID%>" value="<%=java.net.URLEncoder.encode(handlers.get(0).getLastName()+", "+handlers.get(0).getFirstName())%>"/>
                                    <% if ( !ackFlag ) { %>
                                    <input type="button" value="<bean:message key="oscarMDS.segmentDisplay.btnAcknowledge"/>" onclick="handleLab('acknowledgeForm_<%=segmentID%>','<%=segmentID%>','ackLab');">
                                    <input type="button" value="<bean:message key="oscarMDS.segmentDisplay.btnComment"/>" onclick="return getComment('<%=segmentID%>');">
                                    <% } %>
                                    <input type="button" class="smallButton" value="<bean:message key="oscarMDS.index.btnForward"/>" onClick="popupStart(300, 400, '../oscarMDS/SelectProviderAltView.jsp?doc_no=<%=segmentID%>&providerNo=<%=providerNo%>&searchProviderNo=<%=searchProviderNo%>', 'providerselect')">
                                    <input type="button" value=" <bean:message key="global.btnPrint"/> " onClick="printPDF('<%=segmentID%>')">

                                    <input type="button" value="Msg" onclick="handleLab('','<%=segmentID%>','msgLab');"/>
                                    <input type="button" value="Tickler" onclick="handleLab('','<%=segmentID%>','ticklerLab');"/>

                                    <% if ( searchProviderNo != null ) { // null if we were called from e-chart%>
                                    <input type="button" value=" <bean:message key="oscarMDS.segmentDisplay.btnEChart"/> " onClick="popupStart(360, 680, '../oscarMDS/SearchPatient.do?labType=HL7&segmentID=<%= segmentID %>&name=<%=java.net.URLEncoder.encode(handlers.get(0).getLastName()+", "+handlers.get(0).getFirstName())%>', 'searchPatientWindow')">
                                    <% } %>
				    <input type="button" value="Req# <%=reqTableID%>" title="Link to Requisition" onclick="linkreq('<%=segmentID%>','<%=reqID%>');" />
                                    <% if (!label.equals(null) && !label.equals("")) { %>
				<button type="button" id="createLabel" value="Label" onClick="createTdisLabel('TDISLabelForm<%=segmentID%>','acknowledgeForm_<%=segmentID%>','labelspan_<%=segmentID%>','label_<%=segmentID%>')">Label</button>
				<%} else { %>
				<button type="button" id="createLabel" style="background-color:#6699FF" value="Label" onClick="createTdisLabel('TDISLabelForm<%=segmentID%>','acknowledgeForm_<%=segmentID%>','labelspan_<%=segmentID%>','label_<%=segmentID%>')">Label</button>
				<%} %>
                 <input type="text" id="label_<%=segmentID%>" name="label" value=""/>
                 <% String labelval="";
                 if (label!="" && label!=null) {
                 	labelval = label;
                 }else {
                	 labelval = "(not set)";
                 	
                 } %>
                 <span id="labelspan_<%=segmentID%>" class="Field2"><i>Label: <%=labelval%> </i></span>
                                    <span class="Field2"><i>Next Appointment: <oscar:nextAppt demographicNo="<%=demographicID%>"/></i></span>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" border="1" cellspacing="0" cellpadding="3" bgcolor="#9999CC" bordercolordark="#bfcbe3">
                            <%
                            if (multiLabId != null){
								// Only print the top version information if the lab is not a spire lab or it has only 1 lab
								if (handlers.size() == 1 || !(handlers.get(0) instanceof SpireHandler)) {
	                                String[] multiID = multiLabId.split(",");
	                                if (multiID.length > 1){
	                                    %>
	                                    <tr>
	                                        <td class="Cell" colspan="2" align="middle">
	                                            <div class="Field2">
	                                                Version:&#160;&#160;
	                                                <%
	                                                for (int i=0; i < multiID.length; i++){
	                                                    if (multiID[i].equals(segmentID)){
	                                                        %>v<%= i+1 %>&#160;<%
	                                                    }else{
	                                                        if ( searchProviderNo != null ) { // null if we were called from e-chart
	                                                            %><a href="labDisplay.jsp?segmentID=<%=multiID[i]%>&multiID=<%=multiLabId%>&providerNo=<%= providerNo %>&searchProviderNo=<%= searchProviderNo %>">v<%= i+1 %></a>&#160;<%
	                                                        }else{
	                                                            %><a href="labDisplay.jsp?segmentID=<%=multiID[i]%>&multiID=<%=multiLabId%>&providerNo=<%= providerNo %>">v<%= i+1 %></a>&#160;<%
	                                                        }
	                                                    }
	                                                }
	                                                %>
	                                            </div>
	                                        </td>
	                                    </tr>
	                                    <%
									}
								}
                            }
                            %>
                            <tr>
                                <td width="66%" align="middle" class="Cell">
                                    <div class="Field2">
                                        <bean:message key="oscarMDS.segmentDisplay.formDetailResults"/>
                                    </div>
                                </td>
                                <td width="33%" align="middle" class="Cell">
                                    <div class="Field2">
                                        <bean:message key="oscarMDS.segmentDisplay.formResultsInfo"/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="white" valign="top">
                                    <table valign="top" border="0" cellpadding="2" cellspacing="0" width="100%">
                                        <tr valign="top">
                                            <td valign="top" width="33%" align="left">
                                                <table width="100%" border="0" cellpadding="2" cellspacing="0" valign="top">
                                                    <tr>
                                                        <td valign="top" align="left">
                                                            <table width="100%" border="0" cellpadding="2" cellspacing="0" valign="top"  <% if ( demographicID.equals("") || demographicID.equals("0")){ %> bgcolor="orange" <% } %> id="DemoTable<%=segmentID%>" >
                                                                <tr>
                                                                    <td nowrap>
                                                                        <div class="FieldData">
                                                                            <strong><bean:message key="oscarMDS.segmentDisplay.formPatientName"/>: </strong>
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div class="FieldData" nowrap="nowrap">
                                                                            <% if ( searchProviderNo == null ) { // we were called from e-chart
                                                                                %>
                                                                            <a href="javascript:window.close()"> <% } else { // we were called from lab module
    %></a>
                                                                            <a href="javascript:popupStart(360, 680, '../oscarMDS/SearchPatient.do?labType=HL7&segmentID=<%= segmentID %>&name=<%=java.net.URLEncoder.encode(handlers.get(0).getLastName()+", "+handlers.get(0).getFirstName())%>', 'searchPatientWindow')">
                                                                                <% } %>
                                                                                <%=handlers.get(0).getPatientName()%>
                                                                            </a>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td nowrap>
                                                                        <div class="FieldData">
                                                                            <strong><bean:message key="oscarMDS.segmentDisplay.formDateBirth"/>: </strong>
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div class="FieldData" nowrap="nowrap">
                                                                            <%=handlers.get(0).getDOB()%>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td nowrap>
                                                                        <div class="FieldData">
                                                                            <strong><bean:message key="oscarMDS.segmentDisplay.formAge"/>: </strong>
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div class="FieldData">
                                                                            <%=handlers.get(0).getAge()%>
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div class="FieldData">
                                                                            <strong><bean:message key="oscarMDS.segmentDisplay.formSex"/>: </strong>
                                                                        </div>
                                                                    </td>
                                                                    <td align="left" nowrap>
                                                                        <div class="FieldData">
                                                                            <%=handlers.get(0).getSex()%>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td nowrap>
                                                                        <div class="FieldData">
                                                                            <strong>
                                                                                <bean:message key="oscarMDS.segmentDisplay.formHealthNumber"/>
                                                                            </strong>
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div class="FieldData" nowrap="nowrap">
                                                                            <%=handlers.get(0).getHealthNum()%>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td width="33%" valign="top">
                                                            <table valign="top" border="0" cellpadding="3" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td nowrap>
                                                                        <div align="left" class="FieldData">
                                                                            <strong><bean:message key="oscarMDS.segmentDisplay.formHomePhone"/>: </strong>
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div align="left" class="FieldData" nowrap="nowrap">
                                                                            <%=handlers.get(0).getHomePhone()%>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td nowrap>
                                                                        <div align="left" class="FieldData">
                                                                            <strong><bean:message key="oscarMDS.segmentDisplay.formWorkPhone"/>: </strong>
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div align="left" class="FieldData" nowrap="nowrap">
                                                                            <%=handlers.get(0).getWorkPhone()%>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td nowrap>
                                                                        <div align="left" class="FieldData" nowrap="nowrap">
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div align="left" class="FieldData" nowrap="nowrap">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td nowrap>
                                                                        <div align="left" class="FieldData">
                                                                            <strong><bean:message key="oscarMDS.segmentDisplay.formPatientLocation"/>: </strong>
                                                                        </div>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <div align="left" class="FieldData" nowrap="nowrap">
                                                                            <%=handlers.get(0).getPatientLocation()%>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td bgcolor="white" valign="top">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="1">
                                        <tr>
                                            <td>
                                                <div class="FieldData">
                                                    <strong><bean:message key="oscarMDS.segmentDisplay.formDateService"/>:</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="FieldData" nowrap="nowrap">
                                                    <%= handlers.get(0).getServiceDate() %>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="FieldData">
                                                    <strong><bean:message key="oscarMDS.segmentDisplay.formReportStatus"/>:</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="FieldData" nowrap="nowrap">
                                                    <%= ( (String) ( handlers.get(0).getOrderStatus().equals("F") ? "Final" : handlers.get(0).getOrderStatus().equals("C") ? "Corrected" : "Partial") )%>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td nowrap>
                                                <div class="FieldData">
                                                    <strong><bean:message key="oscarMDS.segmentDisplay.formClientRefer"/>:</strong>
                                                </div>
                                            </td>
                                            <td nowrap>
                                                <div class="FieldData" nowrap="nowrap">
                                                    <%= handlers.get(0).getClientRef()%>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="FieldData">
                                                    <strong><bean:message key="oscarMDS.segmentDisplay.formAccession"/>:</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="FieldData" nowrap="nowrap">
                                                    <%= handlers.get(0).getAccessionNum()%>
                                                </div>
                                            </td>
                                        </tr>
                                        <% if (handlers.get(0).getMsgType().equals("MEDVUE")) {  %>
                                        <tr>
                                        	<td>
                                                <div class="FieldData">
                                                    <strong>MEDVUE Encounter Id:</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="FieldData" nowrap="nowrap">
                                                   <%= handlers.get(0).getEncounterId() %>                                        
                                                </div>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="white" colspan="2">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
                                        <tr>
                                            <td bgcolor="white">
                                                <div class="FieldData">
                                                    <strong><bean:message key="oscarMDS.segmentDisplay.formRequestingClient"/>: </strong>
                                                    <%= handlers.get(0).getDocName()%>
                                                </div>
                                            </td>
                                            
                                            <td bgcolor="white" align="right">
                                                <div class="FieldData">
                                                    <strong><bean:message key="oscarMDS.segmentDisplay.formCCClient"/>: </strong>
                                                    <%= handlers.get(0).getCCDocs()%>

                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" bgcolor="white" colspan="2">
                                    <%String[] multiID = multiLabId.split(",");
                                    ReportStatus report;          
                                    boolean startFlag = false;
                                    for (int j=multiID.length-1; j >=0; j--){
                                        ackList = AcknowledgementData.getAcknowledgements(multiID[j].trim());
                                        if (multiID[j].trim().equals(segmentID))
                                            startFlag = true;                                                              
                                        if (startFlag) {
                                            //if (ackList.size() > 0){{%>
                                                <table width="100%" height="20" cellpadding="2" cellspacing="2">
                                                    <tr>
                                                        <% if (multiID.length > 1){ %>
                                                            <td align="center" bgcolor="white" width="20%" valign="top">
                                                                <div class="FieldData">
                                                                    <b>Version:</b> v<%= j+1 %>
                                                                </div>
                                                            </td>
                                                            <td align="left" bgcolor="white" width="80%" valign="top">
                                                        <% }else{ %>
                                                            <td align="center" bgcolor="white">
                                                        <% } %>
                                                            <div class="FieldData">
                                                                <!--center-->          
                                                                    <%	                                                                        
                                                                        for (Map.Entry<String, ReportStatus> entry : acknowledgmentInfo.entrySet()) {
																	        String providerName = entry.getKey();
																		    report = entry.getValue();
																		    String ackStatus = report.getStatus();
																		%>
																			<%= providerName %> :
																			
																		<%	
                                                                            if (ackStatus.equals("A")) {
                                                                                ackStatus = "Acknowledged"; 
                                                                            } else if (ackStatus.equals("F")) {
                                                                                ackStatus = "Filed but not Acknowledged";
                                                                            } else {
                                                                                ackStatus = "Not Acknowledged";
                                                                            }                                                                             
                                                                        %>
																			<font color="red"><%= ackStatus %></font>
	                                                                        <% if ( ackStatus.equals("Acknowledged") ) { %>
	                                                                            <%= report.getTimestamp() %>,                                                                             
	                                                                        <% } %>
	                                                                        <span id="<%=report.getProviderNo()%>commentLabel"><%=report.getComment().equals("") ? "no comment" : "comment : "%></span><span id="<%=report.getProviderNo()%>commentText"><%=report.getComment()%></span>
	                                                                        <br>
																			
																		<%
																	    
                                                                        %>

                                                                    <% } 
                                                                    if (ackList.size() == 0){
                                                                        %><font color="red">N/A</font><%
                                                                    }
                                                                    %>
                                                                <!--/center-->
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>

                                            <%//}
                                        }
                                    }%>
                                </td>
                            </tr>
                        </table>


                        <% int i=0;
                        int j=0;
                        int k=0;
                        int l=0;
                        int linenum=0;
                        String highlight = "#E0E0FF";

						// Render all labs in the handlers list
                        for (MessageHandler handler : handlers) {

	                        ArrayList headers = handler.getHeaders();
	                        int OBRCount = handler.getOBRCount();
	                        if (handler.getMsgType().equals("MEDVUE")) { %>
	                        <table style="page-break-inside:avoid;" bgcolor="#003399" border="0" cellpadding="0" cellspacing="0" width="100%">
	                           <tr>
	                               <td colspan="4" height="7">&nbsp;</td>
	                           </tr>
	                           <tr>
	                               <td bgcolor="#FFCC00" width="300" valign="bottom">
	                                   <div class="Title2">
	                                      <%=headers.get(0)%>
	                                   </div>
	                               </td>
	                               <%--<td align="right" bgcolor="#FFCC00" width="100">&nbsp;</td>--%>
	                               <td width="9">&nbsp;</td>
	                               <td width="9">&nbsp;</td>
	                               <td width="*">&nbsp;</td>
	                           </tr>
	                       </table>
	                       <table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#CCCCFF" bordercolor="#9966FF" bordercolordark="#bfcbe3" name="tblDiscs" id="tblDiscs">
	                           <tr class="Field2">
	                               <td width="25%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formTestName"/></td>
	                               <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formResult"/></td>
	                               <td width="5%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formAbn"/></td>
	                               <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formReferenceRange"/></td>
	                               <td width="10%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formUnits"/></td>
	                               <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formDateTimeCompleted"/></td>
	                               <td width="6%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formNew"/></td>
	                           </tr>
		                        <tr class="TDISRes">
			                      	<td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><b>Radiologist: </b><b><%=handler.getRadiologistInfo()%></b></pre></td>
			                      	</td>
		                     	 </tr>
		                        <tr class="TDISRes">
			                       	<td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><b><%=handler.getOBXComment(1, 1, 1)%></b></pre></td>
			                       	</td>
		                      	 </tr>
	                     	 </table>
	                     <% } else {
								// show spire lab version number
								if (handler.getMsgType().equals("Spire")) {
									List<Hl7TextInfo> textInfoList = hl7TextInfoDao.getMatchingLabsByAccessionNumber( handler.getAccessionNum() );
		                            if (textInfoList != null && textInfoList.size() > 1) {
	                                    %>
	                                    
	                                            <div class="Cell Field2" style="text-align:center">
	                                                Version:&#160;&#160;
	                                                <%
	                                                int version = 1;
	                                                String newLabText = "";
													for (Hl7TextInfo info : textInfoList) {
														newLabText = "";
														
														for (int m=0; m < ackList.size(); m++) {
															report = (ReportStatus) ackList.get(m);
															int segId = Integer.parseInt(report.getSegmentID().trim());
															String ackStatus = report.getStatus(); 
															
															if (segId == info.getLabNumber() && !ackStatus.equals("A") && !ackStatus.equals("F") && report.getProviderNo().equals(providerNo)) {
																newLabText = "<span style='color:red;'> NEW </span>";
															}
														}
														
	                                                    if (info.getLabNumber() == segmentIDAsInt) {
	                                                        %>v<%= version %><%=newLabText%>&#160;<%
	                                                    } else {
	                                                        if ( searchProviderNo != null ) { // null if we were called from e-chart
	                                                            %><a href="labDisplay.jsp?segmentID=<%=info.getLabNumber()%>&providerNo=<%= providerNo %>&searchProviderNo=<%= searchProviderNo %>">v<%= version %></a><%=newLabText%>&#160;<%
	                                                        }else{
	                                                            %><a href="labDisplay.jsp?segmentID=<%=info.getLabNumber()%>&providerNo=<%= providerNo %>">v<%= version %></a><%=newLabText%>&#160;<%
	                                                        }
	                                                    }
	                                                    
	                                                    version++;
	                                                }
	                                                %>
	                                            </div>
	                                    
	                                    <%
	                                }
	                            %>
							<% }
	                   	  
	                        
	                        for(i=0;i<headers.size();i++){
	                            linenum=0;
	                        %>
	                        <table style="page-break-inside:avoid;" bgcolor="#003399" border="0" cellpadding="0" cellspacing="0" width="100%">
	                            <tr>
	                                <td colspan="4" height="7">&nbsp;</td>
	                            </tr>
	                            <tr>
	                                <td bgcolor="#FFCC00" width="300" valign="bottom">
	                                    <div class="Title2">
	                                        <%=headers.get(i)%>
	                                    </div>
	                                </td>
	                                <%--<td align="right" bgcolor="#FFCC00" width="100">&nbsp;</td>--%>
	                                <td width="9">&nbsp;</td>
	                                <td width="9">&nbsp;</td>
	                                <td width="*">&nbsp;</td>
	                            </tr>
	                        </table>
	
	                        <table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#CCCCFF" bordercolor="#9966FF" bordercolordark="#bfcbe3" name="tblDiscs" id="tblDiscs">
	                            <tr class="Field2">
	                                <td width="25%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formTestName"/></td>
	                                <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formResult"/></td>
	                                <td width="5%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formAbn"/></td>
	                                <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formReferenceRange"/></td>
	                                <td width="10%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formUnits"/></td>
	                                <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formDateTimeCompleted"/></td>
	                                <td width="6%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formNew"/></td>
	                            </tr>
	
	                            <%
	                            
	                            for ( j=0; j < OBRCount; j++){
	
	                                boolean obrFlag = false;
	                                int obxCount = handler.getOBXCount(j);
	                              
	                                for (k=0; k < obxCount; k++){
	                                    String obxName = handler.getOBXName(j, k);
	                                     boolean b2 = !obxName.equals(""), b3=handler.getObservationHeader(j, k).equals(headers.get(i));
	                                    if (handler.getMsgType().equals("EPSILON")) { 
	                                    	b2=true; b3=true;
	                                    } else if(handler.getMsgType().equals("PFHT")) {
	                                    	b2=true;
	                                    }
	                                    if ( !handler.getOBXResultStatus(j, k).equals("DNS") && b2 && b3){ // <<--  DNS only needed for MDS messages
	                                        String obrName = handler.getOBRName(j);
	                                        if(!obrFlag && !obrName.equals("") && !(obxName.contains(obrName) && obxCount < 2)){%>
	                                           <%--  <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" >
	                                                <td valign="top" align="left"><%=obrName%></td>
	                                                <td colspan="6">&nbsp;</td>
	                                            </tr> --%>
	                                            <%obrFlag = true;
	                                        }
	
	                                        String lineClass = "NormalRes";
	                                        String abnormal = handler.getOBXAbnormalFlag(j, k);
	                                        if ( abnormal != null && abnormal.startsWith("L")){
	                                            lineClass = "HiLoRes";
	                                        } else if ( abnormal != null && ( abnormal.equals("A") || abnormal.startsWith("H") || handler.isOBXAbnormal( j, k) ) ){
	                                            lineClass = "AbnormalRes";
	                                        }%>
	                                        <%if (handler.getMsgType().equals("EPSILON")) {
		                                    	   if (handler.getOBXIdentifier(j,k).equals(headers.get(i)) && !obxName.equals("")) { %>
			                                    	
		                                        	<tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="<%=lineClass%>">
			                                            <td valign="top" align="left"><%= obrFlag ? "&nbsp; &nbsp; &nbsp;" : "&nbsp;" %><a href="javascript:popupStart('660','900','../lab/CA/ON/labValues.jsp?testName=<%=obxName%>&demo=<%=demographicID%>&labType=HL7&identifier=<%= handler.getOBXIdentifier(j, k) %>')"><%=obxName %></a></td>                                         
			                                            <td align="right"><%= handler.getOBXResult( j, k) %></td>
			                                           
			                                            <td align="center">
			                                                    <%= handler.getOBXAbnormalFlag(j, k)%>
			                                            </td>
			                                            <td align="left"><%=handler.getOBXReferenceRange( j, k)%></td>
			                                            <td align="left"><%=handler.getOBXUnits( j, k) %></td>
			                                            <td align="center"><%= handler.getTimeStamp(j, k) %></td>
			                                            <td align="center"><%= handler.getOBXResultStatus( j, k) %></td>
		                                       		</tr> 
		                                       <% } else if (handler.getOBXIdentifier(j,k).equals(headers.get(i)) && obxName.equals("")) { %>
		                                       			<tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="NormalRes">
		                                                    <td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><%=handler.getOBXResult( j, k)%></pre></td>
		                                                </tr>
		                                       	<% }
	                                        } else if (handler.getMsgType().equals("PFHT") || handler.getMsgType().equals("HHSEMR")) {
		                                    	   if (!obxName.equals("")) { %>
			                                    		<tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="<%=lineClass%>">
				                                            <td valign="top" align="left"><%= obrFlag ? "&nbsp; &nbsp; &nbsp;" : "&nbsp;" %><a href="javascript:popupStart('660','900','../lab/CA/ON/labValues.jsp?testName=<%=obxName%>&demo=<%=demographicID%>&labType=HL7&identifier=<%= handler.getOBXIdentifier(j, k) %>')"><%=obxName %></a></td>                                         
				                                            <td align="right"><%= handler.getOBXResult( j, k) %></td>
				                                           
				                                            <td align="center">
				                                                    <%= handler.getOBXAbnormalFlag(j, k)%>
				                                            </td>
				                                            <td align="left"><%=handler.getOBXReferenceRange( j, k)%></td>
				                                            <td align="left"><%=handler.getOBXUnits( j, k) %></td>
				                                            <td align="center"><%= handler.getTimeStamp(j, k) %></td>
				                                            <td align="center"><%= handler.getOBXResultStatus( j, k) %></td>
			                                       		 </tr> 
				                                       
		                                    	 	<%} else { %>
		                                    		   <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="NormalRes">
		      	                                     <td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><%=handler.getOBXResult( j, k)%></pre></td>
		      	                                	 </tr>
		                                    	 	<%}
			                                    	if (!handler.getNteForOBX(j,k).equals("") && handler.getNteForOBX(j,k)!=null) { %> 
				                                       <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="NormalRes">
				                                       		<td valign="top" align="left"colspan="8"><pre  style="margin:0px 0px 0px 100px;"><%=handler.getNteForOBX(j,k)%></pre></td>
				                                       </tr>
				                                    <% } 
					                                for (l=0; l < handler.getOBXCommentCount(j, k); l++){%>
					                                     <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="NormalRes">
					                                        <td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><%=handler.getOBXComment(j, k, l)%></pre></td>
					                                     </tr>  
					                                <%} 
					                                
					                                
		                                       } else if ((!handler.getOBXResultStatus(j, k).equals("TDIS") && handler.getMsgType().equals("Spire")) )  { %>
												<tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="<%=lineClass%>">
	                                           <td valign="top" align="left"><%= obrFlag ? "&nbsp; &nbsp; &nbsp;" : "&nbsp;" %><a href="javascript:popupStart('660','900','../lab/CA/ON/labValues.jsp?testName=<%=obxName%>&demo=<%=demographicID%>&labType=HL7&identifier=<%= handler.getOBXIdentifier(j, k) %>')"><%=obxName %></a>                                         
	                                           &nbsp; </td>
	                                           <% 	if (handler.getOBXResult( j, k).length() > 20) {
														%>
														
														<td align="left" colspan="4"><%= handler.getOBXResult( j, k) %></td>
	                                          
														<% 	String abnormalFlag = handler.getOBXAbnormalFlag(j, k);
															if (abnormalFlag != null && abnormalFlag.length() > 0) {
														 %>
			                                           <td align="center">
			                                                   <%= abnormalFlag%>
			                                           </td>
			                                           <% } %>
			                                           
			                                           <% 	String refRange = handler.getOBXReferenceRange(j, k);
															if (refRange != null && refRange.length() > 0) {
														 %>
			                                           <td align="left"><%=refRange%></td>
			                                           <% } %>
			                                           
			                                           <% 	String units = handler.getOBXUnits(j, k);
															if (units != null && units.length() > 0) {
														 %>
			                                           <td align="left"><%=units %></td>
			                                           <% } %>
													<%
													} else {
													%>
													   <td align="right" colspan="1"><%= handler.getOBXResult( j, k) %></td>                                          
			                                           <td align="center"> <%= handler.getOBXAbnormalFlag(j, k)%> </td>
			                                           <td align="left"> <%=handler.getOBXReferenceRange(j, k)%> </td>
			                                           <td align="left"> <%=handler.getOBXUnits(j, k) %> </td>													
													<% 
													} 
													%>
	                                           
	                                           <td align="center"><%= handler.getTimeStamp(j, k) %></td>
	                                           <td align="center"><%= handler.getOBXResultStatus(j, k) %></td>
	                                       </tr> 
	                                     
	                                       <%for (l=0; l < handler.getOBXCommentCount(j, k); l++){%>
	                                            <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="NormalRes">
	                                               <td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><%=handler.getOBXComment(j, k, l)%></pre></td>
	                                            </tr>  
	                                       <%}  
	                                      			
	
	                                      } else  if (!handler.getOBXResultStatus(j, k).equals("TDIS") && !handler.getMsgType().equals("EPSILON")) { %>
	                                        <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="<%=lineClass%>">
	                                            <td valign="top" align="left"><%= obrFlag ? "&nbsp; &nbsp; &nbsp;" : "&nbsp;" %><a href="javascript:popupStart('660','900','../lab/CA/ON/labValues.jsp?testName=<%=obxName%>&demo=<%=demographicID%>&labType=HL7&identifier=<%= handler.getOBXIdentifier(j, k) %>')"><%=obxName %></a></td>
	                                            <td align="right"><%= handler.getOBXResult( j, k) %></td>
	                                            <td align="center">
	                                                    <%= handler.getOBXAbnormalFlag(j, k)%>
	                                            </td>
	                                            <td align="left"><%=handler.getOBXReferenceRange( j, k)%></td>
	                                            <td align="left"><%=handler.getOBXUnits( j, k) %></td>
	                                            <td align="center"><%= handler.getTimeStamp(j, k) %></td>
	                                            <td align="center"><%= handler.getOBXResultStatus( j, k) %></td>
	                                        </tr>
	 										
	                                        <%for (l=0; l < handler.getOBXCommentCount(j, k); l++){%>
	                                            <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="NormalRes">
	                                                <td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><%=handler.getOBXComment(j, k, l)%></pre></td>
	                                            </tr>
	                                        <%}
		                                    } else { %>
			                                	<%for (l=0; l < handler.getOBXCommentCount(j, k); l++){%>
			                                     <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="TDISRes">
			                                        <td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><%=handler.getOBXComment(j, k, l)%></pre></td>
			                                     </tr>  
			                                	<%} 
		                                   }
	                                   }
	                                }
	                            //}
	
	                            //for ( j=0; j< OBRCount; j++){
	                             if (!handler.getMsgType().equals("PFHT")) {
	                                if (headers.get(i).equals(handler.getObservationHeader(j, 0))) {%>
	                                <%for (k=0; k < handler.getOBRCommentCount(j); k++){
	                                    // the obrName should only be set if it has not been
	                                    // set already which will only have occured if the
	                                    // obx name is "" or if it is the same as the obr name
	                                    if(!obrFlag && handler.getOBXName(j, 0).equals("")){%>
	                                        <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" >
	                                            <td valign="top" align="left"><%=handler.getOBRName(j)%></td>
	                                            <td colspan="6">&nbsp;</td>
	                                        </tr>
	                                        <%obrFlag = true;
	                                    }%>
	                                <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" class="NormalRes">
	                                    <td valign="top" align="left" colspan="8"><pre  style="margin:0px 0px 0px 100px;"><%=handler.getOBRComment(j, k)%></pre></td>
	                                </tr>
	                                <% if  (!handler.getMsgType().equals("HHSEMR")) {
	                                	if(handler.getOBXName(j,k).equals("")){
	                                       String result = handler.getOBXResult(j, k);%>
	                                        <tr bgcolor="<%=(linenum % 2 == 1 ? highlight : "")%>" >
	                                                <td colspan="7" valign="top"  align="left"><%=result%></td>
	                                        </tr>
	                                            <%
	                                    } 
	                                }
	
	
	                                }
	                            } 
	                             } // end for if (PFHT)
	                            }
	                          } // end for handler.getMsgType().equals("MEDVUE")
	                          
	                          if (handler.getMsgType().equals("Spire")) {
									
									int numZDS = ((SpireHandler)handler).getNumZDSSegments();
									String lineClass = "NormalRes";
									int lineNumber = 0;
									
									if (numZDS > 0) { %>
										<tr class="Field2">
			                               <td width="25%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formTestName"/></td>
			                               <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formResult"/></td>
			                               <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formProvider"/></td>
			                               <td width="15%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formDateTimeCompleted"/></td>
			                               <td width="6%" align="middle" valign="bottom" class="Cell"><bean:message key="oscarMDS.segmentDisplay.formNew"/></td>
			                            </tr>
									<% 
									}
									
									for (int m=0; m < numZDS; m++) { 
										%>
										<tr bgcolor="<%=(lineNumber % 2 == 1 ? highlight : "")%>" class="<%=lineClass%>">
											<td valign="top" align="left"> <%=((SpireHandler)handler).getZDSName(m)%> </td>
											<td align="right"><%= ((SpireHandler)handler).getZDSResult(m) %></td>
											<td align="center"><%= ((SpireHandler)handler).getZDSProvider(m) %></td>
											<td align="center"><%= ((SpireHandler)handler).getZDSTimeStamp(m) %></td>
											<td align="center"><%= ((SpireHandler)handler).getZDSResultStatus(m) %></td>
										</tr> 
										<%
										lineNumber++;
									}
								}
	                            %>
	                            
	                            
	                        </table>
	                        <% // end for headers
	                        }  // for i=0... (headers) 
						}
  					 %>

                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="MainTableBottomRowRightColumn" bgcolor="#003399">
                            <tr>
                                <td align="left" width="50%">
                                    <% if ( !ackFlag ) { %>
                                    <input type="button" value="<bean:message key="oscarMDS.segmentDisplay.btnAcknowledge"/>" onclick="handleLab('acknowledgeForm_<%=segmentID%>','<%=segmentID%>','ackLab');">
                                    <input type="button" value="<bean:message key="oscarMDS.segmentDisplay.btnComment"/>" onclick="getComment('<%=segmentID%>')">
                                    <% } %>
                                    <input type="button" class="smallButton" value="<bean:message key="oscarMDS.index.btnForward"/>" onClick="popupStart(300, 400, '../oscarMDS/SelectProviderAltView.jsp?doc_no=<%=segmentID%>&providerNo=<%=providerNo%>&searchProviderNo=<%=searchProviderNo%>', 'providerselect')">

                                    <input type="button" value=" <bean:message key="global.btnPrint"/> " onClick="printPDF('<%=segmentID%>')">
                                    <oscarProperties:oscarPropertiesCheck property="MY_OSCAR" value="yes">
                                        <indivo:indivoRegistered demographic="<%=demographicID%>" provider="<%=providerNo%>">
                                        <input type="button" value="<bean:message key="global.btnSendToPHR"/>" onClick="sendToPHR('<%=segmentID%>', '<%=demographicID%>')">
                                        </indivo:indivoRegistered>
                                    </oscarProperties:oscarPropertiesCheck>
                                    <% if ( searchProviderNo != null ) { // we were called from e-chart %>
                                    <input type="button" value=" <bean:message key="oscarMDS.segmentDisplay.btnEChart"/> " onClick="popupStart(360, 680, '../oscarMDS/SearchPatient.do?labType=HL7&segmentID=<%= segmentID %>&name=<%=java.net.URLEncoder.encode(handlers.get(0).getLastName()+", "+handlers.get(0).getFirstName())%>', 'searchPatientWindow')">

                                    <% } %>
                                </td>
                                <td width="50%" valign="center" align="left">
                                    <span class="Field2"><i><bean:message key="oscarMDS.segmentDisplay.msgReportEnd"/></i></span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td colspan="1"><a style="color:white;" href="javascript:void(0);" onclick="showHideItem('rawhl7_<%=segmentID%>');" >show/hide</a>
                    <pre id="rawhl7_<%=segmentID%>" style="display:none;"><%=hl7%></pre></td></tr>
                <tr><td colspan="1" ><hr width="100%" color="red"></td></tr>
            </table>
        </form>        
        
    </div>

<%!

public void removeDuplicates(List<SpireCommonAccessionNumber> cAccns, Hl7TextInfoDao hl7TextInfoDao, String currentAccn, int currentLabNo) {
	List<SpireCommonAccessionNumber> removeList = new ArrayList<SpireCommonAccessionNumber>();
	
	for (SpireCommonAccessionNumber commonAccessionNumber : cAccns) {
		int labNo = commonAccessionNumber.getLabNo().intValue();
		List<Hl7TextInfo> vers = hl7TextInfoDao.getMatchingLabsByLabId(labNo);
		
		if (vers.size() > 1) {
			Hl7TextInfo first = vers.get(0);
			for (Hl7TextInfo ver : vers) {				
				// Generally, we want to keep the first (i.e. newest) version of a lab
				if (first == ver) {
					// Unless newest lab is NOT the version the user wants to see
					if (!currentAccn.equals(ver.getAccessionNumber())) {
						continue;
					}
				}
				
				// Don't remove the version of the current lab
				if (currentLabNo == ver.getLabNumber()) continue;
				
				addToSCANRemoveList(ver, cAccns, removeList);
			}
		}
	}
	
	cAccns.removeAll(removeList);
}

public void addToSCANRemoveList(Hl7TextInfo ver, List<SpireCommonAccessionNumber> cAccns, List<SpireCommonAccessionNumber> removeList) {
	for (int i=0; i < cAccns.size(); i++) {
		if (ver.getLabNumber() == cAccns.get(i).getLabNo().intValue()) {
			removeList.add(cAccns.get(i));
			return;
		}
	}
}
 
%>
