package org.oscarehr.PMmodule.web;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.oscarehr.PMmodule.dao.AdmissionDao;
import org.oscarehr.PMmodule.model.Admission;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.common.dao.OcanClientFormDao;
import org.oscarehr.common.dao.OcanClientFormDataDao;
import org.oscarehr.common.dao.OcanFormOptionDao;
import org.oscarehr.common.dao.OcanStaffFormDao;
import org.oscarehr.common.dao.OcanStaffFormDataDao;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.common.model.OcanClientForm;
import org.oscarehr.common.model.OcanClientFormData;
import org.oscarehr.common.model.OcanFormOption;
import org.oscarehr.common.model.OcanStaffForm;
import org.oscarehr.common.model.OcanStaffFormData;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;

public class OcanForm {
	
	public static final int PRE_POPULATION_LEVEL_ALL 			= 3;
	public static final int PRE_POPULATION_LEVEL_DEMOGRAPHIC 	= 2;
	public static final int PRE_POPULATION_LEVEL_NONE 			= 1;
	
	private static AdmissionDao admissionDao = (AdmissionDao) SpringUtils.getBean("admissionDao");
	private static DemographicDao demographicDao = (DemographicDao) SpringUtils.getBean("demographicDao");
	private static OcanFormOptionDao ocanFormOptionDao = (OcanFormOptionDao) SpringUtils.getBean("ocanFormOptionDao");
	private static OcanStaffFormDao ocanStaffFormDao = (OcanStaffFormDao) SpringUtils.getBean("ocanStaffFormDao");
	private static OcanStaffFormDataDao ocanStaffFormDataDao = (OcanStaffFormDataDao) SpringUtils.getBean("ocanStaffFormDataDao");	
	private static OcanClientFormDao ocanClientFormDao = (OcanClientFormDao) SpringUtils.getBean("ocanClientFormDao");
	private static OcanClientFormDataDao ocanClientFormDataDao = (OcanClientFormDataDao) SpringUtils.getBean("ocanClientFormDataDao");
	
	
	public static Demographic getDemographic(String demographicId)
	{
		return demographicDao.getDemographic(demographicId);
	}
	
	public static OcanStaffForm getOcanStaffForm(Integer clientId, int prepopulationLevel)
	{
		LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();
		
		OcanStaffForm ocanStaffForm=null;
		
		if(prepopulationLevel != OcanForm.PRE_POPULATION_LEVEL_NONE) {
			ocanStaffForm=ocanStaffFormDao.findLatestByFacilityClient(loggedInInfo.currentFacility.getId(), clientId);
		}

		if (ocanStaffForm==null)
		{
			ocanStaffForm=new OcanStaffForm();
			ocanStaffForm.setAddressLine2("");
			
			if(prepopulationLevel != OcanForm.PRE_POPULATION_LEVEL_NONE) {
				Demographic demographic=demographicDao.getDemographicById(clientId);		
				ocanStaffForm.setLastName(demographic.getLastName());
				ocanStaffForm.setFirstName(demographic.getFirstName());	
				ocanStaffForm.setAddressLine1(demographic.getAddress());
				ocanStaffForm.setCity(demographic.getCity());
				ocanStaffForm.setProvince(demographic.getProvince());
				ocanStaffForm.setPostalCode(demographic.getPostal());
				ocanStaffForm.setPhoneNumber(demographic.getPhone());
				ocanStaffForm.setEmail(demographic.getEmail());
				ocanStaffForm.setHcNumber(demographic.getHin());
				ocanStaffForm.setHcVersion(demographic.getVer());
				ocanStaffForm.setDateOfBirth(demographic.getFormattedDob());
			}				             
		}
		
		return(ocanStaffForm);
	}
	
	public static List<OcanFormOption> getOcanFormOptions(String category)
	{
		List<OcanFormOption> results=ocanFormOptionDao.findByVersionAndCategory("1.2", category);
		return(results);
	}
	
