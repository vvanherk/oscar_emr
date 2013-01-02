package org.oscarehr.common.model;

import java.util.List;
import java.util.Iterator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.OneToMany;
import javax.persistence.PostPersist;
import javax.persistence.JoinColumn;
import javax.persistence.CascadeType;
import javax.persistence.FetchType;

@Entity
@Table(name="spireAccessionNumberMap")
public class SpireAccessionNumberMap extends AbstractModel<Integer> {

	@Id
	private Integer id;
	@Column(name="uaccn")
	private String uaccn;
	
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
    @JoinColumn(name="uaccn_id", referencedColumnName="id")
	private List<SpireCommonAccessionNumber> commonAccessionNumbers;

	//@Override
	public Integer getId() {
    	return id;
    }

	public void setId(Integer id) {
    	this.id = id;
    }	
	
	public String getUniqueAccessionNumber() {
	    return uaccn;
    }

	public void setUniqueAccessionNumber(String uaccn) {
		this.uaccn = uaccn;
	}
	
	public List<SpireCommonAccessionNumber> getCommonAccessionNumbers() {
	    return commonAccessionNumbers;
    }
    
    @PostPersist
    public void postPersist() {        
        Iterator<SpireCommonAccessionNumber> i = this.commonAccessionNumbers.iterator();
        SpireCommonAccessionNumber commonAccessionNumber;
        while(i.hasNext()) {
            commonAccessionNumber = i.next();
            commonAccessionNumber.setUniqueAccessionId(id);         
        }
    }

}
