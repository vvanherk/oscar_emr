/**
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
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
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */


package org.oscarehr.document.model;

import java.io.Serializable;


/**
 * This is an object that contains data related to the ctl_document table.
 * Do not modify this class because it will be overwritten if the configuration file
 * related to this class is modified.
 *
 * @hibernate.class
 *  table="ctl_document"
 */

public  class CtlDocument  implements Serializable {

	public static String REF = "CtlDocument";
	public static String PROP_STATUS = "status";
	public static String PROP_MODULE_ID = "moduleId";
	public static String PROP_ID = "id";


	// constructors
	public CtlDocument () {
		initialize();
	}

	/**
	 * Constructor for primary key
	 */
	public CtlDocument (CtlDocumentPK id) {
		this.setId(id);
		initialize();
	}

	/**
	 * Constructor for required fields
	 */
	public CtlDocument (
		CtlDocumentPK id,
		java.lang.Integer moduleId) {

		this.setId(id);
		this.setModuleId(moduleId);
		initialize();
	}

	protected void initialize () {}



	private int hashCode = Integer.MIN_VALUE;

	// primary key
	private CtlDocumentPK id;

	// fields
	private java.lang.Integer moduleId;
	private java.lang.String status;



	/**
	 * Return the unique identifier of this class
     * @hibernate.id
     */
	public CtlDocumentPK getId () {
		return id;
	}

	/**
	 * Set the unique identifier of this class
	 * @param id the new ID
	 */
	public void setId (CtlDocumentPK id) {
		this.id = id;
		this.hashCode = Integer.MIN_VALUE;
	}




	/**
	 * Return the value associated with the column: module_id
	 */
	public java.lang.Integer getModuleId () {
		return moduleId;
	}

	/**
	 * Set the value related to the column: module_id
	 * @param moduleId the module_id value
	 */
	public void setModuleId (java.lang.Integer moduleId) {
		this.moduleId = moduleId;
	}



	/**
	 * Return the value associated with the column: status
	 */
	public java.lang.String getStatus () {
		return status;
	}

	/**
	 * Set the value related to the column: status
	 * @param status the status value
	 */
	public void setStatus (java.lang.String status) {
		this.status = status;
	}

        
        public boolean isDemographicDocument(){
            if(id.getModule() != null && id.getModule().equals("demographic")){
                return true;
            }
            return false;
        }


	public boolean equals (Object obj) {
		if (null == obj) return false;
		if (!(obj instanceof CtlDocument)) return false;
		else {
			CtlDocument ctlDocument = (CtlDocument) obj;
			if (null == this.getId() || null == ctlDocument.getId()) return false;
			else return (this.getId().equals(ctlDocument.getId()));
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
                String ret = "";
                if (id != null){
                    ret = "doc No: "+id.getDocumentNo()+" module : "+id.getModule();
                    
                }
		ret += "module Id: "+ moduleId+ " status : "+status;
                return ret;
	}


}
