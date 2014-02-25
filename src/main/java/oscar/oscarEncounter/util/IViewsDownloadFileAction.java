package oscar.oscarEncounter.util;

import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DownloadAction;
import org.apache.commons.io.FileUtils;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.util.SpringUtils;
import org.oscarehr.util.MiscUtils;

public class IViewsDownloadFileAction extends DownloadAction
{
	protected StreamInfo getStreamInfo(ActionMapping mapping,  ActionForm form,   HttpServletRequest request,  HttpServletResponse response) throws Exception
	{
        response.setHeader("Content-disposition", "attachment; filename=iview.bat");
   
		String contentType = "application/bat";
		
		String demographicNo = request.getParameter("demographicNo");
		
		if (demographicNo == null || demographicNo.equals("")) {
			MiscUtils.getLogger().error("Demographic number is null or empty.");
			return null;
		}
		
		DemographicDao demographicDao = (DemographicDao)SpringUtils.getBean("demographicDao");
        Demographic demographic = demographicDao.getDemographic(demographicNo);
		
		if (demographic == null) {
			MiscUtils.getLogger().error("Demographic does not exist.");
			return null;
		}
		
		File tempFile = File.createTempFile("temp", ".txt"); 
        tempFile.deleteOnExit();
        
        String firstName = demographic.getFirstName();
        String firstNameInitial = "";
        
        if (firstName == null || firstName.equals("")) {
			MiscUtils.getLogger().error("First name is null or empty.");
			return null;
		}
		else {
			firstNameInitial = firstName.substring(0, 1);
		}
            
        String tempText = "\"C:\\Program Files\\Chace and Associates\\iViews Imaging System\\iViews.exe\" /last:\"" + demographic.getLastName() + "\" /first:" + firstNameInitial + " /dob:" + demographic.getMonthOfBirth() + demographic.getDateOfBirth() + demographic.getYearOfBirth() + " /auto";
        
        FileUtils.writeByteArrayToFile(tempFile, tempText.getBytes("UTF-8"));
		
		return new FileStreamInfo(contentType, tempFile);
	}
}
