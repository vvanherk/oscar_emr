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

package org.oscarehr.PMmodule.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.oscarehr.PMmodule.dao.BedDAO;
import org.oscarehr.PMmodule.dao.ProgramDao;
import org.oscarehr.PMmodule.dao.ProgramTeamDAO;
import org.oscarehr.PMmodule.dao.RoomDAO;
import org.oscarehr.PMmodule.exception.BedReservedException;
import org.oscarehr.PMmodule.exception.DuplicateBedNameException;
import org.oscarehr.PMmodule.model.Bed;
import org.oscarehr.PMmodule.model.BedDemographic;
import org.oscarehr.PMmodule.model.BedType;
import org.oscarehr.PMmodule.model.JointAdmission;
import org.oscarehr.PMmodule.model.Program;
import org.oscarehr.PMmodule.model.Room;
import org.oscarehr.util.MiscUtils;
import org.springframework.transaction.annotation.Transactional;

/**
 * Implementation of BedManager interface
 */
@Transactional
public class BedManager {

    private static final Logger log=MiscUtils.getLogger();
    private static <T extends Exception> void handleException(T e) throws T {
        log.error("Error", e);
        throw e;
    }

    private BedDAO bedDAO;
    private RoomDAO roomDAO;
    private ProgramTeamDAO teamDAO;
    private BedDemographicManager bedDemographicManager;
    private ProgramDao programDao;

    public void setBedDAO(BedDAO bedDAO) {
        this.bedDAO = bedDAO;
    }

    public void setRoomDAO(RoomDAO roomDAO) {
        this.roomDAO = roomDAO;
    }

    public void setTeamDAO(ProgramTeamDAO teamDAO) {
        this.teamDAO = teamDAO;
    }
    
    public void setProgramDao(ProgramDao programDao) {
        this.programDao = programDao;
    }

    public void setBedDemographicManager(BedDemographicManager bedDemographicManager) {
        this.bedDemographicManager = bedDemographicManager;
    }

    /**
     * Get bed
     *
     * @param bedId
     *            bed identifier
     * @return bed
     */
    public Bed getBed(Integer bedId) {
        if (bedId == null) {
            handleException(new IllegalArgumentException("bedId must not be null"));
        }

        Bed bed = bedDAO.getBed(bedId);
        setAttributes(bed);

        return bed;
    }

    public Bed getBedForDelete(Integer bedId) {
        if (bedId == null) {
            handleException(new IllegalArgumentException("bedId must not be null"));
        }
        Bed bed = bedDAO.getBed(bedId);
        return bed;
    }

    /**
     * Get beds by program
     *
     * @param programId
     *            program identifier
     * @param reserved
     *            reserved flag
     * @return array of beds
     */
    public Bed[] getBedsByProgram( Integer programId, boolean reserved) {
        if (programId == null) {
            return new Bed[] {};
        }

        List<Bed> beds = new ArrayList<Bed>();

        for (Room room : roomDAO.getRooms(null, programId, Boolean.TRUE)) {
            for (Bed bed : bedDAO.getBedsByRoom(room.getId(), Boolean.TRUE)) {
                setAttributes(bed);

                if (!filterBed(bed, reserved)) {
                    beds.add(bed);
                }
            }
        }

        return beds.toArray(new Bed[beds.size()]);
    }

    /**
     * Get beds by available rooms & assigned program
     *
     * @param availableRooms
     * @param programId
     *            program identifier
     * @param reserved
     *            reserved flag
     * @return array of beds
     */
    public Bed[] getBedsByRoomProgram(Room[] availableRooms, Integer programId, boolean reserved) {
        if (programId == null) {
            return new Bed[] {};
        }
        List<Bed> beds = new ArrayList<Bed>();

        for (Room room : availableRooms) {
            for (Bed bed : bedDAO.getBedsByRoom(room.getId(), Boolean.TRUE)) {
                setAttributes(bed);

                if (!filterBed(bed, reserved)) {
                    beds.add(bed);
                }
            }
        }
        return beds.toArray(new Bed[beds.size()]);
    }
    
    /**
     * Get beds by facility
     *
     * @param facilityId
     *            facility identifier
     * @param reserved
     *            reserved flag
     * @return array of beds
     */
/*
    public Bed[] getBedsByFacility(Integer facilityId, boolean reserved) {
        if (facilityId == null) {
            return new Bed[] {};
        }
        List<Bed> beds = new ArrayList<Bed>();
        for (Bed bed : bedDAO.getBedsByFacility(facilityId, Boolean.TRUE)) {
            setAttributes(bed);

            if (!filterBed(bed, reserved)) {
                beds.add(bed);
            }
        }
        return beds.toArray(new Bed[beds.size()]);
    }
    
    public Bed[] getBedsByFacility(Integer facilityId, Integer roomId, Boolean active, boolean reserved) {
        if (facilityId == null) {
            return new Bed[] {};
        }
        List<Bed> beds = new ArrayList<Bed>();
        for (Bed bed : bedDAO.getBedsByFacility(facilityId, active)) {
            setAttributes(bed);

            if (!filterBed(bed, reserved)) {
                beds.add(bed);
            }
        }
        return beds.toArray(new Bed[beds.size()]);
    }
*/
    
