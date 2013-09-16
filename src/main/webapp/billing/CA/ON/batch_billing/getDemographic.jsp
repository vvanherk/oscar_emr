<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%><%@page import="java.util.List, java.util.Set, java.util.Collections, java.util.Comparator, java.util.Date, java.util.Calendar, java.text.SimpleDateFormat" %><%@page import="org.oscarehr.util.SpringUtils" %><%@page import="org.oscarehr.common.dao.DemographicDao" %><%@page import="org.oscarehr.common.model.Demographic" %>
<%
DemographicDao demographicDao = (DemographicDao)SpringUtils.getBean("demographicDao");

String query = request.getParameter("query");
String source = request.getParameter("source");

List<Demographic> demoList = null;

demoList = demographicDao.searchDemographic(query);
%>[<%
for(int i=0; i < demoList.size(); i++){
	Demographic demo = demoList.get(i);

	String hin = !demo.getHin().equals("") ? demo.getHin() : "HIN not Set";

	String rdoc = "0";
	String family_doctor= demo.getFamilyDoctor();
	String xml_parse = "<rd>";
	if(family_doctor != null && family_doctor.indexOf(xml_parse) >= 0){ //if it exists
		rdoc = family_doctor.substring(family_doctor.indexOf(xml_parse) + xml_parse.length(),
		 family_doctor.indexOf("</rd>"));
	}
%>
	{"id": "<%= demo.getDemographicNo() %>",
	 "name": "<%= demo.getDisplayName() %>",
	 "dob" : "<%= demo.getBirthDayAsString() %>", 
	 "health_card":"<%= hin %>",
	 "rdoctor": "<%= rdoc %>",
	 "gender": "<%= demo.getSex() %>" 
	}<%	if( i + 1 < demoList.size() ){ %>, <% }
}
%>]

