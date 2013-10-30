package org.oscarehr.common.model;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.PrePersist;
import javax.persistence.JoinColumn;
import javax.persistence.CascadeType;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="officeCommunication")
public class OfficeCommunication extends AbstractModel<Integer> {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name="appointment_no")
	private Integer appointmentNo;
	
	@Column(name="demographic_no")
	private Integer demographicNo;
	
	@Column(name="note")
	private String note;
	
	@Column(name="signed")
	private Boolean signed;
	
	@Column(name="create_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createDate;
	
	@Column(name="update_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date updateDate = new Date();
	
	

	public OfficeCommunication() {
	}

	public Integer getId() {
    	return id;
    }

	public void setId(Integer id) {
    	this.id = id;
    }	
	
	public Integer getAppointmentNo() {
	    return appointmentNo;
    }

	public void setAppointmentNo(Integer appointmentNo) {
		this.appointmentNo = appointmentNo;
	}
    
    public Integer getDemographicNo() {
	    return demographicNo;
    }

	public void setDemographicNo(Integer demographicNo) {
		this.demographicNo = demographicNo;
	}
	
	public String getNote() {
	    return note;
    }

	public void setNote(String note) {
		this.note = note;
	}
	
	public Boolean getSigned() {
	    return signed;
    }

	public void setSigned(Boolean signed) {
		this.signed = signed;
	}
	
	public Date getCreateDate() {
	    return createDate;
    }

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public Date getUpdateDate() {
	    return updateDate;
    }

	public void setNote(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	@PrePersist
	public void prePersist() {
		if (createDate == null)
			createDate = new Date();
		
		updateDate = new Date();
	}

}
