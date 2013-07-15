/**
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
 * This software is published under the GPL GNU General Public License.
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version. 
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */


/*
 * RxPharmacyData.java
 *
 * Created on September 29, 2004, 3:41 PM
 */

package oscar.oscarRx.data;

import java.util.List;

import org.oscarehr.common.dao.DemographicPharmacyDao;
import org.oscarehr.common.dao.PharmacyInfoDao;
import org.oscarehr.common.model.DemographicPharmacy;
import org.oscarehr.common.model.PharmacyInfo;
import org.oscarehr.util.SpringUtils;

/**
 *
 * @author  Jay Gallagher
 *
 *
 */
public class RxPharmacyData {

	private PharmacyInfoDao pharmacyInfoDao = (PharmacyInfoDao)SpringUtils.getBean(PharmacyInfoDao.class);
	private DemographicPharmacyDao demographicPharmacyDao = (DemographicPharmacyDao)SpringUtils.getBean(DemographicPharmacyDao.class);

   /** Creates a new instance of RxPharmacyData */
   public RxPharmacyData() {
   }


   /**
    * Used to add a new pharmacy
    * @param name
    * @param address
    * @param city
    * @param province
    * @param postalCode
    * @param phone1
    * @param phone2
    * @param fax
    * @param email
    * @param notes
    */
   synchronized public void addPharmacy(String name,String address,String city,String province,String postalCode, String phone1, String phone2, String fax, String email,String serviceLocationIdentifier, String notes){
	   pharmacyInfoDao.addPharmacy(name, address, city, province, postalCode, phone1, phone2, fax, email, serviceLocationIdentifier, notes);
   }


   /**
    * Used to update an new pharmacy.  Creates a new record for this pharmacy with the same pharmacyID
    * @param ID pharmacy ID
    * @param name
    * @param address
    * @param city
    * @param province
    * @param postalCode
    * @param phone1
    * @param phone2
    * @param fax
    * @param email
    * @param notes
    */
   public void updatePharmacy(String ID,String name,String address,String city,String province,String postalCode, String phone1, String phone2, String fax, String email, String serviceLocationIdentifier, String notes){
		pharmacyInfoDao.updatePharmacy(ID, name, address, city, province, postalCode, phone1, phone2, fax, email, serviceLocationIdentifier, notes);
   }

   /**
    * set the status of the pharmacy to 0, this will not be found in the getAllPharmacy queries
    * @param ID
    */
   public void deletePharmacy(String ID){
	   pharmacyInfoDao.deletePharmacy(ID);
   }

   /**
    * Returns the latest data about a pharmacy.
    * @param ID pharmacy id
    * @return returns a pharmacy class corresponding latest data from the pharmacy ID
    */
   public PharmacyInfo getPharmacy(String ID){
      PharmacyInfo pharmacyInfo = pharmacyInfoDao.getPharmacy(ID);
      return pharmacyInfo;
   }

   /**
    * Returns the data about a pharmacy record.  This would be used to see prior addresses or phone numbers of a pharmacy.
    * @param recordID pharmacy Record ID
    * @return Pharmacy data class
    */
   public PharmacyInfo getPharmacyByRecordID(String recordID){
      return pharmacyInfoDao.getPharmacyByRecordID(recordID);
   }


   /**
    * Used to get a list of all the active pharmacies with their latest data
    * @return ArrayList of Pharmacy classes
    */
   public List<PharmacyInfo> getAllPharmacies(){
      return pharmacyInfoDao.getAllPharmacies();
   }

   /**
    * Used to link a patient with a pharmacy.
    * @param pharmacyId Id of the pharmacy
    * @param demographicNo Patient demographic number
    */
   public void addPharmacyToDemographic(String pharmacyId,String demographicNo){
      demographicPharmacyDao.addPharmacyToDemographic(pharmacyId, demographicNo);
   }

   /**
    * Used to get the most recent pharmacy associated with this patient.  Returns a Pharmacy object with the latest data about that pharmacy.
    * @param demographicNo patients demographic number
    *
    * @return Pharmacy data object
    */
   public PharmacyInfo getPharmacyFromDemographic(String demographicNo){
	   DemographicPharmacy dp = demographicPharmacyDao.findByDemographicId(demographicNo);
	   if(dp != null) {
		   return pharmacyInfoDao.getPharmacy(String.valueOf(dp.getPharmacyId()));
	   }
	   return null;
   }
}
