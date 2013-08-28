package oscar.oscarLab.ca.all.parsers;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.oscarehr.util.MiscUtils;

import oscar.util.UtilDateUtilities;
import ca.uhn.hl7v2.HL7Exception;
import ca.uhn.hl7v2.model.v23.message.ORU_R01;
import ca.uhn.hl7v2.parser.Parser;
import ca.uhn.hl7v2.parser.PipeParser;
import ca.uhn.hl7v2.util.Terser;
import ca.uhn.hl7v2.validation.impl.NoValidation;

public class EpsilonHandler extends CMLHandler {

	private static Logger logger = MiscUtils.getLogger();
	
	@Override
	public String getMsgType() {
		return "Epsilon";
	}

	@Override
	public void init(String hl7Body) throws HL7Exception {
//		if (hl7Body.startsWith("MSH")) {
//			int index = 0;
//			for (int i = 0; i < 11; i++) {
//				index = hl7Body.indexOf('|', index + 1);
//			}
//			int tmp = index + 1;
//			String tmph = hl7Body.substring(0, tmp);
//			index = hl7Body.indexOf('|', index + 1);
//			if (hl7Body.substring(tmp, index).trim().length() == 0) {
//				hl7Body = tmph + "2.3" + hl7Body.substring(index);
//			}
//		}
		Parser p = new PipeParser();
		p.setValidationContext(new NoValidation());
		msg = (ORU_R01) p.parse(hl7Body.replaceAll("\n", "\r\n"));
	}