	private static List<OcanStaffFormData> getStaffAnswers(Integer ocanStaffFormId, String question, int prepopulationLevel)
	{
		if(prepopulationLevel != OcanForm.PRE_POPULATION_LEVEL_ALL) {
			return(new ArrayList<OcanStaffFormData>()); 
		}
		if (ocanStaffFormId==null) return(new ArrayList<OcanStaffFormData>()); 
			
		return(ocanStaffFormDataDao.findByQuestion(ocanStaffFormId, question));
	}
	
	private static List<OcanClientFormData> getClientAnswers(Integer ocanClientFormId, String question, int prepopulationLevel)
	{
		if(prepopulationLevel != OcanForm.PRE_POPULATION_LEVEL_ALL) {
			return(new ArrayList<OcanClientFormData>()); 
		}
		
		if (ocanClientFormId==null) return(new ArrayList<OcanClientFormData>()); 
			
		return(ocanClientFormDataDao.findByQuestion(ocanClientFormId, question));
	}
	
	public static String renderAsDate(Integer ocanStaffFormId, String question, boolean required, int prepopulationLevel)
	{
		return renderAsDate(ocanStaffFormId,question,required, prepopulationLevel, false);
	}
	
	/**
	 * This method is meant to return a bunch of html <option> tags for each list element.
	 */
	public static String renderAsDate(Integer ocanStaffFormId, String question, boolean required, int prepopulationLevel, boolean clientForm)
	{
		String value="", className="";
		if(!clientForm) {
			List<OcanStaffFormData> existingAnswers=getStaffAnswers(ocanStaffFormId, question, prepopulationLevel);
			if(existingAnswers.size()>0) {value = existingAnswers.get(0).getAnswer();}
		} else {
			List<OcanClientFormData> existingAnswers=getClientAnswers(ocanStaffFormId, question, prepopulationLevel);
			if(existingAnswers.size()>0) {value = existingAnswers.get(0).getAnswer();}
		}
		if(required) {className="{validate: {required:true}}";}
		return "<input type=\"text\" value=\"" + value + "\" id=\""+question+"\" name=\""+question+"\" onfocus=\"this.blur()\" readonly=\"readonly\" class=\""+className+"\"/> <img title=\"Calendar\" id=\"cal_"+question+"\" src=\"../../images/cal.gif\" alt=\"Calendar\" border=\"0\"><script type=\"text/javascript\">Calendar.setup({inputField:'"+question+"',ifFormat :'%Y-%m-%d',button :'cal_"+question+"',align :'cr',singleClick :true,firstDay :1});</script>";
	}
	
	public static String renderAsDate(Integer ocanStaffFormId, String question, boolean required, String defaultValue , int prepopulationLevel)
	{
		return renderAsDate(ocanStaffFormId, question, required, defaultValue,prepopulationLevel,false);
	}
	
	public static String renderAsDate(Integer ocanStaffFormId, String question, boolean required, String defaultValue, int prepopulationLevel, boolean clientForm)
	{
		List<OcanStaffFormData> existingAnswers=getStaffAnswers(ocanStaffFormId, question, prepopulationLevel);
		String value="", className="";
		if(existingAnswers.size()>0) {value = existingAnswers.get(0).getAnswer();}
		if(value.equals("")) {value =defaultValue;}
		if(required) {className="{validate: {required:true}}";}
		return "<input type=\"text\" value=\"" + value + "\" id=\""+question+"\" name=\""+question+"\" onfocus=\"this.blur()\" readonly=\"readonly\" class=\""+className+"\"/> <img title=\"Calendar\" id=\"cal_"+question+"\" src=\"../../images/cal.gif\" alt=\"Calendar\" border=\"0\"><script type=\"text/javascript\">Calendar.setup({inputField:'"+question+"',ifFormat :'%Y-%m-%d',button :'cal_"+question+"',align :'cr',singleClick :true,firstDay :1});</script>";
	}	
	
	public static List<Admission> getAdmissions(Integer clientId) {
		LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();
		
		return(admissionDao.getAdmissionsByFacility(clientId, loggedInInfo.currentFacility.getId()));
	}
	
