/**
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
 * This software is published under the GPL GNU General Public License.
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */


package org.oscarehr.eyeform.web;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.util.LabelValueBean;
import org.apache.struts.validator.DynaValidatorForm;
import org.caisi.dao.TicklerDAO;
import org.caisi.model.Tickler;
import org.oscarehr.PMmodule.dao.ProviderDao;
import org.oscarehr.casemgmt.dao.CaseManagementNoteDAO;
import org.oscarehr.casemgmt.dao.IssueDAO;
import org.oscarehr.casemgmt.model.CaseManagementIssue;
import org.oscarehr.casemgmt.model.CaseManagementNote;
import org.oscarehr.casemgmt.model.Issue;
import org.oscarehr.casemgmt.service.CaseManagementManager;
import org.oscarehr.common.IsPropertiesOn;
import org.oscarehr.common.dao.AllergyDao;
import org.oscarehr.common.dao.PrescriptionDao;
import org.oscarehr.common.dao.CaseManagementIssueNotesDao;
import org.oscarehr.common.dao.ClinicDAO;
import org.oscarehr.common.dao.ConsultationRequestExtDao;
import org.oscarehr.common.dao.DemographicContactDao;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.common.dao.DemographicExtDao;
import org.oscarehr.common.dao.DocumentResultsDao;
import org.oscarehr.common.dao.EFormGroupDao;
import org.oscarehr.common.dao.EFormValueDao;
import org.oscarehr.common.dao.OscarAppointmentDao;
import org.oscarehr.common.dao.ProfessionalSpecialistDao;
import org.oscarehr.common.dao.BillingreferralDao;
import org.oscarehr.common.dao.SiteDao;
import org.oscarehr.common.model.Allergy;
import org.oscarehr.common.model.Prescription;
import org.oscarehr.common.model.Drug;
import org.oscarehr.common.model.Appointment;
import org.oscarehr.common.model.Clinic;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.common.model.DemographicContact;
import org.oscarehr.common.model.DemographicExt;
import org.oscarehr.common.model.Document;
import org.oscarehr.common.model.EFormGroup;
import org.oscarehr.common.model.EFormValue;
import org.oscarehr.common.model.ProfessionalSpecialist;
import org.oscarehr.common.model.Billingreferral;
import org.oscarehr.common.model.Provider;
import org.oscarehr.common.model.Site;
import org.oscarehr.common.service.PdfRecordPrinter;
import org.oscarehr.common.web.ContactAction;
import org.oscarehr.eyeform.MeasurementFormatter;
import org.oscarehr.eyeform.dao.ConsultationReportDao;
import org.oscarehr.eyeform.dao.EyeFormDao;
import org.oscarehr.eyeform.dao.FollowUpDao;
import org.oscarehr.eyeform.dao.OcularProcDao;
import org.oscarehr.eyeform.dao.ProcedureBookDao;
import org.oscarehr.eyeform.dao.SpecsHistoryDao;
import org.oscarehr.eyeform.dao.TestBookRecordDao;
import org.oscarehr.eyeform.model.EyeForm;
import org.oscarehr.eyeform.model.EyeformConsultationReport;
import org.oscarehr.eyeform.model.EyeformFollowUp;
import org.oscarehr.eyeform.model.EyeformOcularProcedure;
import org.oscarehr.eyeform.model.EyeformProcedureBook;
import org.oscarehr.eyeform.model.EyeformSpecsHistory;
import org.oscarehr.eyeform.model.EyeformTestBook;
import org.oscarehr.eyeform.model.SatelliteClinic;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;
import org.springframework.beans.BeanUtils;

import oscar.OscarProperties;
import oscar.SxmlMisc;
import oscar.oscarEncounter.oscarMeasurements.dao.MeasurementsDao;
import oscar.oscarEncounter.oscarMeasurements.model.Measurements;
import oscar.util.UtilDateUtilities;

import com.lowagie.text.DocumentException;
import com.lowagie.text.pdf.PdfCopyFields;

public class EyeformAction extends DispatchAction {

	static Logger logger = MiscUtils.getLogger();
	static String[] cppIssues = {"CurrentHistory","eyeformCurrentIssue","Reminders","PastOcularHistory","MedHistory","OMeds","OcularMedication","DiagnosticNotes","FamHistory"};

	CaseManagementManager cmm = null;
	OscarAppointmentDao appointmentDao = (OscarAppointmentDao)SpringUtils.getBean("oscarAppointmentDao");
	DemographicDao demographicDao= (DemographicDao)SpringUtils.getBean("demographicDao");
	ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
	CaseManagementNoteDAO caseManagementNoteDao = (CaseManagementNoteDAO)SpringUtils.getBean("CaseManagementNoteDAO");
	OcularProcDao ocularProcDao = (OcularProcDao)SpringUtils.getBean("OcularProcDAO");
	SpecsHistoryDao specsHistoryDao = (SpecsHistoryDao)SpringUtils.getBean("SpecsHistoryDAO");
	AllergyDao allergyDao = (AllergyDao)SpringUtils.getBean("allergyDao");
	PrescriptionDao prescriptionDao = (PrescriptionDao)SpringUtils.getBean("prescriptionDao");
	FollowUpDao followUpDao = (FollowUpDao)SpringUtils.getBean("FollowUpDAO");
	ProcedureBookDao procedureBookDao = (ProcedureBookDao)SpringUtils.getBean("ProcedureBookDAO");
	TestBookRecordDao testBookDao = (TestBookRecordDao)SpringUtils.getBean("TestBookDAO");
	EyeFormDao eyeFormDao = (EyeFormDao)SpringUtils.getBean("EyeFormDao");
	MeasurementsDao measurementsDao = (MeasurementsDao) SpringUtils.getBean("measurementsDao");
	ProfessionalSpecialistDao professionalSpecialistDao = (ProfessionalSpecialistDao) SpringUtils.getBean("professionalSpecialistDao");
	BillingreferralDao billingreferralDao = (BillingreferralDao) SpringUtils.getBean("billingreferralDao");
	ClinicDAO clinicDao = (ClinicDAO)SpringUtils.getBean("clinicDAO");
	SiteDao siteDao = (SiteDao)SpringUtils.getBean("siteDao");
	TicklerDAO ticklerDao = (TicklerDAO)SpringUtils.getBean("ticklerDAOT");
	//CppMeasurementsDao cppMeasurementsDao = (CppMeasurementsDao)SpringUtils.getBean("cppMeasurementsDao");
	CaseManagementIssueNotesDao caseManagementIssueNotesDao=(CaseManagementIssueNotesDao)SpringUtils.getBean("caseManagementIssueNotesDao");
	DemographicExtDao demographicExtDao = SpringUtils.getBean(DemographicExtDao.class);

	   public ActionForward getConReqCC(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
		   String requestId = request.getParameter("requestId");
		   ConsultationRequestExtDao dao = (ConsultationRequestExtDao)SpringUtils.getBean("consultationRequestExtDao");
		   String cc = "";
		   if(requestId != null) {
			   try {
				   int reqId = Integer.parseInt(requestId);
				   String value = dao.getConsultationRequestExtsByKey(reqId,"cc");
				   if(value!=null)
					   cc = value;
			   } catch(NumberFormatException e){}
		   }
		   request.setAttribute("requestCc", cc);
		   ProfessionalSpecialistDao professionalSpecialistDao=(ProfessionalSpecialistDao)SpringUtils.getBean("professionalSpecialistDao");
		   List<ProfessionalSpecialist> psList = professionalSpecialistDao.findAll();
		   request.setAttribute("professionalSpecialists",psList);
	       return mapping.findForward("conreqcc");
	    }


	   public ActionForward specialConRequestHTML(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
		   ConsultationRequestExtDao consultationRequestExtDao=(ConsultationRequestExtDao)SpringUtils.getBean("consultationRequestExtDao");

		   String reqId = request.getParameter("requestId");
		   int requestId;

		   if(reqId == null || reqId.length()==0 || reqId.equals("null")) {
			   requestId = 0;
		   } else {
			   requestId = Integer.parseInt(reqId);
		   }

		   String specialProblem = "";
		   if(requestId>0) {
			   specialProblem = consultationRequestExtDao.getConsultationRequestExtsByKey(requestId, "specialProblem");
		   }
		   request.setAttribute("ext_specialProblem", specialProblem);

		   return mapping.findForward("conspecialhtml");
	   }

