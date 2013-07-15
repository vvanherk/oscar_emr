/**
 *
 * Copyright (c) 2005-2012. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved.
 * This software is published under the GPL GNU General Public License.
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * This software was written for
 * Centre for Research on Inner City Health, St. Michael's Hospital,
 * Toronto, Ontario, Canada
 */
package org.oscarehr.PMmodule.web;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.log4j.Logger;
import org.caisi.model.Role;
import org.oscarehr.PMmodule.dao.ProgramDao;
import org.oscarehr.PMmodule.dao.ProviderDao;
import org.oscarehr.PMmodule.dao.RoleDAO;
import org.oscarehr.PMmodule.dao.SecUserRoleDao;
import org.oscarehr.PMmodule.model.Program;
import org.oscarehr.PMmodule.model.SecUserRole;
import org.oscarehr.PMmodule.web.PopulationReportDataObjects.EncounterTypeDataGrid;
import org.oscarehr.PMmodule.web.PopulationReportDataObjects.EncounterTypeDataRow;
import org.oscarehr.PMmodule.web.PopulationReportDataObjects.ProviderDataGrid;
import org.oscarehr.PMmodule.web.PopulationReportDataObjects.RoleDataGrid;
import org.oscarehr.common.dao.IssueGroupDao;
import org.oscarehr.common.dao.PopulationReportDao;
import org.oscarehr.common.dao.SecRoleDao;
import org.oscarehr.common.model.IssueGroup;
import org.oscarehr.common.model.Provider;
import org.oscarehr.common.model.SecRole;
import org.oscarehr.util.EncounterUtil;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;

public class PopulationReportUIBean {

	private static Logger logger=MiscUtils.getLogger();
	private ProgramDao programDao = (ProgramDao) SpringUtils.getBean("programDao");
	private RoleDAO roleDAO = (RoleDAO) SpringUtils.getBean("roleDAO");
	private IssueGroupDao issueGroupDao = (IssueGroupDao) SpringUtils.getBean("issueGroupDao");
	private PopulationReportDao populationReportDao = (PopulationReportDao) SpringUtils.getBean("populationReportDao");
	private SecUserRoleDao secUserRoleDao = (SecUserRoleDao) SpringUtils.getBean("secUserRoleDao");
	private SecRoleDao secRoleDao=(SecRoleDao)SpringUtils.getBean("secRoleDao");
	private ProviderDao providerDao=(ProviderDao)SpringUtils.getBean("providerDao");
	
	private Date startDate = null;
	private Date endDate = null;
	private Program program = null;
	public boolean skipTotalRow=false;

	public PopulationReportUIBean() {

	}

	public PopulationReportUIBean(int programId, Date startDate, Date endDate) {
		this.startDate = startDate;
		this.endDate = endDate;
		setProgramId(programId);
	}