	public static String getEscapedAdmissionSelectionDisplay(Admission admission)
	{
		StringBuilder sb=new StringBuilder();
		
		sb.append(admission.getProgramName());
		sb.append(" ( ");
		sb.append(DateFormatUtils.ISO_DATE_FORMAT.format(admission.getAdmissionDate()));
		sb.append(" - ");
		if (admission.getDischargeDate()==null) sb.append("current");
		else sb.append(DateFormatUtils.ISO_DATE_FORMAT.format(admission.getDischargeDate()));
		sb.append(" )");
		
		return(StringEscapeUtils.escapeHtml(sb.toString()));
	}
	
	
	public static String renderAsSelectOptions(Integer ocanStaffFormId, String question, List<OcanFormOption> options, int prepopulationLevel)
	{
		return renderAsSelectOptions(ocanStaffFormId,question, options, prepopulationLevel, false);
	}
	/**
	 * This method is meant to return a bunch of html <option> tags for each list element.
	 */
	public static String renderAsSelectOptions(Integer ocanStaffFormId, String question, List<OcanFormOption> options, int prepopulationLevel, boolean clientForm)
	{
		List<OcanStaffFormData> existingStaffAnswers=null;
		List<OcanClientFormData> existingClientAnswers=null;
		if(!clientForm)
			existingStaffAnswers = getStaffAnswers(ocanStaffFormId, question, prepopulationLevel);
		else
			existingClientAnswers = getClientAnswers(ocanStaffFormId, question, prepopulationLevel);

		StringBuilder sb=new StringBuilder();

		sb.append("<option value=\"\">Select an answer</option>");
		for (OcanFormOption option : options)
		{
			String htmlEscapedName=StringEscapeUtils.escapeHtml(option.getOcanDataCategoryName());
			//String lengthLimitedEscapedName=limitLengthAndEscape(option.getOcanDataCategoryName());
			String selected=null;
			if(!clientForm)
				selected=(OcanStaffFormData.containsAnswer(existingStaffAnswers, option.getOcanDataCategoryValue())?"selected=\"selected\"":"");
			else
				selected=(OcanClientFormData.containsAnswer(existingClientAnswers, option.getOcanDataCategoryValue())?"selected=\"selected\"":"");
			
			sb.append("<option "+selected+" value=\""+StringEscapeUtils.escapeHtml(option.getOcanDataCategoryValue())+"\" title=\""+htmlEscapedName+"\">"+htmlEscapedName+"</option>");
		}
		
		return(sb.toString());
	}
	
	public static String renderAsProvinceSelectOptions(OcanStaffForm ocanStaffForm)
	{
		String province = ocanStaffForm.getProvince();
		if(province==null) province = "ON";
		List<OcanFormOption> options = getOcanFormOptions("Province List");
		
		StringBuilder sb=new StringBuilder();

		for (OcanFormOption option : options)
		{
			String htmlEscapedName=StringEscapeUtils.escapeHtml(option.getOcanDataCategoryName());
			//String lengthLimitedEscapedName=limitLengthAndEscape(option.getOcanDataCategoryName());
			String selected=province.equals(option.getOcanDataCategoryValue())?"selected=\"selected\"":"";

			sb.append("<option "+selected+" value=\""+StringEscapeUtils.escapeHtml(option.getOcanDataCategoryValue())+"\" title=\""+htmlEscapedName+"\">"+htmlEscapedName+"</option>");
		}
		
		return(sb.toString());
	}
	public static String renderAsDomainSelectOptions(Integer ocanStaffFormId, String question, List<OcanFormOption> options, String[] valuesToInclude, int prepopulationLevel)
	{
		List<OcanStaffFormData> existingAnswers=getStaffAnswers(ocanStaffFormId, question ,prepopulationLevel);

		StringBuilder sb=new StringBuilder();

		for (OcanFormOption option : options)
		{
			if(valuesToInclude !=null && valuesToInclude.length>0) {
				boolean include=false;
				for(String inclValue:valuesToInclude) {
					if(option.getOcanDataCategoryValue().equals(inclValue)) {
						include=true;
						break;
					}
				}
				if(!include) {
					continue;
				}
			}
			
			String htmlEscapedName=StringEscapeUtils.escapeHtml(option.getOcanDataCategoryName());
			//String lengthLimitedEscapedName=limitLengthAndEscape(option.getOcanDataCategoryName());
			String selected=(OcanStaffFormData.containsAnswer(existingAnswers, option.getOcanDataCategoryValue())?"selected=\"selected\"":"");

			sb.append("<option "+selected+" value=\""+StringEscapeUtils.escapeHtml(option.getOcanDataCategoryValue())+"\" title=\""+htmlEscapedName+"\">"+htmlEscapedName+"</option>");
		}
		
		return(sb.toString());
	}
	
