package org.oscarehr.common.dao;

import java.util.List;
import java.util.ArrayList;

import javax.persistence.Query;

import org.oscarehr.common.model.SpireAccessionNumberMap;
import org.oscarehr.common.model.SpireCommonAccessionNumber;
import org.springframework.stereotype.Repository;

@Repository
public class SpireAccessionNumberMapDao extends AbstractDao<SpireAccessionNumberMap>{

	public SpireAccessionNumberMapDao() {
		super(SpireAccessionNumberMap.class);
	}
	 
	public List<SpireAccessionNumberMap> getFromCommonAccessionNumbers(List<String> accns) {
		if (accns == null || accns.size() == 0)
			return null;
		
		//Query query = entityManager.createQuery("select map from SpireCommonAccessionNumber caccn inner join SpireAccessionNumberMap caccn.accnMap where caccn.caccn in (:accns) order by accnMap.uaccn");
		Query query = entityManager.createQuery("select c.map from SpireCommonAccessionNumber c where c.caccn in (:accns)");
		query.setParameter("accns", accns);
		
		@SuppressWarnings("unchecked")
		List<SpireAccessionNumberMap> results = query.getResultList();
		
		return results;
	}
	
	public SpireAccessionNumberMap getFromCommonAccessionNumber(String accn) {
		if (accn == null)
			return null;
			
		List<String> accns = new ArrayList<String>();
		accns.add(accn);
		
		List<SpireAccessionNumberMap> results = getFromCommonAccessionNumbers(accns);
		
		if (results.size() > 0) {
			return results.get(0);
		}
		
		return null;
	}
	
	public List<Integer> getAccessionNumberMapIds(List<String> accns) {
		if (accns == null || accns.size() == 0)
			return null;
		
		Query query = entityManager.createQuery("select distinct c.uaccn_id from SpireCommonAccessionNumber c where caccn.caccn in (:accns)");
		query.setParameter("accns", accns);
		
		@SuppressWarnings("unchecked")
		List<Integer> results = query.getResultList();
		
		return results;
	}
	
	public SpireAccessionNumberMap getFromAccessionNumberMapId(Integer accnMapId) {
		if (accnMapId == null)
			return null;
		
		Query query = entityManager.createQuery("select map from SpireAccessionNumberMap map where map.id = ?");
		query.setParameter(1, accnMapId);
		
		@SuppressWarnings("unchecked")
		List<SpireAccessionNumberMap> results = query.getResultList();
		
		if (results.size() > 0) {
			return results.get(0);
		}
		
		return null;
	}
	
	public List<SpireAccessionNumberMap> getFromAccessionNumberMapIds(List<Integer> accnMapIds) {
		if (accnMapIds == null || accnMapIds.size() == 0)
			return null;
		
		Query query = entityManager.createQuery("select map from SpireAccessionNumberMap map where map.id in (:accns)");
		query.setParameter("accns", accnMapIds);
		
		@SuppressWarnings("unchecked")
		List<SpireAccessionNumberMap> results = query.getResultList();
		
		return results;
	}
	
	public SpireAccessionNumberMap getFromUniqueAccessionNumber(Integer uniqueAccn) {
		if (uniqueAccn == null)
			return null;
		
		Query query = entityManager.createQuery("select map from SpireAccessionNumberMap map where map.uaccn = ?");
		query.setParameter(1, uniqueAccn);
		
		@SuppressWarnings("unchecked")
		List<SpireAccessionNumberMap> results = query.getResultList();
		
		if (results.size() > 0) {
			return results.get(0);
		}
		
		return null;
	}
	
	public void add(Integer uniqueAccn, String accn, Integer labNo) {
		if (uniqueAccn == null || accn == null || labNo == null)
			return;
		
		SpireAccessionNumberMap map = getFromUniqueAccessionNumber(uniqueAccn);
		
		if (map == null) {
			addNewMap(uniqueAccn);
			map = getFromUniqueAccessionNumber(uniqueAccn);
		}
		
		int orderIndex = 0;
		
		SpireCommonAccessionNumber tempAccn = map.getCommonAccessionNumberMatchingAccessionNumber(accn);
		
		if (tempAccn != null)
			orderIndex = tempAccn.getOrderIndex();
		else
			orderIndex = map.getNumberOfUniqueLabs();
		
		SpireCommonAccessionNumber commonAccn = new SpireCommonAccessionNumber();
		commonAccn.setCommonAccessionNumber(accn);
		commonAccn.setLabNo(labNo);
		commonAccn.setOrderIndex(orderIndex);

        map.getCommonAccessionNumbers().add(commonAccn);
        
        this.merge(map);
	}
	
	private void addNewMap(Integer uniqueAccn) {
		if (uniqueAccn == null)
			return;
			
		SpireAccessionNumberMap map = new SpireAccessionNumberMap(uniqueAccn);
		this.persist(map);
	}
}
