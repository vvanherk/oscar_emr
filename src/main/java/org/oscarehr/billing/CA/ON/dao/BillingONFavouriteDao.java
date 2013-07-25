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


package org.oscarehr.billing.CA.ON.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import javax.persistence.Query;

import org.oscarehr.billing.CA.ON.model.BillingONFavourite;
import org.oscarehr.common.dao.AbstractDao;


@Repository
public class BillingONFavouriteDao extends AbstractDao<BillingONFavourite> {

	public BillingONFavouriteDao() {
		super(BillingONFavourite.class);
	}
	
//return all supercodes
	public List<BillingONFavourite> findAllBillingONFav() {
	   	String sql = "select b from BillingONFavourite b order by b.name";
    	Query query = entityManager.createQuery(sql);

        @SuppressWarnings("unchecked")
        List<BillingONFavourite> results = query.getResultList();

        return results;
	}
	
//given an id, return SuperCode
	public List<BillingONFavourite> findByBillingONFavId(Integer billingFavId) {
	   	String sql = "select b from BillingONFavourite b where b.id=?1 order by b.name";
    	Query query = entityManager.createQuery(sql);
    	query.setParameter(1,billingFavId);

        @SuppressWarnings("unchecked")
        List<BillingONFavourite> results = query.getResultList();

        return results;
	}
//given a code, return SuperCode
	public List<BillingONFavourite> findByBillingONFavCode(Integer billingFavName) {
	   	String sql = "select b from BillingONFavourite b where b.name=?1 order by b.name";
    	Query query = entityManager.createQuery(sql);
    	query.setParameter(1,billingFavName);

        @SuppressWarnings("unchecked")
        List<BillingONFavourite> results = query.getResultList();

        return results;
	}
//given a description, get SuperCode name
	public String searchServiceDx(String billingFavDx) {
		String sql = "select b from BillingONFavourite b where b.service_dx=?1";
    	Query query = entityManager.createQuery(sql);
    	query.setParameter(1,billingFavDx);

        @SuppressWarnings("unchecked")
        List<BillingONFavourite> results = query.getResultList();
        if(!results.isEmpty()) {
        	return results.get(0).getName();
        }
        return null;
	}

//given a name(code), get SuperCode description
	public String searchServiceCode(String billingFavCode) {
		String sql = "select b from BillingONFavourite b where b.name=?1";
    	Query query = entityManager.createQuery(sql);
    	query.setParameter(1,billingFavCode);

        @SuppressWarnings("unchecked")
        List<BillingONFavourite> results = query.getResultList();
        if(!results.isEmpty()) {
        	return results.get(0).getServiceDx();
        }
        return null;
	}


}
