/**
 *
 * Copyright (c) 2005-2012. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved.
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
 * This software was written for
 * Centre for Research on Inner City Health, St. Michael's Hospital,
 * Toronto, Ontario, Canada
 */

package org.oscarehr.PMmodule.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.oscarehr.common.dao.ProviderFacilityDao;
import org.oscarehr.common.model.Provider;
import org.oscarehr.common.model.ProviderFacility;
import org.oscarehr.common.model.ProviderFacilityPK;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import oscar.OscarProperties;
import oscar.util.SqlUtils;

import org.oscarehr.common.model.ProviderSpireIdMap;
import org.oscarehr.common.dao.ProviderSpireIdMapDao;

import com.quatro.model.security.SecProvider;

public class ProviderDao extends HibernateDaoSupport {
	private static Logger log = MiscUtils.getLogger();

	public boolean providerExists(String providerNo) {
		boolean exists = (((Long) getHibernateTemplate().iterate(
				"select count(*) from Provider p where p.ProviderNo = "
						+ providerNo).next()) == 1);
		log.debug("providerExists: " + exists);

		return exists;
	}

	public Provider getProvider(String providerNo) {
		if (providerNo == null || providerNo.length() <= 0) {
			throw new IllegalArgumentException();
		}

		Provider provider = getHibernateTemplate().get(Provider.class, providerNo);

		if (log.isDebugEnabled()) {
			log.debug("getProvider: providerNo=" + providerNo + ",found=" + (provider != null));
		}

		return provider;
	}

	public String getProviderName(String providerNo) {
		if (providerNo == null || providerNo.length() <= 0) {
			throw new IllegalArgumentException();
		}

		Provider provider = getProvider(providerNo);
		String providerName = "";

		if (provider != null && provider.getFirstName() != null) {
			providerName = provider.getFirstName() + " ";
		}

		if (provider != null && provider.getLastName() != null) {
			providerName += provider.getLastName();
		}

		if (log.isDebugEnabled()) {
			log.debug("getProviderName: providerNo=" + providerNo + ",result=" + providerName);
		}

		return providerName;
	}

	public List<Provider> getProviders() {
		@SuppressWarnings("unchecked")
		List<Provider> rs = getHibernateTemplate().find(
				"FROM  Provider p ORDER BY p.LastName");

		if (log.isDebugEnabled()) {
			log.debug("getProviders: # of results=" + rs.size());
		}
		return rs;
	}

    public List<Provider> getProviderFromFirstLastName(String firstname,String lastname){
            firstname=firstname.trim();
            lastname=lastname.trim();
            String s="From Provider p where p.FirstName=? and p.LastName=?";
            ArrayList<Object> paramList=new ArrayList<Object>();
            paramList.add(firstname);
            paramList.add(lastname);
            Object params[]=paramList.toArray(new Object[paramList.size()]);
            return getHibernateTemplate().find(s,params);
    }

    public List<Provider> getProviderLikeFirstLastName(String firstname,String lastname){
    	firstname=firstname.trim();
    	lastname=lastname.trim();
    	String s="From Provider p where p.FirstName like ? and p.LastName like ?";
    	ArrayList<Object> paramList=new ArrayList<Object>();
    	paramList.add(firstname);
    	paramList.add(lastname);
    	Object params[]=paramList.toArray(new Object[paramList.size()]);
    	return getHibernateTemplate().find(s,params);
	}

    public List<SecProvider> getActiveProviders(Integer programId) {
        ArrayList<Object> paramList = new ArrayList<Object>();

    	String sSQL="FROM  SecProvider p where p.status='1' and p.providerNo in " +
    	"(select sr.providerNo from secUserRole sr, LstOrgcd o " +
    	" where o.code = 'P' || ? " +
    	" and o.codecsv  like '%' || sr.orgcd || ',%' " +
    	" and not (sr.orgcd like 'R%' or sr.orgcd like 'O%'))" +
    	" ORDER BY p.lastName";

    	paramList.add(programId);
    	Object params[] = paramList.toArray(new Object[paramList.size()]);

    	return  getHibernateTemplate().find(sSQL ,params);
	}