	   public ActionForward specialConRequest(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
		   String demo = request.getParameter("demographicNo");
		   String strAppNo = request.getParameter("appNo");
		   String reqId = request.getParameter("requestId");
		   String cpp = request.getParameter("cpp");
		   String endDateAsString = request.getParameter("endDate");
		   boolean cppFromMeasurements=false;
		   if(cpp != null && cpp.equals("measurements")) {
			   cppFromMeasurements=true;
		   }
		   
		   Integer demographicNo = new Integer(0);
		   try {
			   demographicNo = new Integer(demo);
		   } catch (Exception e) {
			   logger.error("Cannot case demographic number to Integer: " + demo, e);
		   }

			Date endDate = null;
			if (endDateAsString != null) {
				try {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					endDate = formatter.parse(endDateAsString);
					endDate = getEndOfDayVersion(endDate);
				} catch (ParseException e) {
					MiscUtils.getLogger().error("Error", e);
				}
			}
		   

		   Provider provider = LoggedInInfo.loggedInInfo.get().loggedInProvider;
		   ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
		   ConsultationRequestExtDao consultationRequestExtDao=(ConsultationRequestExtDao)SpringUtils.getBean("consultationRequestExtDao");
		   OcularProcDao ocularProcDao = (OcularProcDao)SpringUtils.getBean("OcularProcDAO");
		   SpecsHistoryDao specsHistoryDao = (SpecsHistoryDao)SpringUtils.getBean("SpecsHistoryDAO");

		   int appNo;
		   int requestId;
		   if(strAppNo == null || strAppNo.length()==0 || strAppNo.equals("null")) {
			   appNo = 0;
		   } else {
			   appNo = Integer.parseInt(strAppNo);
		   }
		   if(reqId == null || reqId.length()==0 || reqId.equals("null")) {
			   requestId = 0;
		   } else {
			   requestId = Integer.parseInt(reqId);
		   }

		   if(requestId>0) {
			   String tmp = consultationRequestExtDao.getConsultationRequestExtsByKey(requestId, "appNo");
        	   appNo = Integer.parseInt(tmp);
		   }
		   request.setAttribute("providerList", providerDao.getActiveProviders());
		   request.setAttribute("re_demoNo", demo);
/*
		   if(cppFromMeasurements) {
			   request.setAttribute("currentHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Current History:", "cpp_currentHis", Integer.parseInt(demo), appNo, false)));
			   request.setAttribute("pastOcularHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Past Ocular History:", "cpp_pastOcularHis", Integer.parseInt(demo), appNo, true)));
			   request.setAttribute("diagnosticNotes",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Diagnostic Notes:", "cpp_diagnostics", Integer.parseInt(demo), appNo, true)));
			   request.setAttribute("medicalHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Medical History:", "cpp_medicalHis", Integer.parseInt(demo), appNo, true)));
			   request.setAttribute("familyHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Family History:", "cpp_familyHis", Integer.parseInt(demo), appNo, true)));
			   request.setAttribute("ocularMedication",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Ocular Medications:", "cpp_ocularMeds", Integer.parseInt(demo), appNo, true)));

		   } else {*/
				List<String> currentHistoryIssueNames = new ArrayList<String>();
				currentHistoryIssueNames.add("CurrentHistory");
				currentHistoryIssueNames.add("eyeformCurrentIssue");
			
			   request.setAttribute("currentHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Current History:", currentHistoryIssueNames, demographicNo, appNo, endDate, false)));
			   request.setAttribute("pastOcularHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Past Ocular History:", "PastOcularHistory", demographicNo, appNo, endDate, true)));
			   request.setAttribute("diagnosticNotes",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Diagnostic Notes:", "DiagnosticNotes", demographicNo, appNo, endDate, true)));
			   request.setAttribute("medicalHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Medical History:", "MedHistory", demographicNo, appNo, endDate, true)));
			   request.setAttribute("familyHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Family History:", "FamHistory", demographicNo, appNo, endDate, true)));
			   request.setAttribute("ocularMedication",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Ocular Medications:", "OcularMedication", demographicNo, appNo, endDate, true)));
			   
				request.setAttribute("PatientLog",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Patient Log:", "PatientLog", demographicNo, appNo, endDate, true)));
				request.setAttribute("Misc",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Misc:", "Misc", demographicNo, appNo, endDate, true)));

			   IssueDAO issueDao = (IssueDAO)SpringUtils.getBean("IssueDAO");

			   String customCppIssues[] = OscarProperties.getInstance().getProperty("encounter.custom_cpp_issues", "").split(",");
			   
				// Error check
				if (customCppIssues.length == 1 && (customCppIssues[0] == null || customCppIssues[0].length() == 0))
					customCppIssues = new String[0];
			   
			   for(String customCppIssue:customCppIssues) {
				   Issue i = issueDao.findIssueByCode(customCppIssue);
				   if(i != null) {
					   request.setAttribute(customCppIssue,StringEscapeUtils.escapeJavaScript(getFormattedCppItem(i.getDescription()+":", customCppIssue, demographicNo, appNo, endDate, true)));
				   }
			   }
		   //}

		   request.setAttribute("otherMeds",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Other Meds:", "OMeds", demographicNo, appNo, endDate, true)));

			// Allergies and Prescriptions
			request.setAttribute( "aller", StringEscapeUtils.escapeJavaScript(getFormattedAllergies(demographicNo, appNo, endDate, true)) );
			request.setAttribute( "presc", StringEscapeUtils.escapeJavaScript(getFormattedPrescriptions(demographicNo, appNo, endDate, true)) );

		   SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		   List<EyeformOcularProcedure> ocularProcs = ocularProcDao.getHistory(demographicNo, new Date(), "A");
		   StringBuilder ocularProc = new StringBuilder();
		   for(EyeformOcularProcedure op:ocularProcs) {
               ocularProc.append(sf.format(op.getDate()) + " ");
               ocularProc.append(op.getEye() + " ");
               ocularProc.append(op.getProcedureName() + " at " + op.getLocation());
               ocularProc.append(" by " + providerDao.getProvider(op.getDoctor()).getFormattedName());
               if (op.getProcedureNote() != null && !"".equalsIgnoreCase(op.getProcedureNote().trim()))
            	   ocularProc.append(". " + op.getProcedureNote() + "\n");
		   }
           String strOcularProcs = ocularProc.toString();
           if (strOcularProcs != null && !"".equalsIgnoreCase(strOcularProcs.trim()))
        	   strOcularProcs = "Past Ocular Procedures:\n" + strOcularProcs;
           else
        	   strOcularProcs = "";
           request.setAttribute("ocularProc", StringEscapeUtils.escapeJavaScript(strOcularProcs));


           List<EyeformSpecsHistory> specs = specsHistoryDao.getAllPreviousAndCurrent(demographicNo, appNo);
           StringBuilder specsStr = new StringBuilder();
           for(EyeformSpecsHistory spec:specs) {
        	   String specDate = sf.format(spec.getDate());
        	   specsStr.append(specDate + " ");

               StringBuilder data = new StringBuilder("");
               data.append(" OD ");
               StringBuilder dataTemp = new StringBuilder("");
               dataTemp.append(spec.getOdSph() == null ? "" : spec.getOdSph());
               dataTemp.append(spec.getOdCyl() == null ? "" : spec.getOdCyl());
               if (spec.getOdAxis() != null
                               && spec.getOdAxis().trim().length() != 0)
                       dataTemp.append("x" + spec.getOdAxis());
               if (spec.getOdAdd() != null && spec.getOdAdd().trim().length() != 0)
                       dataTemp.append(" add " + spec.getOdAdd());
               if(spec.getOdPrism() != null && spec.getOdPrism().length()>0) {
            	   dataTemp.append(" prism " + spec.getOdPrism());
               }
               specsStr.append(dataTemp.toString());
               specsStr.append("\n           ");
               data.append(dataTemp);

               String secHead = "\n      OS ";
               data.append(secHead);
               dataTemp = new StringBuilder("");
               dataTemp.append(spec.getOsSph() == null ? "" : spec.getOsSph());
               dataTemp.append(spec.getOsCyl() == null ? "" : spec.getOsCyl());
               if (spec.getOsAxis() != null && spec.getOsAxis().trim().length() != 0)
            	   dataTemp.append("x" + spec.getOsAxis());
               if (spec.getOsAdd() != null && spec.getOsAdd().trim().length() != 0)
            	   dataTemp.append(" add " + spec.getOsAdd());

               if(spec.getOsPrism() != null && spec.getOsPrism().length()>0) {
            	   dataTemp.append(" prism " + spec.getOsPrism());
               }

               specsStr.append(dataTemp.toString() + "\n");
               data.append(dataTemp);
           }
           String specsStr1 = "";
           if (specsStr != null && specs.size()>0)
               specsStr1  = "Spectacles:\n" + specsStr.toString();
           else
    	   		specsStr1 = "";

           request.setAttribute("specs", StringEscapeUtils.escapeJavaScript(specsStr1));

           
           //logger.info("appNo="+appNo);
           if(requestId > 0) {
        	   //get the saved app no.
        	   String tmp = consultationRequestExtDao.getConsultationRequestExtsByKey(requestId, "appNo");
        	   appNo = Integer.parseInt(tmp);
        	   request.setAttribute("appNo",appNo);
           }           
           
			//impression
			String impression = getFormattedCppItem("Impression:", "eyeformImpression", demographicNo, appNo, endDate, false);
			impression = impression.replaceAll("\\[Signed on.*?\\]", "");
			request.setAttribute( "impression", StringEscapeUtils.escapeJavaScript(impression) );



           //followUp
           FollowUpDao followUpDao = (FollowUpDao)SpringUtils.getBean("FollowUpDAO");
           List<EyeformFollowUp> followUps = followUpDao.getByAppointmentNo(appNo);
           StringBuilder followup = new StringBuilder();
           for(EyeformFollowUp ef:followUps) {
				if (ef.getTimespan() >0) {
					followup.append((ef.getType().equals("followup")?"Follow Up":"Consult") + " in " + ef.getTimespan() + " " + ef.getTimeframe());
				}
           }

           //get the checkboxes
           EyeForm eyeform = eyeFormDao.getByAppointmentNo(appNo);
           if(eyeform != null) {
	           if (eyeform.getDischarge() != null && eyeform.getDischarge().equals("true"))
					followup.append("Patient is discharged from my active care.\n");
	           if (eyeform.getStat() != null && eyeform.getStat().equals("true"))
					followup.append("Follow up as needed with me STAT or PRN if symptoms are worse.\n");
	           if (eyeform.getOpt() != null && eyeform.getOpt().equals("true"))
					followup.append("Routine eye care by an optometrist is recommended.\n");
           }

           request.setAttribute("followup", StringEscapeUtils.escapeJavaScript(followup.toString()));


           //test book
           TestBookRecordDao testBookDao = (TestBookRecordDao)SpringUtils.getBean("TestBookDAO");
           List<EyeformTestBook> testBookRecords = testBookDao.getByAppointmentNo(appNo);
           StringBuilder testbook = new StringBuilder();
           for(EyeformTestBook tt:testBookRecords) {
        	   testbook.append(tt.getTestname());
   				testbook.append(" ");
   				testbook.append(tt.getEye());
   				testbook.append("\n");
           }
           if (testbook.length() > 0)
        	   testbook.insert(0, "Diagnostic test booking:");
           request.setAttribute("testbooking", StringEscapeUtils.escapeJavaScript(testbook.toString()));


           //procedure book
           ProcedureBookDao procBookDao = (ProcedureBookDao)SpringUtils.getBean("ProcedureBookDAO");
           List<EyeformProcedureBook> procBookRecords = procBookDao.getByAppointmentNo(appNo);
           StringBuilder probook = new StringBuilder();
           for(EyeformProcedureBook pp:procBookRecords) {
        	   probook.append(pp.getProcedureName());
        	   probook.append(" ");
        	   probook.append(pp.getEye());
        	   probook.append("\n");
           }
           if (probook.length() > 0)
        	   probook.insert(0, "Procedure booking:");
           request.setAttribute("probooking", StringEscapeUtils.escapeJavaScript(probook.toString()));

           //measurements
           MeasurementsDao measurementsDao = (MeasurementsDao) SpringUtils.getBean("measurementsDao");
           if(requestId > 0) {
        	   String tmp = consultationRequestExtDao.getConsultationRequestExtsByKey(requestId, "specialProblem");
        	   request.setAttribute("specialProblem", StringEscapeUtils.escapeJavaScript(tmp));
           } else {
        	   request.setAttribute("specialProblem", "");
           }

		   return mapping.findForward("conspecial");
	   }
	   
	   private List<Allergy> getAllergies(int demographicNo, int appointmentNo, Date endDate, boolean includePrevious) {
		   List<Allergy> allergies = allergyDao.findAllergies(demographicNo);
		   
		   if (endDate != null) {
				if( !includePrevious ) {
					allergies = filterAllergiesByDate( allergies, endDate );
				} else {
					allergies = filterAllergiesByPreviousOrCurrentDate( allergies, endDate );
				}
		   }
		   
		   return allergies;
	   }
	   
	   public String getFormattedAllergies(int demographicNo, int appointmentNo, Date endDate, boolean includePrevious) {
		   List<Allergy> allergies = getAllergies(demographicNo, appointmentNo, endDate, includePrevious);
		   
		   if ( allergies.size() > 0 ) {
			   StringBuilder sb = new StringBuilder();
			   for (Allergy a : allergies) {
				   sb.append("\n");
				   sb.append(a.getDescription());
				   if (a.getSeverityOfReactionDesc() != null)
						sb.append(" (" + a.getSeverityOfReactionDesc() + ")");
			   }
			   
			   return "Allergies:" + sb.toString() + "\n";
		   }
		   
		   return "";
	   }
	   
	   // TODO: filter by appointment number
	   private List<Prescription> getPrescriptions(int demographicNo, int appointmentNo, Date endDate, boolean includePrevious) {
		   List<Prescription> prescriptions = prescriptionDao.findByDemographicId(demographicNo);
		   
		   if (endDate != null) {
				if( !includePrevious ) {
					prescriptions = filterPrescriptionsByDate( prescriptions, endDate );
				} else {
					prescriptions = filterPrescriptionsByPreviousOrCurrentDate( prescriptions, endDate );
				}
		   }
		   
		   return prescriptions;
	   }
	   
	   public String getFormattedPrescriptions(int demographicNo, int appointmentNo, Date endDate, boolean includePrevious) {
		   List<Prescription> prescriptions = getPrescriptions(demographicNo, appointmentNo, endDate, includePrevious);
		   
		   if ( prescriptions.size() > 0 ) {
			   StringBuilder sb = new StringBuilder();
			   Date now = new java.util.Date();
			   
			   for (Prescription p : prescriptions) {
				   List<Drug> drugs = p.getDrugs();
				   for ( Drug d : drugs ) {
					   if ( !d.getEndDate().after(now) )
							continue;
						sb.append("\n");
					   /*
					   if (d.getBrandName() != null) {
							sb.append(d.getBrandName() + "\n");
						if (d.getCustomName() != null)
							sb.append(d.getCustomName() + "\n");
						if (d.getQuantity() != null)
							sb.append("Quantity: " + d.getQuantity() + "\n");
						if (d.getRepeat() != null && d.getRepeat() != 0)
							sb.append("Repeats: " + d.getRepeat() + "\n");
						if (p.getComments() != null)
							sb.append(p.getComments() + "\n");
						*/
						sb.append(d.getSpecial());
					}
			   }
			   
			   return "Prescriptions:" + sb.toString() + "\n";
		   }
		   
		   return "";
	   }

	   public String getFormattedCppItemFromMeasurements(String header, String measurementType, int demographicNo, int appointmentNo, boolean includePrevious) {
		  Measurements measurement = measurementsDao.getLatestMeasurementByDemographicNoAndType(demographicNo,measurementType);
		  if(measurement == null) {
			  return new String();
		  }
		  if(!includePrevious) {
			  if(measurement.getAppointmentNo() != appointmentNo) {
				  return new String();
			  }
		  }

		  StringBuilder sb = new StringBuilder();
		  sb.append("\n");
		  sb.append(measurement.getDataField());

		  return header + sb.toString();
	   }
	   
	   private Collection<CaseManagementNote> getCppItems(String issueCode, int demographicNo, int appointmentNo, Date endDate, boolean includePrevious) {
		   List<String> issues = new ArrayList<String>();
		   issues.add( issueCode );
		   
		   return getCppItems(issues, demographicNo, appointmentNo, endDate, includePrevious);
	   }
	   
	   private Collection<CaseManagementNote> getCppItems(List<String> issueCodes, int demographicNo, int appointmentNo, Date endDate, boolean includePrevious) {
		   Collection<CaseManagementNote> notes = null;
			
			if (issueCodes == null || issueCodes.size() == 0)
				return notes;
			
			String[] issues = new String[issueCodes.size()];
			issueCodes.toArray(issues);
			
			if (endDate != null) {
				if( !includePrevious ) {
					notes = filterNotesByDate( caseManagementNoteDao.findNotesByDemographicAndIssueCode(demographicNo, issues), endDate );
				} else {
					notes = filterNotesByPreviousOrCurrentDate( caseManagementNoteDao.findNotesByDemographicAndIssueCode(demographicNo, issues), endDate );
				}
			} else if( !includePrevious ) {
				notes = filterNotesByAppointment(caseManagementNoteDao.findNotesByDemographicAndIssueCode(demographicNo, issues),appointmentNo);
			} else {
				notes = filterNotesByPreviousOrCurrentAppointment(caseManagementNoteDao.findNotesByDemographicAndIssueCode(demographicNo, issues),appointmentNo);
			}
			
			//since current history has a different format
			
			if(issueCodes.contains("CurrentHistory") || issueCodes.contains("eyeformCurrentIssue")){
				 
				 CaseManagementNote closestBeforeDate = null;
				 
				for(CaseManagementNote note:notes) {
					if(closestBeforeDate==null)
					{	closestBeforeDate = note;	}
					else if(note.getObservation_date().compareTo(closestBeforeDate.getObservation_date()) >= 0) {
						closestBeforeDate = note;
					}
				}
		   
				notes = new ArrayList<CaseManagementNote>();
				notes.add(closestBeforeDate);
			}

		   return notes;
	   }

	   public String getFormattedCppItem(String header, List<String> issueCodes, int demographicNo, int appointmentNo, Date endDate, boolean includePrevious) {
		   Collection<CaseManagementNote> notes = getCppItems(issueCodes, demographicNo, appointmentNo, endDate, includePrevious);
			
			if (notes == null)
			{	
				String output = "";
				for (String s : issueCodes){
					output += s + ", ";
				}
				MiscUtils.getLogger().info("Found nothing for " + output);
				return "";
			}
		   if(notes.size()>0) {
			   StringBuilder sb = new StringBuilder();
			   for(CaseManagementNote note:notes) {
				   sb.append("\n");
				   sb.append(note.getNote());
			   }
			   return header + sb.toString();
		   }

		   return "";
	   }
	   
	   public String getFormattedCppItem(String header, String issueCode, int demographicNo, int appointmentNo, Date endDate, boolean includePrevious) {
		   List<String> issues = new ArrayList<String>();
		   issues.add( issueCode );
		   
		   return getFormattedCppItem(header, issues, demographicNo, appointmentNo, endDate, includePrevious);
	   }
/*
	   private String getCppItemAsString(String demo, String issueCode, String text) {
		   if(cmm==null)
			   cmm=(CaseManagementManager) SpringUtils.getBean("caseManagementManager");

		   Issue issue = cmm.getIssueInfoByCode(issueCode);
		   if(issue ==null) {logger.warn("no issue for current history");return "";}
		   List<CaseManagementNote> notes = cmm.getCPP(demo, issue.getId(), null);
		   StringBuilder sb = new StringBuilder();
		   for(CaseManagementNote note:notes) {
			   sb.append(note.getNote()).append("\n");
		   }
		   logger.info(issueCode +":" + sb.toString());

		   return text + "\n" + sb.toString();
	   }
*/
	   private String getImpression(Integer demographicNo, int appointmentNo) {
		   List<CaseManagementNote> notes = caseManagementNoteDao.getMostRecentNotes(demographicNo, appointmentNo);
		   notes = filterOutCpp(notes);
		   if(notes.size()>0) {
			   StringBuilder sb = new StringBuilder();
			   for(CaseManagementNote note:notes) {
				   sb.append(note.getNote()).append("\n");
			   }
			   //return "Impression:" + "\n" + sb.toString();
			   return sb.toString();
		   }
		   return new String();
	   }

	   public ActionForward print(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		   response.setContentType("application/pdf"); // octet-stream
			response.setHeader("Content-Disposition", "attachment; filename=\"Encounter-" + UtilDateUtilities.getToday("yyyy-MM-dd.hh.mm.ss") + ".pdf\"");
			doPrint(request, response.getOutputStream());
			return null;
	   }


	   public void doPrint(HttpServletRequest request, OutputStream os) throws Exception, IOException, DocumentException {
			String ids[] = request.getParameter("apptNos").split(",");
			String providerNo = LoggedInInfo.loggedInInfo.get().loggedInProvider.getProviderNo();
			String endDateAsString = request.getParameter("endDate");
			
			// The demographic number only comes in certain situations - namely, when printing an impression note from the EyeForm
			String demographicNoAsString = request.getParameter("demographicNo");
			
			// The end date to use when looking up appointments with id 0
			Date endDate = null;
			if (endDateAsString != null) {
				try {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					endDate = formatter.parse(endDateAsString);
					endDate = getEndOfDayVersion(endDate);
				} catch (ParseException e) {
					MiscUtils.getLogger().error("Error", e);
				}
			}
			
			// The dates to use when looking up appointments with id 0
			/*
			String[] apptZeroDateStrings = new String[0];
			if (request.getParameter("apptZeroDates") != null)
				apptZeroDateStrings = request.getParameter("apptZeroDates").split(",");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			List<Date> apptZeroDates = new ArrayList<Date>();
			
			// Convert to Java Date Object(s)
			for (int i=0; i < apptZeroDateStrings.length; i++) {
				Date date = sdf.parse( apptZeroDateStrings[i] );
				apptZeroDates.add( date );
			}
				
			if (apptZeroDates.size() == 0)
				apptZeroDates = null;
			*/
			String cpp = request.getParameter("cpp");
			
			boolean cppFromMeasurements=false;
			if(cpp != null && cpp.equals("measurements")) {
				cppFromMeasurements=true;
			}

			PdfCopyFields finalDoc = new PdfCopyFields(os);
			finalDoc.getWriter().setStrictImageSequence(true);
			PdfRecordPrinter printer = new PdfRecordPrinter(request, os);

			//loop through each visit..concatenate into 1 PDF
			for(int x=0;x<ids.length;x++) {
				//List<Date> apptDates = null;

				if(x>0) {
					printer.setNewPage(true);
				}

				// Try to find the appointment
				int appointmentNo = Integer.parseInt(ids[x]);
				Appointment appointment = appointmentDao.find(appointmentNo);
				
				int demographicNo = 0;
				
				if (appointmentNo == 0) {
					try {
						demographicNo = Integer.parseInt(demographicNoAsString);
					} catch (Exception e) {
						logger.error("Unable to parse demographic number.");
					}
				}
				
				
				//need to get notes first to set the signing provider
				List<CaseManagementNote> notes = null;
				if (appointment != null && appointmentNo != 0) {
					// Get all notes for appointment (if the appointment was found)
					notes = caseManagementNoteDao.getMostRecentNotesByAppointmentNo(appointmentNo);
					demographicNo = appointment.getDemographicNo();
				} else if (appointmentNo == 0 && demographicNo != 0 && endDate != null) {
					notes = caseManagementNoteDao.getMostRecentNotesByDemographicNo(demographicNo, endDate);
				} else {
					logger.error("No demographic number or valid appointment number provided.");
					throw new Exception("No demographic number or valid appointment number provided.");
				}
				
				if (demographicNo == 0) {
					logger.error("Unable to get valid demographic number.");
					throw new Exception("Unable to get valid demographic number.");
				}
				
				notes = filterOutCpp(notes);
				if(notes.size()>0) {
					String tmp = notes.get(0).getSigning_provider_no();
					if(tmp != null && tmp.length()>0) {
						Provider signingProvider = providerDao.getProvider(tmp);
						if(signingProvider != null) {
							printer.setSigningProvider(signingProvider.getFormattedName());
						}
					}
				}
				
				Demographic demographic = demographicDao.getClientByDemographicNo(demographicNo);
				printer.setDemographic(demographic);
				printer.setAppointment(appointment);
				
				
				printer.printDocHeaderFooter();
				
				List<String> currentHistoryIssueNames = new ArrayList<String>();
				currentHistoryIssueNames.add("CurrentHistory");
				currentHistoryIssueNames.add("eyeformCurrentIssue");
				
				Collection<CaseManagementNote> cppNotes = null;
				
				cppNotes = getCppItems(currentHistoryIssueNames, demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Current History", cppNotes);
					printer.printBlankLine();
				}
				
				cppNotes = getCppItems("PastOcularHistory", demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Past Ocular History", cppNotes);
					printer.printBlankLine();
				}
				
				cppNotes = getCppItems("MedHistory", demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Medical History", cppNotes);
					printer.printBlankLine();
				}
				
				cppNotes = getCppItems("FamHistory", demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Family History", cppNotes);
					printer.printBlankLine();
				}
				
				cppNotes = getCppItems("DiagnosticNotes", demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Diagnostic Notes", cppNotes);
					printer.printBlankLine();
				}
				
				cppNotes = getCppItems("OcularMedication", demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Ocular Medications", cppNotes);
					printer.printBlankLine();
				}
				
				/*
				cppNotes = getCppItems("PatientLog", demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Patient Log", cppNotes);
					printer.printBlankLine();
				}
				*/
				
				/*
				cppNotes = getCppItems("Misc", demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Misc", cppNotes);
					printer.printBlankLine();
				}
				*/
				
				cppNotes = getCppItems("OMeds", demographicNo, appointmentNo, endDate, true);
				if (cppNotes != null && cppNotes.size() > 0) {
					printer.printCPPItem("Other Medications", cppNotes);
					printer.printBlankLine();
				}
				
				
				IssueDAO issueDao = (IssueDAO)SpringUtils.getBean("IssueDAO");
				String customCppIssues[] = OscarProperties.getInstance().getProperty("encounter.custom_cpp_issues", "").split(",");
				
				// Error check
				if (customCppIssues.length == 1 && (customCppIssues[0] == null || customCppIssues[0].length() == 0))
					customCppIssues = new String[0];
				
				for(String customCppIssue:customCppIssues) {
					Issue i = issueDao.findIssueByCode(customCppIssue);
					if(i != null) {
						cppNotes = getCppItems(customCppIssue, demographicNo, appointmentNo, endDate, true);
						if (cppNotes != null && cppNotes.size() > 0) {
							printer.printCPPItem(i.getDescription(), cppNotes);
							printer.printBlankLine();
						}
					}
				}

				printer.setNewPage(true);

				//ocular procs
				List<EyeformOcularProcedure> ocularProcs = null;
				if (endDate != null)
					ocularProcs = ocularProcDao.getAllByBeforeDate(demographicNo, appointmentNo, endDate);
				else
					ocularProcs = ocularProcDao.getAllPreviousAndCurrent(demographicNo, appointmentNo);

				if(ocularProcs.size()>0) {
					printer.printOcularProcedures(ocularProcs);
				}

				//specs history
				List<EyeformSpecsHistory> specsHistory = null;
				if (endDate != null)
					specsHistory = specsHistoryDao.getAllByBeforeDate(demographicNo, appointmentNo, endDate);
				else
					specsHistory = specsHistoryDao.getAllPreviousAndCurrent(demographicNo, appointmentNo);

				if(specsHistory.size()>0) {
					printer.printSpecsHistory(specsHistory);
				}
				
				//allergies
				List<Allergy> allergies = getAllergies(demographicNo, appointmentNo, endDate, true);
				if(allergies.size()>0) {
					printer.printAllergies(allergies);
				}
				
				List<Prescription> prescriptions = getPrescriptions(demographicNo, appointmentNo, endDate, true);
				if(prescriptions.size()>0) {
					printer.printRx(prescriptions);
				}

				//measurements
				List<Measurements> measurements = null;
				if (endDate != null)
					measurements = measurementsDao.getMeasurementsBeforeDate(demographicNo, endDate);
				else if (appointmentNo != 0)
					measurements = measurementsDao.getMeasurements(appointmentNo, demographicNo);
				else
					measurements = measurementsDao.getMeasurements(demographicNo);

				if(measurements.size()>0) {
					MeasurementFormatter formatter = new MeasurementFormatter(measurements);
					printer.printEyeformMeasurements(formatter);
				}
				
				
				//impression
				//let's filter out custom cpp notes, as they will already have been
				//printed out in CPP section
				List<CaseManagementNote> filteredNotes = new ArrayList<CaseManagementNote>();
				for(CaseManagementNote note:notes) {
					boolean okToAdd=true;
					for(String i:customCppIssues) {
						if(containsIssue(note.getId().intValue(),i)) {
							okToAdd=false;
							break;
						}
					}
					if(okToAdd)
						filteredNotes.add(note);
				}
				if(filteredNotes.size()>0) {
					printer.printNotes(filteredNotes);
				}

				//plan - followups/consults, procedures booked, tests booked, checkboxes
				/*
				List<FollowUp> followUps = followUpDao.getByAppointmentNo(appointmentNo);
				List<ProcedureBook> procedureBooks = procedureBookDao.getByAppointmentNo(appointmentNo);
				List<TestBookRecord> testBooks = testBookDao.getByAppointmentNo(appointmentNo);
				EyeForm eyeform = eyeFormDao.getByAppointmentNo(appointmentNo);
		        printer.printEyeformPlan(followUps, procedureBooks, testBooks,eyeform);
				*/
				
				
		        //photos
		        DocumentResultsDao documentDao = (DocumentResultsDao)SpringUtils.getBean("documentResultsDao");
		        List<Document> documents = null;
		        
		        if (endDate != null)
					documents = documentDao.getPhotosByAppointmentNoAndBeforeDates(appointmentNo, endDate);
				else
					documents = documentDao.getPhotosByAppointmentNo(appointmentNo);

		        if(documents.size()>0) {
		        	String servletUrl  = request.getRequestURL().toString();
		        	String url = servletUrl.substring(0,servletUrl.indexOf(request.getContextPath())+request.getContextPath().length());
		        	printer.printPhotos(url,documents);
		        }

		        //diagrams
		        EFormValueDao eFormValueDao = (EFormValueDao) SpringUtils.getBean("EFormValueDao");
		        EFormGroupDao eFormGroupDao = (EFormGroupDao) SpringUtils.getBean("EFormGroupDao");
		        List<EFormGroup> groupForms = eFormGroupDao.getByGroupName("Eye form");
		        
		        // TODO: How will we filter this when appointment number is 0?
		        List<EFormValue> values = eFormValueDao.findByApptNo(appointmentNo);
		        List<EFormValue> diagrams = new ArrayList<EFormValue>();
		        for(EFormValue value:values) {
		        	int formId = value.getFormId();
		        	boolean include=false;
		        	for(EFormGroup group:groupForms) {
		        		if(group.getFormId() == formId) {
		        			include=true;
		        			break;
		        		}
		        	}
		        	if(include)
		        		diagrams.add(value);
		        }
		        if(diagrams.size()>0) {
		        	printer.printDiagrams(diagrams);
		        }

			} //end of loop

			printer.finish();

	   }

	   private boolean containsIssue(Integer noteId, String issueCode) {
			List<CaseManagementIssue> caseManagementIssues=caseManagementIssueNotesDao.getNoteIssues(noteId);
			for (CaseManagementIssue caseManagementIssue : caseManagementIssues) {
				if (caseManagementIssue.getIssue().getCode().equals(issueCode)) {
						return(true);
				}
			}
			return false;
		}


	   public int getNumMeasurementsWithoutCpp(List<Measurements> measurements) {
		   List<Measurements> filtered = new ArrayList<Measurements>();
		   for(Measurements m:measurements) {
			   if(m.getType().startsWith("cpp_")) {
				   continue;
			   }
			   filtered.add(m);
		   }
		   return filtered.size();
	   }

	   public void printCppItem(PdfRecordPrinter printer, String header, String issueCode, int demographicNo, int appointmentNo, boolean includePrevious) throws DocumentException {
		   printCppItem(printer, header, issueCode, null, demographicNo, appointmentNo, includePrevious);
	   }
	   
	   public void printCppItem(PdfRecordPrinter printer, String header, String issueCode, List<Date> dates, int demographicNo, int appointmentNo, boolean includePrevious) throws DocumentException {
			Collection<CaseManagementNote> notes = null;
			
			if (dates != null && dates.size() > 0)
				notes = caseManagementNoteDao.findNotesByDemographicAndIssueCodeInEyeform(demographicNo, new String[] {issueCode}, dates);
			else
				notes = caseManagementNoteDao.findNotesByDemographicAndIssueCodeInEyeform(demographicNo, new String[] {issueCode});
			
			if (!includePrevious)
				notes = filterNotesByAppointment(notes, appointmentNo);
			else
				notes = filterNotesByPreviousOrCurrentAppointment(notes, appointmentNo);
			
			if (notes.size() > 0) {
				printer.printCPPItem(header, notes);
				printer.printBlankLine();
			}
	   }

	   public void printCppItemFromMeasurements(PdfRecordPrinter printer, String header, String measurementType, int demographicNo, int appointmentNo, boolean includePrevious) throws DocumentException {
			  Measurements measurement = measurementsDao.getLatestMeasurementByDemographicNoAndType(demographicNo,measurementType);
			  if(measurement == null) {
				  return;
			  }
			  if(!includePrevious) {
				  if(measurement.getAppointmentNo() != appointmentNo) {
					  return;
				  }
			  }

			  printer.printCPPItem(header, measurement);
			  printer.printBlankLine();

		   }

	   public Collection<CaseManagementNote> filterNotesByAppointment(Collection<CaseManagementNote> notes, int appointmentNo) {
		   List<CaseManagementNote> filteredNotes = new ArrayList<CaseManagementNote>();
		   for(CaseManagementNote note:notes) {
			   if (note.isArchived())
					continue;

			   if(note.getAppointmentNo() == appointmentNo) {
				   filteredNotes.add(note);
			   }
		   }
		   return filteredNotes;
	   }

	   public Collection<CaseManagementNote> filterNotesByPreviousOrCurrentAppointment(Collection<CaseManagementNote> notes, int appointmentNo) {
		   List<CaseManagementNote> filteredNotes = new ArrayList<CaseManagementNote>();
		   for(CaseManagementNote note:notes) {
			   if (note.isArchived())
					continue;

			   if(note.getAppointmentNo() <= appointmentNo) {
				   filteredNotes.add(note);
			   }
		   }
		   return filteredNotes;
	   }
	   
	   private Date getBeginningOfDayVersion(Date date) {
			Calendar cal = new GregorianCalendar();

			cal.setTime(date);
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);

			return cal.getTime();
	   }
	   
	   private Date getEndOfDayVersion(Date date) {
			Calendar cal = new GregorianCalendar();

			cal.setTime(date);
			cal.set(Calendar.HOUR_OF_DAY, 22);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 59);

			return cal.getTime();
	   }
	   
	   public List<Prescription> filterPrescriptionsByDate(List<Prescription> prescriptions, Date endDate) {
		   Date endDateMidnight = getBeginningOfDayVersion(endDate);
		   Date now = new java.util.Date();
		   
		   List<Prescription> filteredPrescriptions = new ArrayList<Prescription>();
		   
		   for ( Prescription p : prescriptions) {
				boolean hasAVAlidDrug = false;
				for ( Drug d : p.getDrugs() ) {
					if ( d.getEndDate().after(now) ) {
						hasAVAlidDrug = true;
						break;
					}
				}

			   if ( hasAVAlidDrug && p.getDatePrescribed().compareTo(endDateMidnight) > 0 && p.getDatePrescribed().compareTo(endDate) <= 0) {
				   filteredPrescriptions.add(p);
			   }
		   }
		   
		   return filteredPrescriptions;
	   }
	   
	   public List<Prescription> filterPrescriptionsByPreviousOrCurrentDate(List<Prescription> prescriptions, Date endDate) {		   
		   Date now = new java.util.Date();
		   
		   List<Prescription> filteredPrescriptions = new ArrayList<Prescription>();
		   
		   for ( Prescription p : prescriptions) {			   
			   boolean hasAVAlidDrug = false;
				for ( Drug d : p.getDrugs() ) {
					if ( d.getEndDate().after(now) ) {
						hasAVAlidDrug = true;
						break;
					}
				}

			   if ( hasAVAlidDrug && p.getDatePrescribed().compareTo(endDate) <= 0) {
				   filteredPrescriptions.add(p);
			   }
		   }
		   
		   return filteredPrescriptions;
	   }
	   
	   public List<Allergy> filterAllergiesByDate(List<Allergy> allergies, Date endDate) {
		   Date endDateMidnight = getBeginningOfDayVersion(endDate);
		   
		   List<Allergy> filteredAllergies = new ArrayList<Allergy>();
		   
		   for ( Allergy p : allergies) {
			   if ( p.getEntryDate().compareTo(endDateMidnight) > 0 && p.getEntryDate().compareTo(endDate) <= 0) {
				   filteredAllergies.add(p);
			   }
		   }
		   
		   return filteredAllergies;
	   }
	   
	   public List<Allergy> filterAllergiesByPreviousOrCurrentDate(List<Allergy> allergies, Date endDate) {		   
		   List<Allergy> filteredAllergies = new ArrayList<Allergy>();
		   
		   for ( Allergy p : allergies) {
			   if ( p.getEntryDate().compareTo(endDate) <= 0) {
				   filteredAllergies.add(p);
			   }
		   }
		   
		   return filteredAllergies;
	   }
	   
	   public Collection<CaseManagementNote> filterNotesByDate(Collection<CaseManagementNote> notes, Date endDate) {
		   Date endDateMidnight = getBeginningOfDayVersion(endDate);
		   
		   List<CaseManagementNote> filteredNotes = new ArrayList<CaseManagementNote>();
		   
		   for ( CaseManagementNote note : notes) {
			   if (note.isArchived())
					continue;

			   if ( note.getObservation_date().compareTo(endDateMidnight) > 0 && note.getObservation_date().compareTo(endDate) <= 0) {
				   filteredNotes.add(note);
			   }
		   }
		   
		   return filteredNotes;
	   }

	   public Collection<CaseManagementNote> filterNotesByPreviousOrCurrentDate(Collection<CaseManagementNote> notes, Date endDate) {
		   List<CaseManagementNote> filteredNotes = new ArrayList<CaseManagementNote>();
		   
		   for ( CaseManagementNote note : notes ) {
			   if (note.isArchived())
					continue;

			   if ( note.getObservation_date().compareTo(endDate) <= 0 ) {
				   filteredNotes.add(note);
			   }
		   }
		   
		   return filteredNotes;
	   }

	   public List<Measurements> filterMeasurementsByAppointment(List<Measurements> measurements, int appointmentNo) {
		   List<Measurements> filteredMeasurements = new ArrayList<Measurements>();
		   for(Measurements measurement:measurements) {
			   if(measurement.getAppointmentNo() == appointmentNo) {
				   filteredMeasurements.add(measurement);
			   }
		   }
		   return filteredMeasurements;
	   }

	   public List<Measurements> filterMeasurementsByPreviousOrCurrentAppointment(List<Measurements> measurements, int appointmentNo) {
		   List<Measurements> filteredMeasurements = new ArrayList<Measurements>();
		   for(Measurements measurement:measurements) {
			   if(measurement.getAppointmentNo() <= appointmentNo) {
				   filteredMeasurements.add(measurement);
			   }
		   }
		   return filteredMeasurements;
	   }

	   public List<CaseManagementNote> filterOutCpp(Collection<CaseManagementNote> notes) {
		   List<CaseManagementNote> filteredNotes = new ArrayList<CaseManagementNote>();
		   for(CaseManagementNote note:notes) {
			   boolean skip=false;
			   
			 if (note.getIssues() == null || note.getIssues().size() == 0)
				skip = true;
			   
			 for(CaseManagementIssue issue:note.getIssues()) {
				 for(int x=0;x<cppIssues.length;x++) {
					 if(issue.getIssue().getCode().equals(cppIssues[x])) {
						 skip=true;
					 }
				 }
			 }
			 if(!skip) {
				 filteredNotes.add(note);
			 }
		   }
		   return filteredNotes;
	   }

	   public ActionForward prepareConReport(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
		   String demoNo = request.getParameter("demographicNo");
		   String appointmentNo = request.getParameter("appNo");
		   String endDateAsString = request.getParameter("endDate");
		   String cpp = request.getParameter("cpp");
		   boolean cppFromMeasurements=false;
		   if(cpp != null && cpp.equals("measurements")) {
			   cppFromMeasurements=true;
		   }

		   Integer demographicNo = new Integer(demoNo);
		   Integer appNo = new Integer(0);
		   if (appointmentNo != null && appointmentNo.trim().length() > 0)
				appNo = new Integer(appointmentNo);
			
			Date endDate = null;
			if (endDateAsString != null) {
				try {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					endDate = formatter.parse(endDateAsString);
					endDate = getEndOfDayVersion(endDate);
				} catch (ParseException e) {
					MiscUtils.getLogger().error("Error", e);
				}
			}


		   Provider provider = LoggedInInfo.loggedInInfo.get().loggedInProvider;
		   Demographic demographic = demographicDao.getClientByDemographicNo(demographicNo);

		   request.setAttribute("demographicNo", demoNo);
		   request.setAttribute("demographicName", demographic.getFormattedName());
		   request.setAttribute("endDate", endDateAsString);

			//demographic_ext
			String famName = new String();

			DemographicExt famExt = demographicExtDao.getDemographicExt(demographic.getDemographicNo(),"Family_Doctor");
			if(famExt != null) {
				famName = famExt.getValue();
			}
			request.setAttribute("famName", famName);

			EyeformConsultationReport cp = new EyeformConsultationReport();
			String refNo = null;
			String referraldoc = new String();

			//referralNo and referral_doc_name
			String famXml = demographic.getFamilyDoctor();
			if(famXml != null && famXml.length()>0) {
				refNo = SxmlMisc.getXmlContent(famXml,"rdohip");
				referraldoc = SxmlMisc.getXmlContent(famXml,"rd");
				request.setAttribute("referral_doc_name", referraldoc);
				cp.setReferralNo(refNo);
			}

			DemographicContactDao demographicContactDao = (DemographicContactDao)SpringUtils.getBean("demographicContactDao");
			List<DemographicContact> contacts = demographicContactDao.findByDemographicNoAndCategory(demographicNo, "professional");
			contacts = ContactAction.fillContactNames(contacts);
			
			ContactAction.removeDuplicates(contacts);
			
			request.setAttribute("contacts", contacts);
			
			DemographicContact dc = demographicContactDao.getFamilyDoctor( demographicNo );
			List<DemographicContact> dcList = new ArrayList<DemographicContact>();
			if (dc != null)
				dcList.add( dc );
			dcList = ContactAction.fillContactNames(dcList);
			request.setAttribute("family_doc_contact", dcList);


			if (!"saved".equalsIgnoreCase((String) request.getAttribute("savedflag"))
					&& "new".equalsIgnoreCase(request.getParameter("flag"))) {

				cp.setDemographicNo(demographicNo);
				cp.setProviderNo(provider.getProviderNo());
				cp.setAppointmentNo(appNo);
				cp.setDate(new Date());
				cp.setReason(demographic.getFormattedName() + " ");
				cp.setUrgency("Non-urgent");
				cp.setStatus("Incomplete");
				request.setAttribute("newFlag", "true");
			} else {
				String cpId = request.getParameter("conReportNo");
				if ("saved".equalsIgnoreCase((String) request.getAttribute("savedflag"))) {
					cpId = (String) request.getAttribute("cpId");
				}
				ConsultationReportDao crDao = (ConsultationReportDao)SpringUtils.getBean("consultationReportDao");
				cp = crDao.find(new Integer(cpId));
				request.setAttribute("newFlag", "false");
				appNo = cp.getAppointmentNo();

				List<ProfessionalSpecialist> specialists = professionalSpecialistDao.findByReferralNo(cp.getReferralId());
				ProfessionalSpecialist specialist = null;
				
				if (specialists != null && specialists.size() > 0)
					specialist = specialists.get(0);
				
				if(specialist != null) {
					referraldoc = specialist.getLastName() + "," + specialist.getFirstName();
					request.setAttribute("referral_doc_name", referraldoc);
					cp.setReferralNo(specialist.getReferralNo());
					refNo = specialist.getReferralNo();
				}
				
				// Set endDate from the consultation report
				Date d = cp.getDate();
				logger.info("date1: " + d.toString());
				if (d != null && endDate == null) {
					endDate = getEndOfDayVersion(d);
					logger.info("date2: " + endDate);
				}
				
				Appointment appt = null;
				if (cp.getAppointmentNo() != 0)
					appt = appointmentDao.find(cp.getAppointmentNo());
				logger.info("cp.getAppointmentNo(): " + cp.getAppointmentNo());
				// If appt date is after consultation creation date, use the appt date as the end date
				if (appt != null && endDate != null) {
					logger.info("date3: " + appt.getAppointmentDate());
					if ( appt.getAppointmentDate().compareTo(endDate) > 0 )
						endDate = getEndOfDayVersion( appt.getAppointmentDate() );
					logger.info("date4: " + endDate);
				}
			}

			request.setAttribute("providerName",providerDao.getProvider(cp.getProviderNo()).getFormattedName());

			List<Clinic> clinics = clinicDao.findAll();
			request.setAttribute("clinics", clinics);

			List<Site> sites = siteDao.getActiveSitesByProviderNo((String) request.getSession().getAttribute("user"));
			request.setAttribute("sites", sites);

			Integer appt_no= cp.getAppointmentNo();
			Site defaultSite = null;
			if(cp.getSiteId() == null) {
			  Integer siteId = null;
			  if (appt_no != null) {
				Appointment appt = appointmentDao.find(appt_no);
				if (appt != null) {
				    siteId = appt.getSite();
					for (int i = 0; i < sites.size(); i++) {
						Site s = sites.get(i);
						if (s.getId().equals(siteId)) {
							defaultSite = s;
							cp.setSiteId(defaultSite.getSiteId());
							break;
						}
					}
			    }
			  } 
			} else {
				for (int i = 0; i < sites.size(); i++) {
					Site s = sites.get(i);
					if (s.getId() == cp.getSiteId()) {
						defaultSite = s;
						break;
					}
				}					
			}

			DynaValidatorForm crForm = (DynaValidatorForm) form;
			crForm.set("cp", cp);

			//loades latest eyeform

			if ("".equalsIgnoreCase(refNo)) {
				String referral = demographic.getFamilyDoctor();

				if (referral != null && !"".equals(referral.trim())) {
					String ref = getRefId(referral);
					cp.setReferralId(ref);
					refNo = getRefNo(referral);

					List<ProfessionalSpecialist> refList = professionalSpecialistDao.findByReferralNo(refNo);
					if(refList!=null && refList.size()>0) {
						ProfessionalSpecialist refSpecialist = refList.get(0);
						referraldoc = refSpecialist.getLastName() + "," + refSpecialist.getFirstName();
						request.setAttribute("referral_doc_name", referraldoc);
						cp.setReferralNo(refSpecialist.getReferralNo());
					}
				}
			}

			request.setAttribute("reason", cp.getReason());

/*			if(cppFromMeasurements) {
				request.setAttribute("currentHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Current History:", "cpp_currentHis", demographic.getDemographicNo(), appNo, false)));
				request.setAttribute("pastOcularHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Past Ocular History:", "cpp_pastOcularHis", demographic.getDemographicNo(), appNo, true)));
			   request.setAttribute("diagnosticNotes",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Diagnostic Notes:", "cpp_diagnostics", demographic.getDemographicNo(), appNo, true)));
			   request.setAttribute("medHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Medical History:", "cpp_medicalHis", demographic.getDemographicNo(), appNo, true)));
			   request.setAttribute("famHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Family History:", "cpp_familyHis", demographic.getDemographicNo(), appNo, true)));
			   request.setAttribute("ocularMedication",StringEscapeUtils.escapeJavaScript(getFormattedCppItemFromMeasurements("Current Medications:", "cpp_ocularMeds", demographic.getDemographicNo(), appNo, true)));

			} else {*/
				List<String> currentHistoryIssueNames = new ArrayList<String>();
				currentHistoryIssueNames.add("CurrentHistory");
				currentHistoryIssueNames.add("eyeformCurrentIssue");
				
				request.setAttribute("currentHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Current History:", currentHistoryIssueNames, demographic.getDemographicNo(), appNo, endDate, true)));
				request.setAttribute("pastOcularHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Past Ocular History:", "PastOcularHistory", demographic.getDemographicNo(), appNo, endDate, true)));
				request.setAttribute("medHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Medical History:", "MedHistory", demographic.getDemographicNo(), appNo, endDate, true)));
				request.setAttribute("famHistory",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Family History:", "FamHistory", demographic.getDemographicNo(), appNo, endDate, true)));
				request.setAttribute("diagnosticNotes",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Diagnostic Notes:", "DiagnosticNotes", demographic.getDemographicNo(), appNo, endDate, true)));
				request.setAttribute("ocularMedication",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Current Medications:", "OcularMedication", demographic.getDemographicNo(), appNo, endDate, true)));

				request.setAttribute("PatientLog",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Patient Log:", "PatientLog", demographic.getDemographicNo(), appNo, endDate, true)));
				request.setAttribute("Misc",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Misc:", "Misc", demographic.getDemographicNo(), appNo, endDate, true)));

			//}

			request.setAttribute("otherMeds",StringEscapeUtils.escapeJavaScript(getFormattedCppItem("Other Medications:", "OMeds", demographic.getDemographicNo(), appNo, endDate, true)));

			IssueDAO issueDao = (IssueDAO)SpringUtils.getBean("IssueDAO");
			String customCppIssues[] = OscarProperties.getInstance().getProperty("encounter.custom_cpp_issues", "").split(",");
			
			// Error check
			if (customCppIssues.length == 1 && (customCppIssues[0] == null || customCppIssues[0].length() == 0))
				customCppIssues = new String[0];
			
			for(String customCppIssue:customCppIssues) {
				Issue i = issueDao.findIssueByCode(customCppIssue);
				if(i != null) {
					request.setAttribute(customCppIssue,StringEscapeUtils.escapeJavaScript(getFormattedCppItem(i.getDescription()+":", customCppIssue, demographic.getDemographicNo(), appNo, endDate, true)));
				}
			}
			
			// Allergies and Prescriptions
			request.setAttribute( "aller", StringEscapeUtils.escapeJavaScript(getFormattedAllergies(demographic.getDemographicNo(), appNo, endDate, true)) );
			request.setAttribute( "presc", StringEscapeUtils.escapeJavaScript(getFormattedPrescriptions(demographic.getDemographicNo(), appNo, endDate, true)) );
			
			
			//oscar.oscarRx.data.RxPrescriptionData prescriptData = new oscar.oscarRx.data.RxPrescriptionData();
			//oscar.oscarRx.data.RxPrescriptionData.Prescription[] arr = {};
			//arr = prescriptData.getUniquePrescriptionsByPatient(Integer.parseInt(demographicNo));

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			   List<EyeformOcularProcedure> ocularProcs = ocularProcDao.getHistory(demographic.getDemographicNo(), new Date(), "A");
			   StringBuilder ocularProc = new StringBuilder();
			   for(EyeformOcularProcedure op:ocularProcs) {
	               ocularProc.append(sf.format(op.getDate()) + " ");
	               ocularProc.append(op.getEye() + " ");
	               ocularProc.append(op.getProcedureName() + " at " + op.getLocation());
	               ocularProc.append(" by " + providerDao.getProvider(op.getDoctor()).getFormattedName());
	               if (op.getProcedureNote() != null && !"".equalsIgnoreCase(op.getProcedureNote().trim()))
	            	   ocularProc.append(". " + op.getProcedureNote() + "\n");
			   }
	           String strOcularProcs = ocularProc.toString();
	           if (strOcularProcs != null && !"".equalsIgnoreCase(strOcularProcs.trim()))
	        	   strOcularProcs = "Past Ocular Procedures:\n" + strOcularProcs + "\n";
	           else
	        	   strOcularProcs = "";
	           request.setAttribute("ocularProc", StringEscapeUtils.escapeJavaScript(strOcularProcs));

	           List<EyeformSpecsHistory> specs = specsHistoryDao.getAllPreviousAndCurrent(demographic.getDemographicNo(),appNo);
	           StringBuilder specsStr = new StringBuilder();
	           for(EyeformSpecsHistory spec:specs) {
	        	   String specDate = sf.format(spec.getDate());
	        	   specsStr.append(specDate + " ");

	               StringBuilder data = new StringBuilder("");
	               data.append(" OD ");
	               StringBuilder dataTemp = new StringBuilder("");
	               dataTemp.append(spec.getOdSph() == null ? "" : spec.getOdSph());
	               dataTemp.append(spec.getOdCyl() == null ? "" : spec.getOdCyl());
	               if (spec.getOdAxis() != null && spec.getOdAxis().trim().length() != 0)
	                       dataTemp.append("x" + spec.getOdAxis());
	               if (spec.getOdAdd() != null && spec.getOdAdd().trim().length() != 0)
	                       dataTemp.append(" add " + spec.getOdAdd());
	               if(spec.getOdPrism() != null && spec.getOdPrism().length()>0) {
	            	   dataTemp.append(" prism " + spec.getOdPrism());
	               }
	               specsStr.append(dataTemp.toString());
	               specsStr.append("\n           ");
	               data.append(dataTemp);

	               String secHead = "\n      OS ";
	               data.append(secHead);
	               dataTemp = new StringBuilder("");
	               dataTemp.append(spec.getOsSph() == null ? "" : spec.getOsSph());
	               dataTemp.append(spec.getOsCyl() == null ? "" : spec.getOsCyl());
	               if (spec.getOsAxis() != null && spec.getOsAxis().trim().length() != 0)
	            	   dataTemp.append("x" + spec.getOsAxis());
	               if (spec.getOsAdd() != null && spec.getOsAdd().trim().length() != 0)
	            	   dataTemp.append(" add " + spec.getOsAdd());

	               if(spec.getOsPrism() != null && spec.getOsPrism().length()>0) {
	            	   dataTemp.append(" prism " + spec.getOsPrism());
	               }

	               specsStr.append(dataTemp.toString() + "\n");
	               data.append(dataTemp);
	           }
	           String specsStr1 = "";
	           if (specsStr != null && specs.size()>0)
	               specsStr1  = "Spectacles:\n" + specsStr.toString();
	           else
	    	   		specsStr1 = "";

	           request.setAttribute("specs", StringEscapeUtils.escapeJavaScript(specsStr1));

				//impression
				String impression = getFormattedCppItem("Impression:", "eyeformImpression", demographicNo, appNo, endDate, false);
				impression = impression.replaceAll("\\[Signed on.*?\\]", "");
				request.setAttribute( "impression", StringEscapeUtils.escapeJavaScript(impression) );

	           //followUp
	           FollowUpDao followUpDao = (FollowUpDao)SpringUtils.getBean("FollowUpDAO");
	           List<EyeformFollowUp> followUps = followUpDao.getByAppointmentNo(appNo);
	           StringBuilder followup = new StringBuilder();
	           for(EyeformFollowUp ef:followUps) {
					if (ef.getTimespan() >0) {
						followup.append((ef.getType().equals("followup")?"Follow Up":"Consult") + " in " + ef.getTimespan() + " " + ef.getTimeframe());
					}
	           }

	           //get the checkboxes
	           EyeForm eyeform = eyeFormDao.getByAppointmentNo(appNo);
	           if(eyeform != null) {
		           if (eyeform.getDischarge() != null && eyeform.getDischarge().equals("true"))
						followup.append("Patient is discharged from my active care.\n");
		           if (eyeform.getStat() != null && eyeform.getStat().equals("true"))
						followup.append("Follow up as needed with me STAT or PRN if symptoms are worse.\n");
		           if (eyeform.getOpt() != null && eyeform.getOpt().equals("true"))
						followup.append("Routine eye care by an optometrist is recommended.\n");

	           }
	           request.setAttribute("followup", StringEscapeUtils.escapeJavaScript(followup.toString()));


	           //test book
	           TestBookRecordDao testBookDao = (TestBookRecordDao)SpringUtils.getBean("TestBookDAO");
	           List<EyeformTestBook> testBookRecords = testBookDao.getByAppointmentNo(appNo);
	           StringBuilder testbook = new StringBuilder();
	           for(EyeformTestBook tt:testBookRecords) {
	        	   testbook.append(tt.getTestname());
	   				testbook.append(" ");
	   				testbook.append(tt.getEye());
	   				testbook.append("\n");
	           }
	           if (testbook.length() > 0)
	        	   testbook.insert(0, "Diagnostic test booking:");
	           request.setAttribute("testbooking", StringEscapeUtils.escapeJavaScript(testbook.toString()));


	           //procedure book
	           ProcedureBookDao procBookDao = (ProcedureBookDao)SpringUtils.getBean("ProcedureBookDAO");
	           List<EyeformProcedureBook> procBookRecords = procBookDao.getByAppointmentNo(appNo);
	           StringBuilder probook = new StringBuilder();
	           for(EyeformProcedureBook pp:procBookRecords) {
	        	   probook.append(pp.getProcedureName());
	        	   probook.append(" ");
	        	   probook.append(pp.getEye());
	        	   probook.append("\n");
	           }
	           if (probook.length() > 0)
	        	   probook.insert(0, "Procedure booking:");
	           request.setAttribute("probooking", StringEscapeUtils.escapeJavaScript(probook.toString()));

	           return mapping.findForward("conReport");
	   }

		public ActionForward saveConRequest(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
			log.info("saveConRequest");
			ConsultationReportDao dao = (ConsultationReportDao)SpringUtils.getBean("consultationReportDao");

			DynaValidatorForm crForm = (DynaValidatorForm) form;
			EyeformConsultationReport cp = (EyeformConsultationReport) crForm.get("cp");
			EyeformConsultationReport consultReport = null;
			String id = request.getParameter("cp.id");
			if(id != null && id.length()>0) {
					consultReport = dao.find(Integer.parseInt(id));
			} else {
					consultReport = new EyeformConsultationReport();
			}
			BeanUtils.copyProperties(cp, consultReport, new String[]{"id","demographic","provider"});

			consultReport.setReferralId( cp.getReferralNo() );

			//ProfessionalSpecialist professionalSpecialist = professionalSpecialistDao.getByReferralNo(cp.getReferralNo());
			//if (professionalSpecialist != null) {
				//cp.setReferralId(cp.getReferralNo());
				//MiscUtils.getLogger().info("NAH NULL: " + professionalSpecialist.getId());
			//}

			consultReport.setDate(new Date());

			if(consultReport.getId() != null && consultReport.getId()>0) {
				dao.merge(consultReport);
			} else {
				dao.persist(consultReport);
			}
			request.setAttribute("cpId", consultReport.getId().toString());
			request.setAttribute("savedflag", "saved");
			//return prepareConReport(mapping, form, request, response);
			request.setAttribute("parentAjaxId", "conReport");
			return mapping.findForward("success");
		}

		public String getRefNo(String referal) {
			if (referal == null)
				return "";
			int start = referal.indexOf("<rdohip>");
			int end = referal.indexOf("</rdohip>");
			String ref = new String();

			if (start >= 0 && end >= 0) {
				String subreferal = referal.substring(start + 8, end);
				if (!"".equalsIgnoreCase(subreferal.trim())) {
					ref = subreferal;

				}
			}
			return ref;
		}
		public String getRefId(String referal) {
			int start = referal.indexOf("<rdohip>");
			int end = referal.indexOf("</rdohip>");
			String ref = new String();
			String refNo = new String();
			if (start >= 0 && end >= 0) {
				String subreferal = referal.substring(start + 8, end);
				if (!"".equalsIgnoreCase(subreferal.trim())) {
					ref = subreferal;
					ProfessionalSpecialist professionalSpecialist = professionalSpecialistDao.getByReferralNo(ref.trim());
					if(professionalSpecialist != null)
						refNo = professionalSpecialist.getId() + "";
				}
			}
			return refNo;
		}

		public static String getField(HttpServletRequest request, String name) {
			String val = request.getParameter(name);
			if(val == null) {
				val = (String)request.getAttribute(name);
			}
			return val;
		}



		public ActionForward printConRequest(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
			log.debug("printConreport");
			ConsultationReportDao dao = (ConsultationReportDao)SpringUtils.getBean("consultationReportDao");
			DynaValidatorForm crForm = (DynaValidatorForm) form;
			EyeformConsultationReport cp = (EyeformConsultationReport) crForm.get("cp");
			Demographic demographic = demographicDao.getClientByDemographicNo(cp.getDemographicNo());
			request.setAttribute("demographic",demographic);
			Appointment appointment = this.appointmentDao.find(cp.getAppointmentNo());
			EyeformConsultationReport consultReport = null;
			String id = request.getParameter("cp.id");
			if(id != null && id.length()>0) {
					consultReport = dao.find(Integer.parseInt(id));
			} else {
					consultReport = new EyeformConsultationReport();
			}
			BeanUtils.copyProperties(cp, consultReport, new String[]{"id","demographic","provider"});

			//ProfessionalSpecialist professionalSpecialist = professionalSpecialistDao.getByReferralNo(cp.getReferralNo());

			//if (professionalSpecialist != null)
			//	cp.setReferralId(professionalSpecialist.getId());
			
			consultReport.setReferralId( cp.getReferralNo() );
			
			cp.setReferralId( cp.getReferralNo() );
			
			if(consultReport.getDate()==null){
				consultReport.setDate(new Date());
			}
			if(consultReport.getId() != null && consultReport.getId()>0) {
				dao.merge(consultReport);
			} else {
				dao.persist(consultReport);
			}

			cp.setCc(divycc(cp.getCc()));
			cp.setClinicalInfo(divy(wrap(cp.getClinicalInfo(),80)));
			cp.setClinicalInfo(cp.getClinicalInfo().replaceAll("\\s", "&nbsp;"));
			cp.setConcurrentProblems(divy(wrap(cp.getConcurrentProblems(),80)));
			cp.setCurrentMeds(wrap(cp.getCurrentMeds(),80));
			cp.setExamination(divy(wrap(cp.getExamination(),80)));
			cp.setExamination(cp.getExamination().replaceAll("\n", ""));
			cp.setImpression(divy(wrap(cp.getImpression(),80)));
			cp.setAllergies(divy(wrap(cp.getAllergies(),80)));
			cp.setPlan(divy(wrap(cp.getPlan(),80)));

			SimpleDateFormat sf = new SimpleDateFormat("MM/dd/yyyy");
			request.setAttribute("date", sf.format(new Date()));

			Billingreferral ref = billingreferralDao.getByReferralNo(String.valueOf(cp.getReferralId()));
			request.setAttribute("refer", ref);

			request.setAttribute("cp", cp);

			Provider internalProvider = null;
			if(demographic.getProviderNo()!=null && !demographic.getProviderNo().equalsIgnoreCase("null") && demographic.getProviderNo().length()>0) {

				internalProvider = providerDao.getProvider(demographic.getProviderNo());
				if(internalProvider != null) {
					request.setAttribute("internalDrName", internalProvider.getFirstName() + " " + internalProvider.getLastName());
				}
			}

			String specialty = new String();
			String mdStr = new String();
			if (internalProvider != null)
				specialty = internalProvider.getSpecialty();
			if (specialty != null && !"".equalsIgnoreCase(specialty.trim())) {
				if ("MD".equalsIgnoreCase(specialty.substring(0, 2)))
					mdStr = "Dr.";
				specialty = ", " + specialty.trim();
			} else
				specialty = new String();
			request.setAttribute("specialty", specialty);

			//Clinic clinic = clinicDao.getClinic();
			// prepare the satellite clinic address
			//OscarProperties props = OscarProperties.getInstance();
			//String sateliteFlag = "false";

			Clinic clinic = clinicDao.find(cp.getClinicNo());
			Site site = siteDao.getById(cp.getSiteId());
			
			if (site != null) {
				request.setAttribute("subHeaderName", site.getName());
				
				clinic.setClinicAddress(site.getAddress());
				clinic.setClinicCity(site.getCity());
				clinic.setClinicProvince(site.getProvince());
				clinic.setClinicPostal(site.getPostal());
				clinic.setClinicPhone(site.getPhone());
				clinic.setClinicFax(site.getFax());
			}
			
			


			//List<Site> sites = siteDao.getActiveSitesByProviderNo(internalProvider.getProviderNo());
			//request.setAttribute("sites", sites);
			
			//ArrayList<SatelliteClinic> clinicArr = new ArrayList<SatelliteClinic>();
			//Site defaultSite = null;
			//for (Site s : sites) {
			//	SatelliteClinic sc = new SatelliteClinic();
			//	sc.setClinicId(s.getSiteId());
			//	sc.setClinicName(s.getName());
			//	sc.setClinicAddress(s.getAddress());
			//	sc.setClinicCity(s.getCity());
			//	sc.setClinicProvince(s.getProvince());
			//	sc.setClinicPostal(s.getPostal());
			//	sc.setClinicPhone(s.getPhone());
			//	sc.setClinicFax(s.getFax());
			//	clinicArr.add(sc);
			//	if (s.getName().equals(location))
			//		defaultSite = s;
			//}

			//sateliteFlag = "true";
			//request.setAttribute("clinicArr", clinicArr);
			//if (defaultSite != null)
			//	request.setAttribute("sateliteId", defaultSite.getSiteId().toString());
			

			//request.setAttribute("sateliteFlag", sateliteFlag);
			request.setAttribute("clinic", clinic);
			request.setAttribute("appointDate", (appointment!=null?appointment.getAppointmentDate(): "") );

			return mapping.findForward("printReport");
		}

		public ArrayList<SatelliteClinic> getSateliteClinics(OscarProperties props) {
			ArrayList<SatelliteClinic> clinicArr = new ArrayList<SatelliteClinic>();
			String[] temp0 = props.getProperty("clinicSatelliteName", "").split(
					"\\|");
			String[] temp1 = props.getProperty("clinicSatelliteAddress", "").split(
					"\\|");
			String[] temp2 = props.getProperty("clinicSatelliteCity", "").split(
					"\\|");
			String[] temp3 = props.getProperty("clinicSatelliteProvince", "")
					.split("\\|");
			String[] temp4 = props.getProperty("clinicSatellitePostal", "").split(
					"\\|");
			String[] temp5 = props.getProperty("clinicSatellitePhone", "").split(
					"\\|");
			String[] temp6 = props.getProperty("clinicSatelliteFax", "").split(
					"\\|");
			for (int i = 0; i < temp0.length; i++) {
				SatelliteClinic sc = new SatelliteClinic();
				sc.setClinicId(new Integer(i));
				sc.setClinicName(temp0[i]);
				sc.setClinicAddress(temp1[i]);
				sc.setClinicCity(temp2[i]);
				sc.setClinicProvince(temp3[i]);
				sc.setClinicPostal(temp4[i]);
				sc.setClinicPhone(temp5[i]);
				sc.setClinicFax(temp6[i]);
				clinicArr.add(sc);
			}

			return clinicArr;
		}

		public ActionForward specialRepTickler(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
			log.debug("specialRepTickler");

			String demoNo = request.getParameter("demographicNo");
			String docFlag = request.getParameter("docFlag");
			String bsurl = request.getContextPath();
			if ("true".equalsIgnoreCase(docFlag))
				sendDocTickler("REP", demoNo, (String) request.getSession().getAttribute("user"), bsurl);

			response.getWriter().println("alert('tickler sent');");
			return null;
		}

		public void sendDocTickler(String flag, String demoNo, String providerNo, String bsurl) {
			Tickler tkl = new Tickler();
			Date now = new Date();

			tkl.setCreator(providerNo);
			tkl.setDemographic_no(demoNo);
			tkl.setPriority("Normal");
			tkl.setService_date(now);
			tkl.setStatus('A');
			tkl.setTask_assigned_to(providerNo);
			tkl.setUpdate_date(now);

			StringBuilder mes = new StringBuilder();
			mes.append("Remember to <a href=\"javascript:void(0)\" onclick=\"window.open(\'");
			String[] slist = bsurl.trim().split("/");
			mes.append("/");
			mes.append(slist[1]);
			if ("REQ".equalsIgnoreCase(flag)) {
				mes.append("/oscarEncounter/oscarConsultationRequest/DisplayDemographicConsultationRequests.jsp?de=");
				mes.append(demoNo);
				mes.append("\',\'conRequest\',\'height=700,width=700,scrollbars=yes,menubars=no,toolbars=no,resizable=yes\');\">");
				mes.append("complete the consultation request.");
			} else if ("REP".equalsIgnoreCase(flag)) {
				mes.append("/eyeform/ConsultationReportList.do?method=list&cr.demographicNo=");
				mes.append(demoNo);
				mes.append("\',\'conReport\',\'height=700,width=700,scrollbars=yes,menubars=no,toolbars=no,resizable=yes\');\">");
				mes.append("complete the consultation report.");
			}
			mes.append("</a>");
			tkl.setMessage(mes.toString());
			ticklerDao.saveTickler(tkl);
		}

		public void sendFrontTickler(String flag, String demoNo, String providerNo, String creator, String bsurl) {
			Tickler tkl = new Tickler();
			Date now = new Date();
			tkl.setCreator(creator);
			tkl.setDemographic_no(demoNo);
			tkl.setPriority("Normal");
			tkl.setService_date(now);
			tkl.setStatus('A');
			tkl.setTask_assigned_to(providerNo);
			tkl.setUpdate_date(now);
			StringBuilder mes = new StringBuilder();
			mes.append("Arrange <a href=\"javascript:void(0)\" onclick=\"window.open(\'");
			String[] slist = bsurl.trim().split("/");
			mes.append("/");
			mes.append(slist[1]);
			if ("REQ".equalsIgnoreCase(flag)) {
				mes.append("/oscarEncounter/oscarConsultationRequest/DisplayDemographicConsultationRequests.jsp?de=");
				mes.append(demoNo);
				mes.append("\',\'conRequest\',\'height=700,width=700,scrollbars=yes,menubars=no,toolbars=no,resizable=yes\');\">");
				mes.append("consultation request.");
			}
			mes.append("</a>");
			tkl.setMessage(mes.toString());
			ticklerDao.saveTickler(tkl);
		}

		public String wrap(String in,int len) {
			if(in==null)
				in="";
			//in=in.trim();
			if(in.length()<len) {
				if(in.length()>1 && !in.startsWith("  ")) {
					in=in.trim();
				}
				return in;
			}
			if(in.substring(0, len).contains("\n")) {
				String x = in.substring(0, in.indexOf("\n"));
				if(x.length()>1 && !x.startsWith("  ")) {
					x=x.trim();
				}
				return x + "\n" + wrap(in.substring(in.indexOf("\n") + 1), len);
			}
			int place=Math.max(Math.max(in.lastIndexOf(" ",len),in.lastIndexOf("\t",len)),in.lastIndexOf("-",len));
			return in.substring(0,place).trim()+"\n"+wrap(in.substring(place),len);
			}

		public String divy(String str) {
			StringBuilder sb = new StringBuilder();
			sb.append(str);
			int j = 0;
			int i = 0;
			while (i < sb.length()) {
				if (sb.charAt(i) == '\n') {
					sb.insert(i, "<BR>");
					i = i + 4;
				}

				i++;
			}
			return sb.toString();

		}

		public String dive(String str) {
			// add "\n" to string
			StringBuilder stringBuffer = new StringBuilder();
			stringBuffer.append(str);
			int j = 0;
			int i = 0;
			while (i < stringBuffer.length()) {
				if (stringBuffer.charAt(i) == '\n') {
					j = 0;
				}
				i++;
				if (j > 75) {
					stringBuffer.insert(i, "\n");
					i++;
					j = 0;
				}

				j++;
			}
			return stringBuffer.toString();
		}

		public String divycc(String str) {
			StringBuilder stringBuffer = new StringBuilder();
			stringBuffer.append(str);
			int j = 0;
			int i = 0;
			while (i < stringBuffer.length()) {

				if (stringBuffer.charAt(i) == ';') {
					j++;
					if (j % 2 == 0) {
						stringBuffer.insert(i + 1, "<BR>");
						i = i + 4;
					}
				}
				i++;
			}
			return stringBuffer.toString();
		}

		public static List<LabelValueBean> getMeasurementSections() {
	           List<LabelValueBean> sections = new ArrayList<LabelValueBean>();
	           sections.add(new LabelValueBean("VISION ASSESSMENT","VISION ASSESSMENT"));
	           sections.add(new LabelValueBean("MANIFEST VISION","MANIFEST VISION"));
	           sections.add(new LabelValueBean("INTRAOCULAR PRESSURE","INTRAOCULAR PRESSURE"));
	           sections.add(new LabelValueBean("OTHER EXAM","OTHER EXAM"));
	           sections.add(new LabelValueBean("EOM/STEREO","EOM/STEREO"));
	           sections.add(new LabelValueBean("ANTERIOR SEGMENT","ANTERIOR SEGMENT"));
	           sections.add(new LabelValueBean("POSTERIOR SEGMENT","POSTERIOR SEGMENT"));
	           sections.add(new LabelValueBean("EXTERNAL/ORBIT","EXTERNAL/ORBIT"));
	           sections.add(new LabelValueBean("NASOLACRIMAL DUCT","NASOLACRIMAL DUCT"));
	           sections.add(new LabelValueBean("EYELID MEASUREMENT","EYELID MEASUREMENT"));
	           return sections;
		}

		public static List<LabelValueBean> getMeasurementHeaders() {
	           List<LabelValueBean> sections = new ArrayList<LabelValueBean>();
	           sections.add(new LabelValueBean("Auto-refraction","Auto-refraction"));
	           sections.add(new LabelValueBean("Keratometry","Keratometry"));
	           sections.add(new LabelValueBean("Distance vision (sc)","Distance vision (sc)"));
	           sections.add(new LabelValueBean("Distance vision (cc)","Distance vision (cc)"));
	           sections.add(new LabelValueBean("Distance vision (ph)","Distance vision (ph)"));
	           sections.add(new LabelValueBean("Near vision (sc)","Near vision (sc)"));
	           sections.add(new LabelValueBean("Near vision (cc)","Near vision (cc)"));

	           sections.add(new LabelValueBean("Manifest distance","Manifest distance"));
	           sections.add(new LabelValueBean("Manifest near","Manifest near"));
	           sections.add(new LabelValueBean("Cycloplegic refraction","Cycloplegic refraction"));
	          // sections.add(new LabelValueBean("Best corrected distance vision","Best corrected distance vision"));

	           sections.add(new LabelValueBean("NCT","NCT"));
	           sections.add(new LabelValueBean("Applanation","Applanation"));
	           sections.add(new LabelValueBean("Central corneal thickness","Central corneal thickness"));

	           sections.add(new LabelValueBean("Colour vision","Colour vision"));
	           sections.add(new LabelValueBean("Pupil","Pupil"));
	           sections.add(new LabelValueBean("Amsler grid","Amsler grid"));
	           sections.add(new LabelValueBean("Potential acuity meter","Potential acuity meter"));
	           sections.add(new LabelValueBean("Confrontation fields","Confrontation fields"));
	           //sections.add(new LabelValueBean("Maddox rod","Maddox rod"));
	           //sections.add(new LabelValueBean("Bagolini test","Bagolini test"));
	           //sections.add(new LabelValueBean("Worth 4 dot (distance)","Worth 4 dot (distance)"));
	          // sections.add(new LabelValueBean("Worth 4 dot (near)","Worth 4 dot (near)"));
	           sections.add(new LabelValueBean("EOM","EOM"));

	           sections.add(new LabelValueBean("Cornea","Cornea"));
	           sections.add(new LabelValueBean("Conjunctiva/Sclera","Conjunctiva/Sclera"));
	           sections.add(new LabelValueBean("Anterior chamber","Anterior chamber"));
	           sections.add(new LabelValueBean("Angle","Angle"));
	           sections.add(new LabelValueBean("Iris","Iris"));
	           sections.add(new LabelValueBean("Lens","Lens"));

	           sections.add(new LabelValueBean("Optic disc","Optic disc"));
	           sections.add(new LabelValueBean("C/D ratio","C/D ratio"));
	           sections.add(new LabelValueBean("Macula","Macula"));
	           sections.add(new LabelValueBean("Retina","Retina"));
	           sections.add(new LabelValueBean("Vitreous","Vitreous"));

	           sections.add(new LabelValueBean("Face","Face"));
	           sections.add(new LabelValueBean("Upper lid","Upper lid"));
	           sections.add(new LabelValueBean("Lower lid","Lower lid"));
	           sections.add(new LabelValueBean("Punctum","Punctum"));
	           sections.add(new LabelValueBean("Lacrimal lake","Lacrimal lake"));
	           //sections.add(new LabelValueBean("Schirmer test","Schirmer test"));
	           sections.add(new LabelValueBean("Retropulsion","Retropulsion"));
	           sections.add(new LabelValueBean("Hertel","Hertel"));

	           sections.add(new LabelValueBean("Lacrimal irrigation","Lacrimal irrigation"));
	           sections.add(new LabelValueBean("Nasolacrimal duct","Nasolacrimal duct"));
	           sections.add(new LabelValueBean("Dye disappearance","Dye disappearance"));

	           sections.add(new LabelValueBean("Margin reflex distance","Margin reflex distance"));
	           sections.add(new LabelValueBean("Inferior scleral show","Inferior scleral show"));
	           sections.add(new LabelValueBean("Levator function","Levator function"));
	           sections.add(new LabelValueBean("Lagophthalmos","Lagophthalmos"));
	           sections.add(new LabelValueBean("Blink reflex","Blink reflex"));
	           sections.add(new LabelValueBean("Cranial nerve VII function","Cranial nerve VII function"));
	           sections.add(new LabelValueBean("Bell's phenomenon","Bells phenomenon"));

	           return sections;
		}

		public ActionForward getMeasurementText(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
			String[] values = request.getParameterValues(request.getParameter("name"));
			String appointmentNoAsString = request.getParameter("appointmentNo");
			String demographicNoAsString = request.getParameter("demographicNo");
			String endDateAsString = request.getParameter("endDate");
			
			Integer appointmentNo = 0;
			Integer demographicNo = 0;
			
			try {
				appointmentNo = Integer.parseInt( appointmentNoAsString );
			} catch (Exception e) {
				MiscUtils.getLogger().error("Error", e);
			}
			
			try {
				demographicNo = Integer.parseInt( demographicNoAsString );
			} catch (Exception e) {
				MiscUtils.getLogger().error("Error", e);
			}
			
			Date endDate = null;
			if (endDateAsString != null) {
				try {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					endDate = formatter.parse(endDateAsString);
					endDate = getEndOfDayVersion(endDate);
				} catch (ParseException e) {
					MiscUtils.getLogger().error("Error", e);
				}
			}
			
			StringBuilder exam = new StringBuilder();
			Map<String,Boolean> headerMap = new HashMap<String,Boolean>();
			for(int x=0;x<values.length;x++) {
				headerMap.put(values[x],true);
			}

			List<Measurements> measurements = null;
			if (endDate != null)
				measurements = measurementsDao.getMeasurementsBeforeDate(demographicNo, endDate);
			else if (appointmentNo != 0)
				measurements = measurementsDao.getMeasurementsByAppointment(appointmentNo);
			else if (appointmentNoAsString == null)
				measurements = measurementsDao.getMeasurements(demographicNo);
			else if (appointmentNo == 0)
				measurements = measurementsDao.getMeasurements(demographicNo, appointmentNo);
			else
				return null;

			MeasurementFormatter formatter = new MeasurementFormatter(measurements);
			exam.append(formatter.getVisionAssessment(headerMap));
			String tmp = null;
			tmp = formatter.getManifestVision(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);
			tmp = formatter.getIntraocularPressure(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);

			tmp = formatter.getOtherExam(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);

			tmp = formatter.getEOMStereo(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);

			tmp = formatter.getAnteriorSegment(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);

			tmp = formatter.getPosteriorSegment(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);

			tmp = formatter.getExternalOrbit(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);

			tmp = formatter.getNasalacrimalDuct(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);

			tmp = formatter.getEyelidMeasurement(headerMap);
			if(exam.length()>0 && tmp.length()>0 ){
				exam.append("\n\n");
			}
			exam.append(tmp);

			response.getWriter().println(exam.toString());


			return null;
		}

		public static List<Provider> getActiveProviders() {
			ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
			return providerDao.getActiveProviders();
		}

		public ActionForward specialReqTickler(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
			log.debug("specialReqTickler");

			String demoNo = request.getParameter("demographicNo");
			String docFlag = request.getParameter("docFlag");
			String frontFlag = request.getParameter("frontFlag");
			String providerNo = request.getParameter("providerNo");
			String bsurl = request.getContextPath();
			String user = LoggedInInfo.loggedInInfo.get().loggedInProvider.getProviderNo();
			if ("true".equalsIgnoreCase(docFlag))
				sendDocTickler("REQ", demoNo,user, bsurl);
			if ("true".equalsIgnoreCase(frontFlag))
				sendFrontTickler("REQ", demoNo, providerNo,user, bsurl);
			response.getWriter().println("alert('tickler sent');");
			return null;
		}



}
