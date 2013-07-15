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


package oscar.oscarEncounter.oscarMeasurements;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import org.apache.log4j.Logger;
import org.oscarehr.util.MiscUtils;

import oscar.oscarEncounter.oscarMeasurements.bean.EctMeasurementsDataBean;
import oscar.oscarEncounter.oscarMeasurements.bean.EctMeasurementsDataBeanHandler;

/**
 *
 * @author jay
 */
public class MeasurementInfo {
    private static Logger log = MiscUtils.getLogger();

    ArrayList<String> warning = null;
    Hashtable<String,String> warningHash = new Hashtable<String,String>();
    ArrayList<String> recommendations = null;
    Hashtable<String,String> recommendationHash = new Hashtable<String,String>();

    ArrayList measurementList = new ArrayList();
    Hashtable measurementHash = new Hashtable();
    ArrayList itemList = new ArrayList();
    String demographicNo = "";
    /** Creates a new instance of MeasurementInfo */
    public MeasurementInfo(String demographic) {
        demographicNo = demographic;
    }

    public ArrayList getList(){
        ArrayList<String> list = new ArrayList<String>();

        Enumeration<String> e = warningHash.keys();
        while (e.hasMoreElements()){
            list.add(e.nextElement());
        }

        e = recommendationHash.keys();
        while (e.hasMoreElements()){
            list.add(e.nextElement());
        }

        return list;
    }

    public void log(String logMessage){
        log.debug(logMessage);
    }

    public ArrayList getWarnings(){
        if (warning == null){
           warning = new ArrayList();
        }
        return warning;
    }

    public ArrayList getRecommendations(){
        if (recommendations == null){
           recommendations = new ArrayList();
        }
        return recommendations;
    }

    public void setDemographic(String demographic){
        demographicNo = demographic;
    }

    /** Creates a new instance of MeasurementInfo */
    public MeasurementInfo() {
    }


    public void getMeasurements(List<String> list){
        for (int i =0; i < list.size(); i++){
           String measurement = list.get(i);
           EctMeasurementsDataBeanHandler ect = new EctMeasurementsDataBeanHandler(demographicNo, measurement);
           Collection v = ect.getMeasurementsDataVector();
           measurementList.add(new ArrayList(v));
           measurementHash.put(measurement,new ArrayList(v));
        }

    }

    public ArrayList getMeasurementData(String measurement){
        return (ArrayList) measurementHash.get(measurement);
    }

    public void addRecommendation(String measurement,String recommendationMessage){
        if (recommendations == null){
           recommendations = new ArrayList();
        }
        recommendationHash.put(measurement,recommendationMessage);
        recommendations.add(recommendationMessage);
    }

    public void addWarning(String measurement,String warningMessage){
        if (warning == null){
           warning = new ArrayList();
        }
        warningHash.put(measurement,warningMessage);
        warning.add(warningMessage);
    }


    public boolean hasWarning(String measurement){
        boolean warn = false;
        if (warningHash.get(measurement) != null){
            warn = true;
        }
        return warn;
    }

    public boolean hasRecommendation(String measurement){
        boolean warn = false;
        if (recommendationHash.get(measurement) != null){
            warn = true;
        }
        return warn;
    }

    public String getRecommendation(String measurement){
        return recommendationHash.get(measurement);
    }

    public String getWarning(String measurement){
        return warningHash.get(measurement);
    }

//    public void setIndicationColour(String measurement,int threshold,String comparison){
//        ArrayList list = getMeasurementData(measurement);
//        if ( list != null){
//            for (int i =0; i < list.size(); i++){
//                EctMeasurementsDataBean mdata = (EctMeasurementsDataBean) list.get(i);
//                String val = mdata.getDataField();
//            }
//        }
//    }

    public int getLastDateRecordedInMonths(String measurement){

        int numMonths = -1;
        ArrayList list = getMeasurementData(measurement);
        Hashtable h =  null;
        if ( list != null && list.size() > 0){
            //h = (Hashtable) list.get(0);
            EctMeasurementsDataBean mdata = (EctMeasurementsDataBean) list.get(0);
            Date date = mdata.getDateObservedAsDate();
            numMonths = getNumMonths(date, Calendar.getInstance().getTime());
        }

        //EctMeasurementsDataBeanHandler.getLast(demographicNo, measurement);
        //if (h != null ){
        //   Date date = (Date) h.get("dateObserved_date");
        //   numMonths = getNumMonths(date, Calendar.getInstance().getTime());
        //}
        log.debug("Returning the number of months "+numMonths);
        return numMonths;
    }

    public int getLastValueAsInt(String measurement){

        int value = -1; //TODO not sure how to handle a non int value.
        ArrayList list = getMeasurementData(measurement);
        Hashtable h =  null;
        if ( list != null && list.size() > 0){
            EctMeasurementsDataBean mdata = (EctMeasurementsDataBean) list.get(0);
            try{
             value = Integer.parseInt(mdata.getDataField());
            }catch (Exception e ){
               MiscUtils.getLogger().error("Error", e);
            }
        }
        log.debug("Returning the number of months "+value);
        return value;
    }


    private int getNumMonths(Date dStart, Date dEnd) {
        int i = 0;
        log.debug("Getting the number of months between "+dStart.toString()+ " and "+dEnd.toString() );
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(dStart);
        while (calendar.getTime().before(dEnd) || calendar.getTime().equals(dEnd)) {
            calendar.add(Calendar.MONTH, 1);
            i++;
        }
        i--;
        if (i < 0) { i = 0; }
        return i;
   }


    private void debug(String s){
        log.debug(s);
    }


}
