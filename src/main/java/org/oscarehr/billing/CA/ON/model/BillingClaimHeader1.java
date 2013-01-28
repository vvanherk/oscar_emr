///*
// *
// * Copyright (c) 2001-2002. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved. *
// * This software is published under the GPL GNU General Public License.
// * This program is free software; you can redistribute it and/or
// * modify it under the terms of the GNU General Public License
// * as published by the Free Software Foundation; either version 2
// * of the License, or (at your option) any later version. *
// * This program is distributed in the hope that it will be useful,
// * but WITHOUT ANY WARRANTY; without even the implied warranty of
// * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License
// * along with this program; if not, write to the Free Software
// * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *
// *
// * <OSCAR TEAM>
// *
// * BillingClaimHeader1.java
// *
// */
//
package org.oscarehr.billing.CA.ON.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.PostPersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

//import javax.validation.constraints.Min;
//import javax.validation.constraints.Max;
//import javax.validation.constraints.Size;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.oscarehr.common.model.AbstractModel;

import oscar.oscarBilling.ca.on.data.BillingDataHlp;

/**
 *
 * @author rjonasz
 */

@Entity
@Table(name = "billing_on_cheader1")
public class BillingClaimHeader1 extends AbstractModel<Integer> implements Serializable {

    private Integer id;
    private Integer header_id = 0;
    private String transc_id = BillingDataHlp.CLAIMHEADER1_TRANSACTIONIDENTIFIER;
    private String rec_id = BillingDataHlp.CLAIMHEADER1_REORDIDENTIFICATION;
    private String hin;
    private String ver;
    private String dob;
    private String pay_program;
    private String payee = BillingDataHlp.CLAIMHEADER1_PAYEE;
    private String ref_num = "";
    private String facilty_num;
    private String admission_date = "";
    private String ref_lab_num = "";
    private String man_review = "";
    private String location;
    private Integer demographic_no;
    private String provider_no;
    private String appointment_no = "0";
    private String demographic_name;
    private String sex;
    private String province;
    private Date billing_date;
    private Date billing_time;
    private String total = "";
    private String paid = "";
    private String status = "O";
    private String comment1 = "";
    private String visittype = "00";
    private String provider_ohip_no;
    private String provider_rma_no;
    private String apptProvider_no = "";
    private String asstProvider_no = "";
    private String creator;
    private Date timestamp1;
    private String clinic;

    private List<BillingItem> billingItems = new ArrayList<BillingItem>();

    /** Creates a new instance of BillingClaimHeader1 */
    public BillingClaimHeader1() {
        //this.setLocation(properties.getProperty("clinic_no", ""));
        //this.setFacilty_num( "0000" );
        //this.setSex("U");
    }
    
    /**
	 * Method copy
	 * Performs a deep copy of the given BillingClaimHeader1 and returns the new copy.  The id
	 * of the given object is not copied.
	 * 
	 * @param item The BillingClaimHeader1 object that we want to copy
	 * 
	 * @return A new BillingClaimHeader1 object with identical values to the provided BillingClaimHeader1 object (except for the id)
	 */
    public static BillingClaimHeader1 copy(BillingClaimHeader1 bill) {
		BillingClaimHeader1 bill2 = new BillingClaimHeader1();
		bill2.header_id = new Integer( bill.getHeader_id() );
		bill2.transc_id = new String( bill.getTransc_id() );
		bill2.rec_id = new String( bill.getRec_id() );
		bill2.hin = new String( bill.getHin() );
		bill2.ver = new String( bill.getVer() );
		bill2.dob = new String( bill.getDob() );
		bill2.pay_program = new String( bill.getPay_program() );
		bill2.payee = new String( bill.getPayee() );
		bill2.ref_num = new String( bill.getRef_num() );
		bill2.facilty_num = new String( bill.getFacilty_num() );
		bill2.admission_date = new String( bill.getAdmission_date() );
		bill2.ref_lab_num = new String( bill.getRef_lab_num() );
		bill2.man_review = new String( bill.getMan_review() );
		
		bill2.location = new String( bill.getLocation() );
		bill2.demographic_no = new Integer( bill.getDemographic_no() );
		bill2.provider_no = new String( bill.getProvider_no() );
		bill2.appointment_no = new String( bill.getAppointment_no() );
		
		bill2.demographic_name = new String( bill.getDemographic_name() );
		bill2.sex = new String( bill.getSex() );
		bill2.province = new String( bill.getProvince() );
		bill2.billing_date = new Date( bill.getBilling_date().getTime() );
		bill2.billing_time = new Date( bill.getBilling_time().getTime() );
		bill2.total = new String( bill.getTotal() );
		bill2.paid = new String( bill.getPaid() );
		
		bill2.status = new String( bill.getStatus() );
		bill2.comment1 = new String( bill.getComment1() );
		bill2.visittype = new String( bill.getVisittype() );
		bill2.provider_ohip_no = new String( bill.getProvider_ohip_no() );
		bill2.provider_rma_no = new String( bill.getProvider_rma_no() );
		bill2.apptProvider_no = new String( bill.getApptProvider_no() );
		bill2.asstProvider_no = new String( bill.getAsstProvider_no() );
		
		bill2.creator = new String( bill.getCreator() );
		bill2.timestamp1 = new Date( bill.getTimestamp1().getTime() );
		bill2.clinic = new String( bill.getClinic() == null ? "" : bill.getClinic() );
		
		List<BillingItem> items = bill.getBillingItems();
		List<BillingItem> billingItems = bill2.getBillingItems();
		for (BillingItem item : items) {
			BillingItem newItem = BillingItem.copy(item);
			billingItems.add(newItem);
		}
		
		return bill2;
    }

