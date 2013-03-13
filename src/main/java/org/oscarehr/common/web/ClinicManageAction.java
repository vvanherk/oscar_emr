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
		try {
			clinicNo = Integer.parseInt(id);
		} catch (Exception e) {
			logger.error("Unable to parse clinicNo: " + id, e);
			return mapping.findForward("failure");
		}
		
        Clinic clinic = clinicDAO.find(clinicNo);
        DynaActionForm frm = (DynaActionForm)form;
        frm.set("clinic",clinic);
        request.setAttribute("clinicForm",form);
        return mapping.findForward("success");
    }

    public ActionForward update(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		putClinicsInRequest(request);
		
        DynaActionForm frm = (DynaActionForm)form;
        Clinic clinic = (Clinic) frm.get("clinic");
        clinicDAO.save(clinic);
        
        return mapping.findForward("success");
    }
    
    public ActionForward save(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return update(mapping, form, request, response);
    }

    public void setClinicDAO(ClinicDAO clinicDAO) {
        this.clinicDAO = clinicDAO;
    }
    
    private void putClinicsInRequest(HttpServletRequest request) {
		List<Clinic> clinics = this.clinicDAO.findAll();
		
		request.setAttribute("clinics", clinics);
	}
}
