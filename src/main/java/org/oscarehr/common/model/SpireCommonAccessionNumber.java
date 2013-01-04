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
	@ManyToOne
    @JoinColumn(name="uaccn_id", referencedColumnName="uaccn")
	private SpireAccessionNumberMap accnMap;

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
	    return accnMap.getUniqueAccessionNumber();
    }

	public void setSpireAccessionNumberMap(SpireAccessionNumberMap accnMap) {
		this.accnMap = accnMap;
	}


}