    @Override
    @Id()
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setRec_id(String id) {
        this.rec_id = id;
    }

    @Column(length = 1)
    public String getRec_id() {
        return rec_id;
    }

    public String getTransc_id() {
        return this.transc_id;
    }

    public void setTransc_id(String id) {
        this.transc_id = id;
    }

    public int getHeader_id() {
        return this.header_id;
    }

    public void setHeader_id(int id) {
        this.header_id = id;
    }

    public void setHin(String hin) {
        this.hin = hin;
    }

    @Column(length = 10)
    public String getHin() {
        return hin;
    }

    @Column(length=2)
    public String getVer() {
        return ver;
    }

    public void setVer(String ver) {
        this.ver = ver;
    }

    @Column(length=8)
    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    @Column(length=3)
    public String getPay_program() {
        return pay_program;
    }

    public void setPay_program(String pay) {
        this.pay_program = pay;
    }

    @Column(length=1)
    public String getPayee() {
        return payee;
    }

    public void setPayee(String payee) {
        this.payee = payee;
    }

    @Column(length=6)
    public String getRef_num() {
        return ref_num;
    }

    public void setRef_num(String ref_num) {
        this.ref_num = ref_num;
    }

    @Column(length=4)
    public String getFacilty_num() {
        return this.facilty_num;
    }

    public void setFacilty_num(String facility_num) {
        this.facilty_num = facility_num;
    }

    @Column(length=10)
    @Pattern(regexp = "(\\d\\d\\d\\d-\\d\\d-\\d\\d|)", message="Admission date must be in the format yyyy-mm-dd.")
    public String getAdmission_date() {
        return admission_date;
    }

    public void setAdmission_date(String admission_date) {
        this.admission_date = admission_date;
    }

    @Column(length=4)
    public String getRef_lab_num() {
        return ref_lab_num;
    }

    public void setRef_lab_num(String ref_lab_num) {
        this.ref_lab_num = ref_lab_num;
    }

    @Column(length=1)
    public String getMan_review() {
        return man_review;
    }

    public void setMan_review(String man_review) {
        this.man_review = man_review;
    }

    @Column(length=4)
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

	@NotNull(message="Demographic No must be specified.")
    public Integer getDemographic_no() {
        return demographic_no;
    }

    public void setDemographic_no(Integer demographic_no) {
        this.demographic_no = demographic_no;
    }

