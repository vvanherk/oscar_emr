/*
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved. *
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
 * 
 *
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */
package org.oscarehr.common.dao;

import java.util.List;
import org.springframework.dao.support.DataAccessUtils;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.oscarehr.common.model.QueueDocumentLink;

/**
 *
 * @author jackson bi
 */

public class QueueDocumentLinkDao extends HibernateDaoSupport {

    public List getQueueFromDocument(Integer docId){
        List queues = this.getHibernateTemplate().find("from QueueDocumentLink where docId = ?",new Object[] {docId});
        return queues;
    }

    public List getDocumentFromQueue(Integer qId){
        List queues = this.getHibernateTemplate().find("from QueueDocumentLink where queueId = ?",new Object[] {qId});
        return queues;
    }

    public boolean hasQueueBeenLinkedWithDocument(Integer dId,Integer qId){
        int count = DataAccessUtils.intResult(getHibernateTemplate().find("select count(*) from QueueDocumentLink where docId = ? and queueId = ? ",new Object[] {dId,qId}));
        if (count > 0){
            return true;
        }
        else
            return false;
    }

    public void addToQueueDocumentLink(Integer qId,Integer dId){
        System.out.println("Add to QueueDocumentLink");
        try{
            if(!hasQueueBeenLinkedWithDocument(dId,qId)){
               QueueDocumentLink qdl = new QueueDocumentLink();
               qdl.setDocId(dId);
               qdl.setQueueId(qId);
               this.getHibernateTemplate().save(qdl);
           }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}