	public static String renderAsSelectOptions(Integer ocanStaffFormId, String question, List<OcanFormOption> options, String defaultValue, int prepopulationLevel)
	{
		return renderAsSelectOptions(ocanStaffFormId, question, options, defaultValue, prepopulationLevel, false);
	}
	/**
	 * This method is meant to return a bunch of html <option> tags for each list element.
	 */
	public static String renderAsSelectOptions(Integer ocanStaffFormId, String question, List<OcanFormOption> options, String defaultValue, int prepopulationLevel, boolean clientForm)
	{
		List<OcanStaffFormData> existingAnswers=getStaffAnswers(ocanStaffFormId, question, prepopulationLevel);
		boolean useDefaultValue=false;
		if(existingAnswers.size()==0) {
			useDefaultValue=true;
		}
		StringBuilder sb=new StringBuilder();

		for (OcanFormOption option : options)
		{
			String htmlEscapedName=StringEscapeUtils.escapeHtml(option.getOcanDataCategoryName());
			//String lengthLimitedEscapedName=limitLengthAndEscape(option.getOcanDataCategoryName());
			String selected="";
			if(!useDefaultValue)
				selected=(OcanStaffFormData.containsAnswer(existingAnswers, option.getOcanDataCategoryValue())?"selected=\"selected\"":"");
			else {
				if(option.getOcanDataCategoryValue().equals(defaultValue)) {
					selected="selected=\"selected\"";
				}
			}

			sb.append("<option "+selected+" value=\""+StringEscapeUtils.escapeHtml(option.getOcanDataCategoryValue())+"\" title=\""+htmlEscapedName+"\">"+htmlEscapedName+"</option>");
		}
		
		return(sb.toString());
	}	
	
	public static String renderAsTextArea(Integer ocanStaffFormId, String question, int rows, int cols, int prepopulationLevel)
	{
		return renderAsTextArea(ocanStaffFormId, question, rows, cols, prepopulationLevel, false);
	}
	
	public static String renderAsTextArea(Integer ocanStaffFormId, String question, int rows, int cols, int prepopulationLevel, boolean clientForm)
	{
		List<OcanStaffFormData> existingAnswers= null;
		List<OcanClientFormData> existingClientAnswers=null;

		StringBuilder sb=new StringBuilder();

		sb.append("<textarea name=\""+question+"\" id=\""+question+"\" rows=\"" + rows + "\" cols=\"" + cols + "\">");

		if(!clientForm) {
			existingAnswers=getStaffAnswers(ocanStaffFormId, question, prepopulationLevel);
			if(existingAnswers.size()>0) {
				sb.append(existingAnswers.get(0).getAnswer());
			}	
		} else { 
			existingClientAnswers=getClientAnswers(ocanStaffFormId, question, prepopulationLevel);
			if(existingClientAnswers.size()>0) {
				sb.append(existingClientAnswers.get(0).getAnswer());
			}	
		}
		
		
		sb.append("</textarea>");
		return(sb.toString());
	}
	
	public static String renderAsSoATextArea(Integer ocanStaffFormId, String question, int rows, int cols, int prepopulationLevel)
	{
		List<OcanStaffFormData> existingAnswers=getStaffAnswers(ocanStaffFormId, question,prepopulationLevel);

		StringBuilder sb=new StringBuilder();

		sb.append("<textarea name=\""+question+"\" id=\""+question+"\" rows=\"" + rows + "\" cols=\"" + cols + "\" readonly=\"readonly\" onfocus=\"this.blur()\">");
		if(existingAnswers.size()>0) {
			sb.append(existingAnswers.get(0).getAnswer());
		}
		sb.append("</textarea>");
		return(sb.toString());
	}
	
