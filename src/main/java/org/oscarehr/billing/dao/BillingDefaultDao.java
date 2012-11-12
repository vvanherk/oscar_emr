package org.oscarehr.billing.dao;

import java.util.List;

import javax.persistence.Query;

import org.oscarehr.billing.model.BillingDefault;
import org.oscarehr.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

@Repository
public class BillingDefaultDao extends AbstractDao<BillingDefault> {

	public BillingDefaultDao() {
		super(BillingDefault.class);
	}
	
	public List<BillingDefault> getAll() {
	   	String sql = "select d from BillingDefault d order by d.priority";
    	Query query = entityManager.createQuery(sql);

        @SuppressWarnings("unchecked")
        List<BillingDefault> results = query.getResultList();

        return results;
	}
	
	public BillingDefault findById(Integer billingDefaultId) {
	   	String sql = "select d from BillingDefault d where d.id=?1 order by d.priority";
    	Query query = entityManager.createQuery(sql);
    	query.setParameter(1,billingDefaultId);

        @SuppressWarnings("unchecked")
        List<BillingDefault> results = query.getResultList();
        
        if (results.size() > 1) {
			// warning - more than one id
		}
		
		if (results.size() == 0)
			return null;
		

        return results.get(0);
	}

	public List<BillingDefault> findByProviderNo(Integer providerNo) {
	   	String sql = "select d from BillingDefault d where d.providerNo=?1 order by d.priority";
    	Query query = entityManager.createQuery(sql);
    	query.setParameter(1,providerNo);

        @SuppressWarnings("unchecked")
        List<BillingDefault> results = query.getResultList();

        return results;
	}
	
	public void saveBillingDefault(BillingDefault billingDefault) {
		this.persist(billingDefault);
		
		// make sure a priority is set
		if (billingDefault.getPriority() == null) {
			billingDefault.setPriority( billingDefault.getId() );
			this.persist(billingDefault);
		}
	}
	
	public void updateBillingDefault(BillingDefault billingDefault) {
		this.merge(billingDefault);
	}
	
	public void deleteBillingDefault(BillingDefault billingDefault) {
		 this.remove(billingDefault);
	}

	public void deleteById(Integer id) {
		String sql = "select d from BillingDefault d where d.id=?1";
    	Query query = entityManager.createQuery(sql);
    	query.setParameter(1,id);

    	 @SuppressWarnings("unchecked")
         List<BillingDefault> results = query.getResultList();
    	 for(BillingDefault billingDefault : results) {
    		 this.remove(billingDefault);
    	 }
	}
}
