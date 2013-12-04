/*
 * Copyright (c) 2008-2012 Indivica Inc.
 *
 * This software is made available under the terms of the
 * GNU General Public License, Version 2, 1991 (GPLv2).
 * License details are available via "indivica.ca/gplv2"
 * and "gnu.org/licenses/gpl-2.0.html".
 */

var isEyeform = true;

var COPY_LAST_IMPRESSION_TXT = "--Copy last impression--";


/*
 * Utility Functions
 */
Object.keys = Object.keys || (function () {
	var hasOwnProperty = Object.prototype.hasOwnProperty,
	hasDontEnumBug = !{toString:null}.propertyIsEnumerable("toString"),
	DontEnums = ['toString', 'toLocaleString', 'valueOf', 'hasOwnProperty', 'isPrototypeOf', 'propertyIsEnumerable', 'constructor'],
	DontEnumsLength = DontEnums.length;

	return function (o) {
		if (typeof o != "object" && typeof o != "function" || o === null)
			throw new TypeError("Object.keys called on a non-object");

		var result = [];
		for (var name in o) {
			if (hasOwnProperty.call(o, name))
				result.push(name);
		}

		if (hasDontEnumBug) {
			for (var i = 0; i < DontEnumsLength; i++) {
				if (hasOwnProperty.call(o, DontEnums[i]))
					result.push(DontEnums[i]);
			}
		}

		return result;
	};
})();


//http://stackoverflow.com/questions/499126/jquery-set-cursor-position-in-text-area
(function($) {
	$.fn.setCursorPosition = function(pos) {
		if ($(this).get(0).setSelectionRange) {
			$(this).get(0).setSelectionRange(pos, pos);
		} else if ($(this).get(0).createTextRange) {
			var range = $(this).get(0).createTextRange();
			range.collapse(true);
			range.moveEnd('character', pos);
			range.moveStart('character', pos);
			range.select();
		}
	};
})(jQuery);


Date.prototype.toFormattedString = function() {
	var year = this.getUTCFullYear();
	var month = this.getUTCMonth() + 1 + "";
	month = (month.length == 1 ? "0" + month : month);
	var day = this.getUTCDate() + "";
	day = (day.length == 1 ? "0" + day : day);

	return year + "-" + month + "-" + day;
};



/**
 * Eyeform Variables
 */
var impressionHistoryIssueId;
var currentPresentingIssueId;
var lastAppointmentNo = "999";
var savedForm = false;

var dateCalc = new Date();
dateCalc.setHours(0);
dateCalc.setMinutes(0);
dateCalc.setSeconds(0);
dateCalc.setMilliseconds(0);
var baselineDate = dateCalc.getTime();

var endOfToday = new Date();
endOfToday.setHours(23);
endOfToday.setMinutes(59);
endOfToday.setSeconds(59);

var openTime = new Date();


var dateRange = {
		"Off": baselineDate + 10000000000,
		"Last 3 Hours": baselineDate - 10800000,
		"Last Day": baselineDate - 86400000,
		"Last Three Days": baselineDate - 259200000,
		"Past Week": baselineDate - 604800000,
		"Past Month": baselineDate - 2629743000,
		"Past 3 Months": baselineDate - 7889229000,
		"Past 6 Months": baselineDate - 15778458000,
		"Past Year": baselineDate - 31556926000
};

var defaultDateRange = 1;

//For selecting/displaying an entire date's worth of data at once
var appointmentDate = [];


var BoxIssueUrls = {
		"macro": ctx + "/oscarEncounter/displayMacro.do",
		"specsHistory": ctx + "/oscarEncounter/displaySpecsHistory.do",
		"procedures": ctx + "/oscarEncounter/displayOcularProcedure.do",
		"consultations": ctx + "/oscarEncounter/displayConsultation.do?appointment_no=" + appointmentNo,
		"labResults": ctx + "/oscarEncounter/displayLabs.do",
		"documents": ctx + "/oscarEncounter/displayDocuments.do",
		"diagrams": ctx + "/oscarEncounter/displayDiagrams.do?appointment_no=" + appointmentNo,
		"tickler": ctx + "/oscarEncounter/displayTickler.do",
		"messages": ctx + "/oscarEncounter/displayMessages.do",
		"billing": ctx + "/oscarEncounter/displayBilling.do",
		"ocularMeds": ctx + "/oscarEncounter/displayRx.do",
		"allergies": ctx + "/oscarEncounter/displayAllergy.do",
		"consultationReport": ctx + "/oscarEncounter/displayConReport.do?appointment_no=" + appointmentNo
};

var cmds = {
		"macro": "macro",
		"consultations": "consultation",
		"specsHistory": "specshistory",
		"procedures": "ocularprocedure",
		"labResults": "labs",
		"documents": "docs",
		"diagrams": "diagrams",
		"tickler": "tickler",
		"messages": "msgs",
		"billing": "Billing",
		"ocularMeds": "Rx",
		"allergies": "allergies",
		"consultationReport": "conReport"
};

var noteBoxes = {
		"diagnostics": "DiagnosticNotes",
		"medicalOcularHistory": "MedHistory",
		"patientLog": "PatientLog",
		"reminders": "Reminders",
		"impressionHistory": "eyeformImpression",
		"planHistory": "eyeformPlan",
		"currentIssueHistory": "eyeformCurrentIssue",
		"officeCommunication": "officeCommunication",
		"ocularHistory": "PastOcularHistory",
		"familyMedicalOcularHistory": "FamHistory",
		"eyedrops": "OcularMedication",
		"otherMeds": "OMeds"
};

var measurementsToTypes = {
		"ar_sph": "visionPretest",
		"ar_cyl": "visionPretest",
		"ar_axis": "visionPretest",
		"k1": "visionPretest",
		"k2": "visionPretest",
		"k2_axis": "visionPretest",
		"sc_distance": "visionPretest",
		"cc_distance": "visionPretest",
		"ph_distance": "visionPretest",
		"sc_near": "visionPretest",
		"cc_near": "visionPretest",

		"manifest_refraction_sph": "visionManifest",
		"manifest_refraction_cyl": "visionManifest",
		"manifest_refraction_axis": "visionManifest",
		"manifest_refraction_add": "visionManifest",
		"manifest_distance": "visionManifest",
		"manifest_near": "visionManifest",
		"cycloplegic_refraction_sph": "visionManifest",
		"cycloplegic_refraction_cyl": "visionManifest",
		"cycloplegic_refraction_axis": "visionManifest",
		"cycloplegic_refraction_add": "visionManifest",
		"cycloplegic_distance": "visionManifest",

		"iop_nct": "iop",
		"iop_applanation": "iop",
		"cct": "iop",

		"color_vision": "specialExam",
		"pupil": "specialExam",
		"amsler_grid": "specialExam",
		"pam": "specialExam",
		"confrontation": "specialExam",

		"EOM": "eom",

		"cornea": "anteriorSegment",
		"conjuctiva_sclera": "anteriorSegment",
		"anterior_chamber": "anteriorSegment",
		"angle_up": "anteriorSegment",
		"angle_middle0": "anteriorSegment",
		"angle_middle1": "anteriorSegment",
		"angle_middle2": "anteriorSegment",
		"angle_down": "anteriorSegment",
		"iris": "anteriorSegment",
		"lens": "anteriorSegment",

		"disc": "posteriorSegment",
		"cd_ratio_horizontal": "posteriorSegment",
		"macula": "posteriorSegment",
		"retina": "posteriorSegment",
		"vitreous": "posteriorSegment",

		"face": "external",
		"upper_lid": "external",
		"lower_lid": "external",
		"punctum": "external",
		"lacrimal_lake": "external",

		"lacrimal_irrigation": "nld",
		"nld": "nld",
		"dye_disappearance": "nld",

		"mrd": "eyelidMeasurements",
		"levator_function": "eyelidMeasurements",
		"inferior_scleral_show": "eyelidMeasurements",
		"cn_vii": "eyelidMeasurements",
		"blink": "eyelidMeasurements",
		"bells": "eyelidMeasurements",
		"lagophthalmos": "eyelidMeasurements",

		"hertel": "orbit",
		"retropulsion": "orbit"
};
var eyes = ["od", "os"];
var va = {"sc_distance": "sc dist", "cc_distance": "cc dist", "ph_distance": "ph dist", "sc_near": "sc near", "cc_near": "cc near"};
var iop = {"iop_nct": "NCT", "iop_applanation": "applanation", "cct": "cct"};
var ar = {"ar_sph": "sph", "ar_cyl": "cyl", "ar_axis": "axis"};

var specialItems = ["od_sc_distance", "od_cc_distance", "od_ph_distance", "od_sc_near", "od_cc_near",
                    "os_sc_distance", "os_cc_distance", "os_ph_distance", "os_sc_near", "os_cc_near",
                    "od_iop_nct", "od_iop_applanation", "od_cct",
                    "os_iop_nct", "os_iop_applanation", "os_cct",
                    "od_ar_sph", "od_ar_cyl", "od_ar_axis",
                    "os_ar_sph", "os_ar_cyl", "os_ar_axis"];


var prevNote = {};
var lastImpression = "";
var lastImpressionSet = false;

var macros = {};
var measurementsData = {};

var followUpItems = ["followUp_type", "followUp_doc", "followUp_time", "followUp_timeType", "followUp_urgency", "followUp_comment"];
var procedureItems = ["procedure_eye", "procedure_procedure", "procedure_location", "procedure_urgency", "procedure_comment"];
var diagnosticsItems = ["diagnostics_eye", "diagnostics_name", "diagnostics_urgency", "diagnostics_comment"];


var savedImpression = false, savedCurrentPresenting = false, savedOfficeCommunication = false, sendPlanTickler = false, savedPlan = false;
var saveInterval;
var billingArgs;

var extraParams = "numToDisplay=6&json=true&demographicNo=" + demographicNo;
var noteExtraParams = "method=listNotes&json=true&demographicNo=" + demographicNo;





function popupPage(height, width, title, page) {
	page = "" + page;
	var windowprops = "height=" + height + ",width=" + width + ",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes,screenX=50,screenY=50,top=0,left=0";
	var popup = window.open(page, title, windowprops);
	if (popup != null) {
		if (popup.opener == null) {
			popup.opener = self;
		}
		popup.focus();
	}
}

function isThisAppointment(apptNo) {
	if (apptNo == appointmentNo)
		return true;

	return false;
}

function getAppointmentClass(appointmentNo) {
	if (isThisAppointment(appointmentNo))
		return "thisVisit";
	else if (appointmentNo == lastAppointmentNo)
		return "lastVisit";
	else
		return "";
}

function newMacro() {
	popupPage(800, 600, "Eyeform Macro Details", ctx + "/eyeform/Macro.do?method=addMacro");
}

function getMostRecentItem(boxName, callback) {
	var apptNo = "";
	
	if ( boxName == "officeCommunication" )
		apptNo = "&appointment_no=" + appointmentNo;
	
	$.ajax({
		type: "POST",
		url: ctx + "/CaseManagementView.do",
		data: noteExtraParams + apptNo + "&issue_code=" + noteBoxes[boxName],
		dataType: "json",
		success: function(data) {
			var item = {note: ""};
			if (data.Items.length > 0)
				item = data.Items[0];

			callback(item);
		}
	});
}

function loadNoteBox(boxName, boxIssue, initialLoad) {
	var apptNo = "";
	
	if ( boxName == "officeCommunication" )
		apptNo = "&appointment_no=" + appointmentNo;
	
	$.ajax({
		type: "POST",
		url: ctx + "/CaseManagementView.do",
		data: noteExtraParams + apptNo + "&issue_code=" + boxIssue,
		dataType: "json",
		success: function(data) {
			fillAjaxBoxNote(boxName, data, initialLoad);

			setHighlight(null);
		}
	});
};