    public List<Bed> getBedsByFilter(Integer facilityId, Integer roomId, Boolean active,  boolean reserved) {
    	List<Bed> beds = new ArrayList<Bed>();
        for (Bed bed : bedDAO.getBedsByFilter(facilityId, roomId, active)) {
            setAttributes(bed);
            
            // We have decided that all beds(reserved and non-reserved) should be shown up
            // not only show the beds are not being reserved.
            /* so filterBed(..) is not useful anymore until we hear other's idea
            if (!filterBed(bed, reserved)) {
                beds.add(bed);
            }
            */
            beds.add(bed);
        }
        return beds;
    }
    
    /**
     * Get beds by facility
     *
     * @param facilityId
     *            facility identifier
     * @param reserved
     *            reserved flag
     * @return array of beds
     */
    public Bed[] getBedsByFacility(Integer facilityId) {
        if (facilityId == null) {
            return new Bed[] {};
        }
        List<Bed> beds = new ArrayList<Bed>();

        for (Bed bed : bedDAO.getBedsByFacility(facilityId, Boolean.TRUE)) {
            setAttributes(bed);
            beds.add(bed);
        }
        return beds.toArray(new Bed[beds.size()]);
    }

    /**
     * Get beds by facility
     *
     * @param facilityId the facility we're looking up
     * @param reserved
     *            reserved flag
     * @return array of beds
     */
    public Bed[] getBedsByProgramAndFacility(Integer facilityId, boolean reserved) {
        List<Bed> beds = new ArrayList<Bed>();

        for (Room room : roomDAO.getRooms(facilityId, null, Boolean.TRUE)) {
            for (Bed bed : bedDAO.getBedsByRoom(room.getId(), Boolean.TRUE)) {
                setAttributes(bed);

                if (!filterBed(bed, reserved)) {
                    beds.add(bed);
                }
            }
        }

        return beds.toArray(new Bed[beds.size()]);
    }

    /**
     * Get beds
     *
     * @return array of beds
     */
    public Bed[] getBeds() {
        Bed[] beds = bedDAO.getBedsByRoom(null, null);

        for (Bed bed : beds) {
            setAttributes(bed);
        }

        return beds;
    }
    /**
     * Get beds by roomId
     * @param roomId
     * @return array of beds
     */
    public Bed[] getBedsByRoom(Integer roomId) {
        Bed[] beds = bedDAO.getBedsByRoom(roomId, Boolean.TRUE);
        for (Bed bed : beds) {
            setAttributes(bed);
        }
        return beds;
    }
    public Bed[] getBedsForDeleteByRoom(Integer roomId) {
        Bed[] beds = bedDAO.getBedsByRoom(roomId, Boolean.TRUE);
        return beds;
    }

    /*
     * 
     * (e.g. used in BedManagerAction.saveBeds() )
     * 
     * @param rooms
     * @param beds
     * @return array of beds
     */
    public Bed[] getBedsForUnfilledRooms(Room[] rooms, Bed[] beds){
    	
    	if(rooms == null  ||  beds == null){
    		return null;
    	}
    	
    	List<Bed> bedList = new ArrayList<Bed>();
    	for(int i=0; i < beds.length; i++){
    		
    		for(int j=0; j < rooms.length; j++){
    			
    			if(beds[i].getRoomId().intValue() == rooms[j].getId().intValue()){
    				bedList.add(beds[i]);
    				break;
    			}
    		}
    	}
    	return bedList.toArray(new Bed[bedList.size()]);
    }
    /**
     * Get unreserved beds by roomId and clientBedId
     * @param roomId
     * @param clientBedId
     * @return array of beds
     */
    public Bed[] getReservedBedsByRoom(Integer roomId, boolean reserved) {
        Bed[] beds = bedDAO.getBedsByRoom(roomId, Boolean.TRUE);
        List<Bed> bedList = new ArrayList<Bed>();
        for (Bed bed : beds) {
            setAttributes(bed);
            
            // filter for unreserved beds for roomId only
            if (!filterBed(bed, reserved)) {
            	bedList.add(bed);
            }
        }
        return bedList.toArray(new Bed[bedList.size()]);
    }
    
