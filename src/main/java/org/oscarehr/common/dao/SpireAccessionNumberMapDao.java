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
	
	public List<SpireAccessionNumberMap> getFromCommonAccessionNumbers(List<String> accns) {
		if (accns == null)
			return null;
		
		Query query = entityManager.createQuery("select map from SpireAccessionNumberMap map join SpireCommonAccessionNumber caccn where caccn.caccn in (?) order by map.uaccn");
		query.setParameter(1, accns);
		
		@SuppressWarnings("unchecked")
		List<SpireAccessionNumberMap> results = query.getResultList();
		
		return results;
	}
	
	public SpireAccessionNumberMap getFromUniqueAccessionNumber(String uniqueAccn) {
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
	
	public void add(String uniqueAccn, String accn) {
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
	
	private void addNewMap(String uniqueAccn) {
		if (uniqueAccn == null)
			return;
			
		SpireAccessionNumberMap map = new SpireAccessionNumberMap();
		this.persist(map);
	}
}