	public List<Provider> getActiveProviders(String facilityId, String programId) {
		ArrayList<Object> paramList = new ArrayList<Object>();

		String sSQL;
		List<Provider> rs;
		if (programId != null && "0".equals(programId) == false) {
			sSQL = "FROM  Provider p where p.Status='1' and p.ProviderNo in "
					+ "(select c.ProviderNo from ProgramProvider c where c.ProgramId =?) ORDER BY p.LastName";
			paramList.add(Long.valueOf(programId));
			Object params[] = paramList.toArray(new Object[paramList.size()]);
			rs = getHibernateTemplate().find(sSQL, params);
		} else if (facilityId != null && "0".equals(facilityId) == false) {
			sSQL = "FROM  Provider p where p.Status='1' and p.ProviderNo in "
					+ "(select c.ProviderNo from ProgramProvider c where c.ProgramId in "
					+ "(select a.id from Program a where a.facilityId=?)) ORDER BY p.LastName";
			// JS 2192700 - string facilityId seems to be throwing class cast
			// exception
			Integer intFacilityId = Integer.valueOf(facilityId);
			paramList.add(intFacilityId);
			Object params[] = paramList.toArray(new Object[paramList.size()]);
			rs = getHibernateTemplate().find(sSQL, params);
		} else {
			sSQL = "FROM  Provider p where p.Status='1' ORDER BY p.LastName";
			rs = getHibernateTemplate().find(sSQL);
		}
		// List<Provider> rs =
		// getHibernateTemplate().find("FROM  Provider p ORDER BY p.LastName");

		return rs;
	}

	public List<Provider> getActiveProvidersByProviderNoList(List<String> providerNoList) {
		String sSQL;
		List<Provider> rs;
		
		if(providerNoList == null || providerNoList.size() == 0) return null;
		
		String filter = SqlUtils.constructInClauseForStatements(providerNoList.toArray(), true);

		sSQL = "FROM  Provider p where p.Status='1' and p.ProviderNo in "+filter;
		rs = getHibernateTemplate().find(sSQL);

		return rs;
	}

	public List<Provider> getActiveProviders() {
		@SuppressWarnings("unchecked")
		List<Provider> rs = getHibernateTemplate().find(
				"FROM  Provider p where p.Status='1' ORDER BY p.LastName");

		if (log.isDebugEnabled()) {
			log.debug("getProviders: # of results=" + rs.size());
		}
		return rs;
	}

	@SuppressWarnings("unchecked")
    public List<Provider> getBillableProviders() {
		List<Provider> rs = getHibernateTemplate().find("FROM Provider p where p.OhipNo != '' and p.Status = '1'");
		return rs;
	}

	public List<Provider> getProviders(boolean active) {
		@SuppressWarnings("unchecked")
		List<Provider> rs = getHibernateTemplate().find(
				"FROM  Provider p where p.Status='"+(active?1:0)+'\'');
		return rs;
	}

    public List<Provider> getActiveProviders(String providerNo, Integer shelterId) {
    	//@SuppressWarnings("unchecked")
    	String sql;
    	if (shelterId == null || shelterId.intValue() == 0)
    		sql = "FROM  Provider p where p.Status='1'" +
    				" and p.ProviderNo in (select sr.providerNo from Secuserrole sr " +
    				" where sr.orgcd in (select o.code from LstOrgcd o, Secuserrole srb " +
    				" where o.codecsv  like '%' || srb.orgcd || ',%' and srb.providerNo =?))" +
    				" ORDER BY p.LastName";
    	else
    		sql = "FROM  Provider p where p.Status='1'" +
			" and p.ProviderNo in (select sr.providerNo from Secuserrole sr " +
			" where sr.orgcd in (select o.code from LstOrgcd o, Secuserrole srb " +
			" where o.codecsv like '%S" + shelterId.toString()+ ",%' and o.codecsv like '%' || srb.orgcd || ',%' and srb.providerNo =?))" +
			" ORDER BY p.LastName";

    	ArrayList<Object> paramList = new ArrayList<Object>();
    	paramList.add(providerNo);

    	Object params[] = paramList.toArray(new Object[paramList.size()]);

    	List<Provider> rs = getHibernateTemplate().find(sql,params);

		if (log.isDebugEnabled()) {
			log.debug("getProviders: # of results=" + rs.size());
		}
		return rs;
	}

