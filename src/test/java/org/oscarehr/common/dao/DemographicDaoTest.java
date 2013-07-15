/**
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
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
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */
package org.oscarehr.common.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;
import org.oscarehr.common.dao.utils.EntityDataGenerator;
import org.oscarehr.common.dao.utils.SchemaUtils;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.util.SpringUtils;

public class DemographicDaoTest extends DaoTestFixtures {

	private DemographicDao dao = (DemographicDao)SpringUtils.getBean("demographicDao");

	@Before
	public void before() throws Exception {
		SchemaUtils.restoreTable("demographic","lst_gender","admission","demographic_merged",
				"program","health_safety","provider","providersite","site","program_team");
	}

	@Test
	public void testCreate() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		dao.save(entity);
		assertNotNull(entity.getDemographicNo());
	}

	@Test
	public void testGetDemographic() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		dao.save(entity);

		assertNotNull(dao.getDemographic(entity.getDemographicNo().toString()));
		assertNotNull(dao.getDemographicById(entity.getDemographicNo()));
		assertNotNull(dao.getClientByDemographicNo(entity.getDemographicNo()));
	}

	@Test
	public void testGetDemographicByProvider() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setProviderNo("000001");
		entity.setPatientStatus("AC");
		dao.save(entity);

		assertNotNull(dao.getDemographicByProvider(entity.getProviderNo()));
		assertNotNull(dao.getDemographicByProvider(entity.getProviderNo(),false));

		assertEquals(1,dao.getDemographicByProvider(entity.getProviderNo()).size());
		assertEquals(1,dao.getDemographicByProvider(entity.getProviderNo(),false).size());
	}

	@Test
	public void testGetDemographicByMyOscarUserName() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setMyOscarUserName("marc");
		dao.save(entity);

		assertNotNull(dao.getDemographicByMyOscarUserName("marc"));
	}

	@Test
	public void testGetActiveDemosByHealthCardNo() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setHin("2222222222");
		entity.setHcType("Ontario");
		entity.setPatientStatus("AC");
		dao.save(entity);

		assertNotNull(dao.getActiveDemosByHealthCardNo(entity.getHin(),entity.getHcType()));
		assertEquals(1,dao.getActiveDemosByHealthCardNo(entity.getHin(),entity.getHcType()).size());
	}

	@Test
	public void testSearchDemographic() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setLastName("Smith");
		entity.setFirstName("John");
		dao.save(entity);

		assertEquals(1,dao.searchDemographic("Smi").size());
		assertEquals(0,dao.searchDemographic("Doe").size());
		assertEquals(1,dao.searchDemographic("Smi,Jo").size());
		assertEquals(0,dao.searchDemographic("Smi,Ja").size());
	}


	@Test
	public void testGetRosterStatuses() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setRosterStatus("AB");
		dao.save(entity);

		entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setRosterStatus("AB");
		dao.save(entity);

		entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setRosterStatus("AC");
		dao.save(entity);

		assertEquals(2,dao.getRosterStatuses().size());
	}


	@Test
	public void testClientExists() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		dao.save(entity);

		assertTrue(dao.clientExists(entity.getDemographicNo()));
	}

	@Test
	public void testGetClientsByChartNo() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setChartNo("000001");
		dao.save(entity);

		assertNotNull(dao.getClientsByChartNo(entity.getChartNo()));
		assertEquals(1,dao.getClientsByChartNo(entity.getChartNo()).size());

	}

	@Test
	public void testGetClientsByHealthCard() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setHin("2222222222");
		entity.setHcType("ontario");
		dao.save(entity);

		assertNotNull(dao.getClientsByHealthCard(entity.getHin(),entity.getHcType()));
		assertEquals(1,dao.getClientsByHealthCard(entity.getHin(),entity.getHcType()).size());

	}

	@Test
	public void testSearchByHealthCard() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setHin("2222222222");
		dao.save(entity);

		assertNotNull(dao.searchByHealthCard(entity.getHin()));
		assertEquals(1,dao.searchByHealthCard(entity.getHin()).size());

	}

	@Test
	public void testGetDemographicByNamePhoneEmail() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setLastName("Smith");
		entity.setFirstName("John");
		entity.setPhone("444-444-4444");
		entity.setPhone2("555-555-5555");
		entity.setEmail("a@b.com");
		dao.save(entity);

		assertNotNull(dao.getDemographicByNamePhoneEmail(entity.getFirstName(), entity.getLastName(), entity.getPhone(), entity.getPhone2(), entity.getEmail()));
		assertEquals(entity.getDemographicNo(),dao.getDemographicByNamePhoneEmail(entity.getFirstName(), entity.getLastName(), entity.getPhone(), entity.getPhone2(), entity.getEmail()).getDemographicNo());
	}

	@Test
	public void testGetDemographicWithLastFirstDOB() throws Exception {
		Demographic entity = new Demographic();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDemographicNo(null);
		entity.setLastName("Smith");
		entity.setFirstName("John");
		entity.setYearOfBirth("1999");
		entity.setMonthOfBirth("12");
		entity.setDateOfBirth("01");
		dao.save(entity);

		assertNotNull(dao.getDemographicWithLastFirstDOB(entity.getLastName(),entity.getFirstName(), entity.getYearOfBirth(), entity.getMonthOfBirth(), entity.getDateOfBirth()));
		assertEquals(1,dao.getDemographicWithLastFirstDOB(entity.getLastName(),entity.getFirstName(), entity.getYearOfBirth(), entity.getMonthOfBirth(), entity.getDateOfBirth()).size());

	}
}