    /**
     * Get unreserved beds by roomId and clientBedId
     * @param roomId
     * @param clientBedId
     * @return array of beds
     */
    public Bed[] getCurrentPlusUnreservedBedsByRoom(Integer roomId, Integer clientBedId, boolean reserved) {
        Bed[] beds = bedDAO.getBedsByRoom(roomId, Boolean.TRUE);
        List<Bed> bedList = new ArrayList<Bed>();
        
        for (Bed bed : beds) {
            setAttributes(bed);
            
            // filter for unreserved beds for roomId only
            if (!filterBed(bed, reserved)) {
            	bedList.add(bed);
            }
            // include the reserved bed of this current room/bed combination for changing
            if(bed.getId().intValue() == clientBedId  &&  bed.getRoomId().intValue() == roomId){
            	bedList.add(bed);
            }
        }
        return bedList.toArray(new Bed[bedList.size()]);
    }
 

    /**
	 * Used by AdmissionManager during processDischarge()  to  delete discharged 
	 * program-related room/bed reservation records
     * @param demographicNo
     * @param programId
     */
    public boolean isBedOfDischargeProgramAssignedToClient(Integer demographicNo, Integer programId){
    	/*
		 *(1)admission.clientId ===[table:bed_demographic]===>>  bedDemographic.bedId
		 *(2)bedDemographic.bedId ===[table:bed]===>>  bed.roomId
		 *(3)bed.roomId ===[table:room]===>>   room.programId
		 *(4)Compare  admission.programId  with  room.programId
	     *   - if true -->  delete  bedDemographic record
		 *   - if false -->  do nothing
    	 */
    	if(demographicNo == null  ||  programId == null){
    		return false;
    	}
        
    	Program program=programDao.getProgram(programId);
        Integer facilityId=null;
        if (program!=null) facilityId=(int)program.getFacilityId();

        BedDemographic bedDemographic = bedDemographicManager.getBedDemographicByDemographic(demographicNo, facilityId);
    	if(bedDemographic != null){
	    	Bed bed = getBed(bedDemographic.getId().getBedId());
	    	if(bed != null){
		    	Room room = roomDAO.getRoom(bed.getRoomId());
		    	if(room != null  &&  programId.intValue() == room.getProgramId().intValue()){
		    		return true;
		    	}
	    	}
    	}
    	return false;
    }
    
    public Integer[] getBedClientIds(Bed[] beds){
    	
    	Integer[] bedClientIds = null;
        if(beds != null  &&  beds.length > 0){
        	BedDemographic bd = null;
        	bedClientIds = new Integer[beds.length];
        	for(int i=0; i < beds.length; i++){
        		bd = bedDemographicManager.getBedDemographicByBed(beds[i].getId());
        		if(bd != null){
        			bedClientIds[i] = bd.getId().getDemographicNo();
        		}else{
        			bedClientIds[i] = null;
        		}
        	}
        }
        return bedClientIds;

    }
    
    public Bed[] addFamilyIdsToBeds(ClientManager clientManager, Bed[] beds){
    	
    	if(clientManager == null  ||  beds == null  ||  beds.length <= 0){
    		return null;
    	}
    	Integer[] bedClientIds = new Integer[beds.length];
    	JointAdmission clientsJadmFamily = null;
    	boolean isFamilyHead = false;
    	Integer headRecord = 0;
    	
	    if(beds != null  &&  beds.length > 0){
	    	BedDemographic bd = null;
	    	
	    	for(int i=0; i < beds.length; i++){
	    		bd = bedDemographicManager.getBedDemographicByBed(beds[i].getId());
	    		if(bd != null){
	    			bedClientIds[i] = bd.getId().getDemographicNo();
	    			clientsJadmFamily = clientManager.getJointAdmission(Long.valueOf(bedClientIds[i].toString()));
	    			isFamilyHead = clientManager.isClientFamilyHead(bedClientIds[i]);
	    			if(clientsJadmFamily != null){
	    				headRecord = Integer.valueOf(clientsJadmFamily.getHeadClientId().toString());
	    			}else if(isFamilyHead){
	    				headRecord = bedClientIds[i];
	    			}else{
	    				headRecord = null;
	    			}
	   			    isFamilyHead = false;
	    			beds[i].setFamilyId(headRecord);
	    		}else{
	    			bedClientIds[i] = null;
	    			beds[i].setFamilyId(null);
	    		}
	    	}
	    }
	    return beds;
    }
    /**
     * @see org.oscarehr.PMmodule.service.BedManager#getBedTypes()
     */
    public BedType[] getBedTypes() {
        return bedDAO.getBedTypes();
    }

