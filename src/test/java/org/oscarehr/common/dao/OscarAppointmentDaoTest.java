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
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.oscarehr.common.dao.utils.EntityDataGenerator;
import org.oscarehr.common.dao.utils.SchemaUtils;
import org.oscarehr.common.model.Appointment;
import org.oscarehr.util.SpringUtils;


public class OscarAppointmentDaoTest extends DaoTestFixtures {

	OscarAppointmentDao dao=(OscarAppointmentDao)SpringUtils.getBean("oscarAppointmentDao");


	@Before
	public void before() throws Exception {
		//nothing here yet. should clean up the appointment table to a known state
		SchemaUtils.restoreTable("appointment");
	}


	@Test
	public void test() {
		Calendar cal = Calendar.getInstance();

		Appointment a = new Appointment();
		a.setAppointmentDate(cal.getTime());
		a.setStartTime(cal.getTime());
		cal.add(Calendar.MINUTE,60);
		a.setEndTime(cal.getTime());
		a.setCreateDateTime(new Date());
		a.setCreator("999998");
		a.setDemographicNo(1);
		a.setProviderNo("999998");
		a.setStatus("t");
		a.setUpdateDateTime(new Date());
		dao.persist(a);

		assertNotNull(a.getId());
		assertNotNull(dao.find(a.getId()));

		dao.remove(a.getId());
		assertNull(dao.find(a.getId()));
	}

	@Test
	public void testGetByProviderAndDay() throws Exception {
		Appointment appt = new Appointment();
		EntityDataGenerator.generateTestDataForModelClass(appt);
		appt.setProviderNo("000001");
		appt.setAppointmentDate(new Date());
		dao.persist(appt);

		Integer apptId = appt.getId();
		assertNotNull(apptId);

		List<Appointment> appts = dao.getByProviderAndDay(appt.getAppointmentDate(),appt.getProviderNo());
		assertEquals(appts.size(),1);
		assertEquals(appts.get(0).getId(),apptId);
	}

	@Test
	public void testFindByProviderDayAndStatus() throws Exception {
		Appointment appt = new Appointment();
		EntityDataGenerator.generateTestDataForModelClass(appt);
		appt.setProviderNo("000001");
		appt.setAppointmentDate(new Date());
		appt.setStatus("t");
		dao.persist(appt);

		Integer apptId = appt.getId();
		assertNotNull(apptId);

		List<Appointment> appts = dao.findByProviderDayAndStatus(appt.getProviderNo(),appt.getAppointmentDate(),"t");
		assertEquals(appts.size(),1);
		assertEquals(appts.get(0).getId(),apptId);

	}

	@Test
	public void testFindByDayAndStatus() throws Exception {
		Appointment appt = new Appointment();
		EntityDataGenerator.generateTestDataForModelClass(appt);
		appt.setProviderNo("000001");
		appt.setAppointmentDate(new Date());
		appt.setStatus("t");
		dao.persist(appt);

		Integer apptId = appt.getId();
		assertNotNull(apptId);

		List<Appointment> appts = dao.findByDayAndStatus(appt.getAppointmentDate(),"t");
		assertEquals(appts.size(),1);
		assertEquals(appts.get(0).getId(),apptId);

	}

	@Test
	public void testFind() throws Exception {
		Appointment appt = new Appointment();
		EntityDataGenerator.generateTestDataForModelClass(appt);
		appt.setProviderNo("000001");
		appt.setAppointmentDate(new Date());
		appt.setStatus("t");
		dao.persist(appt);

		Integer apptId = appt.getId();
		assertNotNull(apptId);

		List<Appointment> appts = dao.find(
				appt.getAppointmentDate(),
				appt.getProviderNo(),
				appt.getStartTime(),
				appt.getEndTime(),
				appt.getName(),
				appt.getNotes(),
				appt.getReason(),
				appt.getCreateDateTime(),
				appt.getCreator(),
				appt.getDemographicNo()
				);

		assertEquals(appts.size(),1);
		assertEquals(appts.get(0).getId(),apptId);

	}
	
	@Test
	public void testFindNonCancelledFutureAppointments() throws Exception {
		Integer demographicId = 999999;
		
		Appointment appt = new Appointment();		
		EntityDataGenerator.generateTestDataForModelClass(appt);
		appt.setDemographicNo(demographicId);
		appt.setAppointmentDate(new Date(System.currentTimeMillis() + 1000000000));
		appt.setStatus("C");
		dao.persist(appt);
		
		List<Appointment> appts = dao.findNonCancelledFutureAppointments(demographicId);
		assertTrue("Expected to find no appt's for " + demographicId, appts.isEmpty());
		
		appt = new Appointment();		
		EntityDataGenerator.generateTestDataForModelClass(appt);
		appt.setDemographicNo(demographicId);
		appt.setAppointmentDate(new Date(System.currentTimeMillis() + 1000000000));
		appt.setStatus("t");
		dao.persist(appt);
		
		appts = dao.findNonCancelledFutureAppointments(demographicId);
		assertFalse("Expected to find an appt's for " + demographicId, appts.isEmpty());
	}
}
