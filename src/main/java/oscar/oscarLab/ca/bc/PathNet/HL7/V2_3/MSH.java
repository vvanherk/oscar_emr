/**
 * Copyright (c) 2001-2002. Andromedia. All Rights Reserved.
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
 * This software was written for
 * Andromedia, to be provided as
 * part of the OSCAR McMaster
 * EMR System
 */


package oscar.oscarLab.ca.bc.PathNet.HL7.V2_3;

import java.sql.SQLException;

import org.apache.log4j.Logger;

import oscar.oscarDB.DBHandler;
import oscar.oscarLab.ca.bc.PathNet.HL7.Node;

/* @author Jesse Bank
 * For The Oscar McMaster Project
 * Developed By Andromedia
 * www.andromedia.ca
 */
public class MSH extends oscar.oscarLab.ca.bc.PathNet.HL7.Node {
   Logger _logger = Logger.getLogger(this.getClass());
   public Node Parse(String line) {
      return super.Parse(line, 1, 1);
   }
   
   
   //This inserts a record into the hl7_msh returns a 0 if it worked and 1 if it failed  
   public int ToDatabase(int parent) throws SQLException {
      _logger.debug("Inserting into Database :"+this.getInsertSql(parent));
      return booleanConvert(DBHandler.RunSQL(this.getInsertSql(parent)));      
   }
   
   protected String getInsertSql(int parent) {
      String fields = "INSERT INTO hl7_msh ( message_id";
      String values = "VALUES ('" + String.valueOf(parent) + "'";
      String[] properties = this.getProperties();
      for(int i = 0; i < properties.length; ++i) {
         fields += ", " + properties[i];
         values += ", '" + this.get(properties[i], "") + "'";
      }
      return fields + ") " + values + ");";
   }
   
   protected String[] getProperties() {
      return new String[] {
         "seperator",
         "encoding_characters",
         "sending_application",
         "sending_facility",
         "receiving_application",
         "receiving_facility",
         "date_time_of_message",
         "security",
         "message_type",
         "message_control_id",
         "processing_id",
         "version_id",
         "sequence_number",
         "continuation_pointer",
         "accept_acknowledgment_type",
         "application_acknowledge_type",
         "country_code",
         "character_set",
         "principal_language_of_message"
      };
   }
}
