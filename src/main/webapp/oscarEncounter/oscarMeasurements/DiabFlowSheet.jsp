<%--

    Copyright (c) 2008-2012 Indivica Inc.

    This software is made available under the terms of the
    GNU General Public License, Version 2, 1991 (GPLv2).
    License details are available via "indivica.ca/gplv2"
    and "gnu.org/licenses/gpl-2.0.html".

--%>
<% long startTime = System.currentTimeMillis(); %>
<%@page contentType="text/html"%>
<%@page  import="oscar.oscarDemographic.data.*,java.util.*,oscar.oscarPrevention.*,oscar.oscarEncounter.oscarMeasurements.*,oscar.oscarEncounter.oscarMeasurements.bean.*,java.net.*, oscar.oscarRx.util.*"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils,oscar.log.*"%>
<%@page import="org.springframework.web.context.WebApplicationContext,oscar.oscarResearch.oscarDxResearch.bean.*"%>
<%@page import="org.oscarehr.common.dao.FlowSheetCustomizationDao,org.oscarehr.common.model.FlowSheetCustomization"%>
<%@page import="org.oscarehr.common.dao.FlowSheetDrugDao,org.oscarehr.common.model.FlowSheetDrug"%>
<%@page import="org.oscarehr.common.dao.UserPropertyDAO,org.oscarehr.common.model.UserProperty"%>

<%@page import="org.oscarehr.common.dao.AllergyDao"%>
<%@page import="org.oscarehr.common.model.Allergy"%>
<%@page import="org.oscarehr.util.SpringUtils" %>

<%@ include file="/common/webAppContextAndSuperMgr.jsp"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/oscar-tag.tld" prefix="oscar" %>
<%@ taglib uri="/WEB-INF/rewrite-tag.tld" prefix="rewrite" %>
<%@ taglib uri="/WEB-INF/security.tld" prefix="security"%>

<%
    if(session.getValue("user") == null) response.sendRedirect("../../logout.jsp");
    //int demographic_no = Integer.parseInt(request.getParameter("demographic_no"));
    if(session.getAttribute("userrole") == null )  response.sendRedirect("../logout.jsp");
    String project = request.getContextPath();
    String roleName$ = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
    String demographic_no = request.getParameter("demographic_no");
    String providerNo = (String) session.getAttribute("user");
    String temp = "diab3";

    AllergyDao allergyDao = (AllergyDao)SpringUtils.getBean("allergyDao");
%>
<oscar:oscarPropertiesCheck property="SPEC3" value="yes">
    <security:oscarSec roleName="<%=roleName$%>" objectName="_flowsheet" rights="r" reverse="<%=true%>">
        "You have no right to access this page!"
        <%
         LogAction.addLog((String) session.getAttribute("user"), LogConst.NORIGHT+LogConst.READ, LogConst.CON_FLOWSHEET,  temp , request.getRemoteAddr(),demographic_no);
        response.sendRedirect("../../noRights.html"); %>
    </security:oscarSec>
</oscar:oscarPropertiesCheck>


<%
boolean dsProblems = false;


WebApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());

FlowSheetCustomizationDao flowSheetCustomizationDao = (FlowSheetCustomizationDao) ctx.getBean("flowSheetCustomizationDao");
FlowSheetDrugDao flowSheetDrugDao = (FlowSheetDrugDao) ctx.getBean("flowSheetDrugDao");

List<FlowSheetCustomization> custList = flowSheetCustomizationDao.getFlowSheetCustomizations( temp,(String) session.getAttribute("user"),demographic_no);

////Start
MeasurementTemplateFlowSheetConfig templateConfig = MeasurementTemplateFlowSheetConfig.getInstance();


MeasurementFlowSheet mFlowsheet = templateConfig.getFlowSheet(temp,custList);

MeasurementInfo mi = new MeasurementInfo(demographic_no);
List<String> measurementLs = mFlowsheet.getMeasurementList();
ArrayList<String> measurements = new ArrayList(measurementLs);
long startTimeToGetM = System.currentTimeMillis();

