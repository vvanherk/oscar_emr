package org.oscarehr.common.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="providerSpireIdMap")
public class ProviderSpireIdMap extends AbstractModel<Integer> {

	@Column(name="spire_id")
	@Id
	private Integer spire_id;
	@Column(name="ohip_no")
	private String ohip_no;

	//@Override
	public Integer getId() {
    	return spire_id;
    }

	public void setId(Integer id) {
    	this.spire_id = id;
    }	
	
    public Integer getSpireId() {
	    return spire_id;
    }

	public void setSpireId(Integer id) {
		this.spire_id = id;
	}
	
	public String getOhipNo() {
	    return ohip_no;
    }

	public void setOhipNo(String id) {
		this.ohip_no = id;
	}


}
