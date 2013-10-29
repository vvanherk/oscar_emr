package org.oscarehr.common.dao;

import java.util.List;
import java.util.ArrayList;

import javax.persistence.Query;

import java.lang.IllegalArgumentException;

import org.springframework.stereotype.Repository;

import org.oscarehr.common.model.OfficeCommunication;

import org.apache.log4j.Logger;
import org.oscarehr.util.MiscUtils;

@Repository
public class OfficeCommunicationDao extends AbstractDao<OfficeCommunication>{

	static Logger logger = MiscUtils.getLogger();

	public OfficeCommunicationDao() {
		super(OfficeCommunication.class);
	}
	 
	public List<OfficeCommunication> get(List<Integer> ids) {
		if (ids == null || ids.size() == 0)
			return null;
		
		Query query = entityManager.createQuery("select oc from OfficeCommunication oc where oc.id in (:ids)");
		query.setParameter("ids", ids);
		
		@SuppressWarnings("unchecked")
		List<OfficeCommunication> results = query.getResultList();
		
		return results;
	}
	
	public OfficeCommunication get(Integer id) {
		if (id == null)
			return null;
			
		List<Integer> ids = new ArrayList<Integer>();
		ids.add(id);
		
		List<OfficeCommunication> results = get(ids);
		
		if (results.size() > 0) {
			return results.get(0);
		}
		
		return null;
	}
	
	public OfficeCommunication getByAppointmentNo(Integer appointmentNo) {
		if (appointmentNo == null)
			return null;
		
		Query query = entityManager.createQuery("select oc from OfficeCommunication oc where oc.appointmentNo = :appointmentNo");
		query.setParameter("appointmentNo", appointmentNo);
		
		List<OfficeCommunication> results = query.getResultList();
		
		if (results.size() > 0) {
			return results.get(0);
		}
		
		return null;
	}
	
	public void add(Integer appointmentNo, Integer demographicNo, String note) {
		if (appointmentNo == null || demographicNo == null || note == null)
			return;
		
		OfficeCommunication oc = getByAppointmentNo(appointmentNo);
		
		if (oc != null) {
			String error = "OfficeCommunication with appointmentNo '" + appointmentNo.toString() + "' already exists!";
			logger.error( error );
			throw new IllegalArgumentException( error );
		}
		
		oc = new OfficeCommunication();
		oc.setAppointmentNo( appointmentNo );
		oc.setDemographicNo( demographicNo );
		oc.setNote( note );
        
        this.persist( oc );
	}
}
