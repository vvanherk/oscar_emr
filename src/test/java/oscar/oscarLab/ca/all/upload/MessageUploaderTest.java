package oscar.oscarLab.ca.all.upload;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import utils.SchemaUtils;
import utils.TestFixtures;

import org.oscarehr.common.dao.SpireAccessionNumberMapDao;
import org.oscarehr.common.model.SpireAccessionNumberMap;
import org.oscarehr.common.model.SpireCommonAccessionNumber;
import org.oscarehr.util.SpringUtils;
import oscar.oscarLab.ca.all.upload.MessageUploader;

public class MessageUploaderTest extends TestFixtures {
	
	private SpireAccessionNumberMapDao dao = (SpireAccessionNumberMapDao)SpringUtils.getBean("spireAccessionNumberMapDao");
	
	private ArrayList<SpireLabTestData> spireTestData = new ArrayList<SpireLabTestData>();
	private int EXPECTED_NUMBER_OF_MAPS = 12;
	
	class LabTestData {
		public String serviceName;
		public String type;
		public String accn;
		public String hl7Body;
		public int fileId;
		
		public LabTestData(String serviceName, String type, String accn, String hl7Body, int fileId) {
			this.serviceName = serviceName;
			this.type = type;
			this.accn = accn;
			this.hl7Body = hl7Body;
			this.fileId = fileId;
		}
	}
	
	class SpireLabTestData extends LabTestData {
		public String uniqueAccn;
		
		public SpireLabTestData(String serviceName, String type, String accn, String uniqueAccn, String hl7Body, int fileId) {
			super(serviceName, type, accn, hl7Body, fileId);
			this.uniqueAccn = uniqueAccn;
		}
	}

	@Before
	public void before() throws Exception {
		SchemaUtils.restoreTable( 
			new String[] {
				"hl7TextInfo",
				"hl7TextMessage",
				"providerLabRouting",
				"providerSpireIdMap",
				"incomingLabRules",
				"fileUploadCheck",
				"patientLabRouting",
				"spireAccessionNumberMap", 
				"spireCommonAccessionNumber"
			}
		);
		
		createSpireLabTestData();
	}

	@Test
	public void testSpireLabAdd() throws Exception {
		try {
			for ( SpireLabTestData d : spireTestData ) {
				String result = MessageUploader.routeReport( d.serviceName, d.type, d.hl7Body, d.fileId );
				
				if (result == null)
					throw new NullPointerException("Audit String is null!");
				else if (result.length() > 0)
					throw new Exception("Audit String is not empty!");
			}
		} catch (Exception e) {
			assertTrue( false );
		}
		
		List<SpireAccessionNumberMap> maps = null;
		List<SpireCommonAccessionNumber> cAccns = null;
		SpireAccessionNumberMap map = null;
		
		for ( SpireLabTestData d : spireTestData ) {
			map = dao.getFromCommonAccessionNumber( d.accn );
			assertNotNull( map );
			
			map = dao.getFromUniqueAccessionNumber( d.uniqueAccn );
			assertNotNull( map );
		}
		
		// There should be 2 labs associated with this map
		map = dao.getFromUniqueAccessionNumber( "HNA_ACCN000002010204000017" );
		assertNotNull( map );
		cAccns = map.getCommonAccessionNumbers();
		assertNotNull( cAccns );
		assertTrue( cAccns.size() == 2 );
		
		// There should be 2 labs associated with this map
		map = dao.getFromUniqueAccessionNumber( "HNAM_CEREFA78E5C0005BC47EF84A0CFE42376AB9A123412341234ABG" );
		assertNotNull( map );
		cAccns = map.getCommonAccessionNumbers();
		assertNotNull( cAccns );
		assertTrue( cAccns.size() == 2 );
	}
	
