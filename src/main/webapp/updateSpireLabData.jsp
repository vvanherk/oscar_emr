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
Hl7TextInfoDao hl7TextInfoDao = (Hl7TextInfoDao)SpringUtils.getBean("hl7TextInfoDao");
SpireAccessionNumberMapDao accnDao = (SpireAccessionNumberMapDao)SpringUtils.getBean("spireAccessionNumberMapDao");

List<Hl7TextInfo> labs = hl7TextInfoDao.getAllLabsByLabNumberResultStatus();

MiscUtils.getLogger().info("Number of labs to be processed: " labs.size());

int numChanges = 0;
for (Hl7TextInfo lab : labs) {
	MessageHandler h = Factory.getHandler( "" + lab.getLabNumber() );
	
	if (h instanceof SpireHandler) {
		// we need to add a mapping from the 'common' accession number to the 'unique' accession number for spire labs
		String uniqueAccnAsString = ((SpireHandler)h).getUniqueAccessionNum();
		String accn = h.getAccessionNum();
		
		MiscUtils.getLogger().info("unique: " + uniqueAccnAsString + " 'normal': " + accn);
		if (accnDao.getFromLabNumber( lab.getLabNumber() ) == null) {
			try {
				Integer uniqueAccn = Integer.parseInt(uniqueAccnAsString);
				accnDao.add( uniqueAccn, accn, lab.getLabNumber() );
				numChanges++;
			} catch (Exception e) {
				MiscUtils.getLogger().error("Unable to parse Spire Unique Accession number from String to int.", e);
			}
		}
	}
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

Update complete.
<br>
<br>
<%=numChanges%> Spire lab(s) modified.

</body>
</html:html>

