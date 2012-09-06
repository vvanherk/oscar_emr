package org.oscarehr.common.dao;

import java.util.List;

import javax.persistence.Query;

import org.oscarehr.common.model.ProviderSpireIdMap;
import org.springframework.stereotype.Repository;

@Repository
public class ProviderSpireIdMapDao extends AbstractDao<ProviderSpireIdMap>{

	public ProviderSpireIdMapDao() {
		super(ProviderSpireIdMap.class);
	}
	
	public ProviderSpireIdMap getProviderSpireIdMap(Integer spireId) {
		if (spireId == null)
			return null;
		
		Query query = entityManager.createQuery("select map from ProviderSpireIdMap map where map.spire_id=?");
		query.setParameter(1, spireId);
		
		@SuppressWarnings("unchecked")
		List<ProviderSpireIdMap> results = query.getResultList();
		
		if(results.size()>0) {
			return results.get(0);
		}
		return null;
	}
}
