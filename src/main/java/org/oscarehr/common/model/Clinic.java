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


package org.oscarehr.common.model;

import java.io.Serializable;

import java.util.List;
import java.util.ArrayList;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.PrePersist;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
import javax.persistence.CascadeType;
import javax.persistence.FetchType;

/**
 *
 * @author Jay Gallagher
 */
@Entity
@Table(name="clinic")
public class Clinic extends AbstractModel<Integer> implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="clinic_no")
    private Integer id;
	@Column(name="clinic_name")
    private String clinicName;
	@Column(name="clinic_address")
    private String clinicAddress;
	@Column(name="clinic_city")
    private String clinicCity;
	@Column(name="clinic_postal")
    private String clinicPostal;
	@Column(name="clinic_phone")
    private String clinicPhone;
	@Column(name="clinic_fax")
    private String clinicFax;
	@Column(name="clinic_location_code")
    private String clinicLocationCode;
    private String status;
    @Column(name="clinic_province")
    private String clinicProvince;
    @Column(name="clinic_delim_phone")
    private String clinicDelimPhone;
    @Column(name="clinic_delim_fax")
    private String clinicDelimFax;
    
    @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
    @JoinColumn(name="clinicNo", referencedColumnName="clinic_no")
	private List<Site> sites = new ArrayList<Site>();

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    /** Creates a new instance of UserProperty */
    public Clinic() {
    }

    public String getClinicName() {
        return clinicName;
    }

    public void setClinicName(String clinicName) {
        this.clinicName = clinicName;
    }

    public String getClinicAddress() {
        return clinicAddress;
    }

    public void setClinicAddress(String clinicAddress) {
        this.clinicAddress = clinicAddress;
    }

    public String getClinicCity() {
        return clinicCity;
    }

    public void setClinicCity(String clinicCity) {
        this.clinicCity = clinicCity;
    }

    public String getClinicPostal() {
        return clinicPostal;
    }

    public void setClinicPostal(String clinicPostal) {
        this.clinicPostal = clinicPostal;
    }

    public String getClinicPhone() {
        return clinicPhone;
    }

    public void setClinicPhone(String clinicPhone) {
        this.clinicPhone = clinicPhone;
    }

    public String getClinicFax() {
        return clinicFax;
    }

    public void setClinicFax(String clinicFax) {
        this.clinicFax = clinicFax;
    }

    public String getClinicLocationCode() {
        return clinicLocationCode;
    }

    public void setClinicLocationCode(String clinicLocationCode) {
        this.clinicLocationCode = clinicLocationCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getClinicProvince() {
        return clinicProvince;
    }

    public void setClinicProvince(String clinicProvince) {
        this.clinicProvince = clinicProvince;
    }

    public String getClinicDelimPhone() {
        return clinicDelimPhone;
    }

    public void setClinicDelimPhone(String clinicDelimPhone) {
        this.clinicDelimPhone = clinicDelimPhone;
    }

    public String getClinicDelimFax() {
        return clinicDelimFax;
    }

    public void setClinicDelimFax(String clinicDelimFax) {
        this.clinicDelimFax = clinicDelimFax;
    }
    
    public boolean isNew() {
		return this.getId() == null || this.getId().intValue() <= 0;
	}
	
	public List<Site> getSites() {
		return sites;
	}
	
	public void setSites(List<Site> sites) {
		this.sites = sites;
	}
	
	public void removeSite(Site s) {
		this.sites.remove( s );
	}
	
	public void addSite(Site s) {
		this.sites.add( s );
	}
	
	@PrePersist
    public void prePersist() {
        for ( Site s : sites ) {
            s.setClinic(this);
        }
    }

    public String toString(){
       return "clinicName " +clinicName +
    " clinicAddress  " +clinicAddress+
    " clinicCity " +clinicCity+
    " clinicPostal " +clinicPostal+
    " clinicPhone " +clinicPhone+
    "  clinicFax " +clinicFax+
    " clinicLocationCode " +clinicLocationCode+
    " status " +status+
    " clinicProvince " +clinicProvince+
    " clinicDelimPhone " +clinicDelimPhone+
    " clinicDelimFax " +clinicDelimFax;

    }

}
