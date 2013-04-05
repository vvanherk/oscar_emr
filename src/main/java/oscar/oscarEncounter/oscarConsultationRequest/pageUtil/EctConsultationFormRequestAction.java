/*
 *
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved. *
 * This software is published under the GPL GNU General Public License.
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version. *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *
 *
 * <OSCAR TEAM>
 *
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */

package oscar.oscarEncounter.oscarConsultationRequest.pageUtil;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.oscarehr.common.IsPropertiesOn;
import org.oscarehr.common.dao.ClinicDAO;
import org.oscarehr.common.dao.ConsultationRequestDao;
import org.oscarehr.common.dao.ConsultationRequestExtDao;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.common.dao.Hl7TextInfoDao;
import org.oscarehr.common.dao.ProfessionalSpecialistDao;
import org.oscarehr.common.hl7.v2.oscar_to_oscar.OruR01;
import org.oscarehr.common.hl7.v2.oscar_to_oscar.RefI12;
import org.oscarehr.common.hl7.v2.oscar_to_oscar.SendingUtils;
import org.oscarehr.common.hl7.v2.oscar_to_oscar.OruR01.ObservationData;
import org.oscarehr.common.model.Clinic;
import org.oscarehr.common.model.ConsultationRequest;
import org.oscarehr.common.model.ConsultationRequestExt;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.common.model.Hl7TextInfo;
import org.oscarehr.common.model.ProfessionalSpecialist;
import org.oscarehr.common.model.Provider;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;
import org.oscarehr.util.WebUtils;

import oscar.dms.EDoc;
import oscar.dms.EDocUtil;
import oscar.oscarLab.ca.all.pageUtil.LabPDFCreator;
import oscar.oscarLab.ca.on.CommonLabResultData;
import oscar.oscarLab.ca.on.LabResultData;
import oscar.util.ParameterActionForward;
import ca.uhn.hl7v2.HL7Exception;
import ca.uhn.hl7v2.model.v26.message.ORU_R01;
import ca.uhn.hl7v2.model.v26.message.REF_I12;

import com.lowagie.text.DocumentException;

public class EctConsultationFormRequestAction extends Action {

	private static final Logger logger=MiscUtils.getLogger();
	private boolean bMultisites=org.oscarehr.common.IsPropertiesOn.isMultisitesEnable();
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		EctConsultationFormRequestForm frm = (EctConsultationFormRequestForm) form;		

		String appointmentHour = frm.getAppointmentHour();
		String appointmentPm = frm.getAppointmentPm();

		if (appointmentPm.equals("PM") && Integer.parseInt(appointmentHour) < 12 ) {
			appointmentHour = Integer.toString(Integer.parseInt(appointmentHour) + 12);
		}
                else if( appointmentHour.equals("12") && appointmentPm.equals("AM") ) {
                    appointmentHour = "0";
                }		

		String sendTo = frm.getSendTo();
		String submission = frm.getSubmission();
		String providerNo = frm.getProviderNo();
		String demographicNo = frm.getDemographicNo();

		String requestId = "";

                ConsultationRequestDao consultationRequestDao=(ConsultationRequestDao)SpringUtils.getBean("consultationRequestDao");
                ConsultationRequestExtDao consultationRequestExtDao=(ConsultationRequestExtDao)SpringUtils.getBean("consultationRequestExtDao");
                ProfessionalSpecialistDao professionalSpecialistDao=(ProfessionalSpecialistDao)SpringUtils.getBean("professionalSpecialistDao");
                
                String[] format = new String[] {"yyyy-MM-dd","yyyy/MM/dd"};


		String clinicNo = request.getParameter("clinicNo");
		request.getSession().setAttribute("clinic_id", clinicNo);
		
