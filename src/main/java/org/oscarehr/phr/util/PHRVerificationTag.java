// -----------------------------------------------------------------------------------------------------------------------
// *
// *
// * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved. *
// * This software is published under the GPL GNU General Public License. 
// * This program is free software; you can redistribute it and/or 
// * modify it under the terms of the GNU General Public License 
// * as published by the Free Software Foundation; either version 2 
// * of the License, or (at your option) any later version. * 
// * This program is distributed in the hope that it will be useful, 
// * but WITHOUT ANY WARRANTY; without even the implied warranty of 
// * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
// * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License 
// * along with this program; if not, write to the Free Software 
// * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. * 
// * 
// * <OSCAR TEAM>
// * This software was written for the 
// * Department of Family Medicine 
// * McMaster University 
// * Hamilton 
// * Ontario, Canada 
// *
// -----------------------------------------------------------------------------------------------------------------------
package org.oscarehr.phr.util;

import java.sql.SQLException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.oscarehr.common.dao.PHRVerificationDao;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;

import oscar.oscarDemographic.data.DemographicData;
import oscar.oscarProvider.data.ProviderMyOscarIdData;

import javax.servlet.http.HttpServletRequest;


public class PHRVerificationTag extends TagSupport {

	
    public PHRVerificationTag()    {
        
    }

    public void setDemographicNo(String demoNo1)    {
       demoNo = demoNo1;
    }

    public String getDemographicNo()    {
        return demoNo;
    }
    
    public void setStyleId(String styleId){
    	this.styleId = styleId;
    }
    
    public String getStyleId(){
    	return styleId;
    }
    
    public int doStartTag() throws JspException    {        
       try{
    	   HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
    	   conditionMet = false ;
           try {            
               if( ProviderMyOscarIdData.idIsSet((String)request.getSession().getAttribute("user")) ) {
                   if( demoNo != null ) {
                      DemographicData.Demographic demo = new DemographicData().getDemographic(demoNo); 
                      String myOscarUserName = demo.getMyOscarUserName();
                      if( myOscarUserName != null && !myOscarUserName.equals("") ) 
                           conditionMet = true;
                   }                                                    
               }                                        
           }catch(SQLException e) {
               MiscUtils.getLogger().error("Error", e);
           } 
    	 
    	   if(!conditionMet){
    		   return (SKIP_BODY);    
    	   }
    	   
    	   JspWriter out = super.pageContext.getOut();  
    	   String contextPath = request.getContextPath();
          
    	   if(styleId != null){
        	  styleId= " id=\""+styleId+"\" ";
    	   }
          
    	   out.print("<a "+styleId+" href=\"javascript: void(0);\" onclick=\"popup2(500, 600, 20, 30,'"+contextPath+"/phr/PHRVerification.jsp?demographic_no="+demoNo+"','myoscarVerification');\" >");                          
          
       } catch(Exception p) {
    	   MiscUtils.getLogger().error("Error",p);
       }
       return(EVAL_BODY_INCLUDE);
    }

    public int doEndTag()        throws JspException    {
    	if(conditionMet){
    		try{
    			JspWriter out = super.pageContext.getOut();         
    			PHRVerificationDao phrVerificationDao = (PHRVerificationDao)SpringUtils.getBean("PHRVerificationDao"); 
    			out.print("<sup>"+phrVerificationDao.getVerificationLevel(Integer.parseInt(demoNo))+"</sup></a>");
    		}catch(Exception p) {
    			MiscUtils.getLogger().error("Error",p);
    		}
    	 }
        return EVAL_PAGE;
     } 

    private String demoNo;
    private String styleId = null;
    private boolean conditionMet;
}