    /**
     * Add new beds
     *
     * @param numBeds
     *            number of beds
     * @throws BedReservedException
     *             bed is inactive and reserved
     */
    public void addBeds(Integer facilityId, Integer roomId, int numBeds) throws BedReservedException {
        if (numBeds < 1) {
            handleException(new IllegalArgumentException("numBeds must be greater than or equal to 1"));
        }

        BedType defaultBedType = getDefaultBedType();

        for (int i = 0; i < numBeds; i++) {
            saveBed(Bed.create(facilityId, roomId, defaultBedType));
        }
    }

    /**
     * Save beds
     *
     * @param beds
     *            beds to save
     * @throws BedReservedException
     *             bed is inactive and reserved
     */
    public void saveBeds(Bed[] beds) throws BedReservedException, DuplicateBedNameException {
        if (beds == null) {
            handleException(new IllegalArgumentException("beds must not be null"));
        }

		// Checks if there are beds with same name in the same room.
		ArrayList<Bed> duplicateBeds = new ArrayList<Bed>();
		
		for (int i = 0; i < beds.length; i++) {
			for (int j = 0; j < beds.length; j++) {
				if (i == j)
					continue;
				if (beds[i].getName().equals(beds[j].getName())
						&& beds[i].getRoomId().intValue() == beds[j].getRoomId().intValue()) {
					
					beds[i].setRoom(roomDAO.getRoom(beds[i].getRoomId()));
					duplicateBeds.add(beds[i]);
					StringBuilder errMsg = new StringBuilder();
					for (Iterator it = duplicateBeds.iterator(); it.hasNext();) {
						Bed theBed = (Bed) it.next();
						if(theBed != null){
							errMsg.append(theBed.getName() + " " + theBed.getRoomName());
						}
					}
					handleException(new DuplicateBedNameException(errMsg.toString()));
					return;
				}
			}
		}
        for (Bed bed : beds) {
            saveBed(bed);
        }
    }

    /**
     * Save bed
     *
     * @param bed
     *            bed to save
     * @throws BedReservedException
     *             bed is inactive and reserved
     */
    public void saveBed(Bed bed) throws BedReservedException {
        validate(bed);
        bedDAO.saveBed(bed);
    }

    public void deleteBed(Bed bed) {
        
        bedDAO.deleteBed(bed);
    }

    BedType getDefaultBedType() {
        for (BedType bedType : getBedTypes()) {
            if (bedType.isDefault()) {
                return bedType;
            }
        }

        handleException(new IllegalStateException("no default bed type"));

        return null;
    }

    boolean filterBed(Bed bed, Boolean reserved) {
        if (reserved == null) {
            return false;
        }

        return reserved != bed.isReserved();
    }

    void setAttributes(Bed bed) {
   		bed.setBedType(bedDAO.getBedType(bed.getBedTypeId()));
        if (bed.getRoomId() != null){
            bed.setRoom(roomDAO.getRoom(bed.getRoomId()));
        }

        Integer teamId = bed.getTeamId();

        if (teamId != null) {
            bed.setTeam(teamDAO.getProgramTeam(teamId));
        }

        BedDemographic bedDemographic = bedDemographicManager.getBedDemographicByBed(bed.getId());

        if (bedDemographic != null) {
            bed.setBedDemographic(bedDemographic);
        }
    }

    void validate(Bed bed) throws BedReservedException {
        if (bed == null) {
            handleException(new IllegalStateException("bed must not be null"));
        }

        validateBed(bed.getId(), bed);
        validateBedType(bed.getBedTypeId());
        validateRoom(bed.getRoomId());
        validateTeam(bed.getTeamId());
    }

    void validateBed(Integer bedId, Bed bed) throws BedReservedException {
        if (bedId != null) {
            if (!bedDAO.bedExists(bedId)) {
                handleException(new IllegalStateException("no bed with id : " + bedId));
            }

            if (!bed.isActive() && bedDemographicManager.demographicExists(bed.getId())) {
                handleException(new BedReservedException("bed with id : " + bedId + " has a reservation"));
            }
        }
    }

    void validateBedType(Integer bedTypeId) {
        if (!bedDAO.bedTypeExists(bedTypeId)) {
            handleException(new IllegalStateException("no bed type with id : " + bedTypeId));
        }
    }

    void validateRoom(Integer roomId) {
        if (roomId != null && !roomDAO.roomExists(roomId)) {
            handleException(new IllegalStateException("no room with id : " + roomId));
        }
    }

    void validateTeam(Integer teamId) {
        if (teamId != null && !teamDAO.teamExists(teamId)) {
            handleException(new IllegalStateException("no team with id : " + teamId));
        }
    }

}
