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

package org.oscarehr.common.dao;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import javax.persistence.Query;

import org.oscarehr.common.model.Appointment;
import org.oscarehr.common.model.AppointmentArchive;
import org.oscarehr.common.model.Facility;
import org.oscarehr.util.MiscUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Repository;

@Repository
public class OscarAppointmentDao extends AbstractDao<Appointment> {

	public OscarAppointmentDao() {
		super(Appointment.class);
	}

	public boolean checkForConflict(Appointment appt) {
		String sb = "select a from Appointment a where a.appointmentDate = ? and a.startTime >= ? and a.endTime <= ? and a.providerNo = ? and a.status != 'N' and a.status != 'C'";

		Query query = entityManager.createQuery(sb);

		query.setParameter(1, appt.getAppointmentDate());
		query.setParameter(2, appt.getStartTime());
		query.setParameter(3, appt.getEndTime());
		query.setParameter(4, appt.getProviderNo());

		@SuppressWarnings("unchecked")
		List<Facility> results = query.getResultList();

		if (!results.isEmpty()) return true;

		return false;
	}

	public List<Appointment> getAppointmentHistory(Integer demographicNo) {
		String sql = "select a from Appointment a where a.demographicNo=? order by a.appointmentDate DESC, a.startTime DESC";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, demographicNo);

		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}

	public void archiveAppointment(int appointmentNo) {
		Appointment appointment = this.find(appointmentNo);
		if (appointment != null) {
			AppointmentArchive apptArchive = new AppointmentArchive();
			String[] ignores={"id"};
			BeanUtils.copyProperties(appointment, apptArchive, ignores);
			apptArchive.setAppointmentNo(appointment.getId());
			entityManager.persist(apptArchive);
		}
	}

	public List<Appointment> getAllByDemographicNo(Integer demographicNo) {
		String sql = "SELECT a FROM Appointment a WHERE a.demographicNo = " + demographicNo + " ORDER BY a.id";
		Query query = entityManager.createQuery(sql);

		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}

	public List<Appointment> findByDateRange(Date startTime, Date endTime) {
		String sql = "SELECT a FROM Appointment a WHERE a.appointmentDate >=? and a.appointmentDate <= ?";

		Query query = entityManager.createQuery(sql);
		query.setParameter(1, startTime);
		query.setParameter(2, endTime);
		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}

	public List<Appointment> findByDateRangeAndProvider(Date startTime, Date endTime, String providerNo) {
		
		return findByDateRangeAndProvider(startTime, endTime, providerNo, null, null);
	}
	
	public List<Appointment> findByDateRangeAndProvider(Date startTime, Date endTime, String providerNo, Integer firstResult, Integer maxResults) {
		String sql = "SELECT a FROM Appointment a WHERE a.appointmentDate >=? and a.appointmentDate <= ? and providerNo = ?";

		Query query = entityManager.createQuery(sql);
		query.setParameter(1, startTime);
		query.setParameter(2, endTime);
		query.setParameter(3, providerNo);
		
		if (firstResult != null && firstResult.intValue() >= 0)
			query.setFirstResult(firstResult);
			
		if (maxResults != null && maxResults.intValue() > 0)
			query.setMaxResults(maxResults);
		

		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}
	
	public int getCountByDateRangeAndProvider(Date startTime, Date endTime, String providerNo) {
		String sql = "SELECT COUNT(a) FROM Appointment a WHERE a.appointmentDate >=? and a.appointmentDate <= ? and providerNo = ?";

		Query query = entityManager.createQuery(sql);
		query.setParameter(1, startTime);
		query.setParameter(2, endTime);
		query.setParameter(3, providerNo);
		

		@SuppressWarnings("unchecked")
		
		Number numRows = (Number)query.getSingleResult();
		

		return numRows.intValue();
	}


    public List<Appointment> getFirstAndLastUnbilledAppointments( ) {
		String sql1 = "SELECT a FROM Appointment a WHERE a.demographicNo != 0 and a.status IN (:status_list1) ORDER BY appointmentDate";
        String sql2 = "SELECT a FROM Appointment a WHERE a.demographicNo != 0 and a.status IN (:status_list2) ORDER BY appointmentDate DESC";
        //sql       += " ORDER BY appointmentDate";

		List<String> statusList = new ArrayList<String>();
		statusList.add("P");
		statusList.add("H");
		statusList.add("HS");
		statusList.add("PV");
		statusList.add("PS");
		statusList.add("E");
		statusList.add("ES");
		statusList.add("EV");

		Query query1 = entityManager.createQuery(sql1);
		Query query2 = entityManager.createQuery(sql2);
		query1.setParameter("status_list1", statusList);
		query2.setParameter("status_list2", statusList);
        query1.setMaxResults(1);
        query2.setMaxResults(1);
		
		@SuppressWarnings("unchecked")
		List<Appointment> rs1 = query1.getResultList();
		List<Appointment> rs2 = query2.getResultList();
        
        rs1.addAll( rs2 );
		return rs1;
	}
	
	public List<Appointment> getUnbilledByDateRangeAndProvider(Date startTime, Date endTime, String providerNo, Integer firstResult, Integer maxResults) {
		String sql = "SELECT a FROM Appointment a WHERE a.appointmentDate >= :start_time and a.appointmentDate <= :end_time and providerNo = :provider_no";
		sql += " and a.demographicNo != 0 and a.status IN (:status_list)";

		List<String> statusList = new ArrayList<String>();
		statusList.add("P");
		statusList.add("H");
		statusList.add("HS");
		statusList.add("PV");
		statusList.add("PS");
		statusList.add("E");
		statusList.add("ES");
		statusList.add("EV");

		Query query = entityManager.createQuery(sql);
		query.setParameter("start_time", startTime);
		query.setParameter("end_time", endTime);
		query.setParameter("provider_no", providerNo);
		query.setParameter("status_list", statusList);
		
		if (firstResult != null && firstResult.intValue() >= 0)
			query.setFirstResult(firstResult);
			
		if (maxResults != null && maxResults.intValue() > 0)
			query.setMaxResults(maxResults);
		
		
		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}
	
	public List<Appointment> getBilledByDateRangeAndProvider(Date startTime, Date endTime, String providerNo, Integer firstResult, Integer maxResults) {
		String sql = "SELECT a FROM Appointment a WHERE a.appointmentDate >= :start_time and a.appointmentDate <= :end_time and providerNo = :provider_no";
		sql += " and a.demographicNo != 0 and a.status NOT IN (:status_list)";

		List<String> statusList = new ArrayList<String>();
		statusList.add("D");
		statusList.add("S");
		statusList.add("B");

		Query query = entityManager.createQuery(sql);
		query.setParameter("start_time", startTime);
		query.setParameter("end_time", endTime);
		query.setParameter("provider_no", providerNo);
		query.setParameter("status_list", statusList);
		
		if (firstResult != null && firstResult.intValue() >= 0)
			query.setFirstResult(firstResult);
			
		if (maxResults != null && maxResults.intValue() > 0)
			query.setMaxResults(maxResults);
		
		
		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}
	
	public int getCountUnbilledByDateRangeAndProvider(Date startTime, Date endTime, String providerNo) {
		String sql = "SELECT COUNT(a) FROM Appointment a WHERE a.appointmentDate >= :start_time and a.appointmentDate <= :end_time and providerNo = :provider_no";
		sql += " and a.demographicNo != 0 and a.status IN (:status_list)";

		List<String> statusList = new ArrayList<String>();
		statusList.add("P");
		statusList.add("H");
		statusList.add("HS");
		statusList.add("PV");
		statusList.add("PS");
		statusList.add("E");
		statusList.add("ES");
		statusList.add("EV");

		Query query = entityManager.createQuery(sql);
		query.setParameter("start_time", startTime);
		query.setParameter("end_time", endTime);
		query.setParameter("provider_no", providerNo);
		query.setParameter("status_list", statusList);
		

		@SuppressWarnings("unchecked")
		
		Number numRows = (Number)query.getSingleResult();
		
		return numRows.intValue();
	}
	
	public int getCountBilledByDateRangeAndProvider(Date startTime, Date endTime, String providerNo) {
		String sql = "SELECT COUNT(a) FROM Appointment a WHERE a.appointmentDate >= :start_time and a.appointmentDate <= :end_time and providerNo = :provider_no";
		sql += " and a.demographicNo != 0 and a.status NOT IN (:status_list)";

		List<String> statusList = new ArrayList<String>();
		statusList.add("D");
		statusList.add("S");
		statusList.add("B");

		Query query = entityManager.createQuery(sql);
		query.setParameter("start_time", startTime);
		query.setParameter("end_time", endTime);
		query.setParameter("provider_no", providerNo);
		query.setParameter("status_list", statusList);
		

		@SuppressWarnings("unchecked")
		
		Number numRows = (Number)query.getSingleResult();
		
		return numRows.intValue();
	}

	public List<Appointment> getByProviderAndDay(Date date, String providerNo) {
		String sql = "SELECT a FROM Appointment a WHERE a.providerNo=? and a.appointmentDate = ? and a.status != 'N' and a.status != 'C' order by a.startTime";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, providerNo);
		query.setParameter(2, date);
		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}

	public List<Appointment> findByProviderAndDayandNotStatus(String providerNo, Date date, String notThisStatus) {
		String sql = "SELECT a FROM Appointment a WHERE a.providerNo=?1 and a.appointmentDate = ?2 and a.status != ?3";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, providerNo);
		query.setParameter(2, date);
		query.setParameter(3, notThisStatus);

		@SuppressWarnings("unchecked")
		List<Appointment> results = query.getResultList();
		return results;
	}

	public List<Appointment> findByProviderDayAndStatus(String providerNo,Date date, String status) {
		String sql = "SELECT a FROM Appointment a WHERE a.providerNo=? and a.appointmentDate = ? and a.status=?";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, providerNo);
		query.setParameter(2, date);
		query.setParameter(3, status);
		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}

	public List<Appointment> findByDayAndStatus(Date date, String status) {
		String sql = "SELECT a FROM Appointment a WHERE a.appointmentDate = ? and a.status=?";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, date);
		query.setParameter(2, status);
		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}
	
	public Appointment getAppointment(Integer appointmentNo) {

		String sql = "SELECT a FROM Appointment a WHERE a.id = ?";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, appointmentNo);

		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();
		
		if (rs == null || rs.size() == 0)
			return null;

		return rs.get(0);
	}

	public List<Appointment> find(Date date, String providerNo,Date startTime, Date endTime, String name,
			String notes, String reason, Date createDateTime, String creator, Integer demographicNo) {

		String sql = "SELECT a FROM Appointment a " +
				"WHERE a.appointmentDate = ? and a.providerNo=? and a.startTime=?" +
				"and a.endTime=? and a.name=? and a.notes=? and a.reason=? and a.createDateTime=?" +
				"and a.creator=? and a.demographicNo=?";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, date);
		query.setParameter(2, providerNo);
		query.setParameter(3, startTime);
		query.setParameter(4, endTime);
		query.setParameter(5, name);
		query.setParameter(6, notes);
		query.setParameter(7, reason);
		query.setParameter(8, createDateTime);
		query.setParameter(9, creator);
		query.setParameter(10, demographicNo);

		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}

	/**
	 * @return return results ordered by appointmentDate, most recent first
	 */
	public List<Appointment> findByDemographicId(Integer demographicId, int startIndex, int itemsToReturn) {
		String sql = "SELECT a FROM Appointment a WHERE a.demographicNo = ?1 ORDER BY a.appointmentDate desc";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, demographicId);
		query.setFirstResult(startIndex);
		query.setMaxResults(itemsToReturn);

		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}

	public List<Appointment> findAll() {
		String sql = "SELECT a FROM Appointment a";
		Query query = entityManager.createQuery(sql);

		@SuppressWarnings("unchecked")
		List<Appointment> rs = query.getResultList();

		return rs;
	}
	
	@SuppressWarnings("unchecked")
    public List<Appointment> findNonCancelledFutureAppointments(Integer demographicId) {
		Query query = entityManager.createQuery("FROM Appointment appt WHERE appt.demographicNo = :demographicNo AND appt.status NOT LIKE '%C%' " +
				" AND appt.appointmentDate >= CURRENT_DATE ORDER BY appt.appointmentDate");
		query.setParameter("demographicNo", demographicId);
		return query.getResultList();
	}
	
	/**
	 * Finds appointment after current date and time for the specified demographic
	 * 
	 * @param demographicId
	 * 		Demographic to find appointment for
	 * @return
	 * 		Returns the next non-cancelled future appointment or null if there are no appointments
	 * 	scheduled
	 */
	public Appointment findNextAppointment(Integer demographicId) {
		Query query = entityManager.createQuery("FROM Appointment appt WHERE appt.demographicNo = :demographicNo AND appt.status NOT LIKE '%C%' " +
				" AND (appt.appointmentDate > CURRENT_DATE OR (appt.appointmentDate = CURRENT_DATE AND appt.startTime >= CURRENT_TIME)) ORDER BY appt.appointmentDate");
		query.setParameter("demographicNo", demographicId);
		query.setMaxResults(1);
		return getSingleResultOrNull(query);
	}


	public Appointment findDemoAppointmentToday(Integer demographicNo) {
		Appointment appointment = null;

		String sql = "SELECT a FROM Appointment a WHERE a.demographicNo = ? AND a.appointmentDate=DATE(NOW())";
		Query query = entityManager.createQuery(sql);
		query.setParameter(1, demographicNo);

		try {
			appointment = (Appointment) query.getSingleResult();
		} catch (Exception e) {
			MiscUtils.getLogger().info("Couldn't find appointment for demographic " + demographicNo + " today.");
		}

		return appointment;
	}

	public void updateAppointment( Appointment a ) {
        this.merge(a);
    }
}