	@Override
	public int getOBXCount(int i) {				
		try {
			int j = msg.getRESPONSE().getORDER_OBSERVATION(i)
					.getOBSERVATIONReps();
			if(j<=1) return j;
			int result = 1;
			
			String s = getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBSERVATION(0).getOBX(), 3, 0,
					2, 1));
			for( int ii = 0; ii < j; ii++ ) {
				String sub = getString(Terser.get(msg.getRESPONSE()
						.getORDER_OBSERVATION(i).getOBSERVATION(ii).getOBX(), 3, 0,
						2, 1));
				if(sub.trim().equalsIgnoreCase(s)) 
					continue;
				
				result ++;
				s = sub;				
			}
			return result;
				
		} catch (Exception e) {
			return (0);
		}
	}

	public int[] getCorrectObxFlag(int i, int j) {
		/*
		int[] result = new int[2];
		result[0] = i;
		j++;
		int s = 0;
		try {
			for (int k = 0; k < msg.getRESPONSE().getORDER_OBSERVATION(i)
					.getOBSERVATIONReps(); k++) {
				if (getSubNum(i, k) <= 1)				
					s++;
				if (s == j) {
					result[1] = k;
					break;
				}
			}
		} catch (HL7Exception e) {
			return new int[] { i, j };
		}

		return result;
		*/
		
		int[] result = new int[2];
		result[0] = i;
		//j++;
		int s = 0;
		try {
			String s1 = getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBSERVATION(0).getOBX(), 3, 0,
					2, 1));
			
			for (int k = 0; k < msg.getRESPONSE().getORDER_OBSERVATION(i)
					.getOBSERVATIONReps(); k++) {
				
				if (!isSameSub(i, k, s1))				
					s++;
				if (s == j) {
					result[1] = k;
					break;
				}
				s1 = getString(Terser.get(msg.getRESPONSE()
						.getORDER_OBSERVATION(i).getOBSERVATION(k).getOBX(), 3, 0,
						2, 1));
			}
		} catch (HL7Exception e) {
			return new int[] { i, j };
		}

		return result;
		
	}

	public int getSubNum(int i, int j) {
	
		try {
			String s = getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBSERVATION(j).getOBX(), 4, 0,
					1, 1));
			if(s.trim().isEmpty())return 0;
			int ii = Integer.parseInt(s.trim());
			return ii;
		} catch (Exception e) {
			return 0;
		}
		
		
	}
	
	public boolean isSameSub(int i, int j, String sub) {
		
		try {
			String s = getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBSERVATION(j).getOBX(), 3, 0,
					2, 1));
			if(s.trim().equalsIgnoreCase(sub))
				return true;
			else return false;
			
		} catch (Exception e) {
			return false;
		}
		
		
	}
	
	@Override
	public String getOBXResultStatus(int i, int j) {
		int[] s = getCorrectObxFlag(i, j);
		String status = "";
		try {
			status = getString(msg.getRESPONSE().getORDER_OBSERVATION(s[0])
					.getOBSERVATION(s[1]).getOBX().getObservResultStatus()
					.getValue());
			if (status.equalsIgnoreCase("I")) {
				status = "Pending";
			} else if (status.equalsIgnoreCase("F")) {
				status = "Final";
			}
		} catch (Exception e) {
			logger.error("Error retrieving obx result status", e);
			return status;
		}
		return status;
	}

	@Override
	public String getOrderStatus() {
		try {
			return (getString(msg.getRESPONSE().getORDER_OBSERVATION(0)
					.getOBR().getResultStatus().getValue()));
		} catch (Exception e) {
			return ("");
		}
	}

	@Override
	public String getMsgPriority() {
		try {
			return msg.getRESPONSE().getORDER_OBSERVATION(0).getOBR()
					.getPriority().getValue();
		} catch (HL7Exception e) {
			return ("");
		}
	}

	@Override
	public String getServiceDate() {
		try {
			/*return (formatDateTime(getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(0).getOBR(), 6, 0, 1, 1))));
					*/
				String serviceDate = formatDateTime(getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(0).getOBR(), 6, 0, 1, 1)));
				if(StringUtils.isBlank(serviceDate)) {	
						serviceDate = formatDateTime(getString(Terser.get(msg.getRESPONSE()
								.getORDER_OBSERVATION(0).getOBR(), 14, 0, 1, 1)));
					
				}
				return serviceDate;
			} catch (Exception e) {
				return ("");
			}
	}

	@Override
	public boolean isOBXAbnormal(int i, int j) {
		if (("").equals(getOBXAbnormalFlag(i, j).trim())) {
			return (false);
		} else {
			return (true);
		}

	}

	@Override
	public String getOBRComment(int i, int j) {
		// try {
		// int lastOBX =
		// msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATIONReps() - 1;
		// return
		// (getString(msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATION(lastOBX).getNTE(j).getComment(0).getValue()));
		// } catch (Exception e) {
		return ("");
		// }
	}

	@Override
	public int getOBXCommentCount(int i, int j) {
		/*
		int[] s = getCorrectObxFlag(i, j);
		try {
			for (int k = s[1]+1 ; k < msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBSERVATIONReps(); k++) {
				if (getSubNum(i, k) <= 1) {
					return k - 1 - s[1];
				}
			}
		} catch (HL7Exception e) {
		}
		return 0;
		*/
		
		int[] ss = getCorrectObxFlag(i, j);
		try {
			int jj = msg.getRESPONSE().getORDER_OBSERVATION(i)
					.getOBSERVATIONReps();
			if(jj<=1) return jj;
			int result = 0;
			
			String s = getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBSERVATION(ss[1]).getOBX(), 3, 0,
					2, 1));
			for( int ii = ss[1]+1; ii < jj; ii++ ) {
				String sub = getString(Terser.get(msg.getRESPONSE()
						.getORDER_OBSERVATION(i).getOBSERVATION(ii).getOBX(), 3, 0,
						2, 1));
				if(sub.trim().equalsIgnoreCase(s)) {
					result++;
				} 								
			}
			return result;
				
		} catch (Exception e) {
			return (0);
		}
		
	}

	@Override
	public String getOBXComment(int i, int j, int k) {
		int[] s = getCorrectObxFlag(i, j);
		try {
			return (getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(s[0]).getOBSERVATION(s[1] + k + 1)
					.getOBX(), 5, 0, 1, 1)));
			// int lastOBX =
			// msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATIONReps() -
			// 1;
			// return
			// (getString(msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATION(j).getNTE(k).getComment(0).getValue()));
		} catch (Exception e) {
			return ("");
		}
	}

	@Override
	public String getAccessionNum() {
		String accessionNum = "";
		try {
			accessionNum = getString(msg.getRESPONSE().getORDER_OBSERVATION(0)
					.getOBR().getPlacerOrderNumber(0).getEntityIdentifier()
					.getValue());
			if (msg.getRESPONSE().getORDER_OBSERVATION(0).getOBR()
					.getFillerOrderNumber().getEntityIdentifier().getValue() != null) {
				accessionNum = accessionNum
						+ ", "
						+ getString(msg.getRESPONSE().getORDER_OBSERVATION(0)
								.getOBR().getFillerOrderNumber()
								.getEntityIdentifier().getValue());
			}
			return (accessionNum);
		} catch (Exception e) {
			logger.error("Could not return accession number", e);
			return ("");
		}
	}

	@Override
	public String getObservationHeader(int i, int j) {
		try {
			return this.getOBXHeader(i, j).trim();
		} catch (Exception e) {
			return ("");
		}
	}

	@Override
	public String getOBXName(int i, int j) {
		int[] s = getCorrectObxFlag(i, j);
		try {
//			return (getString(msg.getRESPONSE().getORDER_OBSERVATION(s[0]).getOBSERVATION(s[1]).getOBX().getObservationIdentifier().getText().getValue()));
			return (getString(Terser.get(msg.getRESPONSE().getORDER_OBSERVATION(s[0]).getOBSERVATION(s[1]).getOBX(), 3, 0, 3, 1)));
		} catch (Exception e) {
			return ("");
		}
	}

	public String getOBXHeader(int i, int j) {
		int[] s = getCorrectObxFlag(i, j);

		try {
			return (getString(Terser.get(msg.getRESPONSE().getORDER_OBSERVATION(s[0]).getOBSERVATION(s[1]).getOBX(), 3, 0, 1, 1)));
		} catch (Exception e) {
			return ("");
		}
	}

	@Override
	public String getOBXAbnormalFlag(int i, int j) {
		int[] s = getCorrectObxFlag(i, j);

		try {
			return (getString(msg.getRESPONSE().getORDER_OBSERVATION(s[0])
					.getOBSERVATION(s[1]).getOBX().getAbnormalFlags(0)
					.getValue()));
		} catch (Exception e) {
			return ("");
		}
	}

	@Override
	public String getOBXResult(int i, int j) {
		int[] s = getCorrectObxFlag(i, j);

		try {
			Terser terser = new Terser(msg);
			return (getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(s[0]).getOBSERVATION(s[1]).getOBX(),
					5, 0, 1, 1)));
		} catch (Exception e) {
			return ("");
		}
	}

	@Override
	public String getOBXReferenceRange(int i, int j) {
		int[] s = getCorrectObxFlag(i, j);

		try {
			return (getString(msg.getRESPONSE().getORDER_OBSERVATION(s[0])
					.getOBSERVATION(s[1]).getOBX().getReferencesRange()
					.getValue()));
		} catch (Exception e) {
			return ("");
		}
	}

	@Override
	public String getOBXUnits(int i, int j) {
		int[] s = getCorrectObxFlag(i, j);
		try {
			return (getString(msg.getRESPONSE().getORDER_OBSERVATION(s[0])
					.getOBSERVATION(s[1]).getOBX().getUnits().getIdentifier()
					.getValue()));
		} catch (Exception e) {
			return ("");
		}
	}

	public String getOBXHeaderWithInt(int i, int j) {
		try {
			return (getString(Terser.get(msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATION(j).getOBX(), 3, 0, 1, 1)));
		} catch (Exception e) {
			return ("");
		}
	}

	 public String getOBXIdentifier(int i, int j){
            int[] s = getCorrectObxFlag(i, j);
                try {
                        return (getString(Terser.get(msg.getRESPONSE().getORDER_OBSERVATION(s[0]).getOBSERVATION(s[1]).getOBX(), 3, 0, 2, 1)));
                } catch (Exception e) {
                        return ("");
                }
        }

	@Override
	public String getTimeStamp(int i, int j) {
		int[] s = getCorrectObxFlag(i, j);
		try {
			/*return (formatDateTime(getString(msg.getRESPONSE()
					.getORDER_OBSERVATION(s[0]).getOBSERVATION(s[1]).getOBX()
					.getDateTimeOfTheObservation().getTimeOfAnEvent()
					.getValue())));
					*/
			/*return(formatDateTime(getString(msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBR().getObservationDateTime().getTimeOfAnEvent().getValue())));
					*/
			/*
			return (formatDateTime(getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBR(), 6, 0, 1, 1))));
			*/
			String serviceDate = formatDateTime(getString(Terser.get(msg.getRESPONSE()
					.getORDER_OBSERVATION(i).getOBR(), 6, 0, 1, 1)));
				if(StringUtils.isBlank(serviceDate)) {					
						serviceDate = formatDateTime(getString(Terser.get(msg.getRESPONSE()
								.getORDER_OBSERVATION(i).getOBR(), 14, 0, 1, 1)));
					
				}
				return serviceDate;
					
		} catch (Exception e) {
			return ("");
		}
	}

	String delimiter = "  ";
	char bl = ' ';

	public String getAuditLine(String procDate, String procTime, String logId,
			String formStatus, String formType, String accession, String hcNum,
			String hcVerCode, String patientName, String orderingClient,
			String messageDate, String messageTime) {
		logger.info("Getting Audit Line");

		return getPaddedString(procDate, 11, bl) + delimiter
				+ getPaddedString(procTime, 8, bl) + delimiter
				+ getPaddedString(logId, 7, bl) + delimiter
				+ getPaddedString(formStatus, 1, bl) + delimiter
				+ getPaddedString(formType, 1, bl) + delimiter
				+ getPaddedString(accession, 9, bl) + delimiter
				+ getPaddedString(hcNum, 10, bl) + delimiter
				+ getPaddedString(hcVerCode, 2, bl) + delimiter
				+ getPaddedString(patientName, 61, bl) + delimiter
				+ getPaddedString(orderingClient, 8, bl) + delimiter
				+ getPaddedString(messageDate, 11, bl) + delimiter
				+ getPaddedString(messageTime, 8, bl) + "\n\r";

	}

	String getPaddedString(String originalString, int length, char paddingChar) {
		StringBuilder str = new StringBuilder(length);
		str.append(originalString);

		for (int i = str.length(); i < length; i++) {
			str.append(paddingChar);
		}

		return str.substring(0, length);
	}

	public String getHealthNumVersion() {
		try {
			return (getString(Terser.get(msg.getRESPONSE().getPATIENT().getPID(), 4, 0, 2, 1)));
		} catch (HL7Exception e) {
			return "";
		}
	}

	@Override
	public String getMsgDate() {
		try {
            return(formatDateTime(msg.getMSH().getDateTimeOfMessage().getTimeOfAnEvent().getValue()));
            //return(formatDateTime(msg.getRESPONSE().getORDER_OBSERVATION(0).getOBR().getObservationDateTime().getTimeOfAnEvent().getValue()));
		} catch (Exception e) {
            logger.error("Could not retrieve message date", e);
		}		
		return "";
	}
	
	public Date getMsgDateAsDate() {
		Date date = null;
		try {
			date = getDateTime(getMsgDate());
		} catch (Exception e) {
			logger.error("Error of parsing message date :", e);
		}
		return date;
	}

	private Date getDateTime(String plain) {
		String dateFormat = "yyyyMMddHHmmss";
		dateFormat = dateFormat.substring(0, plain.length());
		Date date = UtilDateUtilities.StringToDate(plain, dateFormat);
		return date;
	}

	public String getUnescapedName() {
		return getLastName() + "^" + getFirstName() + "^" + getMiddleName();
	}

	private String getMiddleName() {
		return (getString(msg.getRESPONSE().getPATIENT().getPID()
				.getMotherSMaidenName().getMiddleInitialOrName().getValue()));
	}
	
    @Override
	public String getPatientLocation(){
		return (getString(msg.getMSH().getSendingApplication().getNamespaceID()
				.getValue()));
    }


	@Override
	public String audit() {
		return "";		
	}
	
