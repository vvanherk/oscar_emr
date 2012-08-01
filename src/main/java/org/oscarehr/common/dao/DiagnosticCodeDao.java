package org.oscarehr.common.dao;

import javax.persistence.Query;

import org.oscarehr.common.model.DiagnosticCode;
import org.springframework.stereotype.Repository;

@Repository
public class DiagnosticCodeDao extends AbstractDao<DiagnosticCode>{

	public DiagnosticCodeDao() {
		super(DiagnosticCode.class);
	}
	
	public List<DiagnosticCode> findDiagnosticCodesByCode(String description) {
		Query query = entityManager.createQuery("select dc from DiagnosticCode dc where dc.description like (:description) order by dc.description");
		query.setParameter("description", "%" + description + "%");

		@SuppressWarnings("unchecked")
		List<DiagnosticCode> list = query.getResultList();
		return list;
	}
	
	
	public List<DiagnosticCode> findDiagnosticCodesByDescription(String code) {
		Query query = entityManager.createQuery("select dc from DiagnosticCode dc where dc.diagnostic_code like (:diagnostic_code) order by dc.diagnostic_code");
		query.setParameter("diagnostic_code", code + "%");

		@SuppressWarnings("unchecked")
		List<DiagnosticCode> list = query.getResultList();
		return list;
	}
}
