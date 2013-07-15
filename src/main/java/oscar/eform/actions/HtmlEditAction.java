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


package oscar.eform.actions;

import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.WebUtils;

import oscar.eform.EFormUtil;
import oscar.eform.data.EFormBase;
import oscar.eform.data.HtmlEditForm;
import oscar.util.StringUtils;

public class HtmlEditAction extends Action {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request, HttpServletResponse response) {
        HtmlEditForm fm = (HtmlEditForm) form;
        try {
            String fid = fm.getFid();
            String formName = fm.getFormName();
            String formSubject = fm.getFormSubject();
            String formFileName = fm.getFormFileName();
            String formHtml = fm.getFormHtml();
            FormFile uploadFile = fm.getUploadFile();
            boolean patientIndependent = WebUtils.isChecked(request, "patientIndependent");
            String roleType = fm.getRoleType();
            
            Hashtable errors = new Hashtable();
            if (request.getParameter("uploadMarker").equals("true")) {
                //if uploading file
                String readstream = StringUtils.readFileStream(uploadFile);
                if (readstream.length() == 0) {
                    errors.put("uploadError", "eform.errors.upload.failed");
                } else {
                    formHtml = org.apache.commons.lang.StringEscapeUtils.escapeJava(readstream);
                    formFileName = uploadFile.getFileName();
                }
                Hashtable curht = createHashtable(fid, formName, formSubject, formFileName, formHtml, patientIndependent, roleType);
                request.setAttribute("submitted", curht);
                request.setAttribute("errors", errors);
                return(mapping.findForward("success"));
            }
            formHtml = org.apache.commons.lang.StringEscapeUtils.escapeJava(formHtml);
            EFormBase updatedform = new EFormBase(fid, formName, formSubject, formFileName, formHtml, patientIndependent, roleType); //property container (bean)
            //validation...
            if ((formName == null) || (formName.length() == 0)) {
                errors.put("formNameMissing", "eform.errors.form_name.missing.regular");
            }
            if ((fid.length() > 0) && (EFormUtil.formExistsInDBn(formName, fid) > 0)) {
                errors.put("formNameExists", "eform.errors.form_name.exists.regular");
            }
            if ((fid.length() == 0) && (errors.size() == 0)) {
                fid = EFormUtil.saveEForm(formName, formSubject, formFileName, formHtml, patientIndependent, roleType);
                request.setAttribute("success", "true");
            } else if (errors.size() == 0) {
                EFormUtil.updateEForm(updatedform);
                request.setAttribute("success", "true");
            }
            
            Hashtable curht = createHashtable(fid, formName, formSubject, formFileName, formHtml, patientIndependent, roleType);
            request.setAttribute("submitted", curht);
            
            request.setAttribute("errors", errors);
        } catch (Exception e) {
            MiscUtils.getLogger().error("Error", e);
        }
        return(mapping.findForward("success"));
    }
    
    private Hashtable createHashtable(String fid, String formName, String formSubject, String formFileName, String formHtml, boolean patientIndependent, String roleType) {
        Hashtable curht = new Hashtable();
        curht.put("fid", fid);  
        curht.put("formName", formName);
        curht.put("formSubject", formSubject);
        curht.put("formFileName", formFileName);
        curht.put("patientIndependent", patientIndependent);
        curht.put("roleType", roleType);
        
        if (fid.length() == 0) {
            curht.put("formDate", "--");
            curht.put("formTime", "--");
        } else {
            curht.put("formDate", EFormUtil.getEFormParameter(fid, "formDate"));
            curht.put("formTime", EFormUtil.getEFormParameter(fid, "formTime"));
        }
        curht.put("formHtml", org.apache.commons.lang.StringEscapeUtils.unescapeJava(formHtml));
        return curht;
    }
    
}
