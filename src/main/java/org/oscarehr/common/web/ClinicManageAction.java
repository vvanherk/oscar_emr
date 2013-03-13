package org.oscarehr.common.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.DynaActionForm;
import org.apache.struts.actions.DispatchAction;
import org.oscarehr.common.dao.ClinicDAO;
import org.oscarehr.common.model.Clinic;
import org.oscarehr.util.MiscUtils;

public class ClinicManageAction extends DispatchAction {

	private static final Logger logger = MiscUtils.getLogger();

    private ClinicDAO clinicDAO;

    @Override
    protected ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return view(mapping, form, request, response);
    }
    
    public ActionForward newClinic(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		putClinicsInRequest(request);
		
		Clinic clinic = new Clinic();
        DynaActionForm frm = (DynaActionForm)form;
        frm.set("clinic",clinic);
        request.setAttribute("clinicForm",form);
        return mapping.findForward("success");
    }

    public ActionForward view(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		putClinicsInRequest(request);
		
		String id = request.getParameter("clinicNo");
		int clinicNo = 0;
		Clinic clinic = null;
		
		try {
			clinicNo = Integer.parseInt(id);
			clinic = clinicDAO.find(clinicNo);
		} catch (Exception e) {
			logger.warn("Unable to parse clinicNo: " + id);
		}
		
        if (clinic == null)
			clinic = clinicDAO.getClinic();
		if (clinic == null) {
			logger.error("Unable to find Clinic.");
			request.setAttribute("actionResultMessage", "Unable to find Clinic");
			request.setAttribute("actionResult", -1);
			return mapping.findForward("failure");
		}
				
        DynaActionForm frm = (DynaActionForm)form;
        frm.set("clinic",clinic);
        request.setAttribute("clinicForm",form);
        return mapping.findForward("success");
    }

    public ActionForward update(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {		
        DynaActionForm frm = (DynaActionForm)form;
        Clinic clinic = (Clinic) frm.get("clinic");
        clinicDAO.save(clinic);
        
        // Need to do this AFTER we call save on the clinicDAO
        putClinicsInRequest(request);
        
        request.setAttribute("actionResultMessage", "Successfully saved/updated Clinic");
		request.setAttribute("actionResult", 0);
		
        return mapping.findForward("success");
    }
    
    public ActionForward save(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return update(mapping, form, request, response);
    }
    
    public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {		
		String id = request.getParameter("clinicNo");
		int clinicNo = 0;
		Clinic clinic = null;
		
		try {
			clinicNo = Integer.parseInt(id);
			clinic = clinicDAO.find(clinicNo);
		} catch (Exception e) {
			logger.warn("Unable to parse clinicNo: " + id);
		}
		
		try {
			clinicDAO.delete(clinic);
		} catch (Exception e) {
			logger.error("Unable to delete Clinic");
			request.setAttribute("actionResultMessage", "Unable to delete Clinic");
			request.setAttribute("actionResult", -1);
			return mapping.findForward("failure");
		}
		
		// Need to do this AFTER we call delete on the clinicDAO
		putClinicsInRequest(request);
		
		request.setAttribute("actionResultMessage", "Successfully deleted Clinic");
		request.setAttribute("actionResult", 0);
		
        return view(mapping, form, request, response);
    }

    public void setClinicDAO(ClinicDAO clinicDAO) {
        this.clinicDAO = clinicDAO;
    }
    
    private void putClinicsInRequest(HttpServletRequest request) {
		List<Clinic> clinics = this.clinicDAO.findAll();
		
		request.setAttribute("clinics", clinics);
	}
}
