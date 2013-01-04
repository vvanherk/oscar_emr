package org.oscarehr.common.dao;

import java.util.List;

import javax.persistence.Query;

import org.oscarehr.common.model.SpireAccessionNumberMap;
import org.oscarehr.common.model.SpireCommonAccessionNumber;
import org.springframework.stereotype.Repository;

@Repository
public class SpireAccessionNumberMapDao extends AbstractDao<SpireAccessionNumberMap>{

	public SpireAccessionNumberMapDao() {
		super(SpireAccessionNumberMap.class);
	}
	
	/**
	 * This method is not working properly - crashes with exception.
	 */ 
	public List<SpireAccessionNumberMap> getFromCommonAccessionNumbers(List<String> accns) {
		if (accns == null || accns.size() == 0)
			return null;
		
		Query query = entityManager.createQuery("select map from SpireCommonAccessionNumber caccn inner join SpireAccessionNumberMap caccn.accnMap where caccn.caccn in (:accns) order by accnMap.uaccn");
		query.setParameter("accns", accns);
		
		@SuppressWarnings("unchecked")
		List<SpireAccessionNumberMap> results = query.getResultList();
		
		return results;
	}
	
	public List<Integer> getUniqueAccessionNumbers(List<String> accns) {
		if (accns == null || accns.size() == 0)
			return null;
		
		Query query = entityManager.createQuery("select distinct c.accnMap.uaccn from SpireCommonAccessionNumber c where caccn.caccn in (:accns)");
		query.setParameter("accns", accns);
		
		@SuppressWarnings("unchecked")
		List<Integer> results = query.getResultList();
		
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
	
	public List<SpireAccessionNumberMap> getFromUniqueAccessionNumbers(List<Integer> uniqueAccns) {
		if (uniqueAccns == null || uniqueAccns.size() == 0)
			return null;
		
		Query query = entityManager.createQuery("select map from SpireAccessionNumberMap map where map.uaccn in (:accns)");
		query.setParameter("accns", uniqueAccns);
		
		@SuppressWarnings("unchecked")
		List<SpireAccessionNumberMap> results = query.getResultList();
		
		return results;
	}
	
	public void add(Integer uniqueAccn, String accn) {
		if (uniqueAccn == null)
			return;
		if (accn == null)
			return;
		
		SpireAccessionNumberMap map = getFromUniqueAccessionNumber(uniqueAccn);
		
		if (map == null) {
			addNewMap(uniqueAccn);
			map = getFromUniqueAccessionNumber(uniqueAccn);
		}
		
		SpireCommonAccessionNumber commonAccn = new SpireCommonAccessionNumber();
		commonAccn.setCommonAccessionNumber(accn);

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
