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
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang.StringUtils;

@Entity
@Table(name = "professionalSpecialists")
public class ProfessionalSpecialist extends AbstractModel<Integer> implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "specId")
	private Integer id;

	@Column(name = "fName")
	private String firstName;

	@Column(name = "lName")
	private String lastName;

	@Column(name = "proLetters")
	private String professionalLetters;

	@Column(name = "address")
	private String streetAddress;

	@Column(name = "phone")
	private String phoneNumber;

	@Column(name = "fax")
	private String faxNumber;

	@Column(name = "website")
	private String webSite;

	@Column(name = "email")
	private String emailAddress;

	@Column(name = "specType")
	private String specialtyType;

	private String eDataUrl;
	private String eDataOscarKey;
	private String eDataServiceKey;
	private String eDataServiceName;
    private String annotation;

    private String referralNo;

	@Temporal(TemporalType.TIMESTAMP)
	private Date lastUpdated=new Date();

	@PreUpdate
	protected void jpaUpdateLastUpdateTime() {
		lastUpdated = new Date();
	}

	@Override
    public Integer getId() {
	    return(id);
    }

	public String getFirstName() {
    	return firstName;
    }

	public void setFirstName(String firstName) {
    	this.firstName = StringUtils.trimToNull(firstName);
    }

	public String getLastName() {
    	return lastName;
    }

	public void setLastName(String lastName) {
    	this.lastName = StringUtils.trimToNull(lastName);
    }

	public String getProfessionalLetters() {
    	return professionalLetters;
    }

	public void setProfessionalLetters(String professionalLetters) {
    	this.professionalLetters = StringUtils.trimToNull(professionalLetters);
    }

	public String getStreetAddress() {
    	return streetAddress;
    }

	public void setStreetAddress(String streetAddress) {
    	this.streetAddress = StringUtils.trimToNull(streetAddress);
    }

	public String getPhoneNumber() {
    	return phoneNumber;
    }

	public void setPhoneNumber(String phoneNumber) {
    	this.phoneNumber = StringUtils.trimToNull(phoneNumber);
    }

	public String getFaxNumber() {
    	return faxNumber;
    }

	public void setFaxNumber(String faxNumber) {
    	this.faxNumber = StringUtils.trimToNull(faxNumber);
    }

	public String getWebSite() {
    	return webSite;
    }

	public void setWebSite(String webSite) {
    	this.webSite = StringUtils.trimToNull(webSite);
    }

	public String getEmailAddress() {
    	return emailAddress;
    }

	public void setEmailAddress(String emailAddress) {
    	this.emailAddress = StringUtils.trimToNull(emailAddress);
    }

	public String getSpecialtyType() {
    	return specialtyType;
    }

	public void setSpecialtyType(String specialtyType) {
    	this.specialtyType = StringUtils.trimToNull(specialtyType);
    }

	public Date getLastUpdated() {
    	return lastUpdated;
    }

	public void setLastUpdated(Date lastUpdated) {
    	this.lastUpdated = lastUpdated;
    }


	public String geteDataUrl() {
    	return eDataUrl;
    }

	public void seteDataUrl(String eDataUrl) {
    	this.eDataUrl = StringUtils.trimToNull(eDataUrl);
    }

	public String geteDataOscarKey() {
    	return eDataOscarKey;
    }

	public void seteDataOscarKey(String eDataOscarKey) {
    	this.eDataOscarKey = StringUtils.trimToNull(eDataOscarKey);
    }

	public String geteDataServiceKey() {
    	return eDataServiceKey;
    }

	public void seteDataServiceKey(String eDataServiceKey) {
    	this.eDataServiceKey = StringUtils.trimToNull(eDataServiceKey);
    }

	public String geteDataServiceName() {
    	return eDataServiceName;
    }

	public void seteDataServiceName(String eDataServiceName) {
    	this.eDataServiceName = StringUtils.trimToNull(eDataServiceName);
    }

    /**
     * @return the annotation
     */
    public String getAnnotation() {
        return annotation;
    }

    /**
     * @param annotation the annotation to set
     */
    public void setAnnotation(String annotation) {
        this.annotation = StringUtils.trimToNull(annotation);
    }

	public void setReferralNo(String referralNo) {
	    this.referralNo = referralNo;
    }

	public String getReferralNo() {
	    return referralNo;
    }

	public String getFormattedName() {
    	return getLastName() + "," + getFirstName();
    }


}
