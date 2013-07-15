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

import org.oscarehr.PMmodule.utility.DateTimeFormatUtils;

public class BedCheckTime implements Serializable {

    public static String REF = "BedCheckTime";
    
    private int hashCode = Integer.MIN_VALUE;// primary key

    private Integer id;// fields
    private Integer programId;
    private java.util.Date time;

    public static BedCheckTime create(Integer programId, String time) {
		BedCheckTime bedCheckTime = new BedCheckTime();
		bedCheckTime.setProgramId(programId);
		bedCheckTime.setStrTime(time);
		
		return bedCheckTime;
	}
	

    // constructors
	public BedCheckTime () {
		initialize();
	}

	/**
	 * Constructor for primary key
	 */
	public BedCheckTime (Integer id) {
		this.setId(id);
		initialize();
	}

	/**
	 * Constructor for required fields
	 */
	public BedCheckTime (
		Integer id,
		Integer programId,
		java.util.Date time) {

		this.setId(id);
		this.setProgramId(programId);
		this.setTime(time);
		initialize();
	}

    public String getStrTime() {
		return DateTimeFormatUtils.getStringFromTime(getTime());
	}

	// property adapted for view
	public void setStrTime(String strTime) {
		setTime(DateTimeFormatUtils.getTimeFromString(strTime));
	}

    protected void initialize () {}

    /**
	 * Return the unique identifier of this class
* @hibernate.id
*  generator-class="native"
*  column="bed_check_time_id"
*/
    public Integer getId () {
        return id;
    }

    /**
	 * Set the unique identifier of this class
     * @param id the new ID
     */
    public void setId (Integer id) {
        this.id = id;
        this.hashCode = Integer.MIN_VALUE;
    }

    /**
	 * Return the value associated with the column: program_id
     */
    public Integer getProgramId () {
        return programId;
    }

    /**
	 * Set the value related to the column: program_id
     * @param programId the program_id value
     */
    public void setProgramId (Integer programId) {
        this.programId = programId;
    }

    /**
	 * Return the value associated with the column: time
     */
    public java.util.Date getTime () {
        return time;
    }

    /**
	 * Set the value related to the column: time
     * @param time the time value
     */
    public void setTime (java.util.Date time) {
        this.time = time;
    }

    public boolean equals (Object obj) {
        if (null == obj) return false;
        if (!(obj instanceof BedCheckTime)) return false;
        else {
            BedCheckTime bedCheckTime = (BedCheckTime) obj;
            if (null == this.getId() || null == bedCheckTime.getId()) return false;
            else return (this.getId().equals(bedCheckTime.getId()));
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

    public String toString () {
        return super.toString();
    }
}
