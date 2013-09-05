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

import org.oscarehr.common.model.DemographicContact;
import org.oscarehr.common.dao.DemographicExtDao;
import org.oscarehr.common.model.DemographicExt;
import org.springframework.stereotype.Repository;

import org.oscarehr.util.SpringUtils;

@Repository
public class DemographicContactDao extends AbstractDao<DemographicContact>{
	
	public DemographicContactDao() {
		super(DemographicContact.class);
	}
	
	public List<DemographicContact> findByDemographicNo(int demographicNo) {
		String sql = "select x from " + this.modelClass.getName() + " x where x.demographicNo=? and x.deleted=false";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, demographicNo);
		@SuppressWarnings("unchecked")
		List<DemographicContact> dContacts = query.getResultList();
		
		DemographicContact dc = getFamilyDoctor( demographicNo );
		if (dc != null)
			dContacts.add( dc );
		
		return dContacts;
	}

	public List<DemographicContact> findByDemographicNoAndCategory(int demographicNo,String category) {
		String sql = "select x from " + this.modelClass.getName() + " x where x.demographicNo=? and x.category=? and x.deleted=false";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, demographicNo);
		query.setParameter(2, category);
		@SuppressWarnings("unchecked")
		List<DemographicContact> dContacts = query.getResultList();
		
		DemographicContact dc = getFamilyDoctor( demographicNo );
		if (dc != null)
			dContacts.add( dc );
		
		return dContacts;
	}

	public List<DemographicContact> find(int demographicNo, int contactId) {
		String sql = "select x from " + this.modelClass.getName() + " x where x.demographicNo=? and x.contactId = ? and x.deleted=false";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, demographicNo);
		query.setParameter(2, new Integer(contactId).toString());
		@SuppressWarnings("unchecked")
		List<DemographicContact> dContacts = query.getResultList();
		
		DemographicContact dc = getFamilyDoctor( demographicNo, ""+contactId );
		if (dc != null)
			dContacts.add( dc );
		
		return dContacts;
	}
	
	/**
	 * Hacky method to get the family doctor for this demographic.  Internally, the
	 * DemographicContactDao class will use this method to append the family doctor
	 * to the list of DemographicContact objects.
	 */
	public DemographicContact getFamilyDoctor(int demographicNo) {
		return getFamilyDoctor( demographicNo, null );
	}
	
	private DemographicContact getFamilyDoctor(int demographicNo, String referralNo) {
		DemographicExtDao demographicExtDao= (DemographicExtDao)SpringUtils.getBean("demographicExtDao");
		
		DemographicExt dex = demographicExtDao.getLatestDemographicExt(new Integer(demographicNo), "Family_Doctor_No");
		
		if (dex == null)
			return null;
		if (dex.getValue() == null || (referralNo != null && !dex.getValue().equals(referralNo)))
			return null;
		
		DemographicContact dContact = new DemographicContact();
		dContact.setDemographicNo( demographicNo );
		dContact.setContactId( dex.getValue() );
		dContact.setRole( "Family Doctor" );
		dContact.setType( DemographicContact.TYPE_PROFESSIONAL_SPECIALIST );
		
		return dContact;
	}
}