function editNote(item) {
	var data = $(item).find("span.noteContent").text();
	$(item).attr("noteData", data);
	$(item).attr("dateData", $(item).find("abbr").attr("title"));
	$(item).attr("date", $(item).find("abbr").text());
	$(item).addClass("updating");
	$(item).html("<input type='text' />");
	$(item).find("input").attr("value", data);

	$(item).unbind("click");

	$(item).find("input").blur(function() {
		$(this).parent().unbind("click");
		saveEditNote($(this).parent());
	}).bind('keypress', function(e) {
		var code = (e.keyCode ? e.keyCode : e.which);
		if (code == 13) {
			$(this).parent().unbind("click");
			saveEditNote($(this).parent());
		}
	});

	$(item).find(".archiveNoteBtn").click(function(e) {
		if (typeof console != "undefined")
			console.log("Archive Btn Clicked");

		e.stopPropagation();
		archiveNote($(this).parent());
	});

	$(item).find("input").focus().setCursorPosition($(item).find("input").val().length);
}

function saveEditNote(item) {
	$(item).removeClass("updating");

	var data = encodeURIComponent($(item).find("input").val());
	var noteId = $(item).attr("note_id");

	$(item).html("<strong><abbr /></strong><span class='noteContent' /><span class='uiBarBtn archiveNoteBtn'><span class='text smallerText'>Archive</span></span>");
	$(item).find("abbr").attr("title", $(item).attr("dateData"));
	$(item).find("abbr").text($(item).attr("date"));

	if ($(item).attr("noteData") != data) {
		$.ajax({
			type: "POST",
			url: ctx + "/CaseManagementEntry.do?method=issueNoteSaveJson&appointment_no=" + appointmentNo + "&demographic_no=" + demographicNo,
			data: "value=" + data + "&noteId=" + noteId + "&sign=false",
			dataType: "json",
			success: function(data) {
				if (typeof console != "undefined")
					console.log("Saved " + data.id);
			}
		});
		$(item).find("span.noteContent").text( unescape(data) );
		$(item).addClass("thisVisit");

	} else {
		$(item).find("span.noteContent").text( unescape($(item).attr("noteData")) );
	}

	$(item).click(function(e) {
		editNote($(this));
		e.stopPropagation();
	});

	$(item).find(".archiveNoteBtn").click(function(e) {
		if (typeof console != "undefined")
			console.log("Archive Btn Clicked");
		e.stopPropagation();
		archiveNote($(this).parent());
	});
}

function archiveNote(item) {
	var noteId = $(item).attr("note_id");
	var boxId = $(item).parent().parent().parent().attr("id");
	var $archiveNoteBtn = $(item).find(".archiveNoteBtn");
	
	closeAll();
	
	$(".archiveBox").css("display", "block");
	$(".archiveBox").css("top", ($(window).height()/2-275) + "px");
	$(".archiveBox").css("left", ($(window).width()/2-100) + "px");
	
	$(".archiveBox").children("[name=note_id]").val(noteId);
	$("#newArchiveText").focus();

	$("#closeArchiveBoxBtn").click(function(){	
		$(".archiveBox").css("display", "none");
		$(".archiveBox").children("input").val();	
	});
	
	$("#uiBoxArchiveBtn").click(function(){
		var archiveNote = encodeURIComponent($("#newArchiveText").val());
		
		if (typeof console != "undefined")
			console.log("Archiving " + noteId);
		$(item).hide();
		$(".archiveBox").css("display", "none");
		
		$.ajax({
			type: "POST",
			url: ctx + "/CaseManagementEntry.do?method=issueNoteSaveJson",
			data: "value=" + $(item).children(".noteContent").html() + "&archiveNote=" + archiveNote + "&noteId=" + noteId + "&archived=true",
			dataType: "json",
			success: function(data) {
				loadNoteBox(boxId, noteBoxes[boxId], false);
			}
		});

	});
}

function checkModify(item) {
	if ($(item).attr('id') == "newNoteText") {
		var parent = $(item).parent();
		var value = $(item).val();
		$(parent).html("<strong><abbr /></strong><span />");
		$(parent).find("abbr").attr("title", "Created by you");
		$(parent).find("abbr").text((new Date()).toFormattedString());
		$(parent).find("span").text(value);

		if ($.trim(value) > 0) {
			// save it
		} else {
			// remove it
			$(parent).remove();
		}
	} else {
		// editing a note

	}
}

function displayTickler(value, element) {
	closeAll();

	element = $(element).parent();

	var box = $(".openTicklerUiBox").clone();
	$(box).removeClass("openTicklerUiBox");
	$(box).addClass("openTickler");

	(function() {
		$.ajax({
			url: ctx + "/eyeform/Util.do",
			data: "method=getTickler&tickler_no=" + value,
			type: "POST",
			dataType: "json",
			success: function(data) {
				$(box).css("top", ($(element).position().top - 16) + "px");
				$(box).css("left", "201px");
				$(box).find(".messageContent").text(data.tickler.message);
				$(box).find(".messageDate").text((new Date(data.tickler.updateDate.time)).toFormattedString());
				$(box).find(".messageTo").text(data.tickler.provider);
				$(box).find(".messageFrom").text(data.tickler.toProvider);
				$(box).css("display", "block");
				$(element).addClass("openBox");
				$(element).append(box);
				
				$("#closeTicklerUiBoxBtn").click(function(event) {
					event.stopPropagation();
					if ($("#newSpecsBox").css("display") == "block") {
						closeAll();
					} else {
						closeAll();
					}
				});
			}
		});
	})();
}

function displaySpecs(value, element) {
	closeAll();

	element = $(element).parent();

	var box = $("#newSpecsBox").clone();
	$(box).find("input").val("");
	$(box).attr("id", "specsEditBox");
	$(element).addClass("openBox");

	(function() {
		$.ajax({
			url: ctx + "/eyeform/SpecsHistory.do",
			data: "json=true&specs.id=" + value,
			type: "POST",
			dataType: "json",
			success: function(data) {
				for (var name in data.specs) {
					$(box).find("input[name=specs." + name + "], select[name=specs." + name + "], textarea[name=specs." + name + "]").val(data.specs[name]);

				}

				$(box).find("#uiSaveNewSpecsBtn").attr("id", "uiSaveSpecsBtn");
				$(box).find(".addEditSpecsTitle").text("Edit Specs");

				$(box).css("top", ($(element).offset().top - 1) + "px");
				$(box).css("left", ($(element).offset().left + 197) + "px");
				$(box).css("display", "inline-block");
				$(box).css("position", "absolute");
				$(box).draggable({
					handle: "div.boxTitle",
					cancel: "div.uiBarBtn",
					drag: function() {
						$(this).find(".arrow").css("display", "none");
					}
				});

				$(box).find(".uiBarBtn").click(function() {
					closeAll();
				});

				$("body").append(box);

				(function(id) {
					$(box).find("#uiSaveSpecsBtn").click(function() {
						if (!transformDate($("#specsEditBox input[name=specs.dateStr]")))
							return false;

						var dataStr = "";
						$("#specsEditBox").find("input, select").each(function(index) {
							dataStr += "&" + $(this).attr("name") + "=" + encodeURIComponent($(this).val());
						});

						$.ajax({
							url: ctx + "/eyeform/SpecsHistory.do",
							data: "json=true&method=save&specs.id=" + id + dataStr,
							type: "POST",
							dataType: "json",
							success: function(returnData) {
								$("#specsEditBox").css("display", "none");

								refreshBox("specsHistory", false);
							},
							error: function() {
								$("#uiSaveSpecsBtn").css("display", "inline-block");
							}
						});
					});
				})(value);
			}
		});
	})();
}

function displayProcedure(value, element) {
	closeAll();

	element = $(element).parent();

	var box = $("#newProcedureBox").clone();
	$(box).find("input").val("");
	$(box).attr("id", "procedureEditBox");
	$(element).addClass("openBox");

	(function() {
		$.ajax({
			url: ctx + "/eyeform/OcularProc.do",
			data: "json=true&proc.id=" + value,
			type: "POST",
			dataType: "json",
			success: function(data) {
				for (var name in data.proc) {
					$(box).find("input[name=proc." + name + "], select[name=proc." + name + "], textarea[name=proc." + name + "]").val(data.proc[name]);

				}

				$(box).find("#uiSaveNewProcedureBtn").attr("id", "uiSaveProcedureBtn");
				$(box).find(".addEditProcedureTitle").text("Edit Procedure");

				$(box).css("top", ($(element).offset().top - 6) + "px");
				$(box).css("left", ($(element).offset().left + 197) + "px");
				$(box).css("display", "inline-block");
				$(box).css("position", "absolute");
				$(box).draggable({
					handle: "div.boxTitle",
					cancel: "div.uiBarBtn",
					drag: function() {
						$(this).find(".arrow").css("display", "none");
					}
				});

				$(box).find(".uiBarBtn").click(function() {
					closeAll();
				});

				$("body").append(box);

				(function(id) {
					$(box).find("#uiSaveProcedureBtn").click(function() {
						if (!transformDate($("#procedureEditBox input[name=proc.dateStr]")))
							return false;

						var dataStr = "";
						$("#procedureEditBox").find("input, select, textarea").each(function(index) {
							dataStr += "&" + $(this).attr("name") + "=" + encodeURIComponent($(this).val());
						});

						$.ajax({
							url: ctx + "/eyeform/OcularProc.do",
							data: "json=true&method=save&proc.id=" + id + dataStr,
							type: "POST",
							dataType: "json",
							success: function(returnData) {
								$("#procedureEditBox").css("display", "none");

								refreshBox("procedures", false);
							},
							error: function() {
								$("#uiSaveProcedureBtn").css("display", "inline-block");
							}
						});
					});
				})(value);
			}
		});
	})();
}

function closeAll() {
	$(".uiBarBtnOn").removeClass("uiBarBtnOn");

	$(".openBox").removeClass("openBox");

	$(".openTickler").remove();

	$("#newTicklerBox").css("display", "none");
	
	$("#newArchiveBox").css("display", "none");

	$("#newSpecsBox").css("display", "none");

	$("#specsEditBox").remove();
	$("#procedureEditBox").remove();

	$("#newProcedureBox").css("display", "none");

	$(".openAddList").remove();

	$(".loaderImg").css("display", "none");
}

