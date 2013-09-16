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


package org.oscarehr.ws;

import java.util.Date;

import org.oscarehr.PMmodule.dao.ProviderDao;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.SpringUtils;

import com.quatro.model.security.Security;

public final class WsUtils
{
	private static ProviderDao providerDao = (ProviderDao) SpringUtils.getBean("providerDao");

	/**
	 * This method will check to see if the person is allowed to login, i.e. it will check username/expiry/password.
	 * If the person is allowed it will setup the loggedInInfo data.
	 * 
	 * @param security can be null, it will return false for null. 
	 * @param securityToken can be the SecurityId's password, or a valid securityToken.
	 */
	public static boolean checkAuthenticationAndSetLoggedInInfo(Security security, String securityToken)
	{
		if (security != null)
		{
			if (security.getDateExpiredate()!=null && security.getDateExpiredate().before(new Date())) return(false);
			
			if (checkToken(security, securityToken) || security.checkPassword(securityToken))
			{
				LoggedInInfo x = new LoggedInInfo();
				x.loggedInSecurity = security;
				if (security.getProviderNo() != null) {
					x.loggedInProvider = providerDao.getProvider(security.getProviderNo());
				}

				LoggedInInfo.loggedInInfo.set(x);
				return(true);
			}
		}
		
		return(false);
	}

	private static boolean checkToken(Security security, String securityToken) {
// will sort this out later when we setup tokens
	    return false;
    }
}
