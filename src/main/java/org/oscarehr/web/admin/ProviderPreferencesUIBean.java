/**
 *
 * Copyright (c) 2005-2012. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved.
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
 * Centre for Research on Inner City Health, St. Michael's Hospital,
 * Toronto, Ontario, Canada
 */

package org.oscarehr.web.admin;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.jfree.util.Log;
import org.oscarehr.common.dao.EFormDao;
import org.oscarehr.common.dao.EncounterFormDao;
import org.oscarehr.common.dao.ProviderPreferenceDao;
import org.oscarehr.common.model.EForm;
import org.oscarehr.common.model.EncounterForm;
import org.oscarehr.common.model.Provider;
import org.oscarehr.common.model.ProviderPreference;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;
import org.oscarehr.util.WebUtils;

public final class ProviderPreferencesUIBean {

	private static final ProviderPreferenceDao providerPreferenceDao = (ProviderPreferenceDao) SpringUtils.getBean("providerPreferenceDao");
	private static final EFormDao eFormDao = (EFormDao) SpringUtils.getBean("EFormDao");
	private static final EncounterFormDao encounterFormDao = (EncounterFormDao) SpringUtils.getBean("encounterFormDao");

	public static final ProviderPreference updateOrCreateProviderPreferences(HttpServletRequest request) {
		ProviderPreference providerPreference = getLoggedInProviderPreference();

		// update preferences based on request parameters
		String temp;
		HttpSession session = request.getSession();
		
		// Hack to only update checkbox values if we are receiving this update/create request from the Provider Preferences page
		temp = StringUtils.trimToNull(request.getParameter("updating_from_preferences_page"));
		boolean updateCheckboxValues = (temp != null);

		// new tickler window
		temp = StringUtils.trimToNull(request.getParameter("new_tickler_warning_window"));
		if (temp != null) {
			providerPreference.setNewTicklerWarningWindow(temp);
		} else {
			temp = StringUtils.trimToNull((String) session.getAttribute("newticklerwarningwindow"));
			if (temp != null) providerPreference.setNewTicklerWarningWindow(temp);
		}

		// default pmm
		temp = StringUtils.trimToNull(request.getParameter("default_pmm"));
		if (temp != null) {
			providerPreference.setDefaultCaisiPmm(temp);
		} else {
			temp = StringUtils.trimToNull((String) session.getAttribute("default_pmm"));
			if (temp == null) providerPreference.setDefaultCaisiPmm("disabled");
			else providerPreference.setDefaultCaisiPmm(temp);
		}
		
		// default billing preference (edit or delete)
		temp = StringUtils.trimToNull(request.getParameter("caisiBillingPreferenceNotDelete"));
		if (temp != null) {
			try {
				providerPreference.setDefaultDoNotDeleteBilling(Integer.parseInt(temp));
			}catch(NumberFormatException e) {
				MiscUtils.getLogger().error("Error",e);
			}
		} else {
			temp = StringUtils.trimToNull(String.valueOf(session.getAttribute("caisiBillingPreferenceNotDelete")));
			if (temp == null) 
				providerPreference.setDefaultDoNotDeleteBilling(0);
			else  {
				int defBilling = 0;
				try {
					defBilling = Integer.parseInt(temp);
				} catch(NumberFormatException e) {Log.warn("warning",e);}
				providerPreference.setDefaultDoNotDeleteBilling(defBilling);
			}
		}
		
		// default billing dxCode 
		temp = StringUtils.trimToNull(request.getParameter("dxCode"));
		if (temp != null) providerPreference.setDefaultDxCode(temp);
		
		
		// rest
		temp = StringUtils.trimToNull(request.getParameter("start_hour"));
		if (temp != null) providerPreference.setStartHour(Integer.parseInt(temp));

		temp = StringUtils.trimToNull(request.getParameter("end_hour"));
		if (temp != null) providerPreference.setEndHour(Integer.parseInt(temp));

		temp = StringUtils.trimToNull(request.getParameter("every_min"));
		if (temp != null) providerPreference.setEveryMin(Integer.parseInt(temp));

		temp = StringUtils.trimToNull(request.getParameter("mygroup_no"));
		if (temp != null) providerPreference.setMyGroupNo(temp);

		temp = StringUtils.trimToNull(request.getParameter("default_servicetype"));
		if (temp != null) providerPreference.setDefaultServiceType(temp);
		
		temp = StringUtils.trimToNull(request.getParameter("default_bill_provider"));
		if (temp != null) {
			// 'no' is the string representing 'none'
			if (temp.equals("no"))
				temp = "";
			providerPreference.setBillingProviderDefault(temp);
		}
		
		if ( updateCheckboxValues ) {
			temp = StringUtils.trimToNull(request.getParameter("use_billing_provider_from_previous_bill"));
			providerPreference.setUseBillingProviderFromPreviousBill( temp != null );
				
			temp = StringUtils.trimToNull(request.getParameter("rx_print_pharmacy"));
			providerPreference.setPrintPharmacyOnRx(temp != null);
			
			temp = StringUtils.trimToNull(request.getParameter("rx_print_dates"));
			providerPreference.setPrintDateOnRx(temp != null);
				
			temp = StringUtils.trimToNull(request.getParameter("billing_ref_box_default_checked"));
			providerPreference.setBillingRefBoxDefaultChecked(temp != null);
		}
		
		temp = StringUtils.trimToNull(request.getParameter("default_bill_visit_type"));
		if (temp == null) 
			temp = "";
		providerPreference.setBillingVisitTypeDefault(temp);
		
		temp = StringUtils.trimToNull(request.getParameter("default_bill_visit_location"));
		if (temp == null) 
			temp = "";
		providerPreference.setBillingVisitLocationDefault(temp);

		temp = StringUtils.trimToNull(request.getParameter("color_template"));
		if (temp != null) providerPreference.setColourTemplate(temp);
			
		providerPreference.setPrintQrCodeOnPrescriptions(WebUtils.isChecked(request, "prescriptionQrCodes"));

		// get encounterForms for appointment screen
		temp = StringUtils.trimToNull(request.getParameter("appointmentScreenFormsNameDisplayLength"));
		if (temp != null) providerPreference.setAppointmentScreenLinkNameDisplayLength(Integer.parseInt(temp));

		String[] formNames = request.getParameterValues("encounterFormName");
		Collection<String> formNamesList = providerPreference.getAppointmentScreenForms();		

		formNamesList.clear();
		if( formNames != null ) {
			for (String formName : formNames) {
				formNamesList.add(formName);
			}
		}

		// get eForms for appointment screen
		String[] formIds = request.getParameterValues("eformId");
		Collection<Integer> eFormsIdsList = providerPreference.getAppointmentScreenEForms();		
		
		eFormsIdsList.clear();
		if( formIds != null ) {
			for (String formId : formIds) {
				eFormsIdsList.add(Integer.parseInt(formId));
			}
		}
		
	     // external prescriber prefs
		providerPreference.setERxEnabled(WebUtils.isChecked(request,"erx_enable"));
		
		temp = StringUtils.trimToNull(request.getParameter("erx_username"));
		if (temp != null) providerPreference.setERxUsername(temp);
		
		temp = StringUtils.trimToNull(request.getParameter("erx_password"));
		if (temp != null) providerPreference.setERxPassword(temp);
		
		temp = StringUtils.trimToNull(request.getParameter("erx_facility"));
		if (temp != null) providerPreference.setERxFacility(temp);
		
		providerPreference.setERxTrainingMode(WebUtils.isChecked(request,"erx_training_mode"));
		
		temp = StringUtils.trimToNull(request.getParameter("erx_sso_url"));
		if (temp != null) providerPreference.setERx_SSO_URL(temp);

		providerPreferenceDao.merge(providerPreference);

		return (providerPreference);
	}

