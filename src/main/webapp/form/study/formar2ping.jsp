<%@ page import="oscar.form.*"%>
<%
    int demoNo = Integer.parseInt(request.getParameter("demographic_no"));
    String studyId = request.getParameter("study_no");
    oscar.form.data.FrmData.PatientForm pform = (new oscar.form.data.FrmData()).getCurrentPatientForm(""+demoNo, studyId);
    int formId = (pform == null) ? 0: Integer.parseInt(pform.getFormId());
    //int formId = Integer.parseInt(request.getParameter("formId"));

	// for oscarcitizens
    String historyet = request.getParameter("historyet") == null ? "" : ("&historyet=" + request.getParameter("historyet"));

	if(true) {
        out.clear();
		if (formId == 0) {
			pageContext.forward("formarpg1.jsp?demographic_no=" + demoNo + "&formId=" + formId) ; 
 		} else {
			FrmRecord rec = (new FrmRecordFactory()).factory("AR");
			java.util.Properties props = rec.getFormRecord(demoNo, formId);

			pageContext.forward("formar" + props.getProperty("c_lastVisited", "pg1") 
				+ ".jsp?demographic_no=" + demoNo + "&formId=" + formId + historyet)  ;
		}

		return;
    }
%>
