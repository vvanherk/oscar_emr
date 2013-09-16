<%@page import="org.oscarehr.util.MiscUtils"%>

<%@ page import="java.util.*,
		 java.sql.*,
		 java.text.SimpleDateFormat,
		 oscar.oscarDB.*, oscar.oscarLab.FileUploadCheck, oscar.util.UtilDateUtilities,
		 oscar.oscarLab.ca.all.*,
		 oscar.oscarLab.ca.all.util.*,
		 oscar.oscarLab.ca.all.parsers.*,
		 oscar.oscarLab.LabRequestReportLink,
		 oscar.oscarMDS.data.ReportStatus,oscar.log.*,
		 org.apache.commons.codec.binary.Base64,
         oscar.OscarProperties" %>
         
<%@ page import="org.oscarehr.util.SpringUtils"%>
<%@ page import="org.oscarehr.common.dao.UserPropertyDAO, org.oscarehr.common.model.UserProperty" %>
<%@ page import="oscar.oscarEncounter.oscarMeasurements.dao.*,oscar.oscarEncounter.oscarMeasurements.model.Measurementmap" %>
<%@ page import="org.oscarehr.common.dao.SpireAccessionNumberMapDao" %>
<%@ page import="org.oscarehr.common.model.SpireAccessionNumberMap" %>
<%@ page import="org.oscarehr.common.model.SpireCommonAccessionNumber" %>
<%@ page import="org.oscarehr.casemgmt.service.CaseManagementManager, org.oscarehr.common.dao.Hl7TextInfoDao, org.oscarehr.common.model.Hl7TextInfo,org.oscarehr.common.dao.Hl7TextInfoDao,org.oscarehr.common.model.Hl7TextInfo"%>

<%
String start = request.getParameter("start");
String results = request.getParameter("results");
boolean startFlag = (start != null);
boolean finishedFlag = (results != null);

boolean hasPermission = ((String)session.getAttribute("userrole")).indexOf("admin") >=0;

int numChanges = 0;
if (results != null) {
	try {
		numChanges = Integer.parseInt(results);
	} catch (Exception e) {
	}
}
%>

<%

if(hasPermission && startFlag) {
	Hl7TextInfoDao hl7TextInfoDao = (Hl7TextInfoDao)SpringUtils.getBean("hl7TextInfoDao");
	SpireAccessionNumberMapDao accnDao = (SpireAccessionNumberMapDao)SpringUtils.getBean("spireAccessionNumberMapDao");
	
	List<Hl7TextInfo> labs = hl7TextInfoDao.getAllLabsByLabNumberResultStatus();
	
	MiscUtils.getLogger().info("Number of labs to be processed: " + labs.size());
	
	numChanges = 0;
	for (Hl7TextInfo lab : labs) {
		MessageHandler h = Factory.getHandler( "" + lab.getLabNumber() );
		
		if (h instanceof SpireHandler) {
			// we need to add a mapping from the 'common' accession number to the 'unique' accession number for spire labs
			String uniqueAccn = ((SpireHandler)h).getUniqueAccessionNum();
			String accn = h.getAccessionNum();
			
			MiscUtils.getLogger().info("unique: " + uniqueAccn + " 'normal': " + accn);
			if (uniqueAccn != null && uniqueAccn.length() > 0 && accnDao.getFromLabNumber( lab.getLabNumber() ) == null) {
				try {
					accnDao.add( uniqueAccn, accn, lab.getLabNumber() );
					numChanges++;
				} catch (Exception e) {
					MiscUtils.getLogger().error("Unable to add lab to Accession Map Dao.", e);
				}
			}
		}
	}
	
	
	response.sendRedirect("updateSpireLabData.jsp?results=" + numChanges);
}
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@page import="oscar.OscarProperties"%>
<html:html locale="true">

<head>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/global.js"></script>
<title>Spire Lab Updater</title>
<link rel="stylesheet" type="text/css" href="../share/css/OscarStandardLayout.css" />

</head>

<body>
<%
if (hasPermission) {
	if (finishedFlag) {
%>
	Update complete.
	<br>
	<br>
	<%=numChanges%> Spire lab(s) modified.
<%
	} else {
%>
	This update process can take a while.  Are you sure you want to continue? <a href="updateSpireLabData.jsp?start=true">YES</a>
<%
	}
} else {
%>
	You do not have the necessary privileges to run this update.  Please contact your system administrator.
<%
}
%>
</body>
</html:html>