	public List<Provider> search(String name) {
		boolean isOracle = OscarProperties.getInstance().getDbType().equals(
				"oracle");
		Criteria c = this.getSession().createCriteria(Provider.class);
		if (isOracle) {
			c.add(Restrictions.or(Expression.ilike("FirstName", name + "%"),
					Expression.ilike("LastName", name + "%")));
		} else {
			c.add(Restrictions.or(Expression.like("FirstName", name + "%"),
					Expression.like("LastName", name + "%")));
		}
		c.addOrder(Order.asc("ProviderNo"));

		@SuppressWarnings("unchecked")
		List<Provider> results = c.list();

		if (log.isDebugEnabled()) {
			log.debug("search: # of results=" + results.size());
		}
		return results;
	}

	public List<Provider> getProvidersByType(String type) {
		@SuppressWarnings("unchecked")
		List<Provider> results = this.getHibernateTemplate().find(
				"from Provider p where p.ProviderType = ?", type);

		if (log.isDebugEnabled()) {
			log.debug("getProvidersByType: type=" + type + ",# of results="
					+ results.size());
		}

		return results;
	}

	public List getShelterIds(String provider_no)
	{
		/*
		String sql = "select distinct substr(codetree,18,7) as shelter_id from lst_orgcd" ;
		sql += " where code in (select orgcd from secuserrole where provider_no=?)";
		sql += " and fullcode like '%S%'";
		*/
		String sql ="select distinct c.id as shelter_id from lst_shelter c, lst_orgcd a, secUserRole b  where instr('RO',substr(b.orgcd,1,1)) = 0 and a.codecsv like '%' || b.orgcd || ',%'" +
				" and b.provider_no=? and a.codecsv like '%S' || c.id  || ',%'";

		Query query = getSession().createSQLQuery(sql);
    	((SQLQuery) query).addScalar("shelter_id", Hibernate.INTEGER);
    	query.setString(0, provider_no);
        List lst=query.list();
        return lst;

	}

	public List<Provider> getActiveProvidersByType(String type) {
		@SuppressWarnings("unchecked")
		List<Provider> results = this.getHibernateTemplate().find(
				"from Provider p where p.Status='1' and p.ProviderType = ? order by p.LastName",
				type);

		return results;
	}

	public static void addProviderToFacility(String provider_no, int facilityId) {
		try {
			ProviderFacility pf = new ProviderFacility();
			pf.setId(new ProviderFacilityPK());
			pf.getId().setProviderNo(provider_no);
			pf.getId().setFacilityId(facilityId);
			ProviderFacilityDao pfDao = SpringUtils.getBean(ProviderFacilityDao.class);
			pfDao.persist(pf);
		} catch (RuntimeException e) {
			// chances are it's a duplicate unique entry exception so it's safe
			// to ignore.
			// this is still unexpected because duplicate calls shouldn't be
			// made
			log.warn("Unexpected exception occurred.", e);
		}
	}

	public static void removeProviderFromFacility(String provider_no,
			int facilityId) {
		SqlUtils.update("delete from provider_facility where provider_no='"
				+ provider_no + "' and facility_id=" + facilityId);
	}

	public static List<Integer> getFacilityIds(String provider_no) {
		return (SqlUtils
				.selectIntList("select facility_id from provider_facility,Facility where Facility.id=provider_facility.facility_id and Facility.disabled=0 and provider_no='"
						+ provider_no + '\''));
	}

	public static List<String> getProviderIds(int facilityId) {
		return (SqlUtils
				.selectStringList("select provider_no from provider_facility where facility_id="
						+ facilityId));
	}

    public void updateProvider( Provider provider) {
        this.getHibernateTemplate().update(provider);
    }

    public void saveProvider( Provider provider) {
        this.getHibernateTemplate().save(provider);
    }

	public Provider getProviderByPractitionerNo(String practitionerNo) {
		if (practitionerNo == null || practitionerNo.length() <= 0) {
			throw new IllegalArgumentException();
		}

		List<Provider> providerList = getHibernateTemplate().find("From Provider p where p.practitionerNo=?",new Object[]{practitionerNo});

		if(providerList.size()>1) {
			logger.warn("Found more than 1 provider with practitionerNo="+practitionerNo);
		}
		if(providerList.size()>0)
			return providerList.get(0);

		return null;
	}
	
	public List<Provider> getProvidersByOhipNo(List<String> ohipNumbers) {
		if (ohipNumbers == null || ohipNumbers.size() <= 0) {
			throw new IllegalArgumentException();
		}
		
		String ohipNumbersAsString = "'" + StringUtils.join(ohipNumbers,"','") + "'";

		List<Provider> providerList = getHibernateTemplate().find("From Provider p where p.OhipNo in (" + ohipNumbersAsString + ")");

		return providerList;
	}
	