	public static String renderAsTextField(Integer ocanStaffFormId, String question, int size, int prepopulationLevel)
	{
		return renderAsTextField(ocanStaffFormId, question, size, prepopulationLevel, false);
	}
	
	public static String renderAsTextField(Integer ocanStaffFormId, String question, int size, int prepopulationLevel, boolean clientForm)
	{
		List<OcanStaffFormData> existingAnswers=getStaffAnswers(ocanStaffFormId, question, prepopulationLevel);

		String value = "";
		if(existingAnswers.size()>0) {
			value = existingAnswers.get(0).getAnswer();
		}
		StringBuilder sb=new StringBuilder();

		sb.append("<input type=\"text\" name=\""+question+"\" id=\""+question+"\" size=\"" + size + "\" value=\""+value+"\"/>");
		
		return(sb.toString());
	}
	
	public static String renderAsCheckBoxOptions(Integer ocanStaffFormId, String question, List<OcanFormOption> options, int prepopulationLevel)
	{
		return renderAsCheckBoxOptions(ocanStaffFormId, question,options,prepopulationLevel, false);
	}
	
	public static String renderAsCheckBoxOptions(Integer ocanStaffFormId, String question, List<OcanFormOption> options, int prepopulationLevel, boolean clientForm)
	{
		List<OcanStaffFormData> existingAnswers=getStaffAnswers(ocanStaffFormId, question, prepopulationLevel);
 
		StringBuilder sb=new StringBuilder();

		for (OcanFormOption option : options)
		{
			String htmlEscapedName=StringEscapeUtils.escapeHtml(option.getOcanDataCategoryName());
			//String lengthLimitedEscapedName=limitLengthAndEscape(option.getOcanDataCategoryName());
			String checked=(OcanStaffFormData.containsAnswer(existingAnswers, option.getOcanDataCategoryValue())?"checked=\"checked\"":"");
				
			sb.append("<div title=\""+htmlEscapedName+"\"><input type=\"checkBox\" "+checked+" name=\""+question+"\" value=\""+StringEscapeUtils.escapeHtml(option.getOcanDataCategoryValue())+"\" /> "+htmlEscapedName+"</div>");
		}
		
		return(sb.toString());
	}
	
	public static String renderAsHiddenField(Integer ocanStaffFormId, String question, int prepopulationLevel)
	{
		return renderAsHiddenField(ocanStaffFormId, question, prepopulationLevel, false);
	}
	
	public static String renderAsHiddenField(Integer ocanStaffFormId, String question, int prepopulationLevel, boolean clientForm)
	{
		List<OcanStaffFormData> existingAnswers=getStaffAnswers(ocanStaffFormId, question, prepopulationLevel);

		String value = "";
		if(existingAnswers.size()>0) {
			value = existingAnswers.get(0).getAnswer();
		}
		StringBuilder sb=new StringBuilder();

		sb.append("<input type=\"hidden\" name=\""+question+"\" id=\""+question+"\" value=\""+value+"\"/>");
		
		return(sb.toString());
	}
	
	
	
	
	///client form//////
	
	public static OcanClientForm getOcanClientForm(Integer clientId, int prepopulationLevel)
	{
		LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();
		
		OcanClientForm ocanClientForm=null;
		
		if(prepopulationLevel != OcanForm.PRE_POPULATION_LEVEL_NONE) {
			ocanClientForm = ocanClientFormDao.findLatestByFacilityClient(loggedInInfo.currentFacility.getId(), clientId);
		}

		if (ocanClientForm==null)
		{
			ocanClientForm=new OcanClientForm();

			if(prepopulationLevel != OcanForm.PRE_POPULATION_LEVEL_NONE) {
				Demographic demographic=demographicDao.getDemographicById(clientId);
				ocanClientForm.setLastName(demographic.getLastName());
				ocanClientForm.setFirstName(demographic.getFirstName());				
				ocanClientForm.setDateOfBirth(demographic.getFormattedDob());
			}
		}
		
		return(ocanClientForm);
	}
}