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


package org.oscarehr.integration.born;

import java.io.File;
import java.io.FileInputStream;

import org.apache.commons.net.ftp.FTPFile;
import org.oscarehr.util.SpringUtils;
import org.springframework.integration.file.remote.session.Session;
import org.springframework.integration.ftp.session.DefaultFtpsSessionFactory;

import oscar.OscarProperties;

public class BornFtpManager {

	public BornFtpManager() {

	}

	public void uploadDataToRepository(String path, String filename) throws Exception {
		String remotePath = OscarProperties.getInstance().getProperty("born_ftps_remote_dir","");
		DefaultFtpsSessionFactory ftpFactory = (DefaultFtpsSessionFactory)SpringUtils.getBean("ftpClientFactory");		
		Session<FTPFile> session = null;		
		try {
			session = ftpFactory.getSession();		
			if(session.isOpen()) {
				session.write(new FileInputStream(path + File.separator + filename),remotePath + File.separator +filename);
			}
		}finally {
			if(session!=null && session.isOpen())
				session.close();
		}
	}
}

