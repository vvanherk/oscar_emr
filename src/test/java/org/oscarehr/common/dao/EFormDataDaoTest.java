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

import java.util.Calendar;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import utils.EntityDataGenerator;
import utils.SchemaUtils;
import utils.TestFixtures;
import org.oscarehr.common.model.EFormData;
import org.oscarehr.util.SpringUtils;

public class EFormDataDaoTest extends TestFixtures {

	private EFormDataDao eFormDataDao = (EFormDataDao) SpringUtils.getBean("EFormDataDao");

	public EFormDataDaoTest() {
	}

	@Before
	public void before() throws Exception {
		SchemaUtils.restoreTable(new String[]{"eform_data"});
	}

	@Test
	public void testGetByDemographic() throws Exception {
		EFormData model = new EFormData();
		EntityDataGenerator.generateTestDataForModelClass(model);
		model.setDemographicId(1);
		eFormDataDao.persist(model);
		assertNotNull(model.getId());

		assertEquals(1,eFormDataDao.findByDemographicId(1).size());
		assertEquals(0,eFormDataDao.findByDemographicId(2).size());
	}

	@Test
	public void testGetByDemographicAndLastDate() throws Exception {
		EFormData model = new EFormData();
		EntityDataGenerator.generateTestDataForModelClass(model);
		model.setDemographicId(1);
		Calendar cal = Calendar.getInstance();
		//set to 5 mins ago
		cal.set(Calendar.MINUTE, cal.get(Calendar.MINUTE)-5);
		model.setFormTime(cal.getTime());
		model.setFormDate(cal.getTime());

		eFormDataDao.persist(model);
		assertNotNull(model.getId());

		//set to 10 mins ago .. so we only want forms in the last 10 minutes
		Calendar cal2 = Calendar.getInstance();
		cal2.set(Calendar.MINUTE, cal2.get(Calendar.MINUTE)-10);

		List<EFormData> results = eFormDataDao.findByDemographicIdSinceLastDate(1, cal2.getTime());
		assertEquals(1,results.size());

		cal = Calendar.getInstance();
		//set yesterday
		cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH)-1);
		model.setFormTime(cal.getTime());
		model.setFormDate(cal.getTime());
		eFormDataDao.merge(model);

		results = eFormDataDao.findByDemographicIdSinceLastDate(1, cal2.getTime());
		assertEquals(0,results.size());

		cal = Calendar.getInstance();
		//set today, but too early
		cal.set(Calendar.MINUTE, cal.get(Calendar.MINUTE)-20);
		model.setFormTime(cal.getTime());
		model.setFormDate(cal.getTime());
		eFormDataDao.merge(model);

		results = eFormDataDao.findByDemographicIdSinceLastDate(1, cal2.getTime());
		assertEquals(0,results.size());
	}
}