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

import org.junit.Before;
import org.junit.Test;
import utils.SchemaUtils;
import utils.TestFixtures;
import org.oscarehr.common.model.ProviderSite;
import org.oscarehr.common.model.ProviderSitePK;
import org.oscarehr.util.SpringUtils;

public class ProviderSiteDaoTest extends TestFixtures {

	private ProviderSiteDao dao = SpringUtils.getBean(ProviderSiteDao.class);

	public ProviderSiteDaoTest() {
	}


	@Before
	public void before() throws Exception {
		SchemaUtils.restoreTable("providersite");
	}

	@Test
	public void testCreate() {
		ProviderSite entity = new ProviderSite();
		entity.setId(new ProviderSitePK());
		entity.getId().setProviderNo("000001");
		entity.getId().setSiteId(1);
		dao.persist(entity);
		assertNotNull(entity.getId());
		assertNotNull(dao.find(entity.getId()));
	}

	@Test
	public void testFindByProviderNo() {
		ProviderSite entity = new ProviderSite();
		entity.setId(new ProviderSitePK());
		entity.getId().setProviderNo("000001");
		entity.getId().setSiteId(1);
		dao.persist(entity);

		assertEquals(1,dao.findByProviderNo("000001").size());
	}
}