<%--

    Copyright (c) 2006-. OSCARservice, OpenSoft System. All Rights Reserved.
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

--%>
<%if (session.getAttribute("user") == null)
				response.sendRedirect("../../../logout.jsp");
%>

<%@ page
	import="java.math.*,java.util.*,java.sql.*,oscar.*,oscar.oscarBilling.ca.on.OHIP.*,java.net.*"
	errorPage="errorpage.jsp"%>
<%@ page import="oscar.oscarBilling.ca.on.pageUtil.*"%>
<%@ page
	import="oscar.oscarBilling.ca.on.data.*,oscar.oscarProvider.data.ProviderBillCenter"%>

<jsp:useBean id="apptMainBean" class="oscar.AppointmentMainBean"
	scope="session" />
<%@ include file="dbBilling.jspf"%>
<%@ page import="org.oscarehr.util.SpringUtils" %>
<%@ page import="org.oscarehr.common.model.Provider" %>
<%@ page import="org.oscarehr.PMmodule.dao.ProviderDao" %>
<%@page import="org.oscarehr.util.MiscUtils"%>
<%//
			ProviderDao providerDao = SpringUtils.getBean(ProviderDao.class);
			String provider = request.getParameter("provider");
			String mohOffice = request.getParameter("billcenter");
			String BILLING_STATUS = "(status='O' or status='W' or status='I')";
			int diskId = 0;
            int headerId = 0;
            boolean groupReport=false;
            ProviderBillCenter oriBillCenter = new ProviderBillCenter();

            String dateRange = "";
        	String dateBegin = request.getParameter("xml_vdate");
        	String dateEnd = request.getParameter("xml_appointment_date");
        	if (dateEnd.compareTo("") == 0)
        		dateEnd = request.getParameter("curDate");
        	if (dateBegin.compareTo("") == 0) {
        		dateRange = " and billing_date <= '" + dateEnd + "'";
        	} else {
        		dateRange = " and billing_date >='" + dateBegin + "' and billing_date <='" + dateEnd + "'";
        	}
        	
        	String submit = request.getParameter("Submit");
			if(!provider.equals("all")) {
				Provider p = providerDao.getProvider(provider);
				if(p != null) {
					String retval = SxmlMisc.getXmlContent(p.getComments(), "<xml_p_billinggroup_no>", "</xml_p_billinggroup_no>");
					if(retval != null && retval.length()>0 && !retval.equals("0000")) {
						groupReport = true;
					}
				}
			}
			
        	
            String useProviderMOH = request.getParameter("useProviderMOH");
			if (provider.compareTo("all") == 0 || groupReport) {
				// if all, find who is solo, who is in group
				BillingDiskCreatePrep obj = new BillingDiskCreatePrep();
				//this returns ones who don't have a group billing
				List lProvider = obj.getCurSoloProvider();
				
				if(!groupReport) {
					for (int i = 0; i < lProvider.size(); i++) {
						JdbcBillingCreateBillingFile objFile = new JdbcBillingCreateBillingFile();
						objFile.setDateRange(dateRange);
						BillingProviderData dataProvider = (BillingProviderData) lProvider.get(i);
						diskId = obj.createNewSoloDiskName(dataProvider.getProviderNo(), (String) session.getAttribute("user"));
						String ohipFilename = obj.getOhipfilename(diskId);
						String htmlFilename = obj.getHtmlfilename(diskId, dataProvider.getProviderNo());
						MiscUtils.getLogger().info("OUT1: " + htmlFilename);
	                    boolean existBillCenter = oriBillCenter.hasBillCenter(dataProvider.getProviderNo());
	                    // create the billing file with provider's own bill center
	                    if (existBillCenter && oriBillCenter.getBillCenter(dataProvider.getProviderNo()).compareTo(mohOffice)!=0)
	                        headerId = obj.createBatchHeader(dataProvider, "" + diskId, oriBillCenter.getBillCenter(dataProvider.getProviderNo()), "1", (String) session.getAttribute("user"));
	                    else
							// create the billing file 
	                        headerId = obj.createBatchHeader(dataProvider, "" + diskId, mohOffice, "1", (String) session.getAttribute("user"));
						objFile.setProviderNo(dataProvider.getProviderNo());
						objFile.setOhipFilename(ohipFilename);
						objFile.setHtmlFilename(htmlFilename);
						objFile.createBillingFileStr("" + headerId, BILLING_STATUS, false, mohOffice, false, "on".equals(useProviderMOH));
						objFile.writeFile(objFile.getValue());
						objFile.writeHtml(objFile.getHtmlCode());
						objFile.updateDisknameSum(diskId);
					}
				}
				

				//gets list of providers who are part of a group
				List lProvider2 = obj.getCurGrpProvider();
				List providerNo = new Vector();
				List ohipNo = new Vector();
				HashSet groupNo = new HashSet();
				String value = "";
				
				
				for (int i = 0; i < lProvider2.size(); i++) {
					BillingProviderData dataProvider = (BillingProviderData) lProvider2.get(i);
					if(groupReport && !provider.equals(dataProvider.getProviderNo()))
						continue;

					groupNo.add(dataProvider.getBillingGroupNo());
					providerNo.add(dataProvider.getProviderNo());
					ohipNo.add(dataProvider.getOhipNo());
				}
                                
				if (!groupNo.isEmpty()) {
	               for(Iterator igroup=groupNo.iterator(); igroup.hasNext();){
	                   Object StrGroupNo = igroup.next();
	                   List providerNoCopy = new Vector();
	                   List ohipNoCopy = new Vector();
	                   
	                   // This algorithm is rediculously convoluted...
	                   if(!provider.equals("all")) {
						   // Generate the list of providers within the providerNo list that have the specified group number
		                   for (int provi=0; provi<providerNo.size();provi++){
							   // We need to iterate over ALL providers in the lProvider2 list in order to make sure we check all available group numbers
			                   for (int copyi=0; copyi<lProvider2.size();copyi++){
			                       if (((BillingProviderData)lProvider2.get(copyi)).getBillingGroupNo().compareTo(StrGroupNo.toString())==0){
										providerNoCopy.add(providerNo.get(provi));
										// Not sure why we need to have the ohip number from a provider from the lProvider2 list
										ohipNoCopy.add(((BillingProviderData)lProvider2.get(copyi)).getOhipNo());
			                       }
			                   }
						   }
					   } else {
						   // Generate the list of providers within the providerNo list that have the specified group number
						   for (int copyi=0; copyi<providerNo.size();copyi++){
		                       if (((BillingProviderData)lProvider2.get(copyi)).getBillingGroupNo().compareTo(StrGroupNo.toString())==0){
		                           providerNoCopy.add(providerNo.get(copyi));
		                           ohipNoCopy.add(((BillingProviderData)lProvider2.get(copyi)).getOhipNo());
		                       }
		                   }
					   }
	                   
	                   diskId = obj.createNewGrpDiskName(providerNoCopy, ohipNoCopy, StrGroupNo.toString(), (String) session.getAttribute("user"));
						JdbcBillingCreateBillingFile objFile = null;
                        value = "";
                        for (int i = 0; i < lProvider2.size(); i++) {
                            if (((BillingProviderData) lProvider2.get(i)).getBillingGroupNo().compareTo(StrGroupNo.toString())!=0)
                                continue;
                            objFile = new JdbcBillingCreateBillingFile();
                            objFile.setDateRange(dateRange);
							BillingProviderData dataProvider = (BillingProviderData) lProvider2.get(i);
                            String ohipFilename = obj.getOhipfilename(diskId);
							String htmlFilename = obj.getHtmlfilename(diskId, dataProvider.getProviderNo());
							MiscUtils.getLogger().info("OUT2: " + htmlFilename + " " + dataProvider.getProviderNo() + " " + diskId);
                            boolean existBillCenter = oriBillCenter.hasBillCenter(dataProvider.getProviderNo());
                            // create the billing file with provider's own bill center
                            if (existBillCenter && oriBillCenter.getBillCenter(dataProvider.getProviderNo()).compareTo(mohOffice)!=0)
                                headerId = obj.createBatchHeader(dataProvider, "" + diskId, oriBillCenter.getBillCenter(dataProvider.getProviderNo()), "" + (i + 1),(String) session.getAttribute("user"));
                            else
								// create the billing file 
                                headerId = obj.createBatchHeader(dataProvider, "" + diskId, mohOffice, "" + (i + 1),(String) session.getAttribute("user"));
                        	objFile.setProviderNo(dataProvider.getProviderNo());
							objFile.setOhipFilename(ohipFilename);
							objFile.setHtmlFilename(htmlFilename);
							objFile.createBillingFileStr("" + headerId, BILLING_STATUS, false, mohOffice, false, "on".equals(useProviderMOH));						
							value += objFile.getValue();
							objFile.writeHtml(objFile.getHtmlCode());
							objFile.updateDisknameSum(diskId);
						}
                        objFile.writeFile(value);
					}
			}
			} 
			
			else {
				// solo - one provider
				BillingDiskCreatePrep obj = new BillingDiskCreatePrep();
				List lProvider = new Vector();
				lProvider.add(obj.getProviderObj(provider));
				JdbcBillingCreateBillingFile objFile = new JdbcBillingCreateBillingFile();
				objFile.setDateRange(dateRange);
				for (int i = 0; i < lProvider.size(); i++) {
					BillingProviderData dataProvider = (BillingProviderData) lProvider.get(i);
					// not for group provider
					//if (!(dataProvider.getBillingGroupNo().equals("") || dataProvider.getBillingGroupNo().equals("0000")))
					//	continue;
					
					diskId = obj.createNewSoloDiskName(dataProvider.getProviderNo(), (String) session
							.getAttribute("user"));
					String ohipFilename = obj.getOhipfilename(diskId);
					String htmlFilename = obj.getHtmlfilename(diskId, dataProvider.getProviderNo());
					MiscUtils.getLogger().info("OUT3: " + htmlFilename);
					// create the billing file 
					headerId = obj.createBatchHeader(dataProvider, "" + diskId, mohOffice, "1", (String) session
							.getAttribute("user"));
					objFile.setProviderNo(dataProvider.getProviderNo());
					objFile.setOhipFilename(ohipFilename);
					objFile.setHtmlFilename(htmlFilename);					
					objFile.createBillingFileStr("" + headerId, BILLING_STATUS, false, mohOffice, false, "on".equals(useProviderMOH));
					objFile.writeFile(objFile.getValue());
					objFile.writeHtml(objFile.getHtmlCode());
					objFile.updateDisknameSum(diskId);
				}
			}
		%>

<jsp:forward page='billingONMRI.jsp'>
	<jsp:param name="year" value='' />
</jsp:forward>
