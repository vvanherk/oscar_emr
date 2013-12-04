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


package oscar.oscarRx.data;

import java.util.ArrayList;
import java.util.List;

import org.oscarehr.PMmodule.dao.ProviderDao;
import org.oscarehr.common.dao.ClinicDAO;
import org.oscarehr.common.dao.SiteDao;
import org.oscarehr.common.dao.UserPropertyDAO;
import org.oscarehr.common.model.Clinic;
import org.oscarehr.common.model.Site;
import org.oscarehr.common.model.UserProperty;
import org.oscarehr.util.SpringUtils;
import org.oscarehr.util.MiscUtils;

import oscar.SxmlMisc;

public class RxProviderData {

	private ProviderDao providerDao = (ProviderDao)SpringUtils.getBean("providerDao");
	private UserPropertyDAO userPropertyDao = (UserPropertyDAO)SpringUtils.getBean("UserPropertyDAO");
	private ClinicDAO clinicDao = (ClinicDAO)SpringUtils.getBean("clinicDAO");
	private SiteDao siteDao = (SiteDao)SpringUtils.getBean("siteDao");
	
	public List<Provider> getAllProviders() {
		List<org.oscarehr.common.model.Provider> providers = providerDao.getActiveProviders();
		ArrayList<Provider> results = new ArrayList<Provider>();
		for (org.oscarehr.common.model.Provider p : providers) {
			results.add(convertProvider(p));
		}
		return results;
	}
	
	public Provider getProvider(String providerNo, int clinicNo, int siteId) {
        return convertProvider(providerDao.getProvider(providerNo), clinicNo, siteId);
    }
	
	public Provider getProvider(String providerNo, int clinicNo) {
        return convertProvider(providerDao.getProvider(providerNo), clinicNo, -1);
    }
	
    public Provider getProvider(String providerNo) {
        return getProvider(providerNo, -1, -1);
    }
    
    public Provider convertProvider(org.oscarehr.common.model.Provider p) {
		return convertProvider( p, -1, -1 );
	}
    
    public Provider convertProvider(org.oscarehr.common.model.Provider p, int clinicNo, int siteId) {
    	String surname=null, firstName=null,  clinicName=null, subHeaderName=null, clinicAddress=null, clinicCity=null, clinicPostal=null, clinicPhone=null, clinicFax=null, clinicProvince=null, practitionerNo=null;
    	boolean useFullAddress=true;
        
        if(p != null) {
        	surname = p.getLastName();
        	firstName = p.getFirstName();
        	practitionerNo = p.getPractitionerNo();
        	if(firstName.indexOf("Dr.")<0) {
                firstName = "Dr. " + firstName;
            }
        	
        	if(p.getWorkPhone() != null && p.getWorkPhone().length()>0) {
        		clinicPhone = p.getWorkPhone();
        	}
        	
        	if(p.getComments() != null && p.getComments().length()>0) {
        		String pFax = SxmlMisc.getXmlContent(p.getComments(), "xml_p_fax");
        		if(pFax != null && pFax.length()>0) {
        			clinicFax = pFax;
        		}
        	}
        	
        	if(p.getAddress() != null && p.getAddress().length()>0) {
        		clinicAddress = p.getAddress();
        		useFullAddress=false;
        	}				
        }
        
        // If we specified a valid clinic, set the providers clinic address to this clinic
		Clinic clinic = clinicDao.find(clinicNo);
		//if (clinic == null) {
			// Otherwise, set the providers clinic address to the default clinic
		//	clinic = clinicDao.getClinic();
		//}
		MiscUtils.getLogger().info("CLINIC NO: " + clinicNo);
		if ( clinic != null ) {
			clinicName = clinic.getClinicName();
        	clinicAddress = clinic.getClinicAddress();
        	clinicCity = clinic.getClinicCity();
        	clinicPostal = clinic.getClinicPostal();
        	clinicPhone = clinic.getClinicPhone();
        	clinicProvince = clinic.getClinicProvince();
        	clinicFax = clinic.getClinicFax();
		}
		
		MiscUtils.getLogger().info("SITE ID: " + siteId);
		// If we specified a valid site, set the providers clinic address to this site
		Site site = siteDao.find(siteId);
		
		if ( site != null ) {
			subHeaderName = site.getName();
        	clinicAddress = site.getAddress();
        	clinicCity = site.getCity();
        	clinicPostal = site.getPostal();
        	clinicPhone = site.getPhone();
        	clinicProvince = site.getProvince();
        	clinicFax = site.getFax();
        	
        	MiscUtils.getLogger().info("subHeaderName set to: " + subHeaderName);
		}

		// Override clinic address segments with values from the providers rx address / phone preferences
        UserProperty prop = null;
        
        prop = userPropertyDao.getProp(p.getProviderNo(), "faxnumber");
        if(prop != null && prop.getValue().length()>0) {
        	clinicFax = prop.getValue();
        }
        
        prop = userPropertyDao.getProp(p.getProviderNo(), "rxPhone");
        if(prop != null && prop.getValue().length()>0) {
        	clinicPhone = prop.getValue();
        }
        
        prop = userPropertyDao.getProp(p.getProviderNo(), "rxAddress");
        if(prop != null && prop.getValue().length()>0) {
        	//we're going to override with the preference address
        	clinicAddress = prop.getValue();
        	clinicCity = readProperty(p.getProviderNo(),"rxCity");
        	clinicProvince = readProperty(p.getProviderNo(),"rxProvince");
        	clinicPostal = readProperty(p.getProviderNo(),"rxPostal");
        	useFullAddress=true;
        }

       
        Provider prov =  new Provider(p.getProviderNo(), surname, firstName, clinicName, subHeaderName, clinicAddress,
                clinicCity, clinicPostal, clinicPhone, clinicFax, clinicProvince, practitionerNo);
        if(!useFullAddress)
        	prov.fullAddress=false;
        
        return prov;
    }
    
