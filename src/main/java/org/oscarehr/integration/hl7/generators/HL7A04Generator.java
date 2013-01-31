package org.oscarehr.integration.hl7.generators;

import org.oscarehr.common.model.Demographic;

import org.oscarehr.common.hl7.v2.HL7A04Data;

import org.oscarehr.util.MiscUtils;
import org.apache.log4j.Logger;


public class HL7A04Generator {
	
	Logger logger = MiscUtils.getLogger();
	
	public HL7A04Generator() {
	}
	
	/**
      * method generateHL7A04
      * 
      * Creates an HL7 A04 object, and then saves it to the disk.
      * 
      * @param demo The Demographic object used to create the HL7 A04 object.
      */ 
     public void generateHL7A04(Demographic demo) {
		try {
			// generate A04 HL7
			HL7A04Data A04Obj = new HL7A04Data(demo);
			A04Obj.save();
		} catch (Exception e) {
			logger.error("Unable to generate HL7 A04 file", e);
		}
	 }
}
