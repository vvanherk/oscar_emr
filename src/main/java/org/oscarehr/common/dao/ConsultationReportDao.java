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

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.oscarehr.common.model.ConsultationReport;
import org.springframework.stereotype.Repository;

@Repository(value="generalConsultationReportDao")
public class ConsultationReportDao extends AbstractDao<ConsultationReport>{

	public ConsultationReportDao() {
		super(ConsultationReport.class);
	}
	
	public List<ConsultationReport> findByDemographicNo(Integer demographicNo) {
		Query query = entityManager.createQuery("SELECT e FROM ConsultationReport e WHERE e.demographicNo=?");
		query.setParameter(1,demographicNo);
		@SuppressWarnings("unchecked")
        List<ConsultationReport> results = query.getResultList();
		return results;
	}
	
	public List<ConsultationReport> findAll() {
		Query query = entityManager.createQuery("SELECT e FROM ConsultationReport e ");
		@SuppressWarnings("unchecked")
        List<ConsultationReport> results = query.getResultList();
		return results;
	}
	
	public List<ConsultationReport> search(String status, String providerName, int demographicNo, Date startDate, Date endDate) {
		
		Map<String,Object> params = new HashMap<String,Object>();
		StringBuilder whereClause = new StringBuilder();
		if(status != null  && !status.equals("") && !status.equals("0")) {
			if(whereClause.length()>0) {
				whereClause.append(" AND ");
			}
			whereClause.append(" e.status = :status ");
			params.put("status", status);
		}
		if(!providerName.isEmpty()) {
			if(whereClause.length()>0) {
				whereClause.append(" AND ");
			}
			whereClause.append(" e.provider= :provider");
			params.put("provider", providerName);
		}
		if(demographicNo != 0) {
			if(whereClause.length()>0) {
				whereClause.append(" AND ");
			}
			whereClause.append(" e.demographicNo = :demographicNo ");
			params.put("demographicNo", demographicNo);
		}
		if(startDate != null) {
			if(whereClause.length()>0) {
				whereClause.append(" AND ");
			}
			whereClause.append(" e.date >= :startDate ");
			params.put("startDate", startDate);
		}
		if(endDate != null) {
			if(whereClause.length()>0) {
				whereClause.append(" AND ");
			}
			whereClause.append(" e.date <= :endDate ");
			params.put("endDate", endDate);
		}
		
		Query query = null;
		if(params.size()>0) {
			query = entityManager.createQuery("SELECT e FROM ConsultationReport e WHERE " + whereClause.toString());
			for(String name:params.keySet()) {
				query.setParameter(name, params.get(name));
			}
		} else {
			query = entityManager.createQuery("SELECT e FROM ConsultationReport e");
		}
		
		@SuppressWarnings("unchecked")
        List<ConsultationReport> results = query.getResultList();
		return results;
	}
}