	public void setProgramId(int programId) {
		program = programDao.getProgram(programId);
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	private Set<IssueGroup> allIssueGroups = null;

	public Set<IssueGroup> getIssueGroups() {

		if (allIssueGroups == null) allIssueGroups = new TreeSet<IssueGroup>(issueGroupDao.findAll());
		return (allIssueGroups);
	}

	public Program getProgram() {
		return (program);
	}

	public List<Program> getAllPrograms() {
		return (programDao.getAllActivePrograms());
	}

	private List<Role> allRoles = null;

	public List<Role> getRoles() {

		if (allRoles == null) allRoles = roleDAO.getRoles();
		return (allRoles);
	}

	public RoleDataGrid getRoleDataGrid() {

		long startTime=System.currentTimeMillis();
		
		RoleDataGrid roleDataGrid = new RoleDataGrid();

		for (Role role : getRoles()) {
			roleDataGrid.put(role, getEncounterTypeDataGrid(role));
		}

		if (!skipTotalRow) roleDataGrid.total=getEncounterTypeDataRow((Integer)null, null);
		
		long totalTime=System.currentTimeMillis()-startTime;
		logger.debug("report generation in seconds : "+(totalTime/1000));
		
		return (roleDataGrid);
	}

	/**
	 * The Role is used to determine which providers to report on.
	 */
	public ProviderDataGrid getProviderDataGrid(Integer secRoleId) {

		long startTime=System.currentTimeMillis();
		
		ProviderDataGrid providerDataGrid = new ProviderDataGrid();

		SecRole secRole=secRoleDao.find(secRoleId);
		List<SecUserRole> secUserRoles=secUserRoleDao.getSecUserRolesByRoleName(secRole.getName());
		HashSet<String> providerNos=new HashSet<String>();
		for (SecUserRole secUserRole : secUserRoles) providerNos.add(secUserRole.getProviderNo());
		
		for (String providerNo : providerNos) {
			Provider provider=providerDao.getProvider(providerNo);
			if (provider!=null)	providerDataGrid.put(provider, getEncounterTypeDataGrid(provider));
			else logger.warn("Provider doesn't exist but a secUserRole record does. providerNo="+providerNo);
		}

		long totalTime=System.currentTimeMillis()-startTime;
		logger.debug("report generation in seconds : "+(totalTime/1000));
		
		return (providerDataGrid);
	}

	private EncounterTypeDataGrid getEncounterTypeDataGrid(Role role) {

		Integer roleId=null;
		if (role!=null) roleId=role.getId().intValue();
		
		EncounterTypeDataGrid result = new EncounterTypeDataGrid();

		for (EncounterUtil.EncounterType encounterType : EncounterUtil.EncounterType.values()) {
			result.put(encounterType, getEncounterTypeDataRow(roleId, encounterType));
		}

		if (!skipTotalRow) result.subTotal=getEncounterTypeDataRow(roleId, null);
		
		return (result);
	}

	private EncounterTypeDataGrid getEncounterTypeDataGrid(Provider provider) {

		EncounterTypeDataGrid result = new EncounterTypeDataGrid();

		for (EncounterUtil.EncounterType encounterType : EncounterUtil.EncounterType.values()) {
			result.put(encounterType, getEncounterTypeDataRow(provider, encounterType));
		}

		return (result);
	}

	private EncounterTypeDataRow getEncounterTypeDataRow(Integer roleId, EncounterUtil.EncounterType encounterType) {

		EncounterTypeDataRow result = new EncounterTypeDataRow();

		Map<Integer, Integer> counts = populationReportDao.getCaseManagementNoteCountGroupedByIssueGroup(program.getId(), roleId, encounterType, startDate, endDate);

		for (IssueGroup issueGroup : getIssueGroups()) {
			Integer count = counts.get(issueGroup.getId());
			result.put(issueGroup, (count != null ? count : 0));
		}

		result.rowTotalUniqueEncounters=populationReportDao.getCaseManagementNoteTotalUniqueEncounterCountInIssueGroups(program.getId(), roleId, encounterType, startDate, endDate);
		result.rowTotalUniqueClients=populationReportDao.getCaseManagementNoteTotalUniqueClientCountInIssueGroups(program.getId(), roleId, encounterType, startDate, endDate);
		
		return (result);
	}

	private EncounterTypeDataRow getEncounterTypeDataRow(Provider provider, EncounterUtil.EncounterType encounterType) {

		EncounterTypeDataRow result = new EncounterTypeDataRow();

		Map<Integer, Integer> counts = populationReportDao.getCaseManagementNoteCountGroupedByIssueGroup(program.getId(), provider, encounterType, startDate, endDate);

		for (IssueGroup issueGroup : getIssueGroups()) {
			Integer count = counts.get(issueGroup.getId());
			result.put(issueGroup, (count != null ? count : 0));
		}

		result.rowTotalUniqueEncounters=populationReportDao.getCaseManagementNoteTotalUniqueEncounterCountInIssueGroups(program.getId(), provider, encounterType, startDate, endDate);
		result.rowTotalUniqueClients=populationReportDao.getCaseManagementNoteTotalUniqueClientCountInIssueGroups(program.getId(), provider, encounterType, startDate, endDate);
		
		return (result);
	}
}