/* evk
	 public String getOBXName(int i, int j){
	        String ret = "";
	        try{
	            // leave the name blank if the value type is 'FT' this is because it
	            // is a comment, if the name is blank the obx segment will not be displayed
	            OBX obxSeg = msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATION(j).getOBX();
	            if ((obxSeg.getValueType().getValue()!=null) && (!obxSeg.getValueType().getValue().equals("FT")))
	                ret = getString(obxSeg.getObservationIdentifier().getText().getValue());
	        }catch(Exception e){
	            logger.error("Error returning OBX name", e);
	        }
	        
	        return ret;
	    }
	  
	 public String getOBXResult(int i, int j){
	        
	        String result = "";
	        try{
	            
	            Terser terser = new Terser(msg);
	            result = getString(terser.get(msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATION(j).getOBX(),5,0,1,1));
	            
	            // format the result
	            if (result.endsWith("."))
	                result = result.substring(0, result.length()-1);
	            
	        }catch(Exception e){
	            logger.error("Exception returning result", e);
	        }
	        return result;
	    }
	 
	 
	 
	 public String getOBXComment(int i, int j, int k){
	        String comment = "";
	        try{
	            k++;
	            
	            Terser terser = new Terser(msg);
	            OBX obxSeg = msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATION(j).getOBX();
	            comment = terser.get(obxSeg,7,k,1,1);
	            if (comment == null)
	                comment = terser.get(obxSeg,7,k,2,1);
	            
	        }catch(Exception e){
	            logger.error("Cannot return comment", e);
	        }
	        return comment.replaceAll("\\\\\\.br\\\\", "<br />");
	    }
	  
	 public String getOBRComment(int i, int j){
	        String comment = "";
	        
	        // update j to the number of the comment not the index of a comment array
	        j++;
	        try {
	            Terser terser = new Terser(msg);
	            
	            int obxCount = getOBXCount(i);
	            int count = 0;
	            int l = 0;
	            OBX obxSeg = null;
	            
	            while ( l < obxCount && count < j){
	                
	                obxSeg = msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATION(j).getOBX();
	                if (getString(obxSeg.getValueType().getValue()).equals("FT")){
	                    count++;
	                }
	                l++;
	                
	            }
	            l--;
	            
	            int k = 0;
	            String nextComment = terser.get(obxSeg,5,k,1,1);
	            while(nextComment != null){
	                comment = comment + nextComment.replaceAll("\\\\\\.br\\\\", "<br />");
	                k++;
	                nextComment = terser.get(obxSeg,5,k,1,1);
	            }
	            
	        } catch (Exception e) {
	            logger.error("getOBRComment error", e);
	            comment = "";
	        }
	        if (comment.equals(getOBXResult(i,j))) comment = "";
	        return comment;
	    }
*/	 
	 public int getOBRCommentCount(int i){
	        int count = 0;
	        try {
	        	for (int j=0; j < getOBXCount(i); j++){
		            if (getString(msg.getRESPONSE().getORDER_OBSERVATION(i).getOBSERVATION(j).getOBX().getValueType().getValue()).equals("FT"))
		                count++;
		        }
	        } catch (Exception e){
	        	logger.error("Error getting OBRCommentCount");
	        }
	        
	        
	        return count;
	        
	    }
	 
	 /**
	     *  Retrieve the possible segment headers from the OBX fields
	     */
	@Override
	public ArrayList getHeaders() {
		int i;
		int j;
		int k = 0;
	        ArrayList<String> headers = new ArrayList<String>();
	        String currentHeader;
	        try{
	            for (i=0; i < msg.getRESPONSE().getORDER_OBSERVATIONReps(); i++){
	                
				for (j = 0; j < msg.getRESPONSE().getORDER_OBSERVATION(i)
						.getOBSERVATIONReps(); j++) {
					// only check the obx segment for a header if it is one that
					// will be displayed
					if (!getOBXHeaderWithInt(i, j).equals("")) {
						currentHeader = getOBXHeaderWithInt(i, j);
	                        
	                        if (!headers.contains(currentHeader)){
							logger.info("Adding header: '" + currentHeader
									+ "' to list");
	                            headers.add(currentHeader);
	                        }
					}
	                    
	                }
	                
	            }
	            return(headers);
	        }catch(Exception e){
	            logger.error("Could not create header list", e);
	            
	            return(null);
	        }
	    }
	    
	public static void main(String[] args) throws IOException, HL7Exception {
		StringBuilder sb = new StringBuilder();
//		sb.append("MSH|^~\\&|Epsilon Systems||||200911191011||ORU^R01|20091119100500|P||||||||");
//		sb.append("PID|1||0831710000|1234567890|XYZ^ABC||19531108|M|||10 XYZ ABC RD^TORONTO^ON||4162567278||||||||||||||||||");
//		sb.append("OBR|1||||R|201201270001||||||||201201270001||022468^KHAN^DR.M A|905 450 2981||||||||F|||||||||||||||||||");
//		sb.append("OBX|1|NM|IMMUNOASSAY^FER^Ferritin||69|�g/L|24-336||||F||||||");
//		sb.append("OBX|2|NM|IMMUNOASSAY^B12^Vitamin B12|1|109|pmol/L|133-675|L|||F||||||");
//		sb.append("OBX|3|FT|IMMUNOASSAY^B12^Vitamin B12|2|Intermediate Range : 107 - 132 pmol/L||||||F||||||");
//		sb.append("OBX|4|FT|IMMUNOASSAY^B12^Vitamin B12|3|Deficient Range : < 107 pmol/L||||||F||||||");
//		sb.append("OBX|5|FT|IMMUNOASSAY^B12^Vitamin B12|4|Vitamin B12 assays should be considered for assessment of peripheral neuropathy,||||||F||||||");
//		sb.append("OBX|6|FT|IMMUNOASSAY^B12^Vitamin B12|5|megaloblastic anemia or malabsorptive conditions. Routine screening should only be||||||F||||||");
//		sb.append("OBX|7|FT|IMMUNOASSAY^B12^Vitamin B12|6|ordered on seniors and then only once every few years. In lieu of testing, oral||||||F||||||");
//		sb.append("OBX|8|FT|IMMUNOASSAY^B12^Vitamin B12|7|supplementation should be considered for individuals suspected of vitamin B12 deficiency.||||||F||||||");
//		sb.append("OBX|9|NM|IMMUNOASSAY^TSH^TSH (Ultra-sensitive)|1|0.53|mIU/L |0.35-4.94||||F||||||");
//		sb.append("OBX|10|FT|IMMUNOASSAY^TSH^TSH (Ultra-sensitive)|2|Asymptomatic patients should generally not be screened for thyroid disease||||||F||||||");
//		sb.append("OBX|11|FT|IMMUNOASSAY^TSH^TSH (Ultra-sensitive)|3|(exceptions include pregnant, post-partum or post-menopausal women). Thyroid||||||F||||||");
//		sb.append("OBX|12|FT|IMMUNOASSAY^TSH^TSH (Ultra-sensitive)|4|function in patients with suspected thyroid disease is best assessed with TSH as the||||||F||||||");
//		sb.append("OBX|13|FT|IMMUNOASSAY^TSH^TSH (Ultra-sensitive)|5|sole screening test. It is not appropriate to order free�T4 and/or free-T3 in addition to||||||F||||||");
//		sb.append("OBX|14|FT|IMMUNOASSAY^TSH^TSH (Ultra-sensitive)|6|TSH in the initial screen.||||||F||||||");
//		sb.append("OBX|15|NM|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|1|5.9||||||F||||||");
//		sb.append("OBX|16|FT|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|2|10 Year Risk Category Target Lipid Values||||||F||||||");
//		sb.append("OBX|17|FT|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|3|LDL-C mmol/L T Chol/HDL ratio||||||F||||||");
//		sb.append("OBX|18|FT|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|4|High: (>=20% or history of||||||F||||||");
//		sb.append("OBX|19|FT|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|5|diabetes mellitus or||||||F||||||");
//		sb.append("OBX|20|FT|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|6|any atherosclerotic < 2.0 and < 4.0||||||F||||||");
//		sb.append("OBX|21|FT|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|7|disease)||||||F||||||");
//		sb.append("OBX|22|FT|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|8|Moderate: (10-19%) < 3.5 and < 5.0||||||F||||||");
//		sb.append("OBX|23|FT|GENERAL CHEMISTRY^C/H^Total Cholesterol: HDL Ratio|9|Low: (<10%) < 5.0 and < 6.0||||||F||||||");
//		sb.append("OBX|24|NM|GENERAL CHEMISTRY^LDL^LDL Cholesterol||3.76|mmol/L|< 3.36|H|||F||||||");
//		sb.append("OBX|25|NM|GENERAL CHEMISTRY^HDL^HDL Cholesterol||1.06|mmol/L|0.75-1.85||||F||||||");
//		sb.append("OBX|26|NM|GENERAL CHEMISTRY^TRI^Triglycerides||3.18|mmol/L|< 1.50|H|||F||||||");
//		sb.append("OBX|27|NM|GENERAL CHEMISTRY^CHO^Cholesterol||6.26|mmol/L|< 5.20|H|||F||||||");
//		sb.append("OBX|28|NM|GENERAL CHEMISTRY^ALT^ALT (SGPT)||34|U/L |17-63||||F||||||");
//		sb.append("OBX|29|NM|GENERAL CHEMISTRY^EGFR^EGFR|1|81|mL/min/1.73m\\E\\S\\E\\2|||||F||||||");
//		sb.append("OBX|30|FT|GENERAL CHEMISTRY^EGFR^EGFR|2|||||||F||||||");
//		sb.append("OBX|31|FT|GENERAL CHEMISTRY^EGFR^EGFR|3|For Patients of African descent, the reported eGFR must be multiplied by a correction||||||F||||||");
//		sb.append("OBX|32|FT|GENERAL CHEMISTRY^EGFR^EGFR|4|factor of 1.21||||||F||||||");
//		sb.append("OBX|33|FT|GENERAL CHEMISTRY^EGFR^EGFR|5|eGFR = 30-59 mL/min/1.73m\\E\\S\\E\\2 : Consistent with moderate chronic kidney disease||||||F||||||");
//		sb.append("OBX|34|FT|GENERAL CHEMISTRY^EGFR^EGFR|6|if result confirmed by repeat testing in 3 months.||||||F||||||");
//		sb.append("OBX|35|FT|GENERAL CHEMISTRY^EGFR^EGFR|7|eGFR = 15-29 mL/min/1.73m\\E\\S\\E\\2 : Consistent with severe chronic kidney disease||||||F||||||");
//		sb.append("OBX|36|FT|GENERAL CHEMISTRY^EGFR^EGFR|8|eGFR = < 15 mL/min/1.73m\\E\\S\\E\\2 : Consistent with kidney failure||||||F||||||");
//		sb.append("OBX|37|FT|GENERAL CHEMISTRY^EGFR^EGFR|9|[ MDRD = Modification of Diet in Renal Disease ]||||||F||||||");
//		sb.append("OBX|38|FT|GENERAL CHEMISTRY^EGFR^EGFR|10|||||||F||||||");
//		sb.append("OBX|39|NM|GENERAL CHEMISTRY^CRT^Creatinine||90|�mol/L|50-115||||F||||||");
//		sb.append("OBX|40|NM|GENERAL CHEMISTRY^BSF^Glucose Fasting||4.3|mmol/L|4.2-6.1||||F||||||");
		 File f = new File("D:\\sample.hl7");
		 FileReader fr = new FileReader(f);
		 BufferedReader br = new BufferedReader(fr);
		 String s=null;
		 while((s=br.readLine())!=null){
			 sb.append(s);
			 sb.append("\n");
		 }
		 br.close();
		System.out.println(sb.toString());
		EpsilonHandler eh = new EpsilonHandler();

		eh.init(sb.toString());

		System.out.println(eh.getHeaders());
		System.out.println("obrcount" + eh.getOBRCount());
		for (int i = 0; i < eh.getOBRCount(); i++) {
			System.out.println("obr name of " + i + " is " + eh.getOBRName(i));
			System.out.println("obxcount in " + i + " is" + eh.getOBXCount(i));

			for (int j = 0; j < eh.getOBXCount(i); j++) {
				System.out.println(eh.getOBXName(i, j));
				System.out.println(eh.getOBXResult(i, j));
				for (int k = 0; k < eh.getOBXCommentCount(i, j); k++)
					System.out.println(eh.getOBXComment(i, j, k));
			}
		}
	}
}
