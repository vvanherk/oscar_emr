/*
 * 
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved. *
 * This software is published under the GPL GNU General Public License. 
 * This program is free software; you can redistribute it and/or 
 * modify it under the terms of the GNU General Public License 
 * as published by the Free Software Foundation; either version 2 
 * of the License, or (at your option) any later version. * 
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
 * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License 
 * along with this program; if not, write to the Free Software 
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. * 
 * 
 * <OSCAR TEAM>
 * 
 * This software was written for the 
 * Department of Family Medicine 
 * McMaster University 
 * Hamilton 
 * Ontario, Canada 
 */
package oscar.form;

import java.io.IOException;

import org.oscarehr.util.MiscUtils;

public class FrmRecordFactory {
    public FrmRecord factory (String which) throws IOException {
        String fullName = "oscar.form.Frm" + which + "Record"; // keyword - form_name get reference to the class            
        FrmRecord myClass = null;

        try {
            Class classDefinition = Class.forName( fullName );         
            myClass = (FrmRecord) classDefinition.newInstance(); 
        } catch (InstantiationException e) {
            MiscUtils.getLogger().debug(e);
        } catch (IllegalAccessException e) {
            MiscUtils.getLogger().debug(e);
        } catch (ClassNotFoundException e) {
            MiscUtils.getLogger().debug(e);
        }
        
        return myClass;
    }
}