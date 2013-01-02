package org.oscarehr.common.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="spireCommonAccessionNumber")
public class SpireCommonAccessionNumber extends AbstractModel<Integer> {

	@Id
	private Integer id;
	@Column(name="caccn")
	private String caccn;
	@Column(name="uaccn_id")
	private Integer uaccn_id;

	//@Override
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
	
	public Integer getUniqueAccessionId() {
	    return uaccn_id;
    }

	public void setUniqueAccessionId(Integer uaccn_id) {
		this.uaccn_id = uaccn_id;
	}


}