function fillAjaxBox(boxNameId, jsonData, initialLoad) {
	var showAll = false;
	
	// If we are reloading a box and the user has already clicked 'show more', we want to show all upon reloading
	if (!initialLoad) {
		if ( $("#" + boxNameId + " .content ul li").length > 5 )
			showAll = !$( $("#" + boxNameId + " .content ul li").get(5) ).hasClass("oldEntry");
	}
	
	if (jsonData.Items.length > 0) {
		$("#" + boxNameId + " .wrapper").html("<div class='content'><ul /></div>");
	}

	if ((typeof jsonData.Items != "undefined") &&
			(boxNameId == "ocularMeds"
				|| boxNameId == "consultations"
				|| boxNameId == "documents"
				|| boxNameId == "macro"
				|| boxNameId == "allergies"))
		jsonData.Items = jsonData.Items.reverse();

	for (var jsonItem in jsonData.Items) {
		var item = jsonData.Items[jsonItem];
		item.title = item.title.replace(/\n/g," ");
		var date;
		if (item.date != null) {
			date = new Date(item.date.time);

			if (isNaN(date.getTime()) || date.getTime() == "")
				date = new Date(item.date.year + "/" + (item.date.month + 1) + "/" + item.date.day);
		} else {
			date = {
					getTime: function() { return null; },
					toFormattedString: function() { return "Unspecified" }
			};
		}

		if (boxNameId == "tickler") {
			$("#tickler .content ul").prepend("<li itemtime=\"" + date.getTime() + "\"><span onclick=\"displayTickler('" + item.value + "', this)\" title=\"" + item.linkTitle + "\"><strong>" + date.toFormattedString() + "</strong> " + item.title + "</span></li>");
		} else if (boxNameId == "messages") {
			$("#messages .content ul").prepend("<li itemtime=\"" + date.getTime() + "\"><span onclick=\"" + item.URL + "\" title=\"" + item.linkTitle + "\"><strong>" + date.toFormattedString() + "</strong> " + item.title + "</span></li>");
		} else if (boxNameId == "specsHistory") {
			$("#specsHistory .content ul").prepend("<li itemtime=\"" + date.getTime() + "\"><span onclick=\"displaySpecs('" + item.value + "', this)\" title=\"" + item.linkTitle + "\"><strong>" + date.toFormattedString() + "</strong> " + item.title + "</span></li>");
		} else if (boxNameId == "procedures") {
			$("#procedures .content ul").prepend("<li itemtime=\"" + date.getTime() + "\"><span onclick=\"displayProcedure('" + item.value + "', this)\" title=\"" + item.linkTitle + "\"><strong>" + date.toFormattedString() + "</strong> " + item.title + "</span></li>");
		} else if (boxNameId == "billing") {
			$("#" + boxNameId + " .content ul").append("<li itemtime=\"" + date.getTime() + "\"><span onclick=\"" + item.URL + "\" title=\"" + item.linkTitle + "\"><strong>" + date.toFormattedString() + "</strong> " + item.title + "</span></li>");
		} else if (boxNameId == "macro") {
			$("#" + boxNameId + " .content ul").prepend("<li><span onclick=\"" + item.URL + "\" title=\"" + item.linkTitle + "\">" + item.title + "</span></li>");
		} else {
			if (item.PDF)
				$("#" + boxNameId + " .content ul").prepend("<li itemtime=\"" + date.getTime() + "\"><span onclick=\"popupPage(800, 1000, '', '" + item.URL + "')\" title=\"" + item.linkTitle + "\"><strong>" + date.toFormattedString() + "</strong> " + item.title + "</span></li>");
			else {
				var dateString = date.toFormattedString();
				if (dateString == "Unspecified")
					dateString = "";
				$("#" + boxNameId + " .content ul").prepend("<li itemtime=\"" + date.getTime() + "\"><span onclick=\"" + item.URL + "\" title=\"" + item.linkTitle + "\"><strong>" + dateString + "</strong> " + item.title + "</span></li>");
			}
		}
	}

	if ($("#" + boxNameId + " .content ul li").length > 5 && !showAll) {
		$("#" + boxNameId + " .content ul li").slice(5).attr("class", "oldEntry");
		
		var showMoreBtn = $("<span class='showAllBtn uiBarBtn'><span class='text smallerText'>Show All</span></span>").click(function(e) {
			e.stopPropagation();
			$(this).parent().find("li").removeClass("oldEntry");
			$(this).remove();
		});
		$("#" + boxNameId + " .content").append(showMoreBtn);
	}

	if (initialLoad) {
		$("#newTicklerBox, #newSpecsBox, #newProcedureBox").draggable({
			handle: "div.boxTitle",
			cancel: "div.uiBarBtn",
			drag: function() {
				$(this).find(".arrow").css("display", "none");
			}
		});

		if (boxNameId == "labResults" || boxNameId == "diagrams" || boxNameId == "documents"
			|| boxNameId == "billing" || boxNameId == "tickler" || boxNameId == "consultations"
			|| boxNameId == "consultationReport" || boxNameId == "messages"
				|| boxNameId == "ocularMeds" || boxNameId == "allergies" || boxNameId == "macro") {
			$("#" + boxNameId + " .title").click((function (action) {
				return function(e) {
					e.stopPropagation();
					eval("(function() { " + action + "})()");
				};
			})(jsonData.LeftURL));
		}

		if (boxNameId == "tickler") {
			$("#tickler .addBtn, #closeTicklerBoxBtn").click(function(event) {
				event.stopPropagation();
				if ($("#newTicklerBox").css("display") == "block") {
					closeAll();
				} else {
					closeAll();
					$("#newTicklerBox").css("top", ($(this).offset().top - 62) + "px");
					$("#newTicklerBox").css("left", ($(this).offset().left + 18) + "px");
					$("#newTicklerBox").css("display", "block");
					$("#newTicklerBox .arrow").css("display", "block");
					$("#newTicklerText").focus();
					$("#tickler .uiBarBtn").addClass("uiBarBtnOn");
				}
			});
		} else if (boxNameId == "specsHistory") {
			$("#specsHistory .addBtn, #closeNewSpecsBoxBtn").click(function(event) {
				event.stopPropagation();
				if ($("#newSpecsBox").css("display") == "block") {
					closeAll();
				} else {
					closeAll();
					$("#newSpecsBox").css("top", ($(this).offset().top - 3) + "px");
					$("#newSpecsBox").css("left", ($(this).offset().left + 18) + "px");
					$("#newSpecsBox").css("display", "block");
					$("#newSpecsBox .arrow").css("display", "block");
					$("#newSpecsDate").focus();
					$("#specsHistory .uiBarBtn").addClass("uiBarBtnOn");
				}
			});
		} else if (boxNameId == "procedures") {
			$("#procedures .addBtn, #closeNewProcedureBoxBtn").click(function(event) {
				event.stopPropagation();
				if ($("#newProcedureBox").css("display") == "block") {
					closeAll();
				} else {
					closeAll();
					$("#newProcedureBox").css("top", ($(this).offset().top - 3) + "px");
					$("#newProcedureBox").css("left", ($(this).offset().left + 18) + "px");
					$("#newProcedureBox").css("display", "block");
					$("#newProcedureBox .arrow").css("display", "block");
					$("#newProcedureDate").focus();
					$("#procedures .uiBarBtn").addClass("uiBarBtnOn");
				}
			});
		} else {
			if (jsonData.PopUpMenuURLS.length > 0 && jsonData.PopUpMenuURLS.length == jsonData.PopUpMenuNames.length) {
				(function(urlList, nameList, boxName) {
					$("#" + boxName + " .addBtn").click(function(event) {
						event.stopPropagation();

						if ($("#" + boxName + "_addList").css("display") == "block") {
							closeAll();
						} else {
							closeAll();

							var newListBox = $(".listBox").clone();
							$(newListBox).attr("id", boxName + "_addList");
							$(newListBox).addClass("openAddList");

							for (var i = 0; i < urlList.length; i++) {
								$(newListBox).find("div.fullBoxContent").append("<span class='uiBarBtn' onClick=\"" + urlList[i] + "; closeAll();\"><span class='text smallerText'>" + nameList[i] + "</span></span>");
							}

							$(newListBox).css("top", ($(this).offset().top - 3) + "px");
							$(newListBox).css("left", ($(this).offset().left + 18) + "px");

							$(newListBox).css("display", "block");

							$("body").append(newListBox);

							$(this).parent().addClass("uiBarBtnOn");
						}
					});
				})(jsonData.PopUpMenuURLS, jsonData.PopUpMenuNames, boxNameId);
			} else {
				$("#" + boxNameId + " .addBtn").click((function(action) {
					return function(e) {
						e.stopPropagation();
						eval("(function() { " + action + "})()");
					};
				})(jsonData.RightURL));
			}
		}
	}
}

