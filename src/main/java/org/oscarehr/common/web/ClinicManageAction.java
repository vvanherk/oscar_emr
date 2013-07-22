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
			id = "" + clinic.getId();
		if (clinic == null) {
			logger.error("Unable to find Clinic.");
			request.setAttribute("actionResultMessage", "Unable to find Clinic");
			request.setAttribute("actionResult", -1);
			return mapping.findForward("failure");
		}
		
		request.setAttribute("clinicNo", id);
				
        DynaActionForm frm = (DynaActionForm)form;
        frm.set("clinic",clinic);
        request.setAttribute("clinicForm",form);
        return mapping.findForward("success");
    }

    public ActionForward update(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        DynaActionForm frm = (DynaActionForm)form;
        Clinic clinic = (Clinic) frm.get("clinic");
        //weird hack, but not sure why struts isn't filling in the id.
        if(request.getParameter("clinic.id") != null && request.getParameter("clinic.id").length()>0 && clinic.getId()==null) {
        	clinic.setId(Integer.parseInt(request.getParameter("clinic.id")));
        }
        clinicDAO.save(clinic);
        
        // Set the clinicNo so the 'view' action can load it properly
        //request.setParameter("clinicNo", clinic.getId());
        
        // Need to do this AFTER we call save on the clinicDAO
        putClinicsInRequest(request);
        
        request.setAttribute("actionResultMessage", "Successfully saved/updated Clinic");
		request.setAttribute("actionResult", 0);
		
        return view(mapping, form, request, response);
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
			request.setAttribute("actionResultMessage", "Unable to delete Clinic - No Clinic specified");
			request.setAttribute("actionResult", -1);
			return view(mapping, form, request, response);
		}
		
		
		int numClinics = clinicDAO.getNumberOfClinics();
		
		// We need at least one clinic at all times
		if (numClinics <= 1) {
			logger.error("Unable to delete Clinic - OSCAR must have at least one (1) Clinic");
			request.setAttribute("actionResultMessage", "Unable to delete Clinic - OSCAR must have at least one (1) Clinic");
			request.setAttribute("actionResult", -1);
			return view(mapping, form, request, response);
		}
		
		try {
			clinicDAO.delete(clinic);
		} catch (Exception e) {
			logger.error("Unable to delete Clinic");
			request.setAttribute("actionResultMessage", "Unable to delete Clinic");
			request.setAttribute("actionResult", -1);
			return view(mapping, form, request, response);
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
		List<Clinic> clinics = this.clinicDAO.getClinics();
		
		request.setAttribute("clinics", clinics);
	}
}