mi.getMeasurements(measurements);

mFlowsheet.getMessages(mi);

ArrayList recList = mi.getList();

mFlowsheet.sortToCurrentOrder(recList);
StringBuilder recListBuffer = new StringBuilder();
for(int i = 0; i < recList.size(); i++){
    recListBuffer.append("&amp;measurement="+response.encodeURL( (String) recList.get(i)));
}

String flowSheet = mFlowsheet.getDisplayName();
ArrayList<String> warnings = mi.getWarnings();
ArrayList<String> recomendations = mi.getRecommendations();
%>

<html>

<head>
	<title><%=flowSheet%> - <oscar:nameage demographicNo="<%=demographic_no%>"/></title><!--I18n-->
	<script type="text/javascript" src="<%=request.getContextPath() %>/share/javascript/Oscar.js"></script>


	<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath() %>/share/calendar/calendar.css" title="win2k-cold-1" />

	<script type="text/javascript" src="<%=request.getContextPath() %>/share/calendar/calendar.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/share/calendar/lang/<bean:message key="global.javascript.calendar"/>" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/share/calendar/calendar-setup.js" ></script>


	<script type="text/javascript" src="<%=request.getContextPath() %>/share/javascript/jquery/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/share/javascript/jquery/jquery.autogrow-textarea.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/share/javascript/jquery/jquery-ui-1.8.15.custom.draggable.slider.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/share/javascript/jquery/jquery.sparkline.js"></script>

	<script type="text/javascript">
    	$(function() {
    		$('.inlinesparkline').sparkline('html',{width:"42px"});

    		$('.checkmarksparkline').sparkline('html',{type:"line", lineColor:"#0f0", fillColor:"", spotRadius:"0", spotColor:""})

    		var vals1 = [3,2,1];
    		var vals2 = [1,2,3];
    		$('.xsparkline').sparkline(vals1,{type:"line", lineColor:"#f00", fillColor:"", spotRadius:"0", spotColor:""});
    		$('.xsparkline').sparkline(vals2,{type:"line", lineColor:"#f00", fillColor:"", spotRadius:"0", spotColor:"", composite:"true"});
    	});
    </script>

	<script type="text/javascript">

	Object.keys = Object.keys || (function () {
	    var hasOwnProperty = Object.prototype.hasOwnProperty,
	        hasDontEnumBug = !{toString:null}.propertyIsEnumerable("toString"),
	        DontEnums = ['toString', 'toLocaleString', 'valueOf', 'hasOwnProperty', 'isPrototypeOf', 'propertyIsEnumerable', 'constructor'],
	        DontEnumsLength = DontEnums.length;

	    return function (o) {
	        if (typeof o != "object" && typeof o != "function" || o === null)
	            throw new TypeError("Object.keys called on a non-object");

	        var result = [];
	        for (var name in o) {
	            if (hasOwnProperty.call(o, name))
	                result.push(name);
	        }

	        if (hasDontEnumBug) {
	            for (var i = 0; i < DontEnumsLength; i++) {
	                if (hasOwnProperty.call(o, DontEnums[i]))
	                    result.push(DontEnums[i]);
	            }
	        }

	        return result;
	    };
	})();



	var dateCalc = new Date();
	dateCalc.setHours(0);
	dateCalc.setMinutes(0);
	dateCalc.setSeconds(0);
	dateCalc.setMilliseconds(0);
	var baselineDate = dateCalc.getTime();

	var dateRange = {
		"Off": baselineDate + 10000000000,
		"Last Day": baselineDate - 86400000,
		"Last Three Days": baselineDate - 259200000,
		"Last Week": baselineDate - 604800000,
		"Last Month": baselineDate - 2629743000,
		"Last 3 Months": baselineDate - 7889229000,
		"Last 6 Months": baselineDate - 15778458000,
		"Last Year": baselineDate - 31556926000
	};

	function highlightAllAfter(time) {
		$(".highlightTime").removeClass("highlightTime");

		$("[itemtime]").filter(function() {
			return $(this).attr("itemtime") >= time;
		}).addClass("highlightTime");
	}

	$(document).ready(function() {

		var sliderTimeout;

		$("#highlightSlider").slider({
			value: 0,
			min: 0,
			max: Object.keys(dateRange).length-1,
			step: 1,
			slide: function(event, ui) {
				$("#highlightSliderLength").text(Object.keys(dateRange)[ui.value]);
				highlightAllAfter(dateRange[Object.keys(dateRange)[ui.value]]);
			}
		});

		$("#highlightSliderLength").text(Object.keys(dateRange)[0]);
	});


	var myPopup;
    function popupPage(vheight,vwidth,varpage) {
            if (myPopup != null) {
                    myPopup.close();
            }
            var page = "" + varpage;
            windowprops = "height="+vheight+",width="+vwidth+",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes,screenX=50,screenY=50,top=0,left=0";
            myPopup=window.open(page, "apptProvider", windowprops);
            if (myPopup != null) {
                    if (myPopup.opener == null) {
                            myPopup.opener = self;
                    }
                    myPopup.focus();
            }
    }

    function calcBMI() {
    	if (isNumeric(document.getElementsByName("Weight")[0].value) && isNumeric(document.getElementsByName("Height")[0].value)) {
    		if (document.getElementsByName("Height")[0].value > 0) {
    			document.getElementsByName("BMI")[0].value = (document.getElementsByName("Weight")[0].value/Math.pow(document.getElementsByName("Height")[0].value/100,2)).toFixed(1);
    		}
    	}
    }
	</script>

	<script type="text/javascript">
		function getScrollCoords() {
			var position;

			if (document.all) {
				if (!document.documentElement.scrollTop)
		            position = document.body.scrollTop;
		         else
		            position = document.documentElement.scrollTop;
			} else {
		         position = window.pageYOffset;
		    }

			document.mainForm.ycoord.value = position;
		}

		function setScrollPos() {

			var x = 0;
			var y = document.mainForm.ycoord.value;

			window.scrollTo(x, y);
		}

		window.onload = setScrollPos;
		window.onscroll = getScrollCoords;
		window.onkeypress = getScrollCoords;
		window.onclick = getScrollCoords;

	</script>

	<script LANGUAGE="JavaScript">
	<%if (session.getAttribute("textOnEncounter")!=null) {%>
	
	if( opener.opener.document.forms["caseManagementEntryForm"] != undefined ){
        opener.opener.pasteToEncounterNote('<%=session.getAttribute("textOnEncounter")%>');
    }else if( opener.document.forms["caseManagementEntryForm"] != undefined ){
        opener.pasteToEncounterNote('<%=session.getAttribute("textOnEncounter")%>');
	}

	<%
			//clear so values don't repeat after added to note
			session.setAttribute("textOnEncounter", null);
	
	}
	%>	
	</script>


	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/share/css/jquery-ui-1.8.15.custom.draggable.slider.css" />
	<style type="text/css" media="all">


		.highlight .title .uiBarBtn {
			background: #A5A5A5;
		}

		.highlight .title .uiBarBtn:hover {
			color: #656565;
			background: white;
		}

		.uiBarBtn {
			position: relative;
			float: right;
			line-height: 8px;
			border-radius: 2px;
			background: #656565;
			color: white;
			font-weight: bold;
			font-size: 12px;
			cursor: pointer;
			padding: 2px;
			top: -1px;
			margin-left: 4px;
		}

		.highlightTime {
			background-color: yellow;
		}

		#highlightSlider {
			width: 95%;
			margin-bottom: 4px;
			margin-left: 5px;
		}

		.highlightBox {
			border: 1px solid #9D9D9D;
			border-radius: 5px;
			padding: 4px;
			margin-bottom: 4px;
			cursor: default;
		}

		.ui-slider-horizontal {
			height: 0.5em;
		}

		.ui-slider .ui-slider-handle {
			height: 0.95em;
			width: 0.95em;
		}

		a {
			text-decoration: none;
		}

		div.block {
			display: inline;
            float: left;
            width: 120px;
            min-height: 15px;
            text-align: center;
            vertical-align: middle;
            margin-top: 0.3em;
            margin-bottom: 0.3em;
            margin-left: 0.01em;
            margin-right: 0.01em;
		}

		.measurements {
			cursor: pointer;
		}

		div.measurements:hover {
			background: #9D9D9D;
			color: white;
			border-radius: 4px;
		}

		.recentBlock{
			text-align:center;
		}

		.formTable {
			font-family: Verdana,Tahoma,Arial,sans-serif;
			font-size: 12px;
			line-height: 12px;
			border: 1px solid #9d9d9d;
			border-collapse:collapse;
			margin-left: auto;
			margin-right: auto;
			width: 100%;
		}

		th {
			background: #9d9d9d;
			color: #fff;
			text-align: left;
			padding: 5px;
		}

		tr.dataRow {
			height:35px;
		}

		td {

		}

		td.data {
			overflow:auto;
			border-top: 1px solid #9d9d9d;
			border-left: 1px solid #9d9d9d;
		}


		td.field {
			width:100px;
		}

		td.inputData {
			width:150px;
		}

		td.comments {
			width:40px;
		}

		td.graph {
			width:24px;
			text-align: center;
		}

		td.last {
			width:145px;
		}

		td.rowheader {
			line-height: 2;
			width: 100px;
			text-align: left;
			vertical-align: text-top;
		}

		.rowheader2 {
			text-align: right;
		}

		.header {
			font-weight: bold;
		}

		a.header {
			color: #000000;
    		font-weight: bold;
    		text-decoration: underline;
		}
	</style>