		if (submission.startsWith("Submit")) {

			try {				
                                ConsultationRequest consult = new ConsultationRequest();
                                Date date = DateUtils.parseDate(frm.getReferalDate(), format);
                                consult.setReferralDate(date);
                                consult.setServiceId(new Integer(frm.getService()));

                                if( frm.getAppointmentYear() != null && !frm.getAppointmentYear().equals("") ) {
                                   date = DateUtils.parseDate(frm.getAppointmentYear() + "-" + frm.getAppointmentMonth() + "-" + frm.getAppointmentDay(), format);
                                   consult.setAppointmentDate(date);
                                   date = DateUtils.setHours(date, new Integer(appointmentHour));
                                   date = DateUtils.setMinutes(date, new Integer(frm.getAppointmentMinute()));
                                   consult.setAppointmentTime(date);
                                }
                                consult.setReasonForReferral(frm.getReasonForConsultation());
                                consult.setClinicalInfo(frm.getClinicalInformation());
                                consult.setCurrentMeds(frm.getCurrentMedications());
                                consult.setAllergies(frm.getAllergies());
                                consult.setProviderNo(frm.getProviderNo());
                                consult.setDemographicId(new Integer(frm.getDemographicNo()));
                                consult.setStatus(frm.getStatus());
                                consult.setStatusText(frm.getAppointmentNotes());
                                consult.setSendTo(frm.getSendTo());
                                consult.setConcurrentProblems(frm.getConcurrentProblems());
                                consult.setUrgency(frm.getUrgency());
				consult.setSiteName(frm.getSiteName());
                                Boolean pWillBook = false;
                                if( frm.getPatientWillBook() != null ) {
                                    pWillBook = frm.getPatientWillBook().equals("1");
                                }
                                consult.setPatientWillBook(pWillBook);

                                if( frm.getFollowUpDate() != null && !frm.getFollowUpDate().equals("") ) {
                                    date = DateUtils.parseDate(frm.getFollowUpDate(), format);
                                    consult.setFollowUpDate(date);
                                }


                                consultationRequestDao.persist(consult);

                                    Integer specId = new Integer(frm.getSpecialist());
                                    ProfessionalSpecialist professionalSpecialist=professionalSpecialistDao.find(specId);
                                    if( professionalSpecialist != null ) {
                                        consult.setProfessionalSpecialist(professionalSpecialist);
                                        consultationRequestDao.merge(consult);
                                    }
                                        MiscUtils.getLogger().info("saved new consult id "+ consult.getId());
                                        requestId = String.valueOf(consult.getId());
                                        
                                Enumeration e = request.getParameterNames();
                                while(e.hasMoreElements()) {
                                	String name = (String)e.nextElement();
                                	if(name.startsWith("ext_")) {
                                		String value = request.getParameter(name);
                                		consultationRequestExtDao.persist(createExtEntry(requestId,name.substring(name.indexOf("_")+1),value));
                                	}
                                }
					// now that we have consultation id we can save any attached docs as well
					// format of input is D2|L2 for doc and lab
					String[] docs = frm.getDocuments().split("\\|");

					for (int idx = 0; idx < docs.length; ++idx) {
						if (docs[idx].length() > 0) {
							if (docs[idx].charAt(0) == 'D') EDocUtil.attachDocConsult(providerNo, docs[idx].substring(1), requestId);
							else if (docs[idx].charAt(0) == 'L') ConsultationAttachLabs.attachLabConsult(providerNo, docs[idx].substring(1), requestId);
						}
					}
			}
                        catch (ParseException e) {
                                MiscUtils.getLogger().error("Invalid Date", e);
                        }


			request.setAttribute("transType", "2");

		} else

