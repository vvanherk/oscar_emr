package org.oscarehr.web;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.oscarehr.common.dao.DemographicDao;
import org.oscarehr.common.dao.OcanStaffFormDao;
import org.oscarehr.common.model.Demographic;
import org.oscarehr.util.LoggedInInfo;
import org.oscarehr.util.MiscUtils;
import org.oscarehr.util.SpringUtils;

public class OcanReportingBean {

	private static final Logger logger = MiscUtils.getLogger();

	private static OcanStaffFormDao ocanStaffFormDao = (OcanStaffFormDao) SpringUtils.getBean("ocanStaffFormDao");
	private static DemographicDao demographicDao = (DemographicDao) SpringUtils.getBean("demographicDao");

	public static List<Demographic> getOCANClients() {
		List<Integer> demographicIds = ocanStaffFormDao.getAllOcanClients(LoggedInInfo.loggedInInfo.get().currentFacility.getId());
		List<Demographic> demographics = new ArrayList<Demographic>();
		for(Integer id:demographicIds) {
			demographics.add(demographicDao.getClientByDemographicNo(id));
		}
		return demographics;
	}
}