	/**
	 * Some day we'll fix this so preferences are created when providers are created, it was suppose to be that way
	 * but something got missed somewhere.
	 * @return
	 */
	public static ProviderPreference getLoggedInProviderPreference() {
		LoggedInInfo loggedInInfo = LoggedInInfo.loggedInInfo.get();
		Provider provider = loggedInInfo.loggedInProvider;

		ProviderPreference providerPreference = providerPreferenceDao.find(provider.getProviderNo());
		if (providerPreference == null) {
			providerPreference = new ProviderPreference();
			providerPreference.setProviderNo(provider.getProviderNo());
			providerPreferenceDao.persist(providerPreference);
		}

		return(providerPreference);
	}

	public static List<EForm> getAllEForms() {
		List<EForm> results = eFormDao.findAll(true);
		Collections.sort(results, EForm.FORM_NAME_COMPARATOR);
		return (results);
	}

	public static List<EncounterForm> getAllEncounterForms() {
		List<EncounterForm> results = encounterFormDao.findAll();
		Collections.sort(results, EncounterForm.FORM_NAME_COMPARATOR);
		return (results);
	}

	public static Collection<String> getCheckedEncounterFormNames() {
		ProviderPreference providerPreference = getLoggedInProviderPreference();
		return (providerPreference.getAppointmentScreenForms());
	}

	public static Collection<Integer> getCheckedEFormIds() {
		ProviderPreference providerPreference = getLoggedInProviderPreference();
		return (providerPreference.getAppointmentScreenEForms());
	}
	
	public static ProviderPreference getProviderPreferenceByProviderNo(String providerNo) {
		return providerPreferenceDao.find(providerNo);	
	}

	public static Collection<ProviderPreference.QuickLink> getQuickLinks() {
		ProviderPreference providerPreference = getLoggedInProviderPreference();

		return (providerPreference.getAppointmentScreenQuickLinks());
	}
	
	public static void addQuickLink(String name, String url) {
		ProviderPreference providerPreference = getLoggedInProviderPreference();

		Collection<ProviderPreference.QuickLink> quickLinks=providerPreference.getAppointmentScreenQuickLinks();
		
		ProviderPreference.QuickLink quickLink=new ProviderPreference.QuickLink();
		quickLink.setName(name);
		quickLink.setUrl(url);
		
		quickLinks.add(quickLink);
		
		providerPreferenceDao.merge(providerPreference);
	}

	public static void removeQuickLink(String name) {
		ProviderPreference providerPreference = getLoggedInProviderPreference();

		Collection<ProviderPreference.QuickLink> quickLinks=providerPreference.getAppointmentScreenQuickLinks();

		for (ProviderPreference.QuickLink quickLink : quickLinks)
		{
			if (name.equals(quickLink.getName()))
			{
				// it should be okay to modify the list while we're iterating through it, as long as we don't touch it after it's modified.
				quickLinks.remove(quickLink);
				break;
			}
		}
		
		providerPreferenceDao.merge(providerPreference);
	}
}
