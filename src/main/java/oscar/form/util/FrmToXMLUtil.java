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
package oscar.form.util;

import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.Vector;

import noNamespace.SitePatientVisitRecordsDocument;

import org.apache.commons.validator.GenericValidator;
import org.apache.xmlbeans.XmlCalendar;
import org.apache.xmlbeans.XmlOptions;
import org.oscarehr.util.MiscUtils;

import oscar.oscarDB.DBHandler;
import oscar.oscarEncounter.oscarMeasurements.bean.EctMeasurementTypesBean;
import oscar.oscarProvider.data.ProviderData;
import oscar.oscarRx.data.RxPatientData;
import oscar.oscarRx.data.RxPrescriptionData;
import oscar.util.UtilDateUtilities;

/*
 * This software was written for the 
 * Compete 3 Project
 * Hamilton 
 * Ontario, Canada 
 */

/**
 *
 * @author  Jay Gallagher
 */
public class FrmToXMLUtil{
   
   /** Creates a new instance of ToCDR */
   public FrmToXMLUtil() {
   }
   
   /**
    * @param args the command line arguments
    */
    public static String convertToXml(Vector measurementTypes, Properties nameProps, Properties dataProps){
             
        // TODO code application logic here            
        String _dateFormat = "yyyy-MM-dd hh:mm:ss";
        String dateEntered = UtilDateUtilities.DateToString(UtilDateUtilities.Today(),_dateFormat);
        ProviderData prData = new ProviderData(dataProps.getProperty("provider_no"));
        String vType = "Other"; //Other
        if(prData.getProvider_type().equalsIgnoreCase("doctor"))
            vType = "FamilyMDVisit"; //FamilyMDVisit
        else if(prData.getProvider_type().equalsIgnoreCase("nurse"))
            vType = "NurseVisit"; //NurseVisit        

        XmlOptions xmlOptions = new XmlOptions();
        xmlOptions.setSavePrettyPrint();      
        xmlOptions.setSavePrettyPrintIndent(3);
        String xmlStr="";
      
        SitePatientVisitRecordsDocument visitDocument = SitePatientVisitRecordsDocument.Factory.newInstance();
        SitePatientVisitRecordsDocument.SitePatientVisitRecords visitRecord = visitDocument.addNewSitePatientVisitRecords();      
        SitePatientVisitRecordsDocument.SitePatientVisitRecords.SitePatientVisit visit  = visitRecord.addNewSitePatientVisit();
        
        visitRecord.setVersion(visitRecord.getVersion());
        
        try{   
            String who = dataProps.getProperty("provider_no");
            String how = "EMR";
            String when = dateEntered;
            
            SitePatientVisitRecordsDocument.SitePatientVisitRecords.SitePatientVisit.SelVisitType visitType = visit.addNewSelVisitType();
            visitType.setValue(vType);
            visitType.setSignedWhen(when);
            visitType.setSignedHow(how);
            visitType.setSignedWho(who);

            visit.setPatientCod(dataProps.getProperty("demographic_no"));
            visit.setVisitCod(dataProps.getProperty("visitCod"));  
            
            Class cls = visit.getClass();
            // Add dob
            Method addNewMethod  = cls.getMethod("addNewDatBirthDate", new Class[] {});
            Object obj = addNewMethod.invoke(visit,new Object[]{});
            String value = dataProps.getProperty("dob");
            value = translate(value, "DatBirthDate");           
            setWhoWhatWhereWhen(obj,how,who,when,value);
            //Add Surname                        
            addNewMethod  = cls.getMethod("addNewTxtSurname", new Class[] {});
            obj = addNewMethod.invoke(visit,new Object[]{});
            value = dataProps.getProperty("surname");
            value = translate(value, "TxtSurname");           
            setWhoWhatWhereWhen(obj,how,who,when,value);
            //Add givien Name                        
            addNewMethod  = cls.getMethod("addNewTxtGivenNames", new Class[] {});
            obj = addNewMethod.invoke(visit,new Object[]{});
            value = dataProps.getProperty("givenName");
            value = translate(value, "TxtGivenNames");           
            setWhoWhatWhereWhen(obj,how,who,when,value);
            //Add Gender                        
            addNewMethod  = cls.getMethod("addNewSelGender", new Class[] {});
            obj = addNewMethod.invoke(visit,new Object[]{});
            value = dataProps.getProperty("gender");
            value = translate(value, "SelGender");           
            setWhoWhatWhereWhen(obj,how,who,when,value);
            
             ///FLU SHOT
            if (getFluShotBillingDate(dataProps.getProperty("demographic_no"))!=null){               
               addNewMethod = cls.getMethod("addNewBFluShotDoneThisSeason", new Class[] {});
               obj = addNewMethod.invoke(visit,new Object[]{});                       
               setWhoWhatWhereWhen(obj,how,who,when,"true");                 
            }
            
                                    
            EctMeasurementTypesBean mt;
            for (int i = 0; i < measurementTypes.size(); i++){        
                mt = (EctMeasurementTypesBean) measurementTypes.elementAt(i);
                String itemName = mt.getType();
                String methodCall = (String) nameProps.get(itemName+"Value");
                MiscUtils.getLogger().debug("method "+methodCall);
                org.apache.commons.validator.GenericValidator gValidator = new org.apache.commons.validator.GenericValidator();
                
                if(mt.getType().equalsIgnoreCase("BP") && !GenericValidator.isBlankOrNull(dataProps.getProperty("SBPValue"))){
                    methodCall = (String) nameProps.get("SBPValue");
                    if (methodCall != null){
                       cls = visit.getClass();

                       addNewMethod  = cls.getMethod("addNew"+methodCall, new Class[] {});

                       obj = addNewMethod.invoke(visit,new Object[]{});

                       value = dataProps.getProperty("SBPValue");

                       setWhoWhatWhereWhen(obj,how,who,when,value);
                    }
                    methodCall = (String) nameProps.get("DBPValue");
                    if (methodCall != null){
                       cls = visit.getClass();

                       addNewMethod  = cls.getMethod("addNew"+methodCall, new Class[] {});

                       obj = addNewMethod.invoke(visit,new Object[]{});

                       value = dataProps.getProperty("DBPValue");

                       setWhoWhatWhereWhen(obj,how,who,when,value);
                    }
                    methodCall = (String) nameProps.get("BPDate");

                    if (methodCall != null){                                       

                       cls = visit.getClass();

                       addNewMethod  = cls.getMethod("addNew"+methodCall, new Class[] {});

                       obj = addNewMethod.invoke(visit,new Object[]{});

                       value = dataProps.getProperty(itemName+"Date");

                       setWhoWhatWhereWhen(obj,how,who,when,value);
                    } 
                    
                }                

                else if (methodCall != null && !GenericValidator.isBlankOrNull(dataProps.getProperty(itemName+"Value"))){                                                                               

                   cls = visit.getClass();

                   addNewMethod  = cls.getMethod("addNew"+methodCall, new Class[] {});

                   obj = addNewMethod.invoke(visit,new Object[]{});

                   value = dataProps.getProperty(itemName+"Value");
                   value = translate(value, methodCall);
                   MiscUtils.getLogger().debug(itemName + " who "+who+" how "+how+ " when "+when+ " value "+value);            
                   setWhoWhatWhereWhen(obj,how,who,when,value);

                   //String date = dataProps.getProperty(itemName+"Date");
                   //setWhoWhatWhereWhen(obj,how,who,when,date);

                    methodCall = (String) nameProps.get(itemName+"Date");

                    if (methodCall != null){                                       

                       cls = visit.getClass();

                       addNewMethod  = cls.getMethod("addNew"+methodCall, new Class[] {});

                       obj = addNewMethod.invoke(visit,new Object[]{});

                       value = dataProps.getProperty(itemName+"Date");

                       setWhoWhatWhereWhen(obj,how,who,when,value);
                    } 
                }
               
            }                                                            
            
            
            //get drug list             
            RxPatientData.Patient p = RxPatientData.getPatient(Integer.parseInt(dataProps.getProperty("demographic_no")==null?"0":dataProps.getProperty("demographic_no")));
            RxPrescriptionData.Prescription[] prescribedDrugs = p.getPrescribedDrugsUnique();            
            for(int i=0; i<prescribedDrugs.length; i++){                
                SitePatientVisitRecordsDocument.SitePatientVisitRecords.SitePatientVisit.SitePatientVisitDrug drug = visit.addNewSitePatientVisitDrug();                
                String atccode = prescribedDrugs[i].getAtcCode().trim();
                if (atccode == null || atccode.equalsIgnoreCase("null") || atccode.equals("")){
                   drug.setDrugCod("NAM_"+prescribedDrugs[i].getDrugName());
                }else{
                   drug.setDrugCod("ATC_"+prescribedDrugs[i].getAtcCode().trim());
                }
                SitePatientVisitRecordsDocument.SitePatientVisitRecords.SitePatientVisit.SitePatientVisitDrug.TxtDrugName drugName = drug.addNewTxtDrugName();                
                drugName.setSignedHow(how);
                drugName.setSignedWho(who);
                drugName.setSignedWhen(when);
                drugName.setValue(prescribedDrugs[i].getDrugName());
            }
            
                        
                                        
        }
        catch(NoSuchMethodException e){
            MiscUtils.getLogger().error("Error", e);
        }
        catch(IllegalAccessException e){
            MiscUtils.getLogger().error("Error", e);
        }
        catch(Exception e){
            MiscUtils.getLogger().error("Error", e);
        }

      xmlStr = xmlStr + visitDocument.xmlText(xmlOptions);
      
      MiscUtils.getLogger().debug("*********************************************************************************");
      MiscUtils.getLogger().debug("************************** XML GENERATED BY OSCAR *******************************");
      MiscUtils.getLogger().debug("*********************************************************************************");
      MiscUtils.getLogger().debug(xmlStr);
      return xmlStr;
   }
   
   
   public static void setWhoWhatWhereWhen(Object obj,String how,String who,String when,String value) throws Exception{
      Class cls = obj.getClass();
      Method setSignedHowMethod = cls.getMethod("setSignedHow",new Class[] {String.class});
      setSignedHowMethod.invoke(obj, new Object[] {how});
      
      Method setSignedWhoMethod = cls.getMethod("setSignedWho",new Class[] {String.class});
      setSignedWhoMethod.invoke(obj, new Object[] {who});
      
      Method setSignedWhenMethod = cls.getMethod("setSignedWhen",new Class[] {String.class});
      setSignedWhenMethod.invoke(obj, new Object[] {when});
      
      setValueType(obj,cls,value);
      
    }
   
