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


package oscar.oscarMDS.pageUtil;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;
import org.oscarehr.common.dao.SpireAccessionNumberMapDao;
import org.oscarehr.common.model.SpireAccessionNumberMap;
import org.oscarehr.common.model.SpireCommonAccessionNumber;

import oscar.log.LogAction;
import oscar.log.LogConst;
import oscar.oscarDB.DBHandler;
import oscar.oscarLab.ca.on.CommonLabResultData;

public class ReportStatusUpdateAction extends DispatchAction {

    private static Logger logger = MiscUtils.getLogger();

    public ReportStatusUpdateAction() {
    }

    public ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	return executemain(mapping, form, request, response);
    }

    public ActionForward executemain(ActionMapping mapping,
            ActionForm form,
            HttpServletRequest request,
            HttpServletResponse response)
             {

        int labNo = Integer.parseInt(request.getParameter("segmentID"));
        String multiID = request.getParameter("multiID");
        String providerNo = request.getParameter("providerNo");
        char status = request.getParameter("status").charAt(0);
        String comment = request.getParameter("comment");
        String lab_type = request.getParameter("labType");
        String ajaxcall=request.getParameter("ajaxcall");

        if(status == 'A'){
            String demographicID = getDemographicIdFromLab(lab_type, labNo);
            LogAction.addLog((String) request.getSession().getAttribute("user"), LogConst.ACK, LogConst.CON_HL7_LAB, ""+labNo, request.getRemoteAddr(),demographicID);
        }

        try {
			
			// Acknowledge all individual pieces of a spire lab
			updateSpireReportStatus(labNo, providerNo, status, comment, lab_type);
			
            CommonLabResultData.updateReportStatus(labNo, providerNo, status, comment,lab_type);
            if (multiID != null){
                String[] id = multiID.split(",");
                int i=0;
                int idNum = Integer.parseInt(id[i]);
                while(idNum != labNo){
                	CommonLabResultData.updateReportStatus(idNum, providerNo, 'F', "", lab_type);
                    i++;
                    idNum = Integer.parseInt(id[i]);
                }

            }
            if(ajaxcall!=null&&ajaxcall.equals("yes"))
                return null;
            else
                return mapping.findForward("success");
        } catch (Exception e) {
            logger.error("exception in ReportStatusUpdateAction",e);
            return mapping.findForward("failure");
        }
    }

    public ActionForward addComment(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
    	int labNo = Integer.parseInt(request.getParameter("segmentID"));
    	String providerNo = request.getParameter("providerNo");
    	char status = request.getParameter("status").charAt(0);
        String comment = request.getParameter("comment");
        String lab_type = request.getParameter("labType");

        try {

        	CommonLabResultData.updateReportStatus(labNo, providerNo, status, comment,lab_type);

        } catch(Exception e) {
        	logger.error("exception in setting comment",e);
            return mapping.findForward("failure");
        }
    	return null;
    }

    private static String getDemographicIdFromLab(String labType, int labNo)
    {
    	String demographicID="";
        try{
            String sql = "SELECT demographic_no FROM patientLabRouting WHERE lab_type = '"+labType+"' and lab_no='"+labNo+"'";

            ResultSet rs = DBHandler.GetSQL(sql);

            while(rs.next()){
                demographicID = oscar.Misc.getString(rs, "demographic_no");
            }
            rs.close();
        }catch(Exception e){
        	logger.error("Error", e);
        }

        return(demographicID);
    }
    
    private void updateSpireReportStatus(int labNo, String providerNo, char status, String comment, String lab_type) {
		SpireAccessionNumberMapDao accnDao = (SpireAccessionNumberMapDao)SpringUtils.getBean("spireAccessionNumberMapDao");
		SpireAccessionNumberMap map = accnDao.getFromLabNumber(new Integer(labNo));
		
		if (map != null) {
			List<SpireCommonAccessionNumber> cAccns = map.getCommonAccessionNumbers();
			
			if (cAccns != null) {				
				MiscUtils.getLogger().info("cAccns size: " + cAccns.size());
				
				for (SpireCommonAccessionNumber cAccn : cAccns) {
					CommonLabResultData.updateReportStatus(cAccn.getLabNo().intValue(), providerNo, status, comment, lab_type);
					
				}
			}
		}
	}
}