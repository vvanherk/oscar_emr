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

package org.oscarehr.billing.CA.model;

import org.oscarehr.common.model.AbstractModel;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import java.math.BigDecimal;
import java.io.Serializable;
/**
 *
 * @author rjonasz
 */
@Entity
@Table(name="gstControl")
public class GstControl extends AbstractModel<Integer> implements Serializable {
    
    private Integer id;
    private Boolean gstFlag;
    private BigDecimal gstPercent;

    /**
     * @return the gstFlag
     */
    public Boolean getGstFlag() {
        return gstFlag;
    }

    /**
     * @param gstFlag the gstFlag to set
     */
    public void setGstFlag(Boolean gstFlag) {
        this.gstFlag = gstFlag;
    }

    /**
     * @return the gstPercent
     */
    public BigDecimal getGstPercent() {
        return gstPercent;
    }

    /**
     * @param gstPercent the gstPercent to set
     */
    public void setGstPercent(BigDecimal gstPercent) {
        this.gstPercent = gstPercent;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    @Id()
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Integer getId() {
        return id;
    }


}