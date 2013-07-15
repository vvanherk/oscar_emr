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


package oscar.oscarEncounter.oscarMeasurements.pageUtil;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.upload.FormFile;
import org.apache.struts.util.MessageResources;
import org.oscarehr.util.MiscUtils;

import oscar.OscarProperties;
import oscar.oscarDB.DBHandler;


public class EctAddMeasurementStyleSheetAction extends Action {

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        EctAddMeasurementStyleSheetForm frm = (EctAddMeasurementStyleSheetForm) form;
        request.getSession().setAttribute("EctAddMeasurementStyleSheetForm", frm);
        FormFile fileName = frm.getFile();
        ArrayList<String> messages = new ArrayList<String>();
        ActionMessages errors = new ActionMessages();

        if(!saveFile(fileName)){
            errors.add(ActionMessages.GLOBAL_MESSAGE,
            new ActionMessage("errors.fileNotAdded"));
            saveErrors(request, errors);
            return (new ActionForward(mapping.getInput()));
        }
        else{
            write2Database(fileName.getFileName());
            MessageResources mr = getResources(request);
            String msg = mr.getMessage("oscarEncounter.oscarMeasurement.msgAddedStyleSheet", fileName.getFileName());
            messages.add(msg);
            request.setAttribute("messages", messages);
            return mapping.findForward("success");
        }
    }

    /**
     *
     * Save a Jakarta FormFile to a preconfigured place.
     *
     * @param file
     * @return
     */
    public static boolean saveFile(FormFile file){
        String retVal = null;
        boolean isAdded = true;

        try {


            String sql = "SELECT * FROM measurementCSSLocation WHERE location='" + file.getFileName() + "'";
            ResultSet rs = DBHandler.GetSQL(sql);
            if(rs.next()){
                return false;
            }
            //retrieve the file data

            InputStream stream = file.getInputStream();
            String place= OscarProperties.getInstance().getProperty("oscarMeasurement_css_upload_path");

            if(!place.endsWith("/"))
                    place = new StringBuilder(place).insert(place.length(),"/").toString();
            retVal = place+file.getFileName();

            //write the file to the file specified
            OutputStream bos = new FileOutputStream(retVal);
            int bytesRead = 0;
            byte[] buffer = file.getFileData();
            while ((bytesRead = stream.read(buffer)) != -1){
                    bos.write(buffer, 0, bytesRead);
            }
            bos.close();
            stream.close();
        }
        catch (FileNotFoundException fnfe) {

            MiscUtils.getLogger().debug("File not found");
            MiscUtils.getLogger().error("Error", fnfe);
            return isAdded=false;

        }
        catch (IOException ioe) {
            MiscUtils.getLogger().error("Error", ioe);
            return isAdded=false;
        }
        catch(SQLException e) {
            MiscUtils.getLogger().error("Error", e);
        }
        return isAdded;
    }

    /**
    *
    * Write to database
    *
    * @param fileName - the filename to store
    *
    */
    private void write2Database(String fileName){
         try {

            String sql = "INSERT INTO measurementCSSLocation(location) VALUES('" + fileName + "')";
            MiscUtils.getLogger().debug("Sql Statement: " + sql);
            DBHandler.RunSQL(sql);
        }
        catch(SQLException e) {
            MiscUtils.getLogger().error("Error", e);
        }
    }


}
