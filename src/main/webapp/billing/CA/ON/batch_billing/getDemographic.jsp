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
	String rdocno = "0";
	String family_doctor= demo.getFamilyDoctor();
	String rdoc_xmlparse = "<rd>";
	String rdocno_xmlparse = "<rdohip>";
	if(family_doctor != null && family_doctor.indexOf(rdoc_xmlparse) >= 0){ //if it exists
		rdoc = family_doctor.substring(family_doctor.indexOf(rdoc_xmlparse) + rdoc_xmlparse.length(),
		 family_doctor.indexOf("</rd>"));
		rdocno = family_doctor.substring(family_doctor.indexOf(rdocno_xmlparse) + rdocno_xmlparse.length(),
		 family_doctor.indexOf("</rdohip>"));
	}
%>
	{"id": "<%= demo.getDemographicNo() %>",
	 "name": "<%= demo.getDisplayName() %>",
	 "dob" : "<%= demo.getBirthDayAsString() %>", 
	 "health_card":"<%= hin %>",
	 "rdoctor": "<%= rdoc %>",
	 "rdocNum": "<%= rdocno %>",
	 "gender": "<%= demo.getSex() %>" 
	}<%	if( i + 1 < demoList.size() ){ %>, <% }
}
%>]

