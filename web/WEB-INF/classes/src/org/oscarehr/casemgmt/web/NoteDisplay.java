package org.oscarehr.casemgmt.web;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;

public interface NoteDisplay {
	public static Comparator<NoteDisplay> noteProviderComparator = new Comparator<NoteDisplay>() {
		public int compare(NoteDisplay note1, NoteDisplay note2) {
			if (note1 == null || note2 == null) {
				return 0;
			}

			return note1.getProviderName().compareTo(note2.getProviderName());
		}
	};

	public static Comparator<NoteDisplay> noteProgramComparator = new Comparator<NoteDisplay>() {
		public int compare(NoteDisplay note1, NoteDisplay note2) {
			if (note1 == null || note1.getProgramName() == null || note2 == null || note2.getProgramName() == null) {
				return 0;
			}
			return note1.getProgramName().compareTo(note2.getProgramName());
		}
	};

	public static Comparator<NoteDisplay> noteRoleComparator = new Comparator<NoteDisplay>() {
		public int compare(NoteDisplay note1, NoteDisplay note2) {
			if (note1 == null || note2 == null) {
				return 0;
			}
			return note1.getRoleName().compareTo(note2.getRoleName());
		}
	};

	public static Comparator<NoteDisplay> noteObservationDateComparator = new Comparator<NoteDisplay>() {
		public int compare(NoteDisplay note1, NoteDisplay note2) {
			if (note1 == null || note2 == null) {
				return 0;
			}

			return note2.getObservationDate().compareTo(note1.getObservationDate());
		}
	};
	
	public Integer getNoteId();

	public boolean isSigned();

	public boolean isEditable();

	public Date getObservationDate();

	public String getRevision();

	public Date getUpdateDate();

	public String getProviderName();

	public String getProviderNo();

	public String getStatus();

	public String getProgramName();

	public String getLocation();

	public String getRoleName();

	public Integer getRemoteFacilityId();

	public String getUuid();

	public boolean getHasHistory();

	public boolean isLocked();

	public String getNote();

	public boolean isDocument();

	public String getEncounterType();

	public ArrayList<String> getEditorNames();
	
	public ArrayList<String> getIssueDescriptions();
}