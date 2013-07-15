/**
 * Copyright (c) 2006-. OSCARservice, OpenSoft System. All Rights Reserved.
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
 */

package org.oscarehr.common.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Query;

import org.oscarehr.common.model.ProviderSite;
import org.oscarehr.common.model.Site;
import org.oscarehr.util.SpringUtils;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Victor Weng
 */
@Repository
public class SiteDao extends AbstractDao<Site> {

	/** Creates a new instance of UserPropertyDAO */
	public SiteDao() {
		super(Site.class);
	}

	public void save(Site s) {
		boolean isUpdate = s.getSiteId() != null && s.getSiteId() > 0;
		if (isUpdate) {
			Site old = find(s.getSiteId());
			if (!old.getName().equals(s.getName())) {
				// site name changed, need to update all references as it serves as PK
				// so we need to update the tables that references to the site

				Query query = entityManager.createNativeQuery("update rschedule set avail_hour = replace(avail_hour, :oldname, :newname) ");
				query.setParameter("oldname", ">"+old.getName()+"<");
				query.setParameter("newname", ">"+s.getName()+"<");
				query.executeUpdate();

				query = entityManager.createNativeQuery("update scheduledate set reason = :newname where reason = :oldname");
				query.setParameter("oldname", old.getName());
				query.setParameter("newname", s.getName());
				query.executeUpdate();

				query = entityManager.createNativeQuery("update appointment set location = :newname where location = :oldname");
				query.setParameter("oldname", old.getName());
				query.setParameter("newname", s.getName());
				query.executeUpdate();

				query = entityManager.createNativeQuery("update billing_on_cheader1 set clinic = :newname where clinic = :oldname");
				query.setParameter("oldname", old.getName());
				query.setParameter("newname", s.getName());
				query.executeUpdate();


			}
		}

		merge(s);

	}

	public List<Site> getAllSites() {
		Query query = this.entityManager.createQuery("select s from Site s order by s.name");

		@SuppressWarnings("unchecked")
        List<Site> rs = query.getResultList();
		return rs;
	}

	public List<Site> getAllActiveSites() {
		Query query = this.entityManager.createQuery("select s from Site s where s.status=1 order by s.name");

		@SuppressWarnings("unchecked")
        List<Site> rs = query.getResultList();

		return rs;
	}

	public List<Site> getActiveSitesByProviderNo(String provider_no) {
		ProviderSiteDao providerSiteDao = SpringUtils.getBean(ProviderSiteDao.class);
		List<ProviderSite> pss = providerSiteDao.findByProviderNo(provider_no);

		List<Site> rs = new ArrayList<Site>();
		for(ProviderSite ps:pss) {
			rs.add(find(ps.getId().getSiteId()));
		}

		Iterator<Site> it = rs.iterator();
		while (it.hasNext()) {
			Site site = it.next();
			// remove inactive sites
			if (site.getStatus() == 0)
				it.remove();
		}

		Collections.sort(rs, new Comparator<Site>() {
			public int compare(Site o1, Site o2) {
				return o1.getName().compareTo(o2.getName());
			}
		});

		return rs;
	}

	public Site getById(Integer id) {
		return find(id);
	}

	public Site getByLocation(String location) {
		Query query = this.entityManager.createQuery("select s from Site s where s.name=?");
		query.setParameter(1, location);

		@SuppressWarnings("unchecked")
        List<Site> rs = query.getResultList();

		if (rs.size()>0)
			return rs.get(0);
		else
			return null;
	}

	public List<String> getGroupBySiteLocation(String location) {
		Query query = entityManager.createNativeQuery(
				"select distinct g.mygroup_no from mygroup g	" +
						" inner join provider p on p.provider_no = g.provider_no and p.status = 1 " +
						" inner join providersite ps on ps.provider_no = g.provider_no " +
						" inner join site s on s.site_id = ps.site_id " +
						" where  s.name = :sitename ");
		query.setParameter("sitename",location);

		@SuppressWarnings("unchecked")
        List<String> groupList = query.getResultList();


		return groupList;
	}

	public List<String> getProviderNoBySiteLocation(String location) {

		Query query = entityManager.createNativeQuery(
					"select distinct p.provider_no	" +
					" from provider p " +
					" inner join providersite ps on ps.provider_no = p.provider_no " +
					" inner join site s on s.site_id = ps.site_id " +
					" where  s.name = :sitename ") ;

		query.setParameter("sitename", location);

		@SuppressWarnings("unchecked")
        List<String> pList = query.getResultList();


		return pList;
	}

	public List<String> getProviderNoBySiteManagerProviderNo(String providerNo) {

		Query query = entityManager.createNativeQuery(
					"select distinct p.provider_no	" +
					" from provider p " +
					" inner join providersite ps on ps.provider_no = p.provider_no " +
					" where ps.site_id in (select site_id from providersite where provider_no = :providerno)");
		query.setParameter("providerno", providerNo);

		@SuppressWarnings("unchecked")
        List<String> pList = query.getResultList();

		return pList;
	}

	public List<String> getGroupBySiteManagerProviderNo(String providerNo) {

		Query query = entityManager.createNativeQuery(
					"select distinct g.mygroup_no from mygroup g	" +
					" inner join provider p on p.provider_no = g.provider_no and p.status = 1 " +
					" inner join providersite ps on ps.provider_no = g.provider_no " +
					" where ps.site_id in (select site_id from providersite where provider_no = :providerno)");
		query.setParameter("providerno", providerNo);

		@SuppressWarnings("unchecked")
        List<String> groupList = query.getResultList();


		return groupList;
	}

	public String getSiteNameByAppointmentNo(String appointmentNo) {

		Query query = entityManager.createNativeQuery("select location from appointment where appointment_no = :appointmentno");
		query.setParameter("appointmentno", appointmentNo);

		@SuppressWarnings("unchecked")
        List<String> list = query.getResultList();
		if(list.size()>0) {
			return list.get(0);
		}

		return "";
	}
}