</head>

<%
String[] demographicParam = new String[1];
demographicParam[0] = demographic_no;

String remindersQuery = "intake_reminders";
List<Map<String,Object>> remindersResult = oscarSuperManager.find("providerDao", remindersQuery, demographicParam);
String remindersList = (!remindersResult.isEmpty() && remindersResult.get(0).get("note")!=null) ? remindersResult.get(0).get("note").toString() : "";
if (remindersResult.size() > 1) {
	for (int i=1; i<remindersResult.size(); i++) {
		remindersList += ",<br/>" + remindersResult.get(i).get("note").toString();
	}
}

List<Allergy> allergies = allergyDao.findActiveAllergiesOrderByDescription(Integer.parseInt(demographic_no));
String allergiesList="";
for(int x=0;x<allergies.size();x++) {
	if(x!=0) {
		allergiesList += ",<br/>";
	}
	Allergy allergy = allergies.get(x);
	allergiesList += allergy.getDescription();
}

String curUser_no = (String) session.getAttribute("user");

String medicationsQuery = "intake_medications";
List<Map<String,Object>> medicationsResult = oscarSuperManager.find("providerDao", medicationsQuery, demographicParam);
String medicationsList = "";
if (!medicationsResult.isEmpty()) {
	for (int i=0; i<medicationsResult.size(); i++) {
		if (i != 0) {
			medicationsList += ",<br/>";
		}

		if (medicationsResult.get(i).get("customName")!=null && !medicationsResult.get(i).get("customName").toString().equals("null")) {
			medicationsList += medicationsResult.get(i).get("customName").toString();
		} else if (Integer.parseInt(medicationsResult.get(i).get("GCN_SEQNO").toString())==0) {
			medicationsList += "Unknown";
		} else {
			medicationsList += medicationsResult.get(i).get("BN").toString();
		}

		medicationsList += " " + RxUtil.FloatToString(Float.parseFloat(medicationsResult.get(i).get("takemin").toString()));
		if (!medicationsResult.get(i).get("takemin").toString().equals(medicationsResult.get(i).get("takemax").toString())) {
			medicationsList += "-" + RxUtil.FloatToString(Float.parseFloat(medicationsResult.get(i).get("takemax").toString()));
		}

		if (medicationsResult.get(i).get("freqcode")!=null) {
			medicationsList += " " + medicationsResult.get(i).get("freqcode").toString();
		}

		if (medicationsResult.get(i).get("prn").toString().equals("1")) {
			medicationsList += " PRN";
		}

		if (medicationsResult.get(i).get("duration") != null && !medicationsResult.get(i).get("duration").toString().equals("null")) {
			medicationsList += " " + medicationsResult.get(i).get("duration").toString();
			if (medicationsResult.get(i).get("durunit")!=null) {
				if (medicationsResult.get(i).get("durunit").toString().equals("D")) {
					medicationsList += " Day";
				} else if (medicationsResult.get(i).get("durunit").toString().equals("W")) {
					medicationsList += " Week";
				} else if (medicationsResult.get(i).get("durunit").toString().equals("M")) {
					medicationsList += " Month";
				}
			}
		}

		if (medicationsResult.get(i).get("duration")!=null && !medicationsResult.get(i).get("duration").toString().equals("null") && !medicationsResult.get(i).get("duration").toString().equals("") && Integer.parseInt(medicationsResult.get(i).get("duration").toString())>1) {
			medicationsList += "s";
		}

		medicationsList += "  " + medicationsResult.get(i).get("quantity").toString() + " Qty  Repeats: ";

		medicationsList += medicationsResult.get(i).get("repeat").toString();

		if (medicationsResult.get(i).get("repeat").toString().equals("1")) {
			medicationsList += " No subs";
		}
	}
}
%>

