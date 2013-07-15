<%--

    Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
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

    This software was written for the
    Department of Family Medicine
    McMaster University
    Hamilton
    Ontario, Canada

--%>

<%@page import="org.oscarehr.common.service.myoscar.AllergiesManager"%>
<%@page import="org.oscarehr.common.service.myoscar.ImmunizationsManager"%>
<%@page import="org.oscarehr.common.service.myoscar.MeasurementsManager"%>
<%@page import="org.oscarehr.common.service.myoscar.PrescriptionMedicationManager"%>
<%@page import="org.oscarehr.util.WebUtils"%>
<%@page import="org.oscarehr.util.LocaleUtils"%>
<%@page import="org.oscarehr.util.MiscUtils"%>
<%@page import="org.oscarehr.phr.util.MyOscarUtils"%>
<%@page import="org.oscarehr.phr.PHRAuthentication"%>
<%
	String parentPage = request.getParameter("parentPage");

	try
	{
		Integer demographicNo = Integer.parseInt(request.getParameter("demographicId"));
		String medicalDataType = request.getParameter("medicalDataType");
		PHRAuthentication auth=MyOscarUtils.getPHRAuthentication(session);
		
		if ("Allergies".equals(medicalDataType)) {
			AllergiesManager.sendAllergiesToMyOscar(auth, demographicNo);
		}
		else if ("Immunizations".equals(medicalDataType)) {
			ImmunizationsManager.sendImmunizationsToMyOscar(auth, demographicNo);
		}
		else if ("Measurements".equals(medicalDataType)) {
			MeasurementsManager.sendMeasurementsToMyOscar(auth, demographicNo);
		}
		else if ("Prescriptions".equals(medicalDataType)) {
			PrescriptionMedicationManager.sendPrescriptionsMedicationsToMyOscar(auth, demographicNo);
		}
		else {
			response.sendRedirect(parentPage);
		}
		
		WebUtils.addInfoMessage(session, LocaleUtils.getMessage(request,"ItemsHaveBeenSentToMyOscar"));
	}
	catch (Exception e)
	{
		MiscUtils.getLogger().error("error", e);
		WebUtils.addErrorMessage(session, LocaleUtils.getMessage(request,"UnexpectedError"));
	}
	
	response.sendRedirect(parentPage);
%>
