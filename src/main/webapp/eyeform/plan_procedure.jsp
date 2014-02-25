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

<%@ include file="/taglibs.jsp"%>
<%@page import="org.oscarehr.util.SpringUtils"%>
<%@page import="org.oscarehr.PMmodule.dao.ProviderDao"%>
<%
	String id = request.getParameter("id");
	ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
	request.setAttribute("providers",providerDao.getActiveProviders());
%>

<div class="arrangePlanbox" id="procedure_<%=id%>">

				<input type="hidden" name="procedure_<%=id%>.id" value=""/>
					
				<a class="col_del" href="#" onclick="deleteProcedure(<%=id%>);">[Delete]</a>
	            
	            <select class="col_provider" name="procedure_<%=id%>.Provider" id="procedure_<%=id%>.Provider">
	            	<c:forEach var="item" items="${providers}">
	            		<option value="<c:out value="${item.providerNo}"/>"><c:out value="${item.formattedName}"/></option>
	            	</c:forEach>            	
				</select>
						
				<select class="col_type" name="procedure_<%=id%>.eye">
					<option value="OU">OU</option>
					<option value="OD">OD</option>
					<option value="OS">OS</option>
					<option value="OD then OS">OD then OS</option>
					<option value="OS then OD">OS then OD</option>
				</select>	
				
			    <!-- <span class="col_timespan1">Proc:</span> -->	
				<input class="col_timefram1" type="text" name="procedure_<%=id%>.procedureName" id="procedure_<%=id%>.procedureName" title="input procedure name here" placeholder="procedure name"
				 onfocus="if(this.value==''){this.style.color='#000'; this.value='';}"/>

				<!-- <span class="col_timefram1">Loc:</span> -->
				<input class="col_timefram2" type="text" name="procedure_<%=id%>.location" id="procedure_<%=id%>.location" title="input location here" placeholder="location"
				 onfocus="if(this.value==''){this.style.color='#000'; this.value='';}"/>							
				
				<select class="col_urgency" name="procedure_<%=id%>.urgency" id="procedure_<%=id%>.urgency">
					<option value="routine">routine</option>
					<option value="ASAP">ASAP</option>
					<option value="URGENT">URGENT</option>					
				</select>
				<span class="col_comment1">Comment:</span>
				<input class="col_comment2" type="text" name="procedure_<%=id%>.comment" id="procedure_<%=id%>.comment"/>
				
				

</div>
