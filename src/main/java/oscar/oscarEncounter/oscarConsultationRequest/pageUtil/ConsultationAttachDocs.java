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


package oscar.oscarEncounter.oscarConsultationRequest.pageUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.oscarehr.util.MiscUtils;

import oscar.OscarProperties;
import oscar.dms.EDoc;
import oscar.dms.EDocUtil;
import oscar.oscarDB.DBHandler;

/**
 *
 * Handles logic of attaching documents to a specified consultation
 */
public class ConsultationAttachDocs {
    private String reqId; //consultation id
    private String demoNo;
    private String providerNo;
    private ArrayList<String> docs;  //document ids

    /** Creates a new instance of ConsultationAttachDocs */
    public ConsultationAttachDocs(String req) {
        reqId = req;
        demoNo = "";
        docs = new ArrayList<String>();
    }
    /**
     * @params demographic id, consultation id and array of document ids with prepended 'D' for each id as doc type
     */
    public ConsultationAttachDocs(String prov, String demo, String req, String[] d) {
        providerNo = prov;
        demoNo = demo;
        reqId = req;
        docs = new ArrayList<String>(d.length);

        if (OscarProperties.getInstance().isPropertyActive("consultation_indivica_attachment_enabled")) {
	        for(int idx = 0; idx < d.length; ++idx ) {
	            docs.add(d[idx]);
	        }
        }
        else {
        //if dummy entry skip
        
	        if( !d[0].equals("0") ) {
	            for(int idx = 0; idx < d.length; ++idx ) {
	                if( d[idx].charAt(0) == 'D')
	                    docs.add(d[idx].substring(1));
	            }
	        }
        }
    }

    public String getDemoNo() {
        String demo;
        if( !demoNo.equals(""))
            demo = demoNo;
        else {
            String sql = "SELECT demographicNo FROM consultationRequests WHERE requestId = " + reqId;
            try {

                ResultSet rs = DBHandler.GetSQL(sql);
                if( rs.next() ) {
                    demo = oscar.Misc.getString(rs, "demographicNo");
                    demoNo = demo;
                }
                else
                    demo = "";

            }catch( SQLException e ) {
              MiscUtils.getLogger().error("Error", e);
              demo = "";
            }
        }

        return demo;
    }

    public void attach() {

        //first we get a list of currently attached docs
        ArrayList<EDoc> oldlist = EDocUtil.listDocs(demoNo,reqId,EDocUtil.ATTACHED);
        ArrayList<String> newlist = new ArrayList<String>();
        ArrayList<EDoc> keeplist = new ArrayList<EDoc>();
        boolean alreadyAttached;
        //add new documents to list and get ids of docs to keep attached
        for(int i = 0; i < docs.size(); ++i) {
            alreadyAttached = false;
            for(int j = 0; j < oldlist.size(); ++j) {
                if( (oldlist.get(j)).getDocId().equals(docs.get(i)) ) {
                    alreadyAttached = true;
                    keeplist.add(oldlist.get(j));
                    break;
                }
            }
            if( !alreadyAttached )
                newlist.add(docs.get(i));
        }

        //now compare what we need to keep with what we have and remove association
        for(int i = 0; i < oldlist.size(); ++i) {
            if( keeplist.contains(oldlist.get(i)))
                continue;

            EDocUtil.detachDocConsult((oldlist.get(i)).getDocId(), reqId);
        }

        //now we can add association to new list
        for(int i = 0; i < newlist.size(); ++i)
            EDocUtil.attachDocConsult(providerNo, newlist.get(i), reqId);

    } //end attach
}
