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

import static org.junit.Assert.assertNotNull;

import org.junit.Before;
import org.junit.Test;
import utils.EntityDataGenerator;
import utils.SchemaUtils;
import utils.TestFixtures;
import org.oscarehr.common.model.Document;
import org.oscarehr.util.SpringUtils;

public class DocumentDaoTest extends TestFixtures {

	private DocumentDao dao = SpringUtils.getBean(DocumentDao.class);

	public DocumentDaoTest() {
	}


	@Before
	public void before() throws Exception {
		SchemaUtils.restoreTable("document");
	}

	@Test
	public void testCreate() throws Exception {
		Document entity = new Document();
		EntityDataGenerator.generateTestDataForModelClass(entity);
		entity.setDocumentNo(null);
		dao.persist(entity);

		assertNotNull(entity.getId());
	}
}
