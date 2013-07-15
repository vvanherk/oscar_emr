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

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.oscarehr.caisi_integrator.ws.DemographicWs"%>
<%@page import="org.oscarehr.util.LoggedInInfo"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Enumeration"%>
<%@page import="org.oscarehr.common.model.Demographic"%>
<%@page import="org.oscarehr.util.SpringUtils"%>
<%@page import="org.oscarehr.common.dao.DemographicDao"%>
<%@page import="org.oscarehr.PMmodule.caisi_integrator.CaisiIntegratorManager"%>
<%@page import="org.oscarehr.util.WebUtils"%>
<%@page import="org.oscarehr.util.MiscUtils"%>
<%@ page import="org.oscarehr.PMmodule.model.Admission" %>
<%@ page import="org.oscarehr.PMmodule.dao.AdmissionDao" %>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean" scope="session" />
<%
	AdmissionDao admissionDao = (AdmissionDao)SpringUtils.getBean("admissionDao");
%>
<%
	int remoteFacilityId = Integer.parseInt(request.getParameter("remoteFacilityId"));
	int remoteDemographicId = Integer.parseInt(request.getParameter("demographic_no"));

	//--- make new local demographic record ---
	Demographic demographic=CaisiIntegratorManager.makeUnpersistedDemographicObjectFromRemoteEntry(remoteFacilityId, remoteDemographicId);
	DemographicDao demographicDao=(DemographicDao)SpringUtils.getBean("demographicDao");
	demographicDao.saveClient(demographic);
	Integer demoNoRightNow = demographic.getDemographicNo(); // temp use for debugging

	//--- link the demographic on the integrator so associated data shows up ---
	DemographicWs demographicWs=CaisiIntegratorManager.getDemographicWs();
	LoggedInInfo loggedInInfo=LoggedInInfo.loggedInInfo.get();
	String providerNo=loggedInInfo.loggedInProvider.getProviderNo();
	demographicWs.linkDemographics(providerNo, demographic.getDemographicNo(), remoteFacilityId, remoteDemographicId);


	MiscUtils.getLogger().error("LINK DEMOGRAPHIC #### ProviderNo :"+providerNo+" ,demo No :"+ demographic.getDemographicNo()+" , remoteFacilityId :"+ remoteFacilityId+" ,remoteDemographicId "+ remoteDemographicId+" orig demo "+demoNoRightNow);


	//--- add to program so the caisi program access filtering doesn't cause a security problem ---
	oscar.oscarEncounter.data.EctProgram program = new oscar.oscarEncounter.data.EctProgram(request.getSession());
    String progId = program.getProgram(providerNo);
    if (progId.equals("0")) {
       ResultSet rsProg = apptMainBean.queryResults("OSCAR", "search_program");
       if (rsProg.next())
       {
          progId = rsProg.getString("id");
       }
    }
    GregorianCalendar cal=new GregorianCalendar();
	String admissionDate=""+cal.get(GregorianCalendar.YEAR)+'-'+(cal.get(GregorianCalendar.MONTH)+1)+'-'+cal.get(GregorianCalendar.DAY_OF_MONTH);

	Admission admission = new Admission();
	admission.setClientId(demographic.getDemographicNo());
	admission.setProgramId(Integer.parseInt(progId));
	admission.setProviderNo(providerNo);
	admission.setAdmissionDate(oscar.MyDateFormat.getSysDate(admissionDate));
	admission.setAdmissionStatus("current");
	admission.setTeamId(0);
	admission.setTemporaryAdmission(false);
	admission.setAdmissionFromTransfer(false);
	admission.setDischargeFromTransfer(false);
	admission.setRadioDischargeReason("0");
	admission.setClientStatusId(0);
    admissionDao.saveAdmission(admission);

    //--- build redirect request ---

    // WebUtils.dumpParameters(request);
	// --- Dump Request Parameters Start ---
	// duration=15
	// messageID=null
	// location=
	// user_id=oscardoc, doctor
	// createdatetime=2011-6-13 13:36:24
	// type=
	// remarks=
	// creator=oscardoc, doctor
	// search_mode=search_name
	// orderby=last_name, first_name
	// originalpage=../appointment/addappointment.jsp
	// doctor_no=000000
	// bFirstDisp=false
	// notes=
	// end_time=09:14
	// start_time=09:00
	// ptstatus=active
	// demographic_no=1
	// status=t
	// originalPage=../appointment/addappointment.jsp
	// appointment_date=2011-06-13
	// limit2=5
	// limit1=0
	// resources=
	// provider_no=999998
	// reason=
	// chart_no=
	// remoteFacilityId=1
	// name=ASDF,ASDF
	// --- Dump Request Parameters End ---

	StringBuilder redirect=new StringBuilder();
	redirect.append(request.getParameter("originalPage"));
	redirect.append("?");

	redirect.append("demographic_no=");
	redirect.append(demographic.getDemographicNo());

	redirect.append("&doctor_no=");
	redirect.append(request.getParameter("provider_no"));

	@SuppressWarnings("unchecked")
	Enumeration<String> e = request.getParameterNames();
	while (e.hasMoreElements()) {
		String key = e.nextElement();

		if (key.equals("demographic_no") || key.equals("doctor_no") || key.equals("originalPage"))
		{
			// ignore these parameters
		}
		else
		{
			redirect.append("&");
			redirect.append(key);
			redirect.append("=");
			redirect.append(URLEncoder.encode(request.getParameter(key)));
		}
	}

	response.sendRedirect(redirect.toString());
%>
