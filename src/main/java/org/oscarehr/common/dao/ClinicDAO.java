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

import org.apache.log4j.Logger;

import org.oscarehr.util.MiscUtils;

import java.util.List;
import java.util.ArrayList;

import javax.persistence.Query;

import org.oscarehr.common.model.Clinic;
import org.oscarehr.common.model.Site;
import org.oscarehr.util.SpringUtils;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jason Gallagher
 */
@Repository
public class ClinicDAO extends AbstractDao<Clinic> {

	static Logger logger = MiscUtils.getLogger();

    public ClinicDAO() {
    	super(Clinic.class);
    }

	public int getNumberOfClinics(){
        List<Clinic> codeList = findAll();
        
        if (codeList == null)
			return 0;
		
        return codeList.size();
    }

    public Clinic getClinic(){
    	Query query = entityManager.createQuery("select c from Clinic c");
        @SuppressWarnings("unchecked")
        List<Clinic> codeList = query.getResultList();
        if(codeList.size()>0) {
        	return codeList.get(0);
        }
        return null;
    }

	public List<Clinic> findAll(){
        Query query = entityManager.createQuery("select c from Clinic c");
        
        @SuppressWarnings("unchecked")
        List<Clinic> codeList = query.getResultList();
        
        return codeList;
    }
    
    public Clinic find(int clinicNo){
        Query query = entityManager.createQuery("select c from Clinic c where c.id = :id");
        query.setParameter("id", clinicNo);
        
        return getSingleResultOrNull(query);
    }
    
    public List<Clinic> getClinicsForProvider( String providerNo ) {
		SiteDao siteDao = SpringUtils.getBean(SiteDao.class);
		List<Site> providerSites = siteDao.getActiveSitesByProviderNo(providerNo);
		
		List<Clinic> clinics = new ArrayList<Clinic>();
		
		for ( Site s : providerSites ) {
			if (!clinics.contains(s.getClinic()))
				clinics.add( s.getClinic() );
		}
                
        return clinics;
	}


    public void save(Clinic clinic) {		
        //if(!clinic.isNew()) {
        	merge(clinic);
        //} else {
        //	persist(clinic);
        //}
    }

	public void delete(Clinic clinic) {
        remove( clinic.getId() );
    }


}
