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

<%@page import="java.util.*"%>
<%@page import="org.oscarehr.common.dao.DemographicExtDao" %>
<%@page import="org.oscarehr.util.SpringUtils" %>
<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean" scope="session" />
<%
String demographic_no = request.getParameter("demo");
DemographicExtDao demographicExtDao = SpringUtils.getBean(DemographicExtDao.class);
Map<String,String> demoExt = demographicExtDao.getAllValuesForDemo(demographic_no);

%>
<tr>
	<td align="right"><b>Consent:</b></td>
	<td align="left" colspan="3">
	<% String given_consent = apptMainBean.getString(demoExt.get("given_consent")); %>
	<select name="given_consent">
		<option value="-1" <%=getSel(given_consent,"-1")%>>Not Asked</option>
		<option value="1" <%=getSel(given_consent,"1")%>>Has Given
		Consent</option>
		<option value="2" <%=getSel(given_consent,"2")%>>Has Refused
		Consent</option>
	</select> <input type="hidden" name="ethnicityOrig"
		value="<%=apptMainBean.getString(demoExt.get("given_consent"))%>">
	</td>

</tr>
<%!
    String getSel(String s, String s2){
        if (s != null && s2 != null && s.equals(s2)){
            return "selected";
        }
        return "";
    }

%>
