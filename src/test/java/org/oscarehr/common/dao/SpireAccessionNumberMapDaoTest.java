package org.oscarehr.common.dao;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import utils.EntityDataGenerator;
import utils.SchemaUtils;
import org.oscarehr.common.dao.SpireAccessionNumberMapDao;
import org.oscarehr.common.model.SpireAccessionNumberMap;
import org.oscarehr.common.model.SpireCommonAccessionNumber;
import org.oscarehr.util.SpringUtils;

public class SpireAccessionNumberMapDaoTest extends TestFixtures {

	private SpireAccessionNumberMapDao dao = (SpireAccessionNumberMapDao)SpringUtils.getBean("spireAccessionNumberMapDao");
	
	private ArrayList<SpireTestData> spireTestData = new ArrayList<SpireTestData>();
	private int EXPECTED_NUMBER_OF_MAPS = 12;
	
	class SpireTestData {
		public SpireTestData(String uniqueAccn, String accn, Integer labNo) {
			this.uniqueAccn = uniqueAccn;
			this.accn = accn;
			this.labNo = labNo;
		}
		
		public String uniqueAccn;
		public String accn;
		public Integer labNo;
	}

	@Before
	public void before() throws Exception {
		SchemaUtils.restoreTable(new String[] {"spireAccessionNumberMap", "spireCommonAccessionNumber"});
		
		spireTestData.add( new SpireTestData("HNA_ACCN000002011150009275", "Q162060323", new Integer(1)) );
		spireTestData.add( new SpireTestData("HNA_ACCN000002011400001940", "Q118274394", new Integer(2)) );
		spireTestData.add( new SpireTestData("HNA_ACCN000002012230009054", "Q189186249", new Integer(3)) );
		spireTestData.add( new SpireTestData("HNA_ACCN000002012110011225", "Q132313459", new Integer(4)) );
		spireTestData.add( new SpireTestData("HNA_ACCN000002013230009456", "Q180595459", new Integer(5)) );
		spireTestData.add( new SpireTestData("HNA_ACCN000002014100062888", "Q189188999", new Integer(6)) );
		spireTestData.add( new SpireTestData("HNA_CEACCN5350433", "Q182347883", new Integer(7)) );
		spireTestData.add( new SpireTestData("HNA_CEACCN5359994", "Q121432544", new Integer(8)) );
		spireTestData.add( new SpireTestData("HNA_CEACCN0003875", "Q189186232", new Integer(9)) );
		spireTestData.add( new SpireTestData("HNA_CEACCN1999437", "Q166673159", new Integer(10)) );
		spireTestData.add( new SpireTestData("HNA_CEACCN7374435", "Q181193159", new Integer(11)) );
		
		// Duplicate unique accn numbers - should match them together in the map
		spireTestData.add( new SpireTestData("HNA_CEACCN7371135", "Q181194859", new Integer(12)) );
		spireTestData.add( new SpireTestData("HNA_CEACCN7371135", "Q181193159", new Integer(13)) );
		
		// We should have 12 maps created (since 2 of the fake lab information have duplicate unique accns)
		EXPECTED_NUMBER_OF_MAPS = 12;
	}

	@Test
	public void testCreate() throws Exception {
		SpireAccessionNumberMap entity = new SpireAccessionNumberMap();
		EntityDataGenerator.generateTestDataForModelClass(entity);

		dao.persist(entity);
		assertNotNull(entity.getId());
	}

	@Test
	public void testAdd() throws Exception {
		for ( SpireTestData d : spireTestData) {
			dao.add(d.uniqueAccn, d.accn, d.labNo);
		}

		for ( SpireTestData d : spireTestData) {
			SpireAccessionNumberMap m = dao.getFromUniqueAccessionNumber(d.uniqueAccn);
			assertNotNull( m );
		}
		
		for ( SpireTestData d : spireTestData) {
			SpireAccessionNumberMap m = dao.getFromLabNumber(d.labNo);
			assertNotNull( m );
		}
		
		for ( SpireTestData d : spireTestData) {
			SpireAccessionNumberMap m = dao.getFromCommonAccessionNumber(d.accn);
			assertNotNull( m );
		}
		
		
		
		List<String> accns = new ArrayList<String>();
		List<String> uniqueAccns = new ArrayList<String>();
		List<Integer> labNos = new ArrayList<Integer>();
		for ( SpireTestData d : spireTestData) {
			uniqueAccns.add( d.uniqueAccn );
			accns.add( d.accn );
			labNos.add( d.labNo );
		}
		
		List<SpireAccessionNumberMap> maps = null;
		SpireAccessionNumberMap map = null;
		List<Integer> accnMapIds = new ArrayList<Integer>();
		
		maps = dao.getFromLabNumbers(labNos);
		assertNotNull( maps );
		assertTrue( maps.size() == EXPECTED_NUMBER_OF_MAPS );
		
		maps = dao.getFromCommonAccessionNumbers(accns);
		assertNotNull( maps );
		assertTrue( maps.size() == EXPECTED_NUMBER_OF_MAPS );
		
		for ( SpireAccessionNumberMap m : maps ) {
			accnMapIds.add( m.getId() );
		}
		
		map = dao.getFromAccessionNumberMapId( accnMapIds.get(0) );
		assertNotNull( map );
		
		maps  = dao.getFromAccessionNumberMapIds(accnMapIds);
		assertNotNull( maps );
		assertTrue( maps.size() == EXPECTED_NUMBER_OF_MAPS );
	}


}
