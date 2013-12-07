package org.oscarehr.common.dao;

import java.util.Date;
import java.util.Calendar;
import java.util.List;
import java.util.ArrayList;

import javax.persistence.Query;
import javax.persistence.TemporalType;

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
	
	public List<OfficeCommunication> getByAppointmentNo(Integer appointmentNo) {
		if (appointmentNo == null)
			return null;
		
		Query query = entityManager.createQuery("select oc from OfficeCommunication oc where oc.appointmentNo = :appointmentNo order by oc.createDate desc");
		query.setParameter("appointmentNo", appointmentNo);
		
		List<OfficeCommunication> results = query.getResultList();
		
		return results;
	}
	
	public List<OfficeCommunication> getByDemographicNo(Integer demographicNo) {
		if (demographicNo == null)
			return null;
		
		Query query = entityManager.createQuery("select oc from OfficeCommunication oc where oc.demographicNo = :demographicNo order by oc.createDate desc");
		query.setParameter("demographicNo", demographicNo);
		
		List<OfficeCommunication> results = query.getResultList();
		
		return results;
	}
	
	public OfficeCommunication getByAppointmentNoAndDate(Integer appointmentNo, Date date) {
		if (appointmentNo == null || date == null)
			return null;
		
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(date);
	    int year = cal.get(Calendar.YEAR);
	    int month = cal.get(Calendar.MONTH);
	    int day = cal.get(Calendar.DAY_OF_MONTH);
		
		Query query = entityManager.createQuery("select oc from OfficeCommunication oc where oc.appointmentNo = :appointmentNo and oc.createDate = :date");
		query.setParameter("appointmentNo", appointmentNo);
		
		// Just compare the date, not the time
		query.setParameter("date", date, TemporalType.DATE);
		
		List<OfficeCommunication> results = query.getResultList();
		
		if (results.size() > 0) {
			return results.get(0);
		}
		
		return null;
	}
	
	public void add(Integer appointmentNo, Integer demographicNo, String note) {
		add( appointmentNo, demographicNo, note, null, false );
	}
	
	public void add(Integer appointmentNo, Integer demographicNo, String note, boolean signed) {
		add( appointmentNo, demographicNo, note, null, signed );
	}
	
	public void add(Integer appointmentNo, Integer demographicNo, String note, Date date, boolean signed) {
		if (appointmentNo == null || demographicNo == null || note == null)
			return;
			
		if (date == null)
			date = new Date();
		
		/*
		OfficeCommunication oc = getByAppointmentNo(appointmentNo, date);
		
		if (oc != null) {
			String error = "OfficeCommunication with appointmentNo '" + appointmentNo.toString() + "' already exists!";
			logger.error( error );
			throw new IllegalArgumentException( error );
		}
		*/
		
		OfficeCommunication oc = new OfficeCommunication();
		oc.setAppointmentNo( appointmentNo );
		oc.setDemographicNo( demographicNo );
		oc.setCreateDate( date );
		oc.setNote( note );
		oc.setSigned( signed );
        
        this.persist( oc );
	}
	
	public void update( OfficeCommunication oc ) {
		if (oc == null)
			throw new IllegalArgumentException( "OfficeCommunication object to update was null." );

		this.merge( oc );
	}
}
