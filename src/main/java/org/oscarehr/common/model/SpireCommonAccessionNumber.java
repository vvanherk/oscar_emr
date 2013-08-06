package org.oscarehr.common.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

@Entity
@Table(name="spireCommonAccessionNumber")
public class SpireCommonAccessionNumber extends AbstractModel<Integer> {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name="caccn")
	private String caccn;
	
	@Column(name="lab_no")
	private Integer lab_no;
	
	@ManyToOne
    @JoinColumn(name="map_id", referencedColumnName="id")
	private SpireAccessionNumberMap map;
	
	@Column(name="order_index")
	private Integer orderIndex;
	

	public Integer getId() {
    	return id;
    }

	public void setId(Integer id) {
    	this.id = id;
    }	
	
    public String getCommonAccessionNumber() {
	    return caccn;
    }

	public void setCommonAccessionNumber(String caccn) {
		this.caccn = caccn;
	}
	
	public Integer getLabNo() {
	    return lab_no;
    }

	public void setLabNo(Integer lab_no) {
		this.lab_no = lab_no;
	}
	
	public String getUniqueAccessionId() {
	    return map.getUniqueAccessionNumber();
    }
    
    public void setAccessionNumberMap(SpireAccessionNumberMap map) {
	    this.map = map;
    }
    
    public Integer getOrderIndex() {
    	return orderIndex;
    }

	public void setOrderIndex(Integer orderIndex) {
    	this.orderIndex = orderIndex;
    }
}
