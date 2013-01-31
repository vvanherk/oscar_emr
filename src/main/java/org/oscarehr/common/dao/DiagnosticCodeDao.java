package org.oscarehr.common.dao;

import java.util.List;

import javax.persistence.Query;

import org.oscarehr.common.model.DiagnosticCode;
import org.springframework.stereotype.Repository;

@Repository
public class DiagnosticCodeDao extends AbstractDao<DiagnosticCode>{

	public DiagnosticCodeDao() {
		super(DiagnosticCode.class);
	}
	
	public List<DiagnosticCode> findDiagnosticCodesByDescription(String description) {
		Query query = entityManager.createQuery("select dc from DiagnosticCode dc where dc.description like (:description) order by dc.description");
		query.setParameter("description", "%" + description + "%");

		@SuppressWarnings("unchecked")
		List<DiagnosticCode> list = query.getResultList();
		return list;
	}
	
	
	public List<DiagnosticCode> findDiagnosticCodesByCode(String code) {
		Query query = entityManager.createQuery("select dc from DiagnosticCode dc where dc.diagnosticCode like (:diagnostic_code) order by dc.diagnosticCode");
		query.setParameter("diagnostic_code", code + "%");

		@SuppressWarnings("unchecked")
		List<DiagnosticCode> list = query.getResultList();
		return list;
	}
	
	public List<DiagnosticCode> findDiagnosticCodesByCode(List<String> codes) {
		Query query = entityManager.createQuery("select dc from DiagnosticCode dc where dc.diagnosticCode in (:diagnostic_codes) order by dc.diagnosticCode");
		query.setParameter("diagnostic_codes", codes);

		@SuppressWarnings("unchecked")
		List<DiagnosticCode> list = query.getResultList();
		return list;
	}
}