<%
java.util.Calendar calender = java.util.Calendar.getInstance();
String day =  Integer.toString(calender.get(java.util.Calendar.DAY_OF_MONTH));
String month =  Integer.toString(calender.get(java.util.Calendar.MONTH)+1);
String year = Integer.toString(calender.get(java.util.Calendar.YEAR));
String date = year+"-"+month+"-"+day;
%>

<body>

	<form id="mainForm" name="mainForm" action="<%=request.getContextPath()%>/oscarEncounter/FormUpdate.do">
	<input type="hidden"  name="ycoord"
	<%if (request.getParameter("ycoord") != null) { %>
		value="<%=request.getParameter("ycoord")%>"
	<%} else {%>
		value="0"
	<%}%>
	/>

	<%
	int numPrev;

	if (request.getParameter("numPrev") == null) {
		numPrev = 9;
		%> <%
	} else {
		numPrev = Integer.parseInt(request.getParameter("numPrev"));
		%> <%
	}
	%>


	<table class="formTable" id="headTable">
		<tr><th colspan="8"><oscar:nameage demographicNo="<%=demographic_no%>"/></th></tr>
		<tr>
			<td class="rowheader"><a class="header" href="#" onclick="popupPage('700', '1000', '<%=project%>/CaseManagementEntry.do?method=issuehistory&demographicNo=<%=demographic_no%>&issueIds=38'); return false;">Reminders</a></td>
			<td width="650px"><%=remindersList%></td>
			<td>
			<div class="highlightBox">
				<div id="highlightSlider" class="contentItem"></div>
				<div id="highlightSliderLengthBox"><strong>Highlight:</strong> <span id="highlightSliderLength"></span></div>
			</div>
			<div>
				# of Previous Shown: <input type="text" name="numPrev" id="numPrev" value="<%=numPrev%>" size="1" />
			</div>
			<div>
				<input type="text" name="date" id="date" value="<%=date%>" size="10" > <a id="dateImg"><img title="Calendar" src="<%=request.getContextPath() %>/images/cal.gif" alt="Calendar" border="0" /></a>
			</div>
			<script type="text/javascript">
				Calendar.setup( { inputField : "date", ifFormat : "%Y-%m-%d", showsTime :false, button : "dateImg", singleClick : true, step : 1 } );
			</script>
			</td>
		</tr>

		<tr>
			<td class="rowheader"><a class="header" href="#" onclick="popupPage('700', '1000', '<%=project%>/oscarRx/showAllergy.do?demographicNo=<%=demographic_no%>'); return false;">Allergies</a></td>
			<td width="650px"><%=allergiesList%></td>
		</tr>

		<tr>
			<td class="rowheader"><a class="header" href="#" onclick="popupPage('700', '1000', '<%=project%>/oscarRx/choosePatient.do?providerNo=<%=curUser_no%>&demographicNo=<%=demographic_no%>'); return false;">Medications</a></td>
			<td width="650px"><%=medicationsList%></td>
			<td>
   			</td>
		</tr>

	</table>

	<input type="hidden" name="demographic_no" value="<%=demographic_no%>" />
	<input type="hidden" name="template" value="<%=temp%>" />

	<table class="formTable" id="mainTable">
	<%
	EctMeasurementTypeBeanHandler mType = new EctMeasurementTypeBeanHandler();
    List<MeasurementTemplateFlowSheetConfig.Node>nodes = mFlowsheet.getItemHeirarchy();
    String measure;

    for (int i = 0; i < nodes.size(); i++) {
    	MeasurementTemplateFlowSheetConfig.Node node = nodes.get(i);
    	FlowSheetItem item = node.flowSheetItem;
	%>
    	<tr>
    	<th>
    		<b><%=item.getDisplayName()%></b>
    	</th>
    	<th>Value</th>
    	<th>Comments</th>
    	<th></th>
    	<th>Most Recent</th>
    	<th>Previous</th>
    	</tr>
    	<%
    	String currentSection = item.getDisplayName();
    	for (int j = 0; j < node.children.size(); j++) {
    		MeasurementTemplateFlowSheetConfig.Node child = node.children.get(j);
    		if (child.children == null && child.flowSheetItem != null) {
    			item = child.flowSheetItem;

    			measure = item.getItemName();
				Map h2 = mFlowsheet.getMeasurementFlowSheetInfo(measure);


	            if (h2.get("measurement_type") != null ){
	            	ArrayList<EctMeasurementsDataBean> alist = mi.getMeasurementData(measure);
		            HashMap<String,String> h = new HashMap<String,String>();
		            EctMeasurementTypesBean mtypeBean = mType.getMeasurementType(measure);

		            if(mtypeBean!=null) {
		                h.put("name",mtypeBean.getTypeDisplayName());
		                h.put("desc",mtypeBean.getTypeDesc());
		            }
	    		%>
	    			<%//This part here grabs the field name %>
	    			<tr class="dataRow <%=currentSection%>" >
					<td class="field">
					<a style="color: black; text-decoration : underline;" href="javascript: function myFunction() {return false; }"  onclick="javascript:popup(465,635,'<%=project%>/oscarEncounter/oscarMeasurements/AddMeasurementData.jsp?measurement=<%= response.encodeURL(measure) %>&amp;demographic_no=<%=demographic_no%>&amp;template=<%= URLEncoder.encode(temp,"UTF-8") %>','addMeasurementData<%=Math.abs(h.get("name").hashCode()) %>')">
					<b><%=child.flowSheetItem.getDisplayName()%></b>
					</a>
					</td>

					<%
					String name = child.flowSheetItem.getDisplayName();
					name = name.replaceAll("\\W","");
					%>

					<td class="inputData">
					<%//This part here grabs the type of input %>
					<% if ( mtypeBean.getValidationName() != null && mtypeBean.getValidationName().equals("Yes/No")){ %>
	                           <input type="radio" name="<%=name%>" value="Yes">Yes
	                           <input type="radio" name="<%=name%>" value="No">No
	                           <input type="radio" name="<%=name%>" style="display:none;" value="">
	                           <input type="button" onclick="document.mainForm.<%=name%>[2].checked = true;" value="Clear">
	                 <%}else{%>
	                       <input type="text" id="<%=name%>" name="<%=name%>" size="14"
	                       	<% if (name.equals("Weight") || name.equals("Height") ){ %> onchange="calcBMI()"<%}%>
	                       />
	                       <%=child.flowSheetItem.getValueName()%>

                       <%}%>
					</td>

					<td class="comments">
						<input type="text" size="15" name="<%=name + "_comments"%>" />
					</td>

					<%
					Iterator<EctMeasurementsDataBean> alistIterator = alist.iterator();
					Iterator<EctMeasurementsDataBean> graphIterator = alist.iterator();
    				HashMap<String,String> hdata;
    				EctMeasurementsDataBean mdb;
    				%>

					<td class="graph">
					<%if(h2.get("graphable") != null && ((String) h2.get("graphable")).equals("yes")){%>
			            <%if (alist != null && alist.size() > 1) {
			            boolean sep = false;
			            %>
			               	<span class="inlinesparkline" values="
			               	 <%=alist.get(alist.size()-1).getDataField()%>
			               	 <%for (int x=alist.size()-2; x>=0; x--){
			               	 %>
			               	 ,
				               	 <%if (alist.get(x).getDataField().equals("")) { %>
				               	 null
				               	 <%}else{ %>
				               	 <%=alist.get(x).getDataField()%>
				               	 <%} %>
			               	 <%}%>
			               	 "></span>
			            <%}%>
		           <%} else if ( mtypeBean.getValidationName() != null && mtypeBean.getValidationName().equals("Yes/No")){
		           		if (alist !=null && alist.size() > 0) {
		           			if (alist.get(0).getDataField().equalsIgnoreCase("Yes")) { %>
		           				<span class="checkmarksparkline" values="2,1,2,3"></span>
		           			<%} else if (alist.get(0).getDataField().equalsIgnoreCase("No")) { %>
		           				<span class="xsparkline"></span>
		           			<%
		           			}
		           		}
		           	} else if (name.equals("BP")) {
		           		if (alist != null && alist.size() > 1) {
		           			List<String> first = new ArrayList<String>();
		           			List<String> second = new ArrayList<String>();
		           			for (int x=alist.size()-1; x>=0; x--){
		           				if (alist.get(x) != null && alist.get(x).getDataField() != null && !alist.get(x).getDataField().equals("")) {
			           				String[] parsed = alist.get(x).getDataField().split("/");
			           				first.add(parsed[0]);
			           				second.add(parsed[1]);
		           				} else {
		           					first.add("null");
		           					second.add("null");
		           				}
		           			} %>
		           			<span class="bpline"></span>
		           			<script type="text/javascript">
		           				var first = new Array();
		           				var second = new Array();

		           				<%for (int x = 0; x < first.size(); x++) {%>
		           					first[<%=x%>] = "<%=first.get(x)%>";
		           					second[<%=x%>] = "<%=second.get(x)%>";
		           				<%}%>

		           				$('.bpline').sparkline(first,{width:"42px", type:"line", lineColor:"#00f", fillColor:"#cdf", spotRadius:"0", spotColor:"", chartRangeMin:"0", chartRangeMax:"200"});
		           				$('.bpline').sparkline(second,{composite:"true", type:"line", lineColor:"#040", fillColor:"#7d7", spotRadius:"0", spotColor:"", chartRangeMin:"0", chartRangeMax:"200"});
		           			</script>
		           		<%}
		           	} %>
					</td>

    					<td class="last">
   						<%
   						if (alistIterator.hasNext()) {
   							mdb = alistIterator.next();
   							mFlowsheet.runRulesForMeasurement(mdb);
   							hdata = new HashMap<String,String>();
   							hdata.put("id",""+mdb.getId());
   							hdata.put("data",mdb.getDataField());
   							hdata.put("prevention_date",mdb.getDateObserved());
   							hdata.put("comments",mdb.getComments());
   							hdata.put("unixTime", Long.toString(mdb.getDateEnteredAsDate().getTime()));
   						%>
   							<div itemtime="<%=hdata.get("unixTime")%>" class="recentBlock measurements" onclick="javascript:popup(465,635,'<%=project%>/oscarEncounter/oscarMeasurements/AddMeasurementData.jsp?measurement=<%= response.encodeURL( measure) %>&amp;id=<%=hdata.get("id")%>&amp;demographic_no=<%=demographic_no%>&amp;template=<%= URLEncoder.encode(temp,"UTF-8")%>','addMeasurementData')" >
		   		               		<b><%=hdata.get("data")%></b>; <%=hdata.get("prevention_date")%> <br>
		   		               <b>
		   		                    <%=hdata.get("comments")%>
		   		               </b>
		   		            </div>
   						<%
   						}
   						%>
    					</td>



					<td class="data" align="left">
					<%
					boolean increaseHeight = false;
					int counter = 0;
		            while (alistIterator.hasNext()){
		            	if (counter >= numPrev) break;
		            	counter++;
		            	mdb = alistIterator.next();
		            	mFlowsheet.runRulesForMeasurement(mdb);
		                hdata = new HashMap<String,String>();
		                hdata.put("data",mdb.getDataField());
		                hdata.put("prevention_date",mdb.getDateObserved());
		                hdata.put("comments",mdb.getComments());
		                hdata.put("id",""+mdb.getId());
		            	hdata.put("unixTime", Long.toString(mdb.getDateEnteredAsDate().getTime()));
		                %>

			            	<div itemtime="<%=hdata.get("unixTime")%>" <%if (mdb.getIndicationColour()!=null) {%> <%}%> class="block measurements <%=name%>" onclick="javascript:popup(465,635,'<%=project%>/oscarEncounter/oscarMeasurements/AddMeasurementData.jsp?measurement=<%= response.encodeURL( measure) %>&amp;id=<%=hdata.get("id")%>&amp;demographic_no=<%=demographic_no%>&amp;template=<%= URLEncoder.encode(temp,"UTF-8") %>','addMeasurementData')" >
			                <%if (!hdata.get("data").equals("")) { %>
			                <b><%=hdata.get("data")%></b>, <%=hdata.get("prevention_date")%><br>
			                <%}else{ %>
			                <%=hdata.get("prevention_date")%><br>
			                <%} %>
			              	<%
			              	if (hdata.get("comments")!= null) {

								if(!hdata.get("comments").equals("")) { increaseHeight = true;}
			              		if(hdata.get("comments").toString().length() >= 19) {
			              			String tempComments = hdata.get("comments").toString().substring(0,15) + "...";
			              			%> <%=tempComments%><%
			              		} else {
			              			String tempComments = hdata.get("comments").toString();
			              			%> <%=tempComments%><%
			              		}
			              	}
			              	%>
			            	</div>
		            <%}
		 			if (increaseHeight) {
		 			String className = "\".block.measurements." + name + "\"";
		 			%>
		 				<script type="text/javascript">
		 					$(<%=className%>).css("min-height","25px")
		 				</script>
		 			<%}%> </td></tr><%
	            } %>

    	<%	}

    	}%>
    	<tr>
    	<td><input style="font-size:12;" type="submit" name="submit" value="Update" /></td>
    	<td></td>
    	<td></td>
    	<td></td>
    	<td></td>
    	<td align="right" style="border-top: 1px solid #9d9d9d;">
    	</td></tr>
    <%
    	node = node.getNextSibling();
    }%>

	<tr>
	<th colspan="8" align="left">
	<input style="margin-top: 0.2em; font-size:12;" type="submit" name="submit" value="Submit & Close" />
	</th>
	</tr>

	</table>
	</form>

</body>

</html>