	public List<Provider> getProvidersByOhipNo(String ohipNo) {
		if (ohipNo == null || ohipNo.length() <= 0) {
			throw new IllegalArgumentException();
		}

		List<Provider> providerList = getHibernateTemplate().find("From Provider p where p.OhipNo=?",new Object[]{ohipNo});

		return providerList;
	}
	
	public List<Provider> getProvidersByProviderNo(List<String> providerNumbers) {
		if (providerNumbers == null || providerNumbers.size() <= 0) {
			return null;
		}
		
		String providerNumbersAsString = "'" + StringUtils.join(providerNumbers,"','") + "'";

		List<Provider> providerList = getHibernateTemplate().find("From Provider p where p.ProviderNo in (" + providerNumbersAsString + ")");

		return providerList;
	}

	public Provider getProviderBySpireId(String spireId) {
		if (spireId == null || spireId.length() <= 0) {
			throw new IllegalArgumentException();
		}

		List<Provider> providerList = getAllProvidersWithSpireId(spireId);
	
		if(providerList.size()>1) {
			logger.warn("Found more than 1 provider with spire_id="+spireId);
		}
		if(providerList.size()>0)
			return providerList.get(0);

		return null;
	}
	
	public List<Provider> getAllProvidersWithSpireId(String spireId) {
		if (spireId == null || spireId.length() <= 0) {
			throw new IllegalArgumentException();
		}
		
		// convert spireId from String to an Integer
		Integer id = null;
		try {
			id = Integer.parseInt(spireId);
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("spireId '" + spireId +"' is not a valid integer!");
		}
		
		ProviderSpireIdMapDao mapDao = (ProviderSpireIdMapDao)SpringUtils.getBean("providerSpireIdMapDao");
		ProviderSpireIdMap map = mapDao.getProviderSpireIdMap(id);
		
		if (map == null) {
			logger.warn("Found 0 provider mappings with spire_id="+spireId);
			return null;
		}
		
		String ohipNumber = map.getOhipNo();
		
		if (ohipNumber == null) {
			logger.warn("No OHIP Number associated with spire_id="+spireId);
			return null;
		}

		List<Provider> providerList = getHibernateTemplate().find("From Provider p where OhipNo=?",new Object[]{ohipNumber});
		
		return providerList;
	}
	
	public List<String> getUniqueTeams() {
		@SuppressWarnings("unchecked")
		List<String> providerList = getHibernateTemplate().find("select distinct p.Team From Provider p");

		return providerList;
	}

	public String getProviderTeam(String providerNo) {
		Provider provider = getProvider(providerNo);
		if(provider == null) return null;
		else return provider.getTeam();
	}

	public List<String> getProvidersNoByTeam(String team) {
		@SuppressWarnings("unchecked")
		List<String> providerNoList = getHibernateTemplate().find("select distinct p.ProviderNo From Provider p where p.Team=?", new Object[]{team});

		return providerNoList;
		
	}

	public List<Provider> getProvidersByTeam(String team) {
		@SuppressWarnings("unchecked")
		List<Provider> providerList = getHibernateTemplate().find("select distinct p From Provider p where p.Team=?", new Object[]{team});

		return providerList;
		
	}

	
	public List<String> getRecordsAddedAndUpdatedSinceTime(Date date) {
		@SuppressWarnings("unchecked")
		List<String> providers = getHibernateTemplate().find("select distinct p.ProviderNo From Provider p where p.lastUpdateDate > ? ",date);
		
		return providers;
	}

	public List<Provider> getProvidersForAllSites() {
		List<Provider> pList = new ArrayList<Provider>();
		Session sess = getSession();
		try {
			SQLQuery  q = sess.createSQLQuery(
					"select distinct p.provider_no	" +
					" from provider p " +
					" inner join providersite ps on ps.provider_no = p.provider_no" +
					" where p.status=1");
			List providerNos = q.list();
			for(Object no : providerNos) {
				String providerNo = (String)no;
				Provider provider = getProvider(providerNo);
				pList.add(provider);
			}
		} catch (Exception e) {
			MiscUtils.getLogger().error("Error", e);
		} finally {
			try {
				sess.close();
			} catch (HibernateException e) {
				MiscUtils.getLogger().error("Error", e);
			}
		}		
		return pList;
	}	
	