		if (submission.startsWith("Update")) {

			requestId = frm.getRequestId();

			try {				                                
                                ConsultationRequest consult = consultationRequestDao.find(new Integer(requestId));
                                Date date = DateUtils.parseDate(frm.getReferalDate(), format);
                                consult.setReferralDate(date);
                                consult.setServiceId(new Integer(frm.getService()));

                                Integer specId = new Integer(frm.getSpecialist());
                                ProfessionalSpecialist professionalSpecialist=professionalSpecialistDao.find(specId);
                                consult.setProfessionalSpecialist(professionalSpecialist);
                                if( frm.getAppointmentYear() != null && !frm.getAppointmentYear().equals("") ) {
                                   date = DateUtils.parseDate(frm.getAppointmentYear() + "-" + frm.getAppointmentMonth() + "-" + frm.getAppointmentDay(), format);
                                   consult.setAppointmentDate(date);
                                   date = DateUtils.setHours(date, new Integer(appointmentHour));
                                   date = DateUtils.setMinutes(date, new Integer(frm.getAppointmentMinute()));
                                   consult.setAppointmentTime(date);
                                }
                                consult.setReasonForReferral(frm.getReasonForConsultation());
                                consult.setClinicalInfo(frm.getClinicalInformation());
                                consult.setCurrentMeds(frm.getCurrentMedications());
                                consult.setAllergies(frm.getAllergies());
                                consult.setDemographicId(new Integer(frm.getDemographicNo()));
                                consult.setStatus(frm.getStatus());
                                consult.setStatusText(frm.getAppointmentNotes());
                                consult.setSendTo(frm.getSendTo());
                                consult.setConcurrentProblems(frm.getConcurrentProblems());
                                consult.setUrgency(frm.getUrgency());
				consult.setSiteName(frm.getSiteName());
                                 Boolean pWillBook = false;
                                if( frm.getPatientWillBook() != null ) {
                                    pWillBook = frm.getPatientWillBook().equals("1");
                                }
                                consult.setPatientWillBook(pWillBook);

                                if( frm.getFollowUpDate() != null && !frm.getFollowUpDate().equals("") ) {
                                    date = DateUtils.parseDate(frm.getFollowUpDate(), format);
                                    consult.setFollowUpDate(date);
                                }
                                consultationRequestDao.merge(consult);
                                
                                consultationRequestExtDao.clear(Integer.parseInt(requestId));
                                Enumeration e = request.getParameterNames();
                                while(e.hasMoreElements()) {
                                	String name = (String)e.nextElement();
                                	if(name.startsWith("ext_")) {
                                		String value = request.getParameter(name);
                                		consultationRequestExtDao.persist(createExtEntry(requestId,name.substring(name.indexOf("_")+1),value));
                                	}
                                }
			}

			catch (ParseException e) {
				MiscUtils.getLogger().error("Error", e);
			}

			request.setAttribute("transType", "1");

		}

		frm.setRequestId("");

		request.setAttribute("teamVar", sendTo);

		if (submission.endsWith("And Print Preview")) {

			request.setAttribute("reqId", requestId);
			if (IsPropertiesOn.propertiesOn("CONSULT_PRINT_PDF")) {
				return mapping.findForward("printpdf");
			} else if (IsPropertiesOn.propertiesOn("CONSULT_PRINT_ALT")) {
				return mapping.findForward("printalt");
			} else {
				return mapping.findForward("print");
			}

		} else if (submission.endsWith("And Fax")) {

			request.setAttribute("reqId", requestId);

			return mapping.findForward("fax");

		} 
		else if (submission.endsWith("esend"))
		{
			// upon success continue as normal with success message
			// upon failure, go to consultation update page with message
			try {
	            doHl7Send(Integer.parseInt(requestId));
	            WebUtils.addResourceBundleInfoMessage(request, "oscarEncounter.oscarConsultationRequest.ConfirmConsultationRequest.msgCreatedUpdateESent");
            } catch (Exception e) {
            	logger.error("Error contacting remote server.", e);
            	
	            WebUtils.addResourceBundleErrorMessage(request, "oscarEncounter.oscarConsultationRequest.ConfirmConsultationRequest.msgCreatedUpdateESendError");
	    		ParameterActionForward forward = new ParameterActionForward(mapping.findForward("failESend"));
	    		forward.addParameter("de", demographicNo);
	    		forward.addParameter("requestId", requestId);
	    		return forward;
            }
		}
			