   public static int setValueType(Object obj,Class cls,String value) throws Exception{
      int i = 0;
      try{
         Method setValueMethod = cls.getMethod("setValue",new Class[] {String.class});
         setValueMethod.invoke(obj, new Object[] {value} );
         i = 1;
      }catch (NoSuchMethodException noSuchMethod1){}

      try{
         Method setValueMethod = cls.getMethod("setValue",new Class[] {int.class});
         if(value.equalsIgnoreCase(""))
             value="0";
         Integer integer = null;
         try{
            integer = new Integer(value);
         }catch (NumberFormatException nfe) {
            integer = new Integer(""+Math.round( Double.parseDouble(value) ));
         }
         
         setValueMethod.invoke(obj, new Object[] {integer}); 
         i = 2;
      }catch (NoSuchMethodException noSuchMethod1){}
      
      try{
         Method setValueMethod = cls.getMethod("setValue",new Class[] {double.class});
         if(value.equalsIgnoreCase(""))
             value="0";
         Double dbl = new Double(value);
         setValueMethod.invoke(obj, new Object[] {dbl});           
         i = 3;
      }catch (NoSuchMethodException noSuchMethod1){}
      
      try{
         Method setValueMethod = cls.getMethod("setValue",new Class[] {boolean.class});
         i = 4;      
         Boolean bool = new Boolean(value);
         setValueMethod.invoke(obj, new Object[] {bool});               
      }catch (NoSuchMethodException noSuchMethod2){}
      
      try{
         Method setValueMethod = cls.getMethod("setValue",new Class[] {Calendar.class});
         i = 5;
         if(value!=null){
             //DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
             //Date date = (Date)formatter.parse(value);
             Calendar c = new XmlCalendar(value);
             //c.setTime(date);
             setValueMethod.invoke(obj, new Object[] {c});       
         }
         
         //TODO need way to change String Date into a Calendar instance                 
      }catch (NoSuchMethodException noSuchMethod3){}
      
      try{
         Method setValueMethod = cls.getMethod("setValue",new Class[] {Date.class});
         i = 5;
         if(value!=null){
            DateFormat df = DateFormat.getDateInstance();
            Date date = df.parse(value);
            setValueMethod.invoke(obj, new Object[] {date});       
         }
         
      }catch (NoSuchMethodException noSuchMethod3){}
      return i;
   }
   
