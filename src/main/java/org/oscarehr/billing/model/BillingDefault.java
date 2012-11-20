package org.oscarehr.billing.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import org.oscarehr.common.model.AbstractModel;

@Entity
@Table(name="billing_defaults")
public class BillingDefault extends AbstractModel<Integer> {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name="provider_no")
	private String providerNo;

	@Column(name="visit_type_no")
	private String visitTypeNo;

	@Column(name="location_no")
	private String locationNo;
	
	@Column(name="sli_code")
	private String sliCode;
	
	@Column(name="billing_form")
	private String billingFormServiceType;
	
	@Column(name="priority")
	private Integer priority;
	
	@Column(name="sli_only_if_required")
	@Type(type="yes_no")
	private boolean sliOnlyIfRequired;

	public Integer getId() {
    	return id;
    }

	public void setId(Integer id) {
    	this.id = id;
    }

	public String getproviderNo() {
    	return providerNo;
    }

	public void setProviderNo(String providerNo) {
    	this.providerNo = providerNo;
    }

	public String getVisitTypeNo() {
    	return visitTypeNo;
    }

	public void setVisitTypeNo(String visitTypeNo) {
    	this.visitTypeNo = visitTypeNo;
    }

	public String getLocationNo() {
    	return locationNo;
    }

	public void setLocationNo(String locationNo) {
    	this.locationNo = locationNo;
    }
    
    public String getSliCode() {
    	return sliCode;
    }

	public void setSliCode(String sliCode) {
    	this.sliCode = sliCode;
    }
    
    public String getBillingFormServiceType() {
		return billingFormServiceType;
	}
    
    public void setBillingFormServiceType(String billingFormServiceType) {
		this.billingFormServiceType = billingFormServiceType;
	}
    
    public Integer getPriority() {
    	return priority;
    }

	public void setPriority(Integer priority) {
    	this.priority = priority;
    }
    
    public boolean getSliOnlyIfRequired() {
    	return sliOnlyIfRequired;
    }

	public void setSliOnlyIfRequired(boolean sliOnlyIfRequired) {
    	this.sliOnlyIfRequired = sliOnlyIfRequired;
    }


}
