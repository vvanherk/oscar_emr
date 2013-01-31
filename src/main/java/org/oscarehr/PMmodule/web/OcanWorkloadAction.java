package org.oscarehr.PMmodule.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.oscarehr.PMmodule.dao.AdmissionDao;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.PMmodule.dao.ProgramDao;
import org.oscarehr.PMmodule.model.Admission;
import org.oscarehr.common.dao.OcanStaffFormDao;
import org.oscarehr.common.dao.OcanStaffFormDataDao;
import org.oscarehr.common.model.OcanStaffForm;
import org.oscarehr.common.model.OcanStaffFormData;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;

public class OcanWorkloadAction extends DispatchAction {

	Logger logger = MiscUtils.getLogger();

	private OcanStaffFormDao ocanStaffFormDao = (OcanStaffFormDao) SpringUtils.getBean("ocanStaffFormDao");
	private OcanStaffFormDataDao ocanStaffFormDataDao = (OcanStaffFormDataDao) SpringUtils.getBean("ocanStaffFormDataDao");
	private DemographicDao demographicDao = (DemographicDao)SpringUtils.getBean("demographicDao");
	private ProgramDao programDao = (ProgramDao)SpringUtils.getBean("programDao");
	private AdmissionDao admissionDao = (AdmissionDao)SpringUtils.getBean("admissionDao");

	protected ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return view(mapping,form,request,response);
    }

	public ActionForward view(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String providerNo = LoggedInInfo.loggedInInfo.get().loggedInProvider.getProviderNo();
		Integer facilityId = LoggedInInfo.loggedInInfo.get().currentFacility.getId();

		List<OcanStaffForm> ocanForms = ocanStaffFormDao.findLatestOcanFormsByStaff(facilityId,providerNo);

		//filter out discharged ones. ie. discharged longer than 3 months.
		//how do we define discharged?
		List<OcanStaffForm> filteredOcanForms = new ArrayList<OcanStaffForm>();
		for(OcanStaffForm ocan:ocanForms) {
			Integer demographicNo = ocan.getClientId();
			List<Admission> currentAdmissions = admissionDao.getCurrentAdmissions(demographicNo);
			boolean admit=true;
			for(Admission adm:currentAdmissions) {
				if(adm.getProgramType().equals("community")) {
					//discharged
					Calendar now = Calendar.getInstance();
					Calendar then = Calendar.getInstance();
					then.setTime(adm.getAdmissionDate());

					now.add(Calendar.MONTH, -3);
					if(then.before(now)) {
						admit=false;
					}
				}
			}
			if(admit)
				filteredOcanForms.add(ocan);
		}

		request.setAttribute("ocans", filteredOcanForms);

		return mapping.findForward("view");

	}

	/*
	 * We have to reassign ALL OCANs for this client over to the new staff member.
	 *
	 */
	public ActionForward reassign(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		MiscUtils.getLogger().info("Reassigning OCAN Workload");
		String assessmentId = request.getParameter("assessmentId");
		String consumerId = request.getParameter("consumerId");
		String newProviderNo = request.getParameter("reassign_new_provider");
		logger.info("assessmentId="+assessmentId);
		logger.info("newProviderNo="+newProviderNo);
		logger.info("consumerId="+consumerId);

		//get the latest of each assessment for the client.
		//update the providerNo, and persist as new form,
		//same with data.
		List<OcanStaffForm> ocans = ocanStaffFormDao.findLatestByConsumer(LoggedInInfo.loggedInInfo.get().currentFacility.getId(),Integer.valueOf(consumerId));
		for(OcanStaffForm ocan:ocans) {
			List<OcanStaffFormData> ocanData = ocanStaffFormDataDao.findByForm(ocan.getId());

			ocan.setId(null);
			ocan.setProviderNo(newProviderNo);
			ocan.setCreated(new Date());
			ocanStaffFormDao.persist(ocan);

			for(OcanStaffFormData data:ocanData) {
				data.setId(null);
				data.setOcanStaffFormId(ocan.getId());
				ocanStaffFormDataDao.persist(data);
			}
		}

		return view(mapping,form,request,response);
    }
}
