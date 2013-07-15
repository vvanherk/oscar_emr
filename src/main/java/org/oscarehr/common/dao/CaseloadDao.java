/**
 * Copyright (c) 2008-2012 Indivica Inc.
 *
 * This software is made available under the terms of the
 * GNU General Public License, Version 2, 1991 (GPLv2).
 * License details are available via "indivica.ca/gplv2"
 * and "gnu.org/licenses/gpl-2.0.html".
 */

package org.oscarehr.common.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.oscarehr.caseload.CaseloadCategory;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class CaseloadDao {

	@PersistenceContext
	protected EntityManager entityManager = null;

	public CaseloadDao() {
		if (caseloadSearchQueries == null) { initializeSearchQueries(); }
		if (caseloadSortQueries == null) { initializeSortQueries(); }
		if (caseloadDemoQueries == null) { initializeDemoQueries(); }
	}

	private static HashMap<String,String> caseloadSearchQueries;

	private static void initializeSearchQueries() {
		caseloadSearchQueries = new HashMap<String, String>();
		caseloadSearchQueries.put("search_notes", "select distinct Z.demographic_no, Z.last_name, Z.first_name FROM (select distinct demographic_no, first_name, last_name, year_of_birth, month_of_birth, date_of_birth, sex from demographic left join demographiccust using (demographic_no) where (provider_no='%s' or cust1='%s' or cust2='%s' or cust4='%s') and patient_status not in ('FI','MO','DE','IN')) as Z INNER JOIN casemgmt_note using (demographic_no) where note like '%s' and locked <> '1'");
		caseloadSearchQueries.put("search_alldemo_rodxfilter", "select distinct demographic_no, last_name, first_name from dxresearch left join demographic using (demographic_no) where dxresearch_code='%s' and status='A' and patient_status not in ('FI','MO','DE','IN') and roster_status='%s'");
		caseloadSearchQueries.put("search_alldemo_dxfilter", "select distinct demographic_no, last_name, first_name from dxresearch left join demographic using (demographic_no) where dxresearch_code='%s' and status='A' and patient_status not in ('FI','MO','DE','IN')");
		caseloadSearchQueries.put("search_alldemo_rofilter", "select demographic_no, last_name, first_name from demographic where patient_status not in ('FI','MO','DE','IN') and roster_status='%s'");
		caseloadSearchQueries.put("search_alldemo_nofilter", "select demographic_no, last_name, first_name from demographic where patient_status not in ('FI','MO','DE','IN')");
		caseloadSearchQueries.put("search_provdemo_rodxfilter", "select distinct demographic_no, last_name, first_name from dxresearch left join demographic using (demographic_no) left join demographiccust using (demographic_no)  where (provider_no='%s' or cust1='%s' or cust2='%s' or cust4='%s')  and patient_status not in ('FI','MO','DE','IN')  and roster_status='%s' and dxresearch_code='%s' and status='A'");
		caseloadSearchQueries.put("search_provdemo_dxfilter", "select distinct demographic_no, last_name, first_name from dxresearch left join demographic using (demographic_no) left join demographiccust using (demographic_no)  where (provider_no='%s' or cust1='%s' or cust2='%s' or cust4='%s')  and patient_status not in ('FI','MO','DE','IN') and dxresearch_code='%s' and status='A'");
		caseloadSearchQueries.put("search_provdemo_rofilter", "select distinct demographic_no, last_name, first_name from demographic left join demographiccust using (demographic_no) where (provider_no='%s' or cust1='%s' or cust2='%s' or cust4='%s') and patient_status not in ('FI','MO','DE','IN') and roster_status='%s'");
		caseloadSearchQueries.put("search_provdemo_nofilter", "select distinct demographic_no, last_name, first_name from demographic left join demographiccust using (demographic_no) where (provider_no='%s' or cust1='%s' or cust2='%s' or cust4='%s') and patient_status not in ('FI','MO','DE','IN')");
	}

	private static HashMap<String,String> caseloadSortQueries;

	private static void initializeSortQueries() {
		caseloadSortQueries = new HashMap<String, String>();
		caseloadSortQueries.put("cl_search_demographic_query", "select demographic_no, last_name, first_name, sex, month_of_birth, date_of_birth, CAST((DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(concat(year_of_birth,month_of_birth,date_of_birth), '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(concat(year_of_birth,month_of_birth,date_of_birth), '00-%m-%d'))) as UNSIGNED INTEGER) as age from demographic");
		caseloadSortQueries.put("cl_search_last_appt", "SELECT p.demographic_no, max(appointment_date) appointment_date FROM appointment p where addtime(appointment_date, start_time) < now() GROUP BY p.demographic_no");
		caseloadSortQueries.put("cl_search_next_appt", "SELECT p.demographic_no, min(appointment_date) appointment_date FROM appointment p where addtime(appointment_date, start_time) > now() GROUP BY p.demographic_no");
		caseloadSortQueries.put("cl_search_num_appts", "select demographic_no, count(1) as count from appointment where appointment_date > curdate() - 365 group by demographic_no");
		caseloadSortQueries.put("cl_search_new_labs", "select demographic_no, count(1) as count from providerLabRouting left join patientLabRouting using (lab_no) where providerLabRouting.lab_type='HL7' and status='N' and provider_no='%s' group by demographic_no");
		caseloadSortQueries.put("cl_search_new_docs", "select demographic_no, count(1) as count from providerLabRouting left join patientLabRouting using (lab_no) where providerLabRouting.lab_type='DOC' and status='N' and provider_no='%s' group by demographic_no");
		caseloadSortQueries.put("cl_search_new_ticklers", "select demographic_no, count(1) as count from tickler where status='A' group by demographic_no");
		caseloadSortQueries.put("cl_search_new_msgs", "select demographic_no, count(1) as count from msgDemoMap left join messagelisttbl on message = messageID where status='new' group by demographic_no");
		caseloadSortQueries.put("cl_search_measurement", "SELECT m.demographicNo as demographic_no, dataField FROM measurements m JOIN (SELECT demographicNo as demographic_no, max(dateObserved) max_date FROM measurements WHERE type='%s' GROUP BY demographic_no) m2 ON m.demographicNo = m2.demographic_no AND m.dateObserved = m2.max_date WHERE type='%s'");
	}

	private static HashMap<String, String> caseloadDemoQueries;

	private static void initializeDemoQueries() {
		caseloadDemoQueries = new HashMap<String, String>();
		caseloadDemoQueries.put("search_rsstatus", "select distinct roster_status from demographic where roster_status not in ('', 'RO', 'NR', 'TE', 'FS')");
		caseloadDemoQueries.put("cl_demographic_query", "select last_name, first_name, sex, month_of_birth, date_of_birth, CAST((DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(concat(year_of_birth,month_of_birth,date_of_birth), '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(concat(year_of_birth,month_of_birth,date_of_birth), '00-%m-%d'))) as UNSIGNED INTEGER) as age from demographic where demographic_no=?");
		caseloadDemoQueries.put("cl_demographic_query_roster", "select last_name, first_name, sex, month_of_birth, date_of_birth, CAST((DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(concat(year_of_birth,month_of_birth,date_of_birth), '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(concat(year_of_birth,month_of_birth,date_of_birth), '00-%m-%d'))) as UNSIGNED INTEGER) as age from demographic where demographic_no=? AND roster_status=?");
		caseloadDemoQueries.put("cl_last_appt", "select max(appointment_date) from appointment where addtime(appointment_date, start_time) < now() and demographic_no=?");
		caseloadDemoQueries.put("cl_next_appt", "select min(appointment_date) from appointment where addtime(appointment_date, start_time) > now() and demographic_no=?");
		caseloadDemoQueries.put("cl_num_appts", "select count(*) from appointment where demographic_no=? and appointment_date > curdate() - 365");
		caseloadDemoQueries.put("cl_new_labs", "select count(*) from providerLabRouting left join patientLabRouting using (lab_no) where providerLabRouting.lab_type='HL7' and status='N' and provider_no=? and demographic_no=?");
		caseloadDemoQueries.put("cl_new_docs", "select count(*) from providerLabRouting left join patientLabRouting using (lab_no) where providerLabRouting.lab_type='DOC' and status='N' and provider_no=? and demographic_no=?");
		caseloadDemoQueries.put("cl_new_ticklers", "select count(*) from tickler where status='A' and demographic_no=?");
		caseloadDemoQueries.put("cl_new_msgs", "select count(*) from msgDemoMap left join messagelisttbl on message = messageID where demographic_no=? and status='new'");
		caseloadDemoQueries.put("cl_measurement", "select dataField from measurements where type=? and demographicNo=? order by dateObserved desc limit 1");

		initializeDemoQueryColumns();
	}

	private static HashMap<String, String[]> caseloadDemoQueryColumns;

	private static void initializeDemoQueryColumns() {
		caseloadDemoQueryColumns = new HashMap<String, String[]>();
		caseloadDemoQueryColumns.put("search_rsstatus", new String[] { "roster_status" } );
		caseloadDemoQueryColumns.put("cl_demographic_query", new String[] { "last_name", "first_name", "sex", "month_of_birth", "date_of_birth", "age" } );
		caseloadDemoQueryColumns.put("cl_demographic_query_roster", new String[] { "last_name", "first_name", "sex", "month_of_birth", "date_of_birth", "age" } );
		caseloadDemoQueryColumns.put("cl_last_appt", new String[] { "max(appointment_date)" } );
		caseloadDemoQueryColumns.put("cl_next_appt", new String[] { "min(appointment_date)" } );
		caseloadDemoQueryColumns.put("cl_num_appts", new String[] { "count(*)" } );
		caseloadDemoQueryColumns.put("cl_new_labs", new String[] { "count(*)" } );
		caseloadDemoQueryColumns.put("cl_new_docs", new String[] { "count(*)" } );
		caseloadDemoQueryColumns.put("cl_new_ticklers", new String[] { "count(*)" } );
		caseloadDemoQueryColumns.put("cl_new_msgs", new String[] { "count(*)" } );
		caseloadDemoQueryColumns.put("cl_measurement", new String[] { "dataField" } );
	}

	@SuppressWarnings("unchecked")
	public List<Integer> getCaseloadDemographicSet(String searchQuery, String[] searchParams, String[] sortParams, CaseloadCategory category, String sortDir, int page, int pageSize) {

		String demoQuery = "";
		String sortQuery = "";
		String query = "";
		if (category == CaseloadCategory.Demographic) {
			demoQuery = String.format(caseloadSearchQueries.get(searchQuery), (Object[])searchParams);
			query = demoQuery + String.format(" ORDER BY last_name %s, first_name %s LIMIT %d, %d", sortDir, sortDir, page * pageSize, pageSize);
		} else if (category == CaseloadCategory.Age) {
			demoQuery = String.format(caseloadSearchQueries.get(searchQuery), (Object[])searchParams);
			int split = demoQuery.indexOf(",", demoQuery.indexOf("demographic_no"));
			query = demoQuery.substring(0,split) + ", CAST((DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(concat(year_of_birth,month_of_birth,date_of_birth), '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(concat(year_of_birth,month_of_birth,date_of_birth), '00-%m-%d'))) as UNSIGNED INTEGER) as age " + demoQuery.substring(split) + String.format(" ORDER BY ISNULL(age) ASC, age %s, last_name %s, first_name %s LIMIT %d, %d", sortDir, sortDir, sortDir, page * pageSize, pageSize);
		} else if (category == CaseloadCategory.Sex) {
			demoQuery = String.format(caseloadSearchQueries.get(searchQuery), (Object[])searchParams);
			int split = demoQuery.indexOf(",", demoQuery.indexOf("demographic_no"));
			query = demoQuery.substring(0,split) + ", sex " + demoQuery.substring(split) + String.format(" ORDER BY sex = '' ASC, sex %s, last_name %s, first_name %s LIMIT %d, %d", sortDir, sortDir, sortDir, page * pageSize, pageSize);
		} else {
			demoQuery = String.format(caseloadSearchQueries.get(searchQuery), (Object[])searchParams);
			sortQuery = sortParams != null ? String.format(caseloadSortQueries.get(category.getQuery()), (Object[])sortParams) : caseloadSortQueries.get(category.getQuery());
			if (category.isMeasurement()) {
				query = String.format("SELECT Y.demographic_no, Y.last_name, Y.first_name, X.%s FROM (%s) as Y LEFT JOIN (%s) as X on Y.demographic_no = X.demographic_no ORDER BY ISNULL(X.%s) ASC, CAST(X.%s as DECIMAL(10,4)) %s, Y.last_name %s, Y.first_name %s LIMIT %d, %d",
						category.getField(), demoQuery, sortQuery, category.getField(), category.getField(), sortDir, sortDir, sortDir, page * pageSize, pageSize);
			} else {
				query = String.format("SELECT Y.demographic_no, Y.last_name, Y.first_name, X.%s FROM (%s) as Y LEFT JOIN (%s) as X on Y.demographic_no = X.demographic_no ORDER BY ISNULL(X.%s) ASC, X.%s %s, Y.last_name %s, Y.first_name %s LIMIT %d, %d",
						category.getField(), demoQuery, sortQuery, category.getField(), category.getField(), sortDir, sortDir, sortDir, page * pageSize, pageSize);
			}
		}
		Query q = entityManager.createNativeQuery(query);

		List<Object[]> result = q.getResultList();

		List<Integer> demographicNoList = new ArrayList<Integer>();
		for (Object[] r : result) {
			demographicNoList.add((Integer) r[0]);
		}

		return demographicNoList;
	}

	public List<Map<String, Object>> getCaseloadDemographicData(String searchQuery, Object[] params) {
		String query = caseloadDemoQueries.get(searchQuery);
		String[] queryColumns = caseloadDemoQueryColumns.get(searchQuery);

		Query q = entityManager.createNativeQuery(query);
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				q.setParameter(i+1, params[i]);
			}
		}

		List<Object> result = q.getResultList();

		List<Map<String, Object>> dataResult = new ArrayList<Map<String, Object>>();

		for (Object r : result) {
			Map<String, Object> row = new HashMap<String, Object>();
			if (r instanceof Object[]) {
				for (int i = 0; i < ((Object[])r).length; i++) {
					row.put(queryColumns[i], ((Object[])r)[i]);
				}
			} else {
				row.put(queryColumns[0], r);
			}
			dataResult.add(row);
		}
		return dataResult;
	}

	@SuppressWarnings("unchecked")
	public Integer getCaseloadDemographicSearchSize(String searchQuery, String[] searchParams) {

		String demoQuery ="";
		String query = "";

		demoQuery = String.format(caseloadSearchQueries.get(searchQuery), (Object[])searchParams);
		query = String.format("SELECT count(1) AS count FROM (%s) AS X", demoQuery);

		Query q = entityManager.createNativeQuery(query);
		List<BigInteger> result = q.getResultList();

		return result.get(0).intValue();
	}
}
