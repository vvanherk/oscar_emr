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

import org.oscarehr.common.model.Provider;
import org.oscarehr.common.model.RaHeader;
import org.springframework.stereotype.Repository;

@Repository
public class RaHeaderDao extends AbstractDao<RaHeader>{

	public RaHeaderDao() {
		super(RaHeader.class);
	}
	public List<RaHeader> getSiteRahd(String status, List<Provider> providers) {
		String sql = "select r from RaHeader r, RaDetail t, Provider p where r.id=t.raHeaderNo and p.OhipNo=t.providerOhipNo and r.status <> :statusParam ";
		String where = (providers.size() > 0 ? "and (p.ProviderNo=" + providers.get(0).getProviderNo() : "");
		for(int i=1; i<providers.size(); i++) {
			where += " or p.ProviderNo=" + providers.get(i).getProviderNo();
		}
		if(!where.equals("")) where += ")";
		sql += where
				+ " group by r.id"
				+ " order by r.paymentDate desc, r.readDate desc";
		Query query = entityManager.createQuery(sql);
		query.setParameter("statusParam",status);
		List<RaHeader> ret = query.getResultList();
		return ret;
	}	
	
	public List<RaHeader> getTeamRahd(String status, String provider_no) {
		String sql = "select r from RaHeader r, RaDetail t, Provider p where r.id=t.raHeaderNo and p.OhipNo=t.providerOhipNo and r.status <> :statusParam "
				+ " and (p.ProviderNo= :providerParam or p.Team=(select Team from Provider where ProviderNo= :providerParam) )"
				+ " group by r.id"
				+ " order by r.paymentDate desc, r.readDate desc";
		Query query = entityManager.createQuery(sql);
		query.setParameter("statusParam",status);
		query.setParameter("providerParam",provider_no);
		List<RaHeader> ret = query.getResultList();
		return ret;
	}
	
	public List<RaHeader> getAllRahd(String status) {
		String sql = "select r from RaHeader r where status <> :statusParam order by paymentDate desc, readDate desc";
		Query query = entityManager.createQuery(sql);
		query.setParameter("statusParam",status);
		List<RaHeader> ret = query.getResultList();
		return ret;
	}	
}