	public List<String> getProvidersNoForAllSites() {
		List<String> pList = new ArrayList<String>();
		Session sess = getSession();
		try {
			SQLQuery  q = sess.createSQLQuery(
					"select distinct p.provider_no	" +
					" from provider p " +
					" inner join providersite ps on ps.provider_no = p.provider_no" +
					" where p.status=1");
			pList = q.list();
		} catch (Exception e) {
			MiscUtils.getLogger().error("Error", e);
		} finally {
			try {
				sess.close();
			} catch (HibernateException e) {
				MiscUtils.getLogger().error("Error", e);
			}
		}		
		return pList;
	}	

	public List<Provider> getSiteProvidersByProviderNo(String providerNo) {
		List<Provider> pList = new ArrayList<Provider>();
		Session sess = getSession();
		try {
			SQLQuery  q = sess.createSQLQuery(
					"select distinct p.provider_no	" +
					" from provider p " +
					" inner join providersite ps on ps.provider_no = p.provider_no " +
					" where ps.site_id in (select site_id from providersite where provider_no = :providerno)");
			q.setParameter("providerno", providerNo);
			q.addScalar("provider_no", Hibernate.STRING);			
			List providerNos = q.list();
			ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
			for(Object no : providerNos) {
				String provNo = (String)no;
				Provider provider = providerDao.getProvider(provNo);
				pList.add(provider);				
			}
		} catch (Exception e) {
			MiscUtils.getLogger().error("Error", e);
		} finally {
			try {
				sess.close();
			} catch (HibernateException e) {
				MiscUtils.getLogger().error("Error", e);
			}
		}		
		return pList;
	}		
	
	public List<Provider> getProvidersBySiteLocation(Integer siteId) {
		List<Provider> pList = new ArrayList<Provider>();
		Session sess = getSession();
		try {
			SQLQuery  q = sess.createSQLQuery(
					"select distinct p.provider_no	" +
					" from provider p " +
					" inner join providersite ps on ps.provider_no = p.provider_no " +
					" inner join site s on s.site_id = ps.site_id " +
					" where  s.site_id = :siteId ") ;
			q.setParameter("siteId", siteId);
//			q.addScalar("provider_no", Hibernate.STRING);			
			List providerNos = q.list();
			for(Object no : providerNos) {
				String provNo = (String)no;
				Provider provider = getProvider(provNo);
				pList.add(provider);				
			}
		} catch (Exception e) {
			MiscUtils.getLogger().error("Error", e);
		} finally {
			try {
				sess.close();
			} catch (HibernateException e) {
				MiscUtils.getLogger().error("Error", e);
			}
		}		
		return pList;
	}
	
	public List<Provider> getActiveTeamProviders(String providerNo) {
		List<Provider> ret = new ArrayList<Provider>();
		String sql = "from Provider "
				+ "where Status= '1' and OhipNo!='' and (ProviderNo= ? or " +
				"Team=(select p1.Team from Provider p1 where ProviderNo= ?)) order by LastName, FirstName";
		ArrayList<String> paramList = new ArrayList<String>();
    	paramList.add(providerNo);
    	paramList.add(providerNo);
    	Object params[] = paramList.toArray(new Object[paramList.size()]);
	    	
    	List<Object> rs = getHibernateTemplate().find(sql,params);
	    for(Object p : rs) {
	    	ret.add((Provider)p);
	    }	
		return ret;
	}

	public List<Provider> getActiveSiteProviders(String providerNo) {
		List<Provider> ret = new ArrayList<Provider>();
		Session sess = getSession();
		String sql = "select p.provider_no from provider p "
				+ "where status='1' and ohip_no!='' " +
				"and exists(select * from providersite s where p.provider_no = s.provider_no and s.site_id IN (SELECT site_id from providersite where provider_no= :providerParam))" +
				" order by last_name, first_name";
		SQLQuery  q = sess.createSQLQuery(sql);
/*
		SQLQuery  q = sess.createSQLQuery(
				"select distinct p.provider_no	" +
				" from provider p " +
				" inner join providersite ps on ps.provider_no = p.provider_no " +
				" inner join site s on s.site_id = ps.site_id " +
				" where  s.name = :sitename ") ;
*/				
		q.setParameter("providerParam", providerNo);
//		q.addScalar("provider_no", Hibernate.STRING);			
		List providerNos = q.list();
		for(Object no : providerNos) {
			Provider provider = getProvider((String)no);
			ret.add(provider);				
		}
		return ret;
	}
}
