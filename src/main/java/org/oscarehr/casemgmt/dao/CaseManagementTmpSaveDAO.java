/*
* 
* Copyright (c) 2001-2002. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved. *
* This software is published under the GPL GNU General Public License. 
* This program is free software; you can redistribute it and/or 
* modify it under the terms of the GNU General Public License 
* as published by the Free Software Foundation; either version 2 
* of the License, or (at your option) any later version. * 
* This program is distributed in the hope that it will be useful, 
* but WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
* GNU General Public License for more details. * * You should have received a copy of the GNU General Public License 
* along with this program; if not, write to the Free Software 
* Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. * 
* 
* <OSCAR TEAM>
* 
* This software was written for 
* Centre for Research on Inner City Health, St. Michael's Hospital, 
* Toronto, Ontario, Canada 
*/

package org.oscarehr.casemgmt.dao;

import java.util.Date;
import java.util.List;

import org.oscarehr.casemgmt.model.CaseManagementTmpSave;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class CaseManagementTmpSaveDAO extends HibernateDaoSupport {

    public void delete(String providerNo, Long demographicNo, Long programId) {
        List results = this.getHibernateTemplate().find("from CaseManagementTmpSave c where c.providerNo=? and c.demographicNo=? and c.programId=?", new Object[] {providerNo, demographicNo, programId});
        this.getHibernateTemplate().deleteAll(results);
    }

    public CaseManagementTmpSave load(String providerNo, Long demographicNo, Long programId) {
        List results = this.getHibernateTemplate().find("from CaseManagementTmpSave c where c.providerNo=? and c.demographicNo=? and c.programId=? order by c.update_date DESC", new Object[] {providerNo, demographicNo, programId});
        if (!results.isEmpty()) {
            return (CaseManagementTmpSave)results.get(0);
        }

        return null;
    }
    
    public CaseManagementTmpSave load(String providerNo, Long demographicNo, Long programId, Date date) {
        List results = this.getHibernateTemplate().find("from CaseManagementTmpSave c where c.providerNo=? and c.demographicNo=? and c.programId=? and c.update_date > ? order by c.update_date DESC", new Object[] {providerNo, demographicNo, programId, date});
        if (!results.isEmpty()) {
            return (CaseManagementTmpSave)results.get(0);
        }

        return null;
    }

    public void save(CaseManagementTmpSave obj) {
        this.getHibernateTemplate().saveOrUpdate(obj);
    }

}