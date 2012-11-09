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
	private Integer providerNo;

	@Column(name="visit_type_no")
	private Integer visitTypeNo;

	@Column(name="location_no")
	private Integer locationNo;
	
	@Column(name="sli_code")
	private String sliCode;
	
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

	public Integer getproviderNo() {
    	return providerNo;
    }

	public void setProviderNo(Integer providerNo) {
    	this.providerNo = providerNo;
    }

	public int getVisitTypeNo() {
    	return visitTypeNo;
    }

	public void setVisitTypeNo(Integer visitTypeNo) {
    	this.visitTypeNo = visitTypeNo;
    }

	public Integer getLocationNo() {
    	return locationNo;
    }

	public void setLocationNo(Integer locationNo) {
    	this.locationNo = locationNo;
    }
    
    public String getSliCode() {
    	return sliCode;
    }

	public void setSliCode(String sliCode) {
    	this.sliCode = sliCode;
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
