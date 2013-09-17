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
package org.oscarehr.common.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name="consultationreport")
public class ConsultationReport extends AbstractModel<Integer>{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="request_id")
	private Integer id;
	
	@Temporal(TemporalType.DATE)
	private Date date = new Date();
	
	@Column(name="referal_id")
	private Integer referralId;
	
	private Integer appointmentNo = 0;
	
	@Column(name="appointment_date")
	@Temporal(TemporalType.DATE)
	private Date appointmentDate;
	
	@Column(name="appointment_time")
	@Temporal(TemporalType.TIME)
	private Date appointmentTime;
	
	@Column(name="cc_text")
	private String ccText;
	
	private String reason;
	
	@Column(name="clinical_info")
	private String clinicalInfo;
	
	@Column(name="current_meds")
	private String currentMeds;
	
	@Column(name="allergies")
	private String allergies;
	
	private String provider;
	
	private Integer demographicNo;
	
	private String status;
	
	@Column(name="status_text")
	private String statusText;
	
	@Column(name="sendto")
	private String sendTo;
	
	@Column(name="examination")
	private String examination;
	
	@Column(name="concurrentproblems")
	private String concurrentProblems;
	
	@Column(name="impression")
	private String impression;
	
	private String plan;
	
	@Column(name="con_type")
	private String conType = "";
	
	@Column(name="con_memo")
	private String conMemo;
	
	@Column(name="urgency")
	private String urgency;
	
	@Column(name="patient_will_book")
	private Boolean patientWillBook;
	
	private int greeting;

	@Transient
	private Demographic demographic;
	
	
	public Demographic getDemographic() {
		return demographic;
	}

	public void setDemographic(Demographic demographic) {
		this.demographic = demographic;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getReferralId() {
		return referralId;
	}

	public void setReferralId(Integer referralId) {
		this.referralId = referralId;
	}

	public Integer getAppointmentNo() {
		return appointmentNo;
	}

	public void setAppointmentNo(Integer appointmentNo) {
		this.appointmentNo = appointmentNo;
	}

	public Date getAppointmentDate() {
		return appointmentDate;
	}

	public void setAppointmentDate(Date appointmentDate) {
		this.appointmentDate = appointmentDate;
	}

	public Date getAppointmentTime() {
		return appointmentTime;
	}

	public void setAppointmentTime(Date appointmentTime) {
		this.appointmentTime = appointmentTime;
	}

	public String getCcText() {
		return ccText;
	}

	public void setCcText(String ccText) {
		this.ccText = ccText;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getClinicalInfo() {
		return clinicalInfo;
	}

	public void setClinicalInfo(String clinicalInfo) {
		this.clinicalInfo = clinicalInfo;
	}

	public String getCurrentMeds() {
		return currentMeds;
	}

	public void setCurrentMeds(String currentMeds) {
		this.currentMeds = currentMeds;
	}

	public String getAllergies() {
		return allergies;
	}

	public void setAllergies(String allergies) {
		this.allergies = allergies;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public Integer getDemographicNo() {
		return demographicNo;
	}

	public void setDemographicNo(Integer demographicNo) {
		this.demographicNo = demographicNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatusText() {
		return statusText;
	}

	public void setStatusText(String statusText) {
		this.statusText = statusText;
	}

	public String getSendTo() {
		return sendTo;
	}

	public void setSendTo(String sendTo) {
		this.sendTo = sendTo;
	}

	public String getExamination() {
		return examination;
	}

	public void setExamination(String examination) {
		this.examination = examination;
	}

	public String getConcurrentProblems() {
		return concurrentProblems;
	}

	public void setConcurrentProblems(String concurrentProblems) {
		this.concurrentProblems = concurrentProblems;
	}

	public String getImpression() {
		return impression;
	}

	public void setImpression(String impression) {
		this.impression = impression;
	}

	public String getPlan() {
		return plan;
	}

	public void setPlan(String plan) {
		this.plan = plan;
	}

	public String getConType() {
		return conType;
	}

	public void setConType(String conType) {
		this.conType = conType;
	}

	public String getConMemo() {
		return conMemo;
	}

	public void setConMemo(String conMemo) {
		this.conMemo = conMemo;
	}

	public String getUrgency() {
		return urgency;
	}

	public void setUrgency(String urgency) {
		this.urgency = urgency;
	}

	public Boolean getPatientWillBook() {
		return patientWillBook;
	}

	public void setPatientWillBook(Boolean patientWillBook) {
		this.patientWillBook = patientWillBook;
	}

	public int getGreeting() {
		return greeting;
	}

	public void setGreeting(int greeting) {
		this.greeting = greeting;
	}
	
	
}