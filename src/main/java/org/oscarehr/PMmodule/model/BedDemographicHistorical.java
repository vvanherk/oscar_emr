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

package org.oscarehr.PMmodule.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.oscarehr.common.model.Demographic;

public class BedDemographicHistorical implements Serializable {

    public static String REF = "BedDemographicHistorical";
    private int hashCode = Integer.MIN_VALUE;// primary key
    private java.util.Date usageEnd;
    private BedDemographicHistoricalPK id;// fields
    private Bed bed;
    private Demographic demographic;

    public static BedDemographicHistorical create(BedDemographic bedDemographic) {
		BedDemographicHistorical historical = new BedDemographicHistorical();

		historical.setId(BedDemographicHistoricalPK.create(bedDemographic.getId(), bedDemographic.getReservationStart()));
		historical.setUsageEnd(new Date());

		return historical;
	}

    // constructors
	public BedDemographicHistorical () {
		initialize();
	}

    /**
	 * Constructor for primary key
	 */
	public BedDemographicHistorical (org.oscarehr.PMmodule.model.BedDemographicHistoricalPK id) {
		this.setId(id);
		initialize();
	}


    /**
	 * Constructor for required fields
	 */
	public BedDemographicHistorical (
		org.oscarehr.PMmodule.model.BedDemographicHistoricalPK id,
		java.util.Date usageEnd) {

		this.setId(id);
		this.setUsageEnd(usageEnd);
		initialize();
	}

    public void setBed(Bed bed) {
	    this.bed = bed;
    }
	
	public void setDemographic(Demographic demographic) {
		this.demographic = demographic;
	}

	public String getBedName() {
		return bed != null ? bed.getName() : null;
	}
	
	public String getDemographicName() {
		return demographic != null ? demographic.getFormattedName() : null;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

    protected void initialize () {}

    /**
	 * Return the unique identifier of this class
* @hibernate.id
*/
    public BedDemographicHistoricalPK getId () {
        return id;
    }

    /**
	 * Set the unique identifier of this class
     * @param id the new ID
     */
    public void setId (BedDemographicHistoricalPK id) {
        this.id = id;
        this.hashCode = Integer.MIN_VALUE;
    }

    /**
	 * Return the value associated with the column: usage_end
     */
    public java.util.Date getUsageEnd () {
        return usageEnd;
    }

    /**
	 * Set the value related to the column: usage_end
     * @param usageEnd the usage_end value
     */
    public void setUsageEnd (java.util.Date usageEnd) {
        this.usageEnd = usageEnd;
    }

    public boolean equals (Object obj) {
        if (null == obj) return false;
        if (!(obj instanceof BedDemographicHistorical)) return false;
        else {
            BedDemographicHistorical bedDemographicHistorical = (BedDemographicHistorical) obj;
            if (null == this.getId() || null == bedDemographicHistorical.getId()) return false;
            else return (this.getId().equals(bedDemographicHistorical.getId()));
        }
    }

    public int hashCode () {
        if (Integer.MIN_VALUE == this.hashCode) {
            if (null == this.getId()) return super.hashCode();
            else {
                String hashStr = this.getClass().getName() + ":" + this.getId().hashCode();
                this.hashCode = hashStr.hashCode();
            }
        }
        return this.hashCode;
    }
}