		ParameterActionForward forward = new ParameterActionForward(mapping.findForward("success"));
		forward.addParameter("de", demographicNo);
		return forward;
	}
	
	private ConsultationRequestExt createExtEntry(String requestId, String name,String value) {
		ConsultationRequestExt obj = new ConsultationRequestExt();
		obj.setDateCreated(new Date());
		obj.setKey(name);
		obj.setValue(value);
		obj.setRequestId(Integer.parseInt(requestId));
		return obj;
	}
	private void doHl7Send(Integer consultationRequestId) throws InvalidKeyException, SignatureException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidKeySpecException, IOException, HL7Exception, ServletException {
		
	    ConsultationRequestDao consultationRequestDao=(ConsultationRequestDao)SpringUtils.getBean("consultationRequestDao");
	    ProfessionalSpecialistDao professionalSpecialistDao=(ProfessionalSpecialistDao)SpringUtils.getBean("professionalSpecialistDao");
	    Hl7TextInfoDao hl7TextInfoDao=(Hl7TextInfoDao)SpringUtils.getBean("hl7TextInfoDao");
	    ClinicDAO clinicDAO=(ClinicDAO)SpringUtils.getBean("clinicDAO");

	    ConsultationRequest consultationRequest=consultationRequestDao.find(consultationRequestId);
	    ProfessionalSpecialist professionalSpecialist=professionalSpecialistDao.find(consultationRequest.getSpecialistId());
	    Clinic clinic=clinicDAO.getClinic();
	    
        LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();
	    
	    // set status now so the remote version shows this status
	    consultationRequest.setStatus("2");

	    REF_I12 refI12=RefI12.makeRefI12(clinic, consultationRequest);
	    SendingUtils.send(refI12, professionalSpecialist);
	    
	    // save after the sending just in case the sending fails.
	    consultationRequestDao.merge(consultationRequest);
	    
	    //--- send attachments ---
    	Provider sendingProvider=loggedInInfo.loggedInProvider;
    	DemographicDao demographicDao=(DemographicDao) SpringUtils.getBean("demographicDao");
    	Demographic demographic=demographicDao.getDemographicById(consultationRequest.getDemographicId());

    	//--- process all documents ---
	    ArrayList<EDoc> attachments=EDocUtil.listDocs(demographic.getDemographicNo().toString(), consultationRequest.getId().toString(), true);
	    for (EDoc attachment : attachments)
	    {
	        ObservationData observationData=new ObservationData();
	        observationData.subject=attachment.getDescription();
	        observationData.textMessage="Attachment for consultation : "+consultationRequestId;
	        observationData.binaryDataFileName=attachment.getFileName();
	        observationData.binaryData=attachment.getFileBytes();

	        ORU_R01 hl7Message=OruR01.makeOruR01(clinic, demographic, observationData, sendingProvider, professionalSpecialist);        
	        SendingUtils.send(hl7Message, professionalSpecialist);	    	
	    }
	    
	    //--- process all labs ---
        CommonLabResultData labData = new CommonLabResultData();
        ArrayList<LabResultData> labs = labData.populateLabResultsData(demographic.getDemographicNo().toString(), consultationRequest.getId().toString(), CommonLabResultData.ATTACHED);
	    for (LabResultData attachment : labs)
	    {
	    	try {
	            byte[] dataBytes=LabPDFCreator.getPdfBytes(attachment.getSegmentID(), sendingProvider.getProviderNo());
	            Hl7TextInfo hl7TextInfo=hl7TextInfoDao.findLabId(Integer.parseInt(attachment.getSegmentID()));
	            
	            ObservationData observationData=new ObservationData();
	            observationData.subject=hl7TextInfo.getDiscipline();
	            observationData.textMessage="Attachment for consultation : "+consultationRequestId;
	            observationData.binaryDataFileName=hl7TextInfo.getDiscipline()+".pdf";
	            observationData.binaryData=dataBytes;

	            
	            ORU_R01 hl7Message=OruR01.makeOruR01(clinic, demographic, observationData, sendingProvider, professionalSpecialist);        
	            int statusCode=SendingUtils.send(hl7Message, professionalSpecialist);
	            if (HttpServletResponse.SC_OK!=statusCode) throw(new ServletException("Error, received status code:"+statusCode));
            } catch (DocumentException e) {
	            logger.error("Unexpected error.", e);
            }	    	
	    }
    }

}