function fillAjaxBoxNote(boxNameId, jsonData, initialLoad) {
	if (jsonData !=null && jsonData.Items.length > 0) {
		if ( boxNameId == "currentIssueHistory")
			$("#" + boxNameId + " .content").html("<div class='historyList'></div>");
		else if (boxNameId == "impressionHistory")
			$("#" + boxNameId + " .content").html("<table class='historyTable'><tbody></tbody></table>");
		else if (boxNameId != "officeCommunication")
			$("#" + boxNameId + " .content").html("<ul></ul>");
	}

	if (boxNameId == "impressionHistory") {
		var impressionItems = jsonData.Items;
		if (jsonData.Items.length > 0 && !jsonData.Items[0].signed) {
			$("#impressionAreaBox").val(jsonData.Items[0].note);
			$("#impressionAreaBox").attr("noteId", jsonData.Items[0].id);

			impressionItems = impressionItems.slice(1);
		}

		for (var jsonItem in impressionItems) {
			var item = impressionItems[jsonItem];
			var date = new Date(item.update_date.time);
			
			var provName = "";
			if (item.provider)
				provName = item.provider.formattedName;

			if (!lastImpressionSet) {
				lastImpression = item.note;
				lastImpressionSet = true;
			}

			$("#" + boxNameId + " .historyTable").children("tbody").append("<tr itemtime=\"" + date.getTime() + "\" class='item' appointmentNo='" + item.appointment_no + "' class='" + getAppointmentClass(item.appointment_no) + "'><td style='width:7%;' ><strong><abbr title='Note created by " + provName + "'>" + date.toFormattedString() + "</abbr></strong></td><td style='width:62%'> " + item.note.replace( /\n[\[]/g, '</td><td>[') + "</td></tr>");
		}

		impressionHistoryIssueId = jsonData.Issues[0].id;

		$(".historyList .item, .historyTable tr").click(function() {
			popupPage(800, 1200, "Appointment Report", ctx + "/eyeform/Eyeform.do?method=print&apptNos=" + $(this).attr("appointmentNo"));
		});

	} else if (boxNameId == "currentIssueHistory") {
		var currentIssueItems = jsonData.Items;
		if (jsonData.Items.length > 0 && !jsonData.Items[0].signed) {
			$("#currentIssueAreaBox").val(jsonData.Items[0].note);
			$("#currentIssueAreaBox").attr("noteId", jsonData.Items[0].id);

			currentIssueItems = currentIssueItems.slice(1);
		}
		
		$("#currentHistoryBox .title").click(function(e) {
			e.stopPropagation();
			popupPage(800, 600, "Current Issue History", ctx + "/CaseManagementEntry.do?method=issuehistory&demographicNo=" + demographicNo + "&issueIds=" + currentPresentingIssueId);
		});

		for (var jsonItem in currentIssueItems) {
			var item = currentIssueItems[jsonItem];
			var date = new Date(item.update_date.time);
			
			var provName = "";
			if (item.provider)
				provName = item.provider.formattedName;

			$("#" + boxNameId + " .historyList").append("<div itemtime=\"" + date.getTime() + "\" class='item' appointmentNo='" + item.appointment_no + "' class='" + getAppointmentClass(item.appointment_no) + "'><strong><abbr title='Note created by " + provName + "'>" + date.toFormattedString() + "</abbr></strong> " + item.note.replace( /\n/g, ' ') + "</div>");
		}

		currentPresentingIssueId = jsonData.Issues[0].id;

	} else if (boxNameId == "officeCommunication") {
		var officeCommunicationItems = jsonData.Items;
		
		if (jsonData.Items.length > 0 && !jsonData.Items[0].signed) {
			$("#officeCommunicationAreaBox").val(jsonData.Items[0].note);
			$("#officeCommunicationAreaBox").attr("noteId", jsonData.Items[0].id);
			officeCommunicationItems = officeCommunicationItems.slice(1);
		}

		/*
		for (var jsonItem in officeCommunicationItems) {
			var item = officeCommunicationItems[jsonItem];
			var date = new Date(item.update_date.time);
			
			var provName = "";
			if (item.provider)
				provName = item.provider.formattedName;

			$("#" + boxNameId + " .historyList").append("<div itemtime=\"" + date.getTime() + "\" class='item' appointmentNo='" + item.appointment_no + "' class='" + getAppointmentClass(item.appointment_no) + "'><strong><abbr title='Note created by " + provName + "'>" + date.toFormattedString() + "</abbr></strong> " + item.note.replace( /\n/g, ' ') + "</div>");
		}
		*/

	} else {
		var boxItems = jsonData.Items;
		if (boxNameId == "planHistory") {
			if (jsonData.Items.length > 0 && !jsonData.Items[0].signed) {
				$("#planBox").val(jsonData.Items[0].note);
				$("#planBox").attr("noteId", jsonData.Items[0].id);

				boxItems = boxItems.slice(1);
			}
		}

		for (var jsonItem in boxItems) {
			var item = boxItems[jsonItem];
			var date = new Date(item.update_date.time);
			
			var provName = "";
			if (item.provider)
				provName = item.provider.formattedName;
				
			$("#" + boxNameId + " .content ul").append("<li itemtime=\"" + date.getTime() + "\" note_id='" + item.id + "' class='" + getAppointmentClass(item.appointment_no) + "'><strong><abbr title='Note created by " + provName + "'>" + date.toFormattedString() + "</abbr></strong><span class='noteContent'>" + item.note.replace( /\n/g, ' ' ) + "</span></li>");

			if(boxNameId != "patientLog") { //changed to build list contents based on item properties.
				var $currItem = $("#" + boxNameId + " .content ul").children().last();
				
				$currItem.append("<span class='uiBarBtn archiveNoteBtn'><span class='text smallerText'>Archive</span></span>");
				if( !item.signed ) {
					$currItem.addClass("unSigned");
					$currItem.click(function(e) {
						e.stopPropagation();
						editNote($(this));
					});
				}
			}
		
		}


		$("#" + boxNameId + " .content ul li .archiveNoteBtn").click(function(e) {
			e.stopPropagation();
			archiveNote($(this).parent());
		});

		if (initialLoad) {
			if (boxNameId == "planHistory" || boxNameId == "diagnostics" || boxNameId == "patientLog" || boxNameId == "otherMeds" || boxNameId == "reminders" || boxNameId == "ocularHistory" || boxNameId == "familyMedicalOcularHistory" || boxNameId == "eyedrops") {
				$("#" + boxNameId + " .title").click(function(e) {
					e.stopPropagation();
					var rnd = Math.round(Math.random() * 1000);
					var win = "win" + rnd;
					var url = ctx + "/CaseManagementEntry.do?method=issuehistory&demographicNo=" + demographicNo + "&issueIds=" + jsonData.Issues[0].id;
					window.open(url,win,"scrollbars=yes, location=no, width=647, height=600","");
				});
			}
		}
	}
	if (initialLoad && boxNameId != "officeCommunication" && boxNameId != "patientLog") {
		$("#" + boxNameId + " .addBtn, #" + boxNameId + " .content").click(function(e) {
			e.stopPropagation();

			checkModify($("#newNoteText"));
			$("#" + boxNameId + " .content ul").prepend("<li><input type='text' id='newNoteText' /></li>");

			(function(address, code, boxName) {
				$("#newNoteText").blur(function() {
					var value = $("#newNoteText").val();
					$("#newNoteText").attr("disabled", "disabled");
					if ($.trim(value).length > 0) {
						var parent = $(this).parent();
						$(parent).html("<strong><abbr /></strong><span />");
						$(parent).find("abbr").attr("title", "Created by you");
						$(parent).find("abbr").text((new Date()).toFormattedString());
						$(parent).find("span").text(value);

						$.ajax({
							type: "POST",
							url: address,
							data: "value=" + value + "&issue_code=" + noteBoxes[$(parent).parent().parent().parent().attr('id')] + "&sign=false",
							dataType: "json",
							success: function(data) {
								$("#" + boxNameId + " .content ul").children().remove();
								$.ajax({
									type: "POST",
									url: ctx + "/CaseManagementView.do",
									data: noteExtraParams + "&issue_code=" + noteBoxes[boxName],
									dataType: "json",
									success: function(data) {
										fillAjaxBoxNote(boxName, data, false);
									}
								});
							}
						});
					} else {
						$(this).parent().remove();
					}
				}).bind('keypress', function(e) {
					var code = (e.keyCode ? e.keyCode : e.which);
					if (code == 13) {
						$(this).blur();
					}
				});
			})(ctx + "/CaseManagementEntry.do?method=issueNoteSaveJson&appointment_no=" + appointmentNo + "&demographic_no=" + demographicNo + "&noteId=0&json=true&issue_id=" + jsonData.Issues[0].id, jsonData.Issues[0].code, boxNameId);

			$("#newNoteText").focus();
		});
	}
}


function displayMeasurements(data, table, timeshow) {
	// Build the initial list of measurements to present
	// VA, IOP, AR
	//<tr><td class='measurementsDate'><strong>" + new Date(parseInt(timesToShow[t])).toFormattedString() + "</strong></td><td class='measurementsDetail' id='measurements_" + timesToShow[t] + "'></td></tr>
	$(table).append("<tr><td colspan='4'><strong>" + new Date(timeshow).toFormattedString() + "</strong></td></tr>");
	var vaPresent = false, iopPresent = false, arPresent = false;

	for (var e in eyes) {
		for (var i in va) {
			if ( !(typeof data[eyes[e] + "_" + i] == "undefined"))
				vaPresent = true;
		}

		for (var i in iop) {
			if (!(typeof data[eyes[e] + "_" + i] == "undefined"))
				iopPresent = true;
		}

		for (var i in ar) {
			if (!(typeof data[eyes[e] + "_" + i] == "undefined"))
				arPresent = true;
		}
	}

	if (vaPresent || iopPresent || arPresent)
		$(table).append("<tr/>");
	
	if (arPresent||iopPresent||vaPresent) {
		var vaStr = "<br />";
		for (var e in eyes) {
			vaStr += "<em>" + eyes[e].toUpperCase() + "</em> ";
			vaStr += "<br />";
		}

		$(table).children().last().append("<td>" + vaStr + "</td>");
	}

	if (vaPresent) {
		var vaStr="<strong>VA</strong><br /> ";
		for (var e in eyes) {
			for (var i in va) {
				if (!(typeof data[eyes[e] + "_" + i] == "undefined")&&i.indexOf("ph_distance")==-1) {
					var date = new Date(data[eyes[e] + "_" + i].dateEntered.time);
					vaStr += "<span itemtime=\"" + date.getTime() + "\" class='measurementItem " + getAppointmentClass(va[i].appointmentNo) + "'><abbr title=\"" + va[i] + "\">" + data[eyes[e] + "_" + i].dataField + "</abbr></span>";
				}
			}
			vaStr += "<br />";
		}

		$(table).children().last().append("<td>" + vaStr + "</td>");
	}

	if (iopPresent) {
		var iopStr = "<strong>IOP</strong><br /> ";
		for (var e in eyes) {
			for (var i in iop) {
				if (!(typeof data[eyes[e] + "_" + i] == "undefined") &&i.indexOf("iop_applanation")!=-1) {
					var date = new Date(data[eyes[e] + "_" + i].dateEntered.time);
					iopStr += "<span itemtime=\"" + date.getTime() + "\" class='measurementItem " + getAppointmentClass(iop[i].appointmentNo) + "'><abbr title=\"" + va[i] + "\">" + data[eyes[e] + "_" + i].dataField + "</abbr></span>";
				}
			}
			iopStr += "<br />";
		}

		$(table).children().last().append("<td>" + iopStr + "</td>");
	}
	if (arPresent) {
		var arStr = "<strong>AR</strong><br /> ";
		for (var e in eyes) {
			var symbol =[ "-", "+", "x"];
			var j=0;
			for (var i in ar) {
				if (!(typeof data[eyes[e] + "_" + i] == "undefined")) {
					var date = new Date(data[eyes[e] + "_" + i].dateEntered.time);
					arStr += "<span itemtime=\"" + date.getTime() + "\" class='measurementItem " + getAppointmentClass(ar[i].appointmentNo) + "'><abbr title=\"" + va[i] + "\">" +  symbol[j] +data[eyes[e] + "_" + i].dataField + "</abbr></span>";
					j++;
				}
			}
			arStr += "<br />";
		}

		$(table).children().last().append("<td>" + arStr + "</td>");
	}

	var count = 0;
	var newestDate = 0;
	for (var d in data) {
		if (!(d in specialItems)) {
			count++;
			if (data[d].dateEntered.time > newestDate)
				newestDate = data[d].dateEntered.time;
		}
	}

	/*if (count > 0) {
		//$(table).append("<tr><td class='moreMeasurements' itemtime='" + newestDate + "'>+ " + count + " more</td></tr>");
	}*/
}

function refreshBox(boxName, initialLoad) {
	var boxUrl = BoxIssueUrls[boxName];
	
	$.ajax({
		type: "POST",
		url: boxUrl,
		data: extraParams + "&cmd=" + cmds[boxName],
		dataType: "json",
		success: function(data) {
			fillAjaxBox(boxName, data, initialLoad);

			setHighlight(null);
		}
	});
}


function saveEyeform(fn, signAndExit, bill, closeForm, macroId) {
	var value = $("#impressionAreaBox").val();
	var currentPresentingValue = $("#currentIssueAreaBox").val();
	var officeCommunicationValue = $("#officeCommunicationAreaBox").val();
	var planValue = $("#planBox").val();
	var issueNoteId = $("#impressionAreaBox").attr("noteId");
	var planNoteId = $("#planBox").attr("noteId");
	var currentPresentingNoteId = $("#currentIssueAreaBox").attr("noteId");
	var officeCommunicationNoteId = $("#officeCommunicationAreaBox").attr("noteId");
	savedImpression = false;
	savedCurrentPresenting = false;
	savedOfficeCommunication = false;
	sendPlanTickler = false;
	savedPlan = false;
	savedForm = false;

	if (typeof issueNoteId == "undefined")
		issueNoteId = 0;

	if (typeof planNoteId == "undefined")
		planNoteId = 0;

	if (typeof currentPresentingNoteId == "undefined")
		currentPresentingNoteId = 0;

	$("#saveBtn").css("display", "none");
	$("#saveSignExitBtn").css("display", "none");
	$("#billBtn").css("display", "none");

	$(".loaderImg").css("display", "inline");
	
	if(signAndExit){
		var unSignedNotes = [];
		
		$(".unSigned").each(function(){
			unSignedNotes.push({
				"value": encodeURIComponent($(this).find(".noteContent").html()),
				"issue_id": $(this).closest(".boxTitleLink").attr("id"), 
				"noteId": $(this).attr("note_id")
			});
		});
		
		$.ajax({
			type: "POST",
			url: ctx + "/CaseManagementEntry.do?method=signSavedNotes&appointment_no=" + appointmentNo + "&demographic_no=" + demographicNo + "&json=true",
			data: "issues=" + JSON.stringify(unSignedNotes),
			dataType: "json"
		});
	}

	$.ajax({
		type: "POST",
		url: ctx + "/CaseManagementEntry.do?method=issueNoteSaveJson&appointment_no=" + appointmentNo + "&demographic_no=" + demographicNo + "&json=true",
		data: "value=" + encodeURIComponent(value) + "&issue_id=" + impressionHistoryIssueId
			+ (signAndExit ? "&sign=true&appendSignText=true&signAndExit=true" : "")
			+ (!isNaN(issueNoteId) ? "&noteId=" + issueNoteId : "&noteId=0")
			+ (!isNaN(macroId) ? "&macroId=" + macroId : "")
			+ "&runMacro=true", // We only want to run the macro once
		dataType: "json",
		success: function(data) {
			savedImpression = true;
		}
	});

	$.ajax({
		type: "POST",
		url: ctx + "/CaseManagementEntry.do?method=issueNoteSaveJson&appointment_no=" + appointmentNo + "&demographic_no=" + demographicNo + "&json=true",
		data: "value=" + encodeURIComponent(currentPresentingValue) + "&issue_id=" + currentPresentingIssueId
			+ (signAndExit ? "&sign=true&appendSignText=true&signAndExit=true" : "")
			+ (!isNaN(currentPresentingNoteId) ? "&noteId=" + currentPresentingNoteId : "&noteId=0")
			+ (!isNaN(macroId) ? "&macroId=" + macroId : "") // We need to include the macro id here so that 'issueNoteSaveJson' knowns what macro note data to add to the clinical note
			+ "&runMacro=false",
		dataType: "json",
		success: function(data) {
			savedCurrentPresenting = true;
		}
	});
	
	$.ajax({
		type: "POST",
		url: ctx + "/CaseManagementEntry.do?method=officeCommunicationSaveJson&appointment_no=" + appointmentNo + "&demographic_no=" + demographicNo + "&json=true",
		data: "value=" + encodeURIComponent(officeCommunicationValue)
			+ (signAndExit ? "&sign=true&appendSignText=true&signAndExit=true" : "")
			+ (!isNaN(officeCommunicationNoteId) ? "&noteId=" + officeCommunicationNoteId : "&noteId=0")
			+ (!isNaN(macroId) ? "&macroId=" + macroId : "") // We need to include the macro id here so that 'issueNoteSaveJson' knowns what macro note data to add to the clinical note
			+ "&runMacro=false",
		dataType: "json",
		success: function(data) {
			savedOfficeCommunication = true;
		}
	});


	// Send the plan text to all receptionists
	if (signAndExit) {
		$.ajax({
			type: "POST",
			url: ctx + "/eyeform/Util.do?method=sendPlan",
			data: "value=" + encodeURIComponent(planValue) + "&demographicNo=" + demographicNo,
			dataType: "json",
			success: function(data) {
				sendPlanTickler = true;
			}
		});
	}

	// Save the plan
	$.ajax({
		type: "POST",
		url: ctx + "/CaseManagementEntry.do?method=issueNoteSaveJson&appointment_no=" + appointmentNo + "&demographic_no=" + demographicNo + "&json=true",
		data: "value=" + encodeURIComponent(planValue) + "&issue_code=eyeformPlan"
			+ (signAndExit ? "&sign=true" : "")
			+ (!isNaN(planNoteId) ? "&noteId=" + planNoteId : "&noteId=0"),
		dataType: "json",
		success: function(data) {
			savedPlan = true;
		}
	});
	
	saveInterval = setInterval(function () { afterSave(fn, signAndExit, bill, closeForm); }, 1000);
}

function saveMeasurements() {
	$("#measurementsSavingMessage").show();

	var postData = "";
	$("#NewMeasurementContent [measurement]").each(function() {
		var className = $(this).attr("class");


		if(className == 'examfieldwhite') {
			if(postData.length > 0) {
				postData += "&";
			}
			var name = $(this).attr("measurement");
			var value = encodeURIComponent($(this).val());
			var data = name + "=" + value;
			postData += data;
		}
	});
	$.ajax({
		type: 'POST',
		url: ctx+"/oscarEncounter/MeasurementData.do?action=saveValues&demographicNo=" + demographicNo + "&appointmentNo=" + appointmentNo,
		data: postData,
		success: function(){
			loadMeasurements();
		}
	});
}

function afterSave(callback, signAndExit, bill, closeForm) {
	if ((!signAndExit && savedImpression && savedPlan) ||
			(signAndExit && savedImpression && savedPlan && sendPlanTickler)) {

		if (closeForm || (signAndExit && !bill)) {
			window.opener.location.reload(true);
			window.close();
			return;
		}

		savedImpression = false;
		savedPlan = false;
		sendPlanTickler = false;
		savedForm = true;

		$(".loaderImg").css("display", "none");
		$("#saveMsg").css("display", "block");

		$("#billBtn").css("display", "block");

		setTimeout(function() {
			$("#saveBtn").css("display", "block");
			$("#saveSignExitBtn").css("display", "block");
			$("#billBtn").css("display", "block");
			$("#saveMsg").css("display", "none");
		}, 5000);

		clearInterval(saveInterval);

		callback();
	}
}

function printThisReport() {
	popupPage(800, 1200, "Appointment Report", ctx + "/eyeform/Eyeform.do?method=print&apptNos=" + appointmentNo);
}

function highlightAllAfter(time) {
	$(".highlightTime").removeClass("highlightTime");

	$("[itemtime]").filter(function() {
		return $(this).attr("itemtime") >= time;
	}).addClass("highlightTime");
}


function addBillingToMacroList(e) {
	$("#billingAutocomplete").css("display", "none");
	$("#macroBillingItemBox").append("<div class='macroBillingItem' code='" + $(e).attr("code") + "'><span class='removeBillingItem'>x</span> " + $(e).attr("code") + " x1</div>");
	$("#macroBillingTextBox").val("");
	$("#macroBillingTextBox").focus();

	$(".removeBillingItem").click(function() {
		$(this).parent().remove();
	});
}

function addBillingToBillingBox(e) {
	$("#billCodeAutocomplete").css("display", "none");

	var existingItem = $("#billCodeBox .macroBillingItem[code=" + $(e).attr("code") + "]");

	if ($(existingItem).length > 0) {
		$("#billCode").val("");
		$("#billCodeBox .macroBillingItem[code=" + $(e).attr("code") + "] .count").each(function() {
			$(this).text(parseInt($(this).text()) + 1);
		});
	} else if ($("#billCodeBox .macroBillingItem").length >= 10) {
		$("#billCodeMaximumError").show();
		setTimeout(function() { $("#billCodeMaximumError").hide(); }, 2500);
	} else {
		$("#billCode").val("");
		$("#billCodeBox").append("<div class='macroBillingItem' code='" + $(e).attr("code") + "'><span class='removeBillingItem'>x</span> " + $(e).attr("code") + " x<span class='count'>1</span></div>");
	}

	$("#billCode").focus();

	$(".removeBillingItem").click(function() {
		$(this).parent().remove();
	});

}

function addBillingDxToBillingBox(e) {
	$("#billDxCodeAutocomplete").css("display", "none");

	if ($("#billDxCodeBox .dxBillingItem[code=" + $(e).attr("code") + "]").length > 0) {
		$("#billDxCode").val("");
	} else if ($("#billDxCodeBox .dxBillingItem").length >= 3) {
		$("#dxCodeMaximumError").show();
		setTimeout(function() { $("#dxCodeMaximumError").hide(); }, 2500);
	} else {
		$("#billDxCode").val("");
		$("#billDxCodeBox").append("<div class='macroBillingItem dxBillingItem' code='" + $(e).attr("code") + "'><span class='removeBillingItem'>x</span> " + $(e).attr("code") + "</div>");
	}

	$("#billDxCode").focus();

	$(".removeBillingItem").click(function() {
		$(this).parent().remove();
	});

}



function handleAutocompleteKeyup(autocomplete, textbox, event, submitFn) {
	if (event.keyCode == 27) {
		$(textbox).val("");
		$(autocomplete).css("display", "none");
		return true;
	} else if (event.keyCode == 38) { // Up
		if ($(autocomplete).find(".selectedListItem").length == 0) {
			$(autocomplete).children().last().addClass("selectedListItem");
		} else {
			var currSelect = $(".selectedListItem");
			if ($(currSelect).prev().length != 0)
				$(currSelect).prev().addClass("selectedListItem");
			else
				$(autocomplete).children().last().addClass("selectedListItem");

			$(currSelect).removeClass("selectedListItem");
		}
		return true;
	} else if (event.keyCode == 40 || event.keyCode == 39) { // Down
		if ($(autocomplete).find(".selectedListItem").length == 0) {
			$(autocomplete).children().first().addClass("selectedListItem");
		} else {
			var currSelect = $(".selectedListItem");
			if ($(currSelect).next().length != 0)
				$(currSelect).next().addClass("selectedListItem");
			else
				$(autocomplete).children().first().addClass("selectedListItem");

			$(currSelect).removeClass("selectedListItem");
		}
		return true;
	} else if (event.keyCode == 13) { // Enter
		submitFn($(autocomplete).find(".selectedListItem"));
		return true;
	}
	return false;
}

/**
 * Function to run the macro.  Not sure why we are using the odd name - it's from the echart macro code.
 */
function runMacro2(macroId, macroName, appointmentNo, cpp) {
	var c = confirm('Are you sure to execute macro [ '+ macroName+' ] and sign this form?');
	if (c == false) 
		return false;
		
	//potentially need admission date.
	//document.forms['caseManagementEntryForm'].sign.value='on';
	//jQuery("form[name='caseManagementEntryForm']").append("<input type=\"hidden\" id=\"macro.id\" name=\"macro.id\" value=\""+macroId+"\"/>");
	
	//var result =  savePage('runMacro', '');
	saveEyeform(saveFunc, true, false, true, macroId);
	//saveEyeform(postBillingEntry, true, true, false);
	
	return false;
}

function executeMacro(listElement) {
	$("#selectMacroExecuteBox").val("");
	$("#macroAutocomplete").css("display", "none");

	var macro = macros[$(listElement).attr("code")];

	for (var b in macro.billingItems) {
		$("#billCodeBox").append("<div class='macroBillingItem' code='" + macro.billingItems[b].billingServiceCode + "'><span class='removeBillingItem'>x</span> " + macro.billingItems[b].billingServiceCode + " x <span class='count'>" + macro.billingItems[b].multiplier + "</span></div>");
	}

	$("#billCodeBox .removeBillingItem, #billDxCodeBox .removeBillingItem").click(function() {
		$(this).parent().remove();
	});

	if (macro.copyFromLastImpression)
		$("#impressionAreaBox").val($.trim($("#impressionAreaBox").val() + "\n\n" + lastImpression));
	else
		$("#impressionAreaBox").val($.trim($("#impressionAreaBox").val() + "\n\n" + macro.impressionText));

	$("#planBox").val($.trim($("#planBox").val() + "\n\n" + macro.planText));

	$("#impressionAreaBox, #planBox").addClass("macroField");
	$("#impressionAreaBox, #planBox").click(function() {
		$(this).removeClass("macroField");
	});
}


function scrollMeasurementsBox() {
	$("#measurements .content").scrollTop($("#measurements .selectedMeasurementsTable").position().top);
}

function buildBillingArgumentsArray() {
	var args = {};
	var date = new Date();
	if ($("#billDate").val().trim().length > 0) {
		date = new Date($("#billDate").val().trim());
		if (isNaN(date.getTime()))
			date = new Date(); // default to billing for today?
	}
	args["service_date"] = date.toFormattedString();


	$("#billDxCodeBox .dxBillingItem").each(function(dx, dxItem) {
		args["dxCode" + (dx > 0 ? dx : "")] = $(dxItem).attr("code");
	});

	if ($("#billDxCodeBox .dxBillingItem").length < 3) {
		for (var i = $("#billDxCodeBox .dxBillingItem").length; i < 3; i++) {
			args["dxCode" + (i > 0 ? i : "")] = "";
		}
	}

	$("#billCodeBox .macroBillingItem").each(function(item, bItem) {
		args["serviceCode" + item] = $(bItem).attr("code");
		args["serviceUnit" + item] = $(bItem).find(".count").text();
		args["serviceAt" + item] = "1";
	});

	if ($("#billCodeBox .macroBillingItem").length < 10) {
		for (var i = $("#billCodeBox .macroBillingItem").length; i < 10; i++) {
			args["serviceCode" + i] = "";
			args["serviceUnit" + i] = "";
			args["serviceAt" + i] = "";
		}
	}

	args["appointment_no"] = appointmentNo;
	args["demographic_no"] = demographicNo;
	args["checkFlag"] = "0";
	args["day"] = "365";
	args["xml_visittype"] = "00| Clinic Visit";
	args["xml_billtype"] = "ODP | Bill OHIP";
	args["xml_location"] = "0000|Not Applicable";
	args["xml_provider"] = $("#billProvider").val();

	for (var k in Object.keys(billingArgs)) {
		args[Object.keys(billingArgs)[k]] = billingArgs[Object.keys(billingArgs)[k]];
	}

	args["cutlist"] = "";
	args["rfcheck"] = "checked";
	args["referralCode"] = "000000";
	args["referralSpet"] = "";
	args["referralDocName"] = "N/A";
	args["xml_vdate"] = "";
	args["clinic_no"] = clinicNo;
	args["asstProvider_no"] = "null";
	args["providerview"] = "";
	args["assgProvider_no"] = "";
	args["billForm"] = "";
	args["curBillForm"] = "";
	args["services_checked"] = "0";
	args["url_back"] = "";

	args["xml_slicode"] = "";

	return args;
}

function retrieveBillingArguments() {
	$.ajax({
		url: ctx + "/eyeform/Util.do",
		data: "method=getBillingArgs&demographic_no=" + demographicNo + "&appointment_no=" + appointmentNo,
		type: "POST",
		dataType: "json",
		success: function(data) {
			billingArgs = data;

			if (typeof data["appointment_date"] != "undefined") {
				data["appointment_date"] = new Date(data["appointment_date"]);
				if (!isNaN(data["appointment_date"]))
					$("#billDate").val(data["appointment_date"].toFormattedString());
			}

			if (typeof data["demo_mrp_provider_no"] != "undefined")
				$("#billProvider option[providerNo=" + data["demo_mrp_provider_no"] + "]").attr("selected", "selected");

			if (typeof data["current_provider_no"] != "undefined")
				$("#billProvider option[providerNo=" + data["current_provider_no"] + "]").attr("selected", "selected");

		}
	});
}

function postBilling() {
	var args = buildBillingArgumentsArray();
	var form = $("<form></form>").appendTo("body");
	$.each(args, function(key, value) {
		$(form).append($("<input />")
				.attr({ type: "hidden",
					name: key,
					value: value
				})
		);
	});

	$(form).attr({ method: "GET",
		action: ctx + "/billing/CA/ON/billingONReview.jsp"
	}).submit();
}

function postBillingEntry() {
	var args = buildBillingEntryArgumentsArray();
	var form = $("<form></form>").appendTo("body");
	$.each(args, function(key, value) {
		$(form).append($("<input />")
				.attr({ type: "hidden",
					name: key,
					value: value
				})
		);
	});

	$(form).attr({ method: "GET",
		action: ctx + "/billing.do"
	}).submit();
}

function buildBillingEntryArgumentsArray() {
	var args = {};
	args["billRegion"] = "ON";
	args["billForm"] = "MFP";
	args["hotclick"] = "";
	args["appointment_no"] = appointmentNo;
	args["demographic_name"] = encodeURIComponent(demographicName);
	args["status"] = "t";
	args["demographic_no"] = demographicNo;
	args["providerview"] = billingArgs.current_provider_no;
	args["user_no"] = billingArgs.current_provider_no;

	if (typeof billingArgs.apptProvider_no != "undefined")
		args["apptProvider_no"] = billingArgs.apptProvider_no;
	else
		args["apptProvider_no"] = billingArgs.current_provider_no;

	if (typeof billingArgs.appointment_date != "undefined")
		args["appointment_date"] = billingArgs.appointment_date.toFormattedString();
	else
		args["appointment_date"] = openTime.toFormattedString();

	if (typeof billingArgs.start_time != "undefined")
		args["start_time"] = billingArgs.start_time;
	else
		args["start_time"] = openTime.getHours() + ":" + openTime.getMinutes();


	args["bNewForm"] = "1";

	return args;

}


function hideUnenteredMeasurements(measurementsBox) {
	$(measurementsBox).find(".slidey").each(function() {
		var show = $(this).find(".slideblock input[value!='']").length > 0;
		$(this).find(".slideblock textarea").each(function() {
			show = show || $(this).val().trim().length > 0;
		});

		if (!show)
			$(this).find(".slideblock").hide();
	});
}

function showMeasurementsHistoryBox(time) {
	var measurements = measurementsData[time];

	var tmpBoxLeft = $("#tmpMeasurementsBox").css("left");
	var tmpBoxTop = $("#tmpMeasurementsBox").css("top");
	$("#tmpMeasurementsBox").remove();

	var tmpMeasurementsBox = $("#measurementsBox").clone();
	$(tmpMeasurementsBox).attr("id", "tmpMeasurementsBox");
	$(tmpMeasurementsBox).attr("measurementsTime", time);
	$(tmpMeasurementsBox).find("input, textarea").attr("disabled", "disabled").val("");

	var times = Object.keys(measurementsData).sort().reverse();
	var index = times.indexOf(time);
	if (index-1 >= 0) {
		$(tmpMeasurementsBox).find(".prevMeasurementsBoxBtn").click(function() {
			showMeasurementsHistoryBox(times[index-1]);
		}).show();
	}

	if (index+1 <= times.length-1) {
		$(tmpMeasurementsBox).find(".nextMeasurementsBoxBtn").click(function() {
			showMeasurementsHistoryBox(times[index+1]);
		}).show();
	}


	for (var m in measurements) {
		var box = $(tmpMeasurementsBox).find("input[measurement=" + m + "], textarea[measurement=" + m + "]");
		$(box).val(measurements[m].dataField);
		if (measurements[m].dateEntered.time == time)
			$(box).addClass("highlightTime");
	}

	$(tmpMeasurementsBox).find("#closeMeasurementsBtn").attr("id", "closeTmpMeasurementsBtn").click(function() {
		$(this).parent().parent().parent().remove();
	});

	$(tmpMeasurementsBox).find(".explanation").css("display", "block");
	$(tmpMeasurementsBox).find(".measurementsTime").text(new Date(parseInt(time)).toFormattedString());

	$(tmpMeasurementsBox).draggable({
		handle: "div.boxTitle",
		cancel: "div.boxTitle .uiBarBtn",
		scroll: false
	});

	hideUnenteredMeasurements($(tmpMeasurementsBox));

	$("body").append($(tmpMeasurementsBox).css({
		position: "absolute",
		display: "block",
		left: tmpBoxLeft,
		top: tmpBoxTop
	}));

}

function setHighlight(timePeriod) {
	if (timePeriod != null) {
		$("#highlightSliderLength").text(Object.keys(dateRange)[timePeriod]);
		highlightAllAfter(dateRange[Object.keys(dateRange)[timePeriod]]);

		$("#highlightSlider").slider("option", "value", timePeriod);
	} else {
		highlightAllAfter(dateRange[Object.keys(dateRange)[$("#highlightSlider").slider("option", "value")]]);
		$("#highlightSliderLength").text(Object.keys(dateRange)[$("#highlightSlider").slider("option", "value")]);
	}
}

function updateAppointmentReason(newReason) {
	$.ajax({
		url: ctx + "/eyeform/Util.do",
		data: {
			method: "updateAppointmentReason",
			reason: newReason,
			appointmentNo: appointmentNo
		},
		type: "POST",
		dataType: "json",
		success: function(data) {

		}
	});
}

function loadMeasurements() {
	//create comma separated list of the measurement types (from attribute)
	var types='';
	$("input[measurement]").each(function() {
		if(types.length > 0) {
			types += ',';
		}
		types += $(this).attr("measurement");
	});
	$("textarea[measurement]").each(function() {
		if(types.length > 0) {
			types += ',';
		}
		types += $(this).attr("measurement");
	});
	
	$.ajax({
		url:ctx+"/oscarEncounter/MeasurementData.do?demographicNo=" + demographicNo + "&types="+types+"&action=getMeasurementsGroupByDate&appointmentNo=" + appointmentNo + "&fresh=cpp_currentHis&json=true",
		dataType: "json",
		success: function(data) {
			$("#measurements .content").empty();

			measurementsData = data;

			var times = Object.keys(data).sort().reverse();
			$("#measurements .content").append("<div id='measurementsSavingMessage'>Measurements are being saved...</div>");

			var timesToShow = [];

			for (var t in times) {
				// Convert this time to a formatted date string
				var dayString = new Date(parseInt(times[t])).toFormattedString();

				// Only keep the most recent version from each day, discard the rest
				if (timesToShow.length == 0)
					timesToShow.push(times[t]);
				else {
					var add = false;
					for (var ts in timesToShow) {
						var tsDayString = new Date(parseInt(timesToShow[ts])).toFormattedString();
						if (tsDayString == dayString && times[t] > timesToShow[ts]) {
							// Replace timesToShow[ts] with times[t]
							timesToShow[ts] = times[t];
							add = false;
							break;
						} else if (tsDayString != dayString) {
							add = true;
							break;
						}
					}

					if (add)
						timesToShow.push(times[t]);
				}
			}
            var showAllMeasurements = false;
            var i = 2;
            var j = 0;
			for (var t in timesToShow) {
				var showMeasurement = (j<2) || showAllMeasurements;
				if(showMeasurement)
					$("#measurements .content").append("<table class='measurementsTableLatest2' measurementsTime='" +  + timesToShow[t] + "' id='measurements_" + timesToShow[t] + "'></table>");
     			else
					$("#measurements .content").append("<table class='measurementsTable measurementsTableNoShow' measurementsTime='" +  + timesToShow[t] + "' id='measurements_" + timesToShow[t] + "'></table>");			
				displayMeasurements(data[timesToShow[t]], $("#measurements_" + timesToShow[t]),parseInt(timesToShow[t]));
				j=j+1;
			}
			
			$("#measurements .content").append("<span id='showAllMeasurementBtn' class='uiBarBtn'><span class='text smallerText'>Show All</span></span>").click(function(e) {
				e.stopPropagation();
			    $(this).parent().find("table").removeClass("measurementsTableNoShow");
			    document.getElementById('showAllMeasurementBtn').remove();
			});

			$(".measurementsTable").click(function() {
				showMeasurementsHistoryBox($(this).attr("measurementsTime"));
			});
			$(".measurementsTableLatest2").click(function() {
				showMeasurementsHistoryBox($(this).attr("measurementsTime"));
			});
		}
	});
}

// Ported from newEncounterLayout.jsp - used after creating / editing a macro
function reloadNav(name) {
	refreshBox(name, false);
}


//For OscarRx "Paste into EMR" functionality
function pasteToEncounterNote(text) {
	$("#impressionAreaBox").val($.trim($("#impressionAreaBox").val() + "\n\n" + text));
	refreshBox("ocularMeds", false);
}

function transformDate(dateField) {
	var v = $(dateField).val();

	var d = new Date(v);

	if (typeof d != "undefined" && !isNaN(d.getTime()))
		$(dateField).val(d.toFormattedString());
	else {
		$(dateField).css("border", "2px solid red");
		$(dateField).one("click", function() {
			$(this).css("border", "");
		});

		return false;
	}

	return true;
}

function saveFunc() {
	loadMeasurements();
	loadNoteBox("impressionHistory", noteBoxes["impressionHistory"], false);
	loadNoteBox("planHistory", noteBoxes["planHistory"], false);
	refreshBox("tickler", false);
	$("#impressionAreaBox").val("");
	$("#planBox").val("");
	$("#billDxCodeBox").empty();
	$("#billCodeBox").empty();
}

$(document).ready(function() {
	setHighlight(defaultDateRange);

	$("#impressionAreaBox, #planBox, #currentIssueAreaBox").autogrow();
	$("#impressionAreaBox, #planBox, input[measurement]").change(function() {
		savedForm = false;
	});

	for (var boxId in BoxIssueUrls) {
		refreshBox(boxId, true);
	}

	for (var boxId in noteBoxes) {
		loadNoteBox(boxId, noteBoxes[boxId], true);
	}

	$(".impressionBtn").click(function() {
		if ($(this).attr("id") == "stableBtn") {
			$("#impressionAreaBox").val($.trim($("#impressionAreaBox").val() + "\n\nPatient's condition is stable."));
		} else if ($(this).attr("id") == "noChangeBtn") {
			$("#impressionAreaBox").val($.trim($("#impressionAreaBox").val() + "\n\nPatient's condition has not changed."));
		} else if ($(this).attr("id") == "copyLastBtn") {
			$("#impressionAreaBox").val($.trim($("#impressionAreaBox").val() + "\n\n" + lastImpression));
		}

		$("#impressionAreaBox").autogrow();

	});

	$("#copyApptReasonBtn").click(function(e) {
		e.stopPropagation();
		$("#currentIssueAreaBox").val($.trim($("#currentIssueAreaBox").val() + "\n\n" + $("#complaint .content").text()));
		$("#currentIssueAreaBox").autogrow();
	});

	
	$(".iViewsBtn").click(function() {
		window.open(ctx + "/oscarEncounter/eyeform/downloadIViews.do?demographicNo=" + demographicNo);
	});
	
	$(".eChartBtn").click(function() {
		window.open(ctx + "/oscarEncounter/IncomingEncounter.do?demographicNo=" + demographicNo + "&curProviderNo=&reason=Progress+Notes&encType=&curDate=&appointmentDate=&startTime=&status=", "width=1024,height=710");
	});

	$(".masterRecBtn").click(function() {
		window.open(ctx + "/demographic/demographiccontrol.jsp?demographic_no=" + demographicNo + "&displaymode=edit&dboperation=search_detail", "width=900,height=600");
	});

	$(".rx3Btn").click(function() {
		window.open(ctx + "/oscarRx/choosePatient.do?demographicNo=" + demographicNo, "width=1300,height=700");
	});

	$(".billingBtn").click(function(e) {
		e.stopPropagation();
		postBillingEntry();
	});

	$("#saveBtn").click(function() {
		saveEyeform(saveFunc, false, false, true);
	});

	$("#saveSignExitBtn").click(function() {
		saveEyeform(saveFunc, true, false, true);
	});

	$("#billBtn").click(function() {
		saveEyeform(postBillingEntry, true, true, false);
	});



	$("#highlightSlider").slider({
		value: 1,
		min: 0,
		max: Object.keys(dateRange).length-1,
		step: 1,
		slide: function(event, ui) {
			$("#highlightSliderLength").text(Object.keys(dateRange)[ui.value]);
			highlightAllAfter(dateRange[Object.keys(dateRange)[ui.value]]);
		}
	});

	$("#highlightSliderLength").text(Object.keys(dateRange)[0]);




	$("#planSendTicklerBtn").click(function() {
		var followUp = $("#followUpCheckbox").is(":checked");
		var procedure = $("#procedureCheckbox").is(":checked");
		var diagnostics = $("#diagnosticsCheckbox").is(":checked");

		var dataStr = "";
		if (followUp) {
			dataStr += "followUp=true";
			for (var item in followUpItems) {
				dataStr += "&" + followUpItems[item] + "=" + $("#" + followUpItems[item]).val();
			}
		}

		if (procedure) {
			dataStr += "&procedure=true";
			for (var item in procedureItems) {
				dataStr += "&" + procedureItems[item] + "=" + $("#" + procedureItems[item]).val();
			}
		}

		if (diagnostics) {
			dataStr += "&diagnostics=true";
			for (var item in diagnosticsItems) {
				dataStr += "&" + diagnosticsItems[item] + "=" + $("#" + diagnosticsItems[item]).val();
			}
		}

		dataStr += "&demographic_no=" + demographicNo + "&toProvider=" + $("#planSendTicklerToList").val();

		$.ajax({
			type: "POST",
			url: ctx + "/eyeform/SendTickler.do",
			data: dataStr,
			dataType: "json",
			success: function(data) {
				$("#planSendTicklerBtn, #planSendTicklerTo").css("display", "none");

				var html = "";
				var i = 1;
				if (!(typeof data.followUp == "undefined"))
					html += "<abbr title=\"" + data.followUp + "\">[" + i++ + "]</abbr> ";

				if (!(typeof data.procedure == "undefined"))
					html += "<abbr title=\"" + data.procedure + "\">[" + i++ + "]</abbr> ";

				if (!(typeof data.diagnostics == "undefined"))
					html += "<abbr title=\"" + data.diagnostics + "\">[" + i++ + "]</abbr> ";

				$("#ticklerResponse").html("Sent message(s): " + html);
			}
		});
	});

	//create comma separated list of the measurement types (from attribute)
	var types='';
	$("input[measurement]").each(function() {
		if(types.length > 0) {
			types += ',';
		}
		types += $(this).attr("measurement");
	});
	$("textarea[measurement]").each(function() {
		if(types.length > 0) {
			types += ',';
		}
		types += $(this).attr("measurement");
	});

	//make a call to update the existing values
	$.ajax({
		dataType: "script",
		url:ctx+"/oscarEncounter/MeasurementData.do?demographicNo=" + demographicNo + "&types="+types+"&action=getLatestValues&appointmentNo=" + appointmentNo + "&fresh=cpp_currentHis",
		success: function(data) {
			$("#measurementsBox table").first().attr({
				appointment_no: appointmentNo
			});
		}
	});

	loadMeasurements();

	$("#closeMeasurementsBtn").click(function() {
		$("#measurementsBox").css("display", "none");

		if ($(this).parent().parent().find("[measurement].examfieldwhite").length > 0) {
			saveMeasurements();
		}

	});

	$("#showMeasurementsBtn").click(function() {
		$("#measurementsBox").css("display", "block");

		hideUnenteredMeasurements($("#measurementsBox"));
	});

	$("#nextMeasurementsBtn").click(function () {
		if ($(".selectedMeasurementsTable").length > 0 && $(".selectedMeasurementsTable").next().length > 0) {
			var current = $(".selectedMeasurementsTable").first();
			$(current).removeClass("selectedMeasurementsTable").next().addClass("selectedMeasurementsTable");
		} else {
			$(".selectedMeasurementsTable").removeClass("selectedMeasurementsTable");
			$("#measurements .measurementsTable").first().addClass("selectedMeasurementsTable");
		}

		scrollMeasurementsBox();
	});

	$("#prevMeasurementsBtn").click(function () {
		if ($(".selectedMeasurementsTable").length > 0 && $(".selectedMeasurementsTable").prev().length > 0) {
			var current = $(".selectedMeasurementsTable").first();
			$(current).removeClass("selectedMeasurementsTable").prev().addClass("selectedMeasurementsTable");
		} else {
			$(".selectedMeasurementsTable").removeClass("selectedMeasurementsTable");
			$("#measurements .measurementsTable").last().addClass("selectedMeasurementsTable");
		}

		scrollMeasurementsBox();
	});

	if (!(appointmentNo == "undefined") && appointmentNo.length > 0) {
		$("#complaint").show();
		if (!(typeof reason == "undefined") && reason.length > 0) {
			$("#complaint .content").html(reason);
		}
	}

	$("#measurementsBox").draggable({
		handle: "div.boxTitle",
		cancel: "div.boxTitle .uiBarBtn",
		scroll: false
	});

	$.ajax({
		url: ctx + "/eyeform/Util.do",
		data: "method=getProviders",
		type: "POST",
		dataType: "json",
		success: function(data) {
			for (var p in data.providers) {

				$("#addProcedureProviderList, #planSendTicklerToList, #newTicklerRecipients, #followUp_doc").append("<option value='" + data.providers[p].providerNo + "'>" + data.providers[p].formattedName + "</option>");

				if (data.providers[p].providerType=="doctor") {
					$("#billProvider").append("<option value='" + data.providers[p].providerNo + "|" + data.providers[p].ohipNo + "' providerNo='" + data.providers[p].providerNo + "'>" + data.providers[p].formattedName + "</option>");
				}
			}
		}
	});

	$("#uiSaveNewSpecsBtn").click(function() {
		if (!transformDate($("#newSpecsBox input[name=specs.dateStr]")))
			return false;

		var dataStr = "method=save&json=true";
		$("#newSpecsBox").find("input, select").each(function(index) {
			dataStr += "&" + $(this).attr("name") + "=" + encodeURIComponent($(this).val());
		});

		$.ajax({
			url: ctx + "/eyeform/SpecsHistory.do",
			data: dataStr,
			type: "POST",
			dataType: "json",
			success: function(data) {
				closeAll();
				$("#newSpecsBox").find("input, select").val("");
				$("#uiSaveNewSpecsBtn").css("display", "inline-block");

				refreshBox("specsHistory", false);
			},
			error: function() {
				$("#uiSaveNewSpecsBtn").css("display", "inline-block");
			}
		});

		$(this).css("display", "none");
		$(this).parent().find("loaderImg").css("display", "inline");
	});

	$("#uiSaveNewProcedureBtn").click(function() {
		if (!transformDate($("#newProcedureBox input[name=proc.dateStr]")))
			return false;

		var dataStr = "method=save&json=true";
		$("#newProcedureBox").find("input, select, textarea").each(function(index) {
			dataStr += "&" + $(this).attr("name") + "=" + encodeURIComponent($(this).val());
		});

		$.ajax({
			url: ctx + "/eyeform/OcularProc.do",
			data: dataStr,
			type: "POST",
			dataType: "json",
			success: function(data) {
				closeAll();
				$("#newProcedureBox").find("input, select, textarea").val("");
				$("#uiSaveNewProcedureBtn").css("display", "inline-block");

				refreshBox("procedures", false);

			},
			error: function() {
				$("#uiSaveNewProcedureBtn").css("display", "inline-block");
			}
		});

		$(this).css("display", "none");
		$(this).parent().find("loaderImg").css("display", "inline");
	});

	$("#uiBoxSendTicklerBtn").click(function() {
		var dataStr = "json=true";
		$("#newTicklerBox").find("input, select, textarea").each(function(index) {
			dataStr += "&" + $(this).attr("name") + "=" + encodeURIComponent($(this).val());
		});

		$.ajax({
			url: ctx + "/eyeform/SendTickler.do",
			data: dataStr,
			type: "POST",
			dataType: "json",
			success: function(data) {
				closeAll();
				$("#newTicklerBox").find("input, select, textarea").val("");
				$("#uiBoxSendTicklerBtn").css("display", "inline-block");

				refreshBox("tickler", false);
			}
		});

		$(this).css("display", "none");
		$(this).parent().find("loaderImg").css("display", "inline");
	});

	$("#openMacroBoxBtn, #closeMacroBoxBtn").click(function() {
		if ($("#macroListBox").css("display") == "block") {
			closeAll();
		} else {
			$("#macroListBox").css("top", $(this).offset().top - 2 + "px");
			$("#macroListBox").css("left", $(this).offset().left + 28 + "px");

			$("#macroListBox").css("display", "block");
			$("#macroListBox .arrow").css("display", "block");
			$("#openMacroBoxBtn").addClass("uiBarBtnOn");
		}
	});

	$("#newMacroBtn").click(function() {
		newMacro();
	});

	$("#copyMacroBtn").click(function() {
		copyMacro();
	});

	$("#macroCopyLastImpressionBtn").click(function() {
		if ($(this).hasClass("uiBarBtnOn")) {
			$(this).removeClass("uiBarBtnOn");
			$("#macroImpressionBox").val("");
		} else {
			$(this).addClass("uiBarBtnOn");
			$("#macroImpressionBox").val(COPY_LAST_IMPRESSION_TXT);
		}
	});

	$("#macroBillingTextBox").keyup(function(event) {
		if (!handleAutocompleteKeyup($("#billingAutocomplete"), $(this), event, addBillingToMacroList)) {
			if ($(this).val().length > 0) {
				$.ajax({
					url: ctx + "/eyeform/Util.do?method=getBillingAutocompleteList",
					data: "query=" + $(this).val(),
					type: "POST",
					dataType: "json",
					success: function(data) {
						$("#billingAutocomplete .listItem").remove();

						$("#billingAutocomplete").css("display", "block");

						for (var b in data.billing) {
							$("#billingAutocomplete").append("<div class='listItem' code='" + data.billing[b].serviceCode + "'><span class='autocompleteTitle'>" + data.billing[b].serviceCode + "</span> " + data.billing[b].description + "</div>");
						}

						$("#billingAutocomplete .listItem").first().addClass("selectedListItem");

						$("#billingAutocomplete .listItem").click(function() {
							addBillingToMacroList($(this));
						});

						$("#billingAutocomplete .listItem").mouseover(function() {
							$(".selectedListItem").removeClass("selectedListItem");
						});
					}
				});
			} else {
				$("#billingAutocomplete").css("display", "none");
			}
		}
	}).blur(function() {
		$(this).parent().find("autocompleteList").hide();
	});

	$("#selectMacroExecuteBox").keyup(function(event) {
		if (!handleAutocompleteKeyup($("#macroAutocomplete"), $(this), event, executeMacro)) {
			if ($(this).val().length > 0) {
				$("#macroAutocomplete .listItem").remove();
				$("#macroAutocomplete").css("display", "block");

				var completeList = [];
				for (var m in macros) {
					if (macros[m].label.toLowerCase().indexOf($(this).val().toLowerCase()) >= 0)
						completeList.push(m);
				}

				for (var c in completeList) {
					$("#macroAutocomplete").append("<div class='listItem' code='" + completeList[c] + "'><span class='autocompleteTitle'>" + macros[completeList[c]].label + "</span></div>");
				}

				$("#macroAutocomplete .listItem").first().addClass("selectedListItem");

				$("#macroAutocomplete .listItem").click(function() {
					executeMacro($(this));
				});

				$("#macroAutocomplete .listItem").mouseover(function() {
					$(".selectedListItem").removeClass("selectedListItem");
				});
			} else {
				$("#macroAutocomplete").css("display", "none");
			}
		}
	}).blur(function() {
		$(this).parent().find("autocompleteList").hide();
	});

	$("#macroSaveBtn").click(function() {
		$("#macroSaveBtn").css("display", "none");
		$("#macroListBox .loaderImg").css("display", "inline");

		var data = "";
		$("#macroListBox input, #macroListBox textarea").each(function() {
			if ($(this).attr("name").length > 0)
				data += "&" + $(this).attr("name") + "=" + $(this).val();
		});

		if ($("#macroCopyLastImpressionBtn").hasClass("uiBarBtnOn"))
			data += "&macroCopyFromLastImpression=true";
		else
			data += "&macroCopyFromLastImpression=false";


		$("#macroListBox .macroBillingItem").each(function() {
			data += "&billingData[]=" + $(this).attr("code") + "|1";
		});

		$.ajax({
			url: ctx + "/eyeform/Util.do?method=saveMacro",
			data: data,
			type: "POST",
			dataType: "json",
			success: function(data) {
				if (!(typeof data.saved == "undefined")) {
					$("#macroSaveBtn").css("display", "inline");
					$("#macroListBox .loaderImg").css("display", "none");
				} else {
					alert("Error in saving macro: " + data.error);
				}
			}
		});
	});


	$("#complaint").click(function() {
		if ($(this).find(".content").css("display") == "inline") {
			$(this).find(".content").css("display", "none");
			$("#complaintBox").css("display", "inline");
			$("#complaintBox").val($(this).find(".content").text());

			$("#complaintBox").focus();
		}
	});

	$("#complaintBox").blur(function() {
		$("#complaint .content").text($(this).val());
		updateAppointmentReason($(this).val());

		$(this).css("display", "none");
		$("#complaint .content").css("display", "inline");
	}).bind('keypress', function(e) {
		var code = (e.keyCode ? e.keyCode : e.which);
		if (code == 13) {
			$("#complaint .content").text($(this).val());
			updateAppointmentReason($(this).val());

			$(this).css("display", "none");
			$("#complaint .content").css("display", "inline");
		}
	});



	// Billing box
	$("#billCode").keyup(function(event) {
		if (!handleAutocompleteKeyup($("#billCodeAutocomplete"), $(this), event, addBillingToBillingBox)) {
			if ($(this).val().length > 0) {
				$.ajax({
					url: ctx + "/eyeform/Util.do?method=getBillingAutocompleteList",
					data: "query=" + $(this).val(),
					type: "POST",
					dataType: "json",
					success: function(data) {
						$("#billCodeAutocomplete .listItem").remove();

						$("#billCodeAutocomplete").css("display", "block");

						for (var b in data.billing) {
							$("#billCodeAutocomplete").append("<div class='listItem' code='" + data.billing[b].serviceCode + "'><span class='autocompleteTitle'>" + data.billing[b].serviceCode + "</span> " + data.billing[b].description + "</div>");
						}

						$("#billCodeAutocomplete .listItem").first().addClass("selectedListItem");

						$("#billCodeAutocomplete .listItem").click(function() {
							addBillingToBillingBox($(this));
						});

						$("#billCodeAutocomplete .listItem").mouseover(function() {
							$(".selectedListItem").removeClass("selectedListItem");
						});
					}
				});
			} else {
				$("#billCodeAutocomplete").css("display", "none");
			}
		}
	}).blur(function() {
		$(this).parent().find("autocompleteList").hide();
	});


	$("#billDxCode").keyup(function(event) {
		if (!handleAutocompleteKeyup($("#billDxCodeAutocomplete"), $(this), event, addBillingDxToBillingBox)) {
			if ($(this).val().length > 0) {
				$.ajax({
					url: ctx + "/eyeform/Util.do?method=getBillingDxAutocompleteList",
					data: "query=" + $(this).val(),
					type: "POST",
					dataType: "json",
					success: function(data) {
						$("#billDxCodeAutocomplete .listItem").remove();

						$("#billDxCodeAutocomplete").css("display", "block");

						for (var d in data.dxCode) {
							$("#billDxCodeAutocomplete").append("<div class='listItem' code='" + data.dxCode[d].diagnosticCode + "'><span class='autocompleteTitle'>" + data.dxCode[d].diagnosticCode + "</span> " + data.dxCode[d].description + "</div>");
						}

						$("#billDxCodeAutocomplete .listItem").first().addClass("selectedListItem");

						$("#billDxCodeAutocomplete .listItem").click(function() {
							addBillingDxToBillingBox($(this));
						});

						$("#billDxCodeAutocomplete .listItem").mouseover(function() {
							$(".selectedListItem").removeClass("selectedListItem");
						});


					}
				});
			} else {
				$("#billDxCodeAutocomplete").css("display", "none");
			}
		}
	}).blur(function() {
		$(this).parent().find("autocompleteList").hide();
	});

	$("#clearBillingBtn").click(function() {
		$("#billDxCodeBox").children().remove();
		$("#billCodeBox").children().remove();
		$("#billCode").val("");
		$("#billDxCode").val("");
	});



	retrieveBillingArguments();

	/*
	 * Calendar setup
	 */
	Calendar.setup({ inputField : "specs.dateStr", ifFormat : "%Y-%m-%d", showsTime :false, button : "specs.dateCalBtn", singleClick : true, step : 1 });
	Calendar.setup({ inputField : "newProcedureDate", ifFormat : "%Y-%m-%d", showsTime :false, button : "proc.dateCalBtn", singleClick : true, step : 1 });
	Calendar.setup({ inputField : "billDate", ifFormat : "%Y-%m-%d", showsTime :false, button : "billDateBtn", singleClick : true, step : 1 });


	/*
	 * Appointment Select Button
	 */
	$(".appointmentSelectBtn .appointmentDate").click(function(e) {
		e.stopPropagation();

		var dateList = $(this).parent().find(".appointmentList");

		$(dateList).toggle();

		// Set up list of possible dates for appointment selection
		appointmentDate = [];
		$("[itemtime]").each(function() {
			var d = new Date(parseInt($(this).attr("itemtime")));
			if (!isNaN(d.getTime())) {
				d.setHours(23);
				d.setMinutes(59);
				d.setSeconds(59);

				if ($.inArray(d.getTime(), appointmentDate) == -1)
					appointmentDate.push(d.getTime());
			}
		});

		appointmentDate.sort().reverse();
		$(dateList).empty();

		var appointmentListItemCallback = function(e) {
			e.stopPropagation();

			$(".showAllBtn").each(function() {
				// Remove all 'show all' buttons except the one for macros
				$this = $(this);
				if (!$this.closest("#macro").length)
					$this.remove();
			});

			$("[itemtime]").show();

			var time = $(this).attr("appttime");
			$("[itemtime]").filter(function() {
				return $(this).attr("itemtime") > time;
			}).hide();

			$(this).parent().parent().find(".appointmentDateText").text($(this).text());

			$(this).parent().hide();
		};

		$(dateList).append($("<span>").attr({
			class: "listItem",
			appttime: endOfToday.getTime()
		}).text("Today")
		.click(appointmentListItemCallback));

		for (var d in appointmentDate) {
			$(dateList).append($("<span>").attr({
				class: "listItem",
				appttime: appointmentDate[d]
			}).text(new Date(appointmentDate[d]).toFormattedString())
			.click(appointmentListItemCallback));
		}
	});



});
//Arrage plan  copy from eyeform2/cme.js
function messagesLoaded(savedId){
	   //alert('messagesLoaded() - savedNoteId=' + savedId); 
	   var noteAddonUrl = ctx+"/eyeform/NoteData.do?method=getCurrentNoteData&demographicNo="+demographicNo+"&noteId="+savedId+"&appointmentNo="+appointmentNo;
    jQuery.ajax({url:noteAddonUrl,dataType: "html",success: function(data) {
			jQuery("#current_note_addon").html(data);
    }});

    jQuery("#displayResolvedIssues").hide();
    jQuery("#displayUnresolvedIssues").hide();
    jQuery("#newNoteImg").hide();
    jQuery("#imgPrintEncounter").removeAttr('onclick');
    jQuery("#imgPrintEncounter").live('click',function(e){
 	   e.preventDefault();
 	   location.href=ctx+'/eyeform/Eyeform.do?method=print&apptNos=' + appointmentNo;
    });
    jQuery("#assignIssueSection").html("<span>&nbsp;</span>");
    jQuery("#caseNote_note"+savedId).css('height','10em');
    
    jQuery("#saveImg, #signSaveImg, #signVerifyImg, #signSaveBill").bind('click',function() {      	   
    
 	   jQuery("#save_measurements").click();
 	   saveEyeformNoteNoGenerate();
    });    
}
