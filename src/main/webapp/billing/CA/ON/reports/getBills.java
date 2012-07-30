
/*
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import="net.sf.json.JSONArray;

import org.oscarehr.billing.CA.ON.dao.BillingClaimDAO;
import org.oscarehr.billing.CA.ON.model.BillingClaimHeader1;
 
public class gettime extends HttpServlet {
 
	private BillingClaimDAO billingClaimDAO = (BillingClaimDAO)SpringUtils.getBean("billingClaimDAO");
 
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
 
	public void destroy() {
 
	}
 
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		PrintWriter out = response.getWriter();
		out.println("ERROR");
	}
 
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		PrintWriter out = response.getWriter();
		out.println();
		
		List<BillingClaimHeader1> bills = billingClaimDAO.getInvoices(new Integer(apt.getDemographicNo()).toString(), new Integer(30));
	}
}

*/