	/**
	 * Create spire lab test data.
	 */
	private void createSpireLabTestData() {
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q90336483",
				"HNA_ACCN000002010204000017",
				"MSH|^~\\&|OCF|HDH|XENOS|GBHS-OS|20100723152938||ORU^R01|Q90336483|T|2.3\n" +
				"PID|1||63382^^^HDH||TESTING^HANOVER||20000409|Female|||^^^Ontario^^Canada||(000)000-0519^Home||English|||4286864^^^HDH^FIN NBR\n" +
				"PV1|1|Outpt.|Laboratory-HDH^^^HDH^^Ambulatory(s)^HDH||||00095^Rudrick^Brian^F|||||||||||Outpt.|2010110000631^^^HDH^Visit Id|OHIP|||||||||||||||||||HDH||Discharged|||20100409131445|20100409235959|||||2010110000631\n" +
				"OBR|1|114128075^HNAM_ORDERID||Microalbumin (Urine)^U Microalb|||20100723152700|||||||20100723152700|Urine&Urine^^^^^Urine|00154^Harada^Glenn^K||||000002010204000017^HNA_ACCN~3134511^HNA_ACCNID||20100723152935||General Lab|Auth (Verified)||1^^^20100723152700^^Urgent~^^^^^UR|||||||||20100723152700\n" +
				"OBX|1|NUM|Microalbumin (Urine)^Microalbumin (Urine)||1.0|mg/L^mg/L|0.0-10.0^0.0^10.0|||? Unknown|Auth (Verified)|||20100723152935||pmaloney^Maloney^Pam^M|^^^HDHSO  SGH GL\n" +
				"OBX|2|NUM|Ur Microalbumin^Ur Microalbumin||<6.10|mg/L^mg/L||NA||? Unknown|Auth (Verified)|||20100723152935||pmaloney^Maloney^Pam^M|^^^HDHSO  SGH GL\n" +
				"OBX|3|NUM|Creatinine (Urine)^Creatinine (Urine)||1.0|umol/L^mcmol/L||NA||? Unknown|Auth (Verified)|||20100723152935||pmaloney^Maloney^Pam^M|^^^HDHSO  SGH GL\n" +
				"OBX|4|NUM|Ur Creatinine^Ur Creatinine||<84.0|umol/L^mcmol/L||NA||? Unknown|Auth (Verified)|||20100723152935||pmaloney^Maloney^Pam^M|^^^HDHSO  SGH GL\n" +
				"OBX|5|NUM|Microalbumin/Creatinine Ratio^Microalbumin/Creatinine Ratio||1.0|mg/mmol Cr^mg/mmol Cr|<=2.8^^<=2.8|||? Unknown|Auth (Verified)|||20100723152935||pmaloney^Maloney^Pam^M|^^^HDHSO  SGH GL\n" +
				"NTE|1|Interpretive Data|MICROALBUMINURIA: M: 2.0 - 20.0 mg/mmol CR\\.br\\                                            F: 2.8 - 28.0 mg/mmol CR\\.br\\OVERT NEPHROPATHY: M: >20.0 mg/mmol CR\\.br\\(MACROALBUMINURIA) F: >28.0 mg/mmol CR\\.br\\As transient microalbuminuria unrelated to diabetic nephropathy can occur, persistent microalbuminuria (at least 2 of 3 urine Microalbumin/Creatinine ratio tests positive taken at 1-8 week intervals) should be demonstrated before the diagnosis of nephropathy is made.",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q90333895",
				"HNA_ACCN000002010204000017",
				"MSH|^~\\&|OCF|HDH|XENOS|GBHS-OS|20100723152938||ORU^R01|Q90333895|T|2.3\n" +
				"PID|1||63382^^^HDH||TESTING^HANOVER||20000409|Female|||^^^Ontario^^Canada||(000)000-0519^Home||English|||4286864^^^HDH^FIN NBR\n" +
				"PV1|1|Outpt.|Laboratory-HDH^^^HDH^^Ambulatory(s)^HDH||||00095^Rudrick^Brian^F|||||||||||Outpt.|2010110000631^^^HDH^Visit Id|OHIP|||||||||||||||||||HDH||Discharged|||20100409131445|20100409235959|||||2010110000631\n" +
				"OBR|1|114128075^HNAM_ORDERID||Microalbumin (Urine)^U Microalb|||20100723152700|||||||20100723152700|Urine&Urine^^^^^Urine|00154^Harada^Glenn^K||||000002010204000017^HNA_ACCN~3134511^HNA_ACCNID||20100723152935||General Lab|Auth (Verified)||1^^^20100723152700^^Urgent~^^^^^UR|||||||||20100723152700\n" +
				"OBX|1|NUM|Microalbumin (Urine)^Microalbumin (Urine)||1.0|mg/L^mg/L|0.0-10.0^0.0^10.0|||? Unknown|Auth (Verified)|||20100723152935||pmaloney^Maloney^Pam^M|^^^HDHSO  SGH GL\n" +
				"OBX|2|NUM|Ur Microalbumin^Ur Microalbumin||<6.10|mg/L^mg/L||NA||? Unknown|Auth (Verified)|||20100723152935||pmaloney^Maloney^Pam^M|^^^HDHSO  SGH GL\n" +
				"NTE|1|Interpretive Data|MICROALBUMINURIA: M: 2.0 - 20.0 mg/mmol CR\\.br\\                                            F: 2.8 - 28.0 mg/mmol CR\\.br\\OVERT NEPHROPATHY: M: >20.0 mg/mmol CR\\.br\\(MACROALBUMINURIA) F: >28.0 mg/mmol CR\\.br\\As transient microalbuminuria unrelated to diabetic nephropathy can occur, persistent microalbuminuria (at least 2 of 3 urine Microalbumin/Creatinine ratio tests positive taken at 1-8 week intervals) should be demonstrated before the diagnosis of nephropathy is made.",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q90336556",
				"HNA_ACCN000002010207000010",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q90336556|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID||Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||000002010207000010^HNA_ACCN~3134562^HNA_ACCNID||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q90333546",
				"HNA_CEACCN3938227",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q90333546|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID||Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||3938227^HNA_CEACCN~3134562^HNA_ACCNID||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q90332226",
				"HNA_ACCN000002010208847017",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q90332226|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID||Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||3938227^HNA_PAKSID~3134562^HNA_ACCNID~000002010208847017^HNA_ACCN||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q03432226",
				"HNA_ACCN000002011208147011",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q03432226|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID||Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||3938227^HNA_PAKSID~000002011208147011^HNA_ACCN~3134562^HNA_ACCNID||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q07532226",
				"HNA_CEACCN000002011208147011BRTBR6JU8FG23GDSG",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q07532226|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID||Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||3938227^HNA_PAKSID~000002011208147011BRTBR6JU8FG23GDSG^HNA_CEACCN~3134562^HNA_ACCNID||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q90356678",
				"HNA_CEACCN3938221",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q90356678|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID||Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||3133362^HNA_SOMEID~3938221^HNA_CEACCN~3134562^HNA_ACCNID||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q90356603",
				"HNA_ACCN000002009208137011",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q90356603|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID||Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||3133362^HNA_SOMEID~3938221^HNA_CEACCN~3134562^HNA_ACCNID~000002009208137011^HNA_ACCN||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		// New HNAM_CEREF id testing
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q167450614",
				"HNAM_CEREFA78E5C0005BC47EF84A0CFE42376AB9A",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q167450614|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID|531754029^HNAM_EVENTID~A78E5C0005BC47EF84A0CFE42376AB9A^HNAM_CEREF|Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q167450615",
				"HNAM_CEREFA78E5C0005BC47EF84A0CFE42376AB9A123412341234",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q167450615|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID|531754029^HNAM_EVENTID~A78E5C0005BC47EF84A0CFE42376AB9A123412341234^HNAM_CEREF|Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q167457615",
				"HNAM_CEREFA78E5C0005BC47EF84A0CFE42376AB9A123412341234ABG",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q167457615|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID|531754029^HNAM_EVENTID~531754022^HNAM_EVENTID~A78E5C0005BC47EF84A0CFE42376AB9A123412341234ABG^HNAM_CEREF~531799029^HNAM_EVENTID|Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
		
		spireTestData.add(
			new SpireLabTestData(
				"spire",
				"Spire",
				"Q167457655",
				"HNAM_CEREFA78E5C0005BC47EF84A0CFE42376AB9A123412341234ABG",
				"MSH|^~\\&|OCF|GBHS-OS|XENOS|GBHS-OS|20100726104304||ORU^R01|Q167457655|T|2.3\n" +
				"PID|1||332223^^^GBHS-OS||VEDANTTEST^ANEG||19850503|Female|||^^^Ontario^O1O1O1^Canada^^^Grey, Blue Mountains, T,|Grey, Blue Mountains, T,|(000)000-0519^Home||English|Married||3600321^^^GBHS-OS^FIN NBR\n" +
				"PV1|1|Outpt.|Lab Oncology-OS^^^GBHS-OS^^Ambulatory(s)^GBHS-OS||||00154^Harada^Glenn^K|||||||||||Outpt.|2010110003213^^^^Visit Id|Self Pay|||||||||||||||||||GBHS-OS||Active|||20100504085739||||||2010110003213\n" +
				"OBR|1|114129021^HNAM_ORDERID|531754029^HNAM_EVENTID~531754022^HNAM_EVENTID~A78E5C0005BC47EF84A0CFE42376AB9A123412341234ABG^HNAM_CEREF~531799029^HNAM_EVENTID|Group and Rh^Group and Rh|||20100726103500|||||||20100726104000|Blood&Blood^^^^^Venous Draw|00154^Harada^Glenn^K||||||20100726104259||Blood Bank|Auth (Verified)||1^^^20100726103500^^Routine~^^^^^Routine|||||||||20100726103500\n" +
				"OBX|1|TXT|ABORh^ABORh||A NEG|||Unknown||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|2|CE|Anti-D1^Anti-D1||0-^0-|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|3|CE|BR^BR||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|4|CE|Anti-A,B^Anti-A,B||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|5|CE|Anti-B^Anti-B||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|6|CE|A1R^A1R||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|7|CE|RhC^RhC||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|8|CE|Anti-A^Anti-A||4^4|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion\n" +
				"OBX|9|CE|Anti-D2^Anti-D2||0^0|||||? Unknown|Auth (Verified)|||20100726104259|||^^^OSB Transfusion",
				0
			)
		);
	}


}