   private static String translate(String input, String xmlName){
        if(xmlName.startsWith("B")){
            if(input.equalsIgnoreCase("yes")){
                return "true";
            }
            else if(input.equalsIgnoreCase("no"))
                return "false";
        }
        else if (xmlName.startsWith("Sel")){
            if(input.equalsIgnoreCase("yes")){
                return "Present";
            }
            else if(input.equalsIgnoreCase("no")){
                return "Absent";
            } 
            else if(input.equalsIgnoreCase("F")){
                return "Female";
            } 
            else if(input.equalsIgnoreCase("M")){
                return "Male";
            } 
        }
        return input;
            
    }
   
   private static String getFluShotBillingDate(String demoNo) {
        String s = null;
        try {
                String s1 = "select b.billing_no, b.billing_date from billing b, billingdetail bd where b.demographic_no='"
                                + demoNo
                                + "' and bd.billing_no=b.billing_no and (bd.service_code='G590A' or bd.service_code='G591A') "
                                + " and bd.status<>'D' and b.status<>'D' order by b.billing_date desc limit 0,1";
                ResultSet rs = DBHandler.GetSQL(s1);

                if (rs.next())
                        s = oscar.Misc.getString(rs, "billing_date");
                rs.close();
            } catch (SQLException sqlexception) {
                MiscUtils.getLogger().debug(sqlexception.getMessage());
        }
        return s;
    }
          
}