    private String readProperty(String providerNo, String key) {
    	UserProperty prop = userPropertyDao.getProp(providerNo, key);
        if(prop != null) {
        	return prop.getValue();
        }
        return "";
    }

    public class Provider{
    	boolean fullAddress=true;
    	
        String providerNo;
        String surname;
        String firstName;
        String clinicName;
        String subHeaderName;
        String clinicAddress;
        String clinicCity;
        String clinicPostal;
        String clinicPhone;
        String clinicFax;
        String clinicProvince;
        String practitionerNo;

        public Provider(String providerNo, String surname, String firstName,
        String clinicName, String subHeaderName, String clinicAddress, String clinicCity,
        String clinicPostal, String clinicPhone, String clinicFax, String practitionerNo){
            this.providerNo = providerNo;
            this.surname = surname;
            this.firstName = firstName;
            this.clinicName = clinicName;
            this.subHeaderName = subHeaderName;
            this.clinicAddress = clinicAddress;
            this.clinicCity = clinicCity;
            this.clinicPostal = clinicPostal;
            this.clinicPhone = clinicPhone;
            this.clinicFax = clinicFax;
	    this.practitionerNo = practitionerNo;
        }

        public Provider(String providerNo, String surname, String firstName,
        String clinicName, String subHeaderName, String clinicAddress, String clinicCity,
        String clinicPostal, String clinicPhone, String clinicFax,String clinicProvince, String practitionerNo){
        	this(providerNo,surname,firstName,clinicName,subHeaderName,clinicAddress,clinicCity,clinicPostal,clinicPhone,clinicFax,practitionerNo);
            this.clinicProvince = clinicProvince;
        }


        public String getProviderNo(){
            return this.providerNo;
        }

        public String getSurname(){
            return this.surname;
        }

        public String getFirstName(){
            return this.firstName;
        }
        
        public void setClinicData(Clinic clinic) {
			this.clinicName = clinic.getClinicName();
			this.clinicAddress = clinic.getClinicAddress();
			this.clinicCity = clinic.getClinicCity();
			this.clinicPostal = clinic.getClinicPostal();
			this.clinicPhone = clinic.getClinicPhone();
			this.clinicFax = clinic.getClinicFax();
			this.clinicProvince = clinic.getClinicProvince();
		}

        public String getClinicName(){
            return this.clinicName;
        }
        
        public String getSubHeaderName(){
            return this.subHeaderName;
        }

        public String getClinicAddress(){
            return this.clinicAddress;
        }

        public String getClinicCity(){
            return this.clinicCity;
        }

        public String getClinicPostal(){
            return this.clinicPostal;
        }

        public String getClinicPhone(){
            return this.clinicPhone;
        }

        public String getClinicFax(){
            return this.clinicFax;
        }

        public String getClinicProvince(){
            return this.clinicProvince;
        }

		public String getPractitionerNo() {
		   return this.practitionerNo;
		}
		
		public String getFullAddress() {
			if(fullAddress)
				return (getClinicAddress() + "  " + getClinicCity() + "   " + getClinicProvince() + "  " + getClinicPostal()).trim();
			else
				return getClinicAddress().trim();
		}

    }
}
