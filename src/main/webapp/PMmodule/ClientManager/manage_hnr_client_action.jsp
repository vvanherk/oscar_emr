<%--


    Copyright (c) 2005-2012. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved.
    This software is published under the GPL GNU General Public License.
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

    This software was written for
    Centre for Research on Inner City Health, St. Michael's Hospital,
    Toronto, Ontario, Canada

--%>
<%@page import="org.oscarehr.util.MiscUtils"%>
<%@page import="org.oscarehr.caisi_integrator.ws.ConnectException_Exception"%>
<%@page import="org.oscarehr.util.WebUtils"%>
<%@page import="org.oscarehr.caisi_integrator.ws.DuplicateHinExceptionException"%>
<%@page import="org.oscarehr.caisi_integrator.ws.InvalidHinExceptionException"%>
<%@page import="org.apache.log4j.LogManager"%><%@page import="org.oscarehr.util.SessionConstants"%>
<%@page import="org.oscarehr.PMmodule.web.ManageHnrClientAction"%>
<%@page import="org.oscarehr.common.model.Facility"%>
<%@page import="org.oscarehr.common.model.Provider"%>
<%@page import="org.oscarehr.common.model.Demographic"%>
<%@page import="org.apache.commons.lang.time.DateFormatUtils"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%
	int currentDemographicId=Integer.parseInt(request.getParameter("demographicId"));
	Facility currentFacility = (Facility) request.getSession().getAttribute(SessionConstants.CURRENT_FACILITY);
	Provider currentProvider = (Provider) request.getSession().getAttribute(SessionConstants.LOGGED_IN_PROVIDER);
	
	if ("copyLocalValidatedToHnr".equals(request.getParameter("action")))
	{
		try
		{
			ManageHnrClientAction.copyLocalValidatedToHnr(currentDemographicId);
		}
		catch (ConnectException_Exception e)
		{
			WebUtils.addErrorMessage(session, "The HNR server is currently unavailable.");
		}
		catch (DuplicateHinExceptionException e)
		{
			WebUtils.addErrorMessage(session, "This HIN is already in use in the HNR, please link to that individual.");
			ManageHnrClientAction.setHcInfoValidation(currentDemographicId, false);
		}
		catch (InvalidHinExceptionException e)
		{
			WebUtils.addErrorMessage(session, "This HIN you provided does not pass validation. Please check the HIN and it's Type.");
			ManageHnrClientAction.setHcInfoValidation(currentDemographicId, false);
		}
	}
	else if ("copyHnrToLocal".equals(request.getParameter("action")))
	{
		try
		{
			ManageHnrClientAction.copyHnrToLocal(currentDemographicId);
		}
		catch (ConnectException_Exception e)
		{
			WebUtils.addErrorMessage(session, "The HNR server is currently unavailable.");
		}
	}
	else if ("validatePicture".equals(request.getParameter("action")))
	{
		ManageHnrClientAction.setPictureValidation(currentDemographicId, true);
	}
	else if ("invalidatePicture".equals(request.getParameter("action")))
	{
		ManageHnrClientAction.setPictureValidation(currentDemographicId, false);
	}
	else if ("validateHcInfo".equals(request.getParameter("action")))
	{
		ManageHnrClientAction.setHcInfoValidation(currentDemographicId, true);
	}
	else if ("invalidateHcInfo".equals(request.getParameter("action")))
	{
		ManageHnrClientAction.setHcInfoValidation(currentDemographicId, false);
	}
	else if ("validateOtherInfo".equals(request.getParameter("action")))
	{
		ManageHnrClientAction.setOtherInfoValidation(currentDemographicId, true);
	}
	else if ("invalidateOtherInfo".equals(request.getParameter("action")))
	{
		ManageHnrClientAction.setOtherInfoValidation(currentDemographicId, false);
	}
	else
	{
		MiscUtils.getLogger().error("Unexpected action. qs="+request.getQueryString());
	}
	
	response.sendRedirect("manage_hnr_client.jsp?demographicId="+currentDemographicId);
%>
