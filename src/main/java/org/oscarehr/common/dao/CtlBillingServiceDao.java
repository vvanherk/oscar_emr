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

import java.util.List;

import javax.persistence.Query;

import org.oscarehr.common.model.CtlBillingService;
import org.springframework.stereotype.Repository;

@Repository
public class CtlBillingServiceDao extends AbstractDao<CtlBillingService> {

	public static final String DEFAULT_STATUS = "A";

	public CtlBillingServiceDao() {
		super(CtlBillingService.class);
	}

	/**
	 * Gets distinct service type for services with the specific service status 
	 * 
	 * @param serviceStatus
	 * 		Status of the service to be retrieved
	 * @return
	 * 		Returns list containing arrays of strings, where the first element represents the service type and the second element is the service type name.
	 */
	public List<Object[]> getUniqueServiceTypes(String serviceStatus) {
		Query query = entityManager.createQuery("SELECT DISTINCT b.serviceType, b.serviceTypeName FROM CtlBillingService b WHERE b.status = :serviceStatus");
		query.setParameter("serviceStatus", serviceStatus);

		@SuppressWarnings("unchecked")
		List<Object[]> results = query.getResultList();
		return results;
	}

	/**
	 * Gets distinct service type for services with {@link #DEFAULT_STATUS} 
	 * 
	 * @return
	 * 		Returns list containing arrays of strings, where the first element represents the service type code and the second element is the service type name.
	 */
	public List<Object[]> getUniqueServiceTypes() {
		return getUniqueServiceTypes(DEFAULT_STATUS);
	}
}
