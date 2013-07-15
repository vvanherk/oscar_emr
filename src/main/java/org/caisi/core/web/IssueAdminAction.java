/**
 *
 * Copyright (c) 2005-2012. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved.
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
 * This software was written for
 * Centre for Research on Inner City Health, St. Michael's Hospital,
 * Toronto, Ontario, Canada
 */

package org.caisi.core.web;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.action.DynaActionForm;
import org.apache.struts.actions.DispatchAction;
import org.caisi.model.IssueAdmin;
import org.caisi.service.IssueAdminManager;
import org.oscarehr.common.dao.SecRoleDao;
import org.oscarehr.util.MiscUtils;

// use your IDE to handle imports
public class IssueAdminAction extends DispatchAction {
    private static Logger log = MiscUtils.getLogger();
    private IssueAdminManager mgr = null;
   // private CaisiRoleManager caisiRoleMgr = null;
    private SecRoleDao secRoleDao;

    public void setSecRoleDao(SecRoleDao secRoleDao) {
    	this.secRoleDao = secRoleDao;
    }

    public void setIssueAdminManager(IssueAdminManager issueAdminManager) {
        this.mgr = issueAdminManager;
    }
    /*
    public void setCaisiRoleManager(CaisiRoleManager caisiRoleManager) {
        this.caisiRoleMgr = caisiRoleManager;
    }
    */
    public ActionForward cancel(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request,
                                HttpServletResponse response)
     {
        if (log.isDebugEnabled()) {
            log.debug("entering 'delete' method...");
        }
        return list(mapping, form, request, response);
    }

    public ActionForward delete(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request,
                                HttpServletResponse response)
     {
        if (log.isDebugEnabled()) {
            log.debug("entering 'delete' method...");
        }
        mgr.removeIssueAdmin(request.getParameter("issueAdmin.id"));
        ActionMessages messages = new ActionMessages();
        messages.add(ActionMessages.GLOBAL_MESSAGE,
                     new ActionMessage("issueAdmin.deleted"));
        saveMessages(request, messages);
        return list(mapping, form, request, response);
    }
    public ActionForward edit(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response)
     {
        if (log.isDebugEnabled()) {
            log.debug("entering 'edit' method...");
        }
        DynaActionForm issueAdminForm = (DynaActionForm) form;
        String issueAdminId = request.getParameter("id");
        // null issueAdminId indicates an add
        if (issueAdminId != null) {
            IssueAdmin issueAdmin = mgr.getIssueAdmin(issueAdminId);
            if (issueAdmin == null) {
                ActionMessages errors = new ActionMessages();
                errors.add(ActionMessages.GLOBAL_MESSAGE,
                           new ActionMessage("issueAdmin.missing"));
                saveErrors(request, errors);
                return mapping.findForward("list");
            }
            request.setAttribute("issueRole", issueAdmin.getRole());
            issueAdminForm.set("issueAdmin", issueAdmin);
        }
        //request.setAttribute("caisiRoles", caisiRoleMgr.getRoles());
	request.setAttribute("caisiRoles", secRoleDao.findAll());
        return mapping.findForward("edit");
    }
    public ActionForward list(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response)
     {
        if (log.isDebugEnabled()) {
            log.debug("entering 'list' method...");
        }
        request.setAttribute("issueAdmins", mgr.getIssueAdmins());
        return mapping.findForward("list");
    }
    public ActionForward save(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response)
     {
        if (log.isDebugEnabled()) {
            log.debug("entering 'save' method...");
        }

        // run validation rules on this form
        ActionMessages errors = form.validate(mapping, request);
        if (!errors.isEmpty()) {
            saveErrors(request, errors);
           // request.setAttribute("caisiRoles", caisiRoleMgr.getRoles());
            return mapping.findForward("edit");
        }

        DynaActionForm issueAdminForm = (DynaActionForm) form;

	//issue code cannot be duplicated
	String newCode = ((IssueAdmin)issueAdminForm.get("issueAdmin")).getCode();
	String newId = String.valueOf(((IssueAdmin)issueAdminForm.get("issueAdmin")).getId());
	List issueAdmins = mgr.getIssueAdmins();
	for(Iterator it = issueAdmins.iterator(); it.hasNext();) {
	    IssueAdmin issueAdmin = (IssueAdmin)it.next();
	    String existCode = issueAdmin.getCode();
	    String existId = String.valueOf(issueAdmin.getId());
	    if((existCode.equals(newCode)) && !(existId.equals(newId))) {
		ActionMessages messages = new ActionMessages();
		messages.add(ActionMessages.GLOBAL_MESSAGE,new ActionMessage("issueAdmin.code.exist"));
		saveErrors(request,messages);
                //request.setAttribute("caisiRoles", caisiRoleMgr.getRoles());
                return mapping.findForward("edit");
	    }
	}

        mgr.saveIssueAdmin((IssueAdmin)issueAdminForm.get("issueAdmin"));
        ActionMessages messages = new ActionMessages();
        messages.add(ActionMessages.GLOBAL_MESSAGE,
                     new ActionMessage("issueAdmin.saved"));
        saveMessages(request, messages);
        return list(mapping, form, request, response);
    }
}