    @Column(length=1)
    public String getSex() {
        return this.sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Column(length=2)
    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Temporal(TemporalType.DATE)
    public Date getBilling_date() {
        return billing_date;
    }

    public void setBilling_date(Date date) {
        this.billing_date = date;
    }

    @Temporal(TemporalType.TIME)
    public Date getBilling_time() {
        return billing_time;
    }

    public void setBilling_time(Date time) {
        this.billing_time = time;
    }
	
	@Pattern(regexp = "\\d*(\\.|)\\d*", message="Total amount must be a numeric value (i.e. 100.00, 32.6, 50, etc).")
    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

	@Pattern(regexp = "\\d*(\\.|)\\d*", message="Paid amount must be a numeric value (i.e. 100.00, 32.6, 50, etc).")
    public String getPaid() {
        return paid;
    }

    public void setPaid(String paid) {
        this.paid = paid;
    }

    @Column(length=1)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getComment1() {
        return comment1;
    }

    public void setComment1(String comment) {
        this.comment1 = comment;
    }

    @Column(length=2)
    public String getVisittype() {
        return visittype;
    }

    public void setVisittype(String visittype) {
        this.visittype = visittype;
    }

    public String getProvider_ohip_no() {
        return provider_ohip_no;
    }

    public void setProvider_ohip_no(String provider_ohip_no) {
        this.provider_ohip_no = provider_ohip_no;
    }

    public String getProvider_rma_no() {
        return provider_rma_no;
    }

    public void setProvider_rma_no(String provider_rma_no) {
        this.provider_rma_no = provider_rma_no;
    }

    /**
     * @return the apptProvider_no
     */
    @Column(length=6)
    public String getApptProvider_no() {
        return apptProvider_no;
    }

    /**
     * @param apptProvider_no the apptProvider_no to set
     */
    public void setApptProvider_no(String apptProvider_no) {
        this.apptProvider_no = apptProvider_no;
    }

    /**
     * @return the asstProvider_no
     */
    @Column(length=6)
    public String getAsstProvider_no() {
        return asstProvider_no;
    }

    /**
     * @param asstProvider_no the asstProvider_no to set
     */
    public void setAsstProvider_no(String asstProvider_no) {
        this.asstProvider_no = asstProvider_no;
    }

    /**
     * @return the creator
     */
    @Column(length=6)
    public String getCreator() {
        return creator;
    }

    /**
     * @param creator the creator to set
     */
    public void setCreator(String creator) {
        this.creator = creator;
    }

    /**
     * @return the timestamp1
     */
    @Temporal(TemporalType.TIMESTAMP)
    public Date getTimestamp1() {
        return timestamp1;
    }

    /**
     * @param timestamp1 the timestamp1 to set
     */
    public void setTimestamp1(Date timestamp1) {
        this.timestamp1 = timestamp1;
    }

    /**
     * @return the clinic
     */
    public String getClinic() {
        return clinic;
    }

    /**
     * @param clinic the clinic to set
     */
    public void setClinic(String clinic) {
        this.clinic = clinic;
    }

    /**
     * @return the billingItems
     */
    @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
    @JoinColumn(name="ch1_id", referencedColumnName="id")
    public List<BillingItem> getBillingItems() {
        return billingItems;
    }

    /**
     * @param billingItems the billingItems to set
     */
    public void setBillingItems(List<BillingItem> billingItems) {
        this.billingItems = billingItems;
    }

    /**
     * @return the provider_no
     */
	@NotNull(message="Provider No must be specified.")
    public String getProvider_no() {
        return provider_no;
    }

    /**
     * @param provider_no the provider_no to set
     */
    public void setProvider_no(String provider_no) {
        this.provider_no = provider_no;
    }

    /**
     * @return the appointment_no
     */
    public String getAppointment_no() {
        return appointment_no;
    }

    /**
     * @param appointment_no the appointment_no to set
     */
    public void setAppointment_no(String appointment_no) {
        this.appointment_no = appointment_no;
    }

    /**
     * @return the demographic_name
     */
    public String getDemographic_name() {
        return demographic_name;
    }

    /**
     * @param demographic_name the demographic_name to set
     */
    public void setDemographic_name(String demographic_name) {
        this.demographic_name = demographic_name;
    }

    @PostPersist
    public void postPersist() {        
        Iterator<BillingItem> i = this.billingItems.iterator();
        BillingItem item;
        while(i.hasNext()) {
            item = i.next();
            item.setCh1_id(id);           
        }
    }
    
    /*
     * Filter deleted billing items from list
     */
    @Transient
    public List<BillingItem> getNonDeletedInvoices() {
    	List<BillingItem>tempItems = new ArrayList<BillingItem>();
    	
    	Iterator<BillingItem> i = this.billingItems.iterator();
        BillingItem item;
        while(i.hasNext()) {
        	item = i.next();        	
        	if( !item.getStatus().equals("D")) {
        		tempItems.add(item);
        	}        	        	
        }
        
        return tempItems;
    }
}
