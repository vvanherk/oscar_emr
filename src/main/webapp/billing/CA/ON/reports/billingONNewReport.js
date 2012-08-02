/**
 * 
 * totalNumberOfBills (int) and incrementingId (int) are required for this script.
 */ 

/**
 * 
 */ 
function hasClass( classname, element) {
	var cn = element.className;
	
	if( cn.indexOf( classname ) != -1 ) {
        return true;
    }
    
    return false;
}

/**
 * 
 */ 
function addClass( classname, element ) {
    var cn = element.className;
    //test for existance
    if( cn.indexOf( classname ) != -1 ) {
        return;
    }
    //add a space if the element already has class
    if( cn != '' ) {
        classname = ' '+classname;
    }
    element.className = cn+classname;
}

/**
 * 
 */ 
function removeClass( classname, element ) {
    var cn = element.className;
    var rxp = new RegExp( "\\s?\\b"+classname+"\\b", "g" );
    cn = cn.replace( rxp, '' );
    element.className = cn;
}

/**
 * 
 */ 
function showBillDetails(id) {
	var elem = document.getElementById("bill_details"+id);
	removeClass('hide_bill', elem);
	addClass('show_bill', elem);
	document.getElementById("bill"+id).onclick = function() { hideBillDetails(id); }
	setFocusOnFirstInputField(id);
}

/**
 * 
 */ 
function hideBillDetails(id) {
	var elem = document.getElementById("bill_details"+id);
	removeClass('show_bill', elem);
	addClass('hide_bill', elem);
	document.getElementById("bill"+id).onclick = function() { showBillDetails(id); }
	
	hideAllServiceCodeLookups(id);
}

function isAlphaNumericKey(evt) {
	var keynum;
	var keychar;
	var charcheck;
	
	keynum = evt.keyCode;
		
	keychar = String.fromCharCode(keynum);
	charcheck = /[a-zA-Z0-9]/;
	
	return charcheck.test(keychar);
}

function isBackspaceKey(evt) {
	return (evt.keyCode == 8);
}

function isDeleteKey(evt) {
	return (evt.keyCode == 46);
}

/**
 * 
 */ 
function isShiftKey(evt) {
	return (evt.shiftKey);
}

/**
 * 
 */ 
function isEnterKey(evt) {
	return (evt.keyCode == 13);
}

/**
 * 
 */ 
function isUpArrowKey(evt) {
	return (evt.keyCode == 38);
}

/**
 * 
 */ 
function isDownArrowKey(evt) {
	return (evt.keyCode == 40);
}

/**
 * 
 */ 
function isTabKey(evt) {
	return (evt.keyCode == 9 && !evt.shiftKey);
}

function setServiceCode(billId, billingItemId, serviceCode) {
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	var inputElements = billingItem.getElementsByTagName("input");
	
	if (inputElements != null && inputElements.length > 0) {
		inputElements[0].value = serviceCode;
	}
}

function setDiagnosticCode(billId, billingItemId, diagnosticCode) {
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	var inputElements = billingItem.getElementsByTagName("input");
	
	if (inputElements != null && inputElements.length > 0) {
		inputElements[3].value = diagnosticCode;
	}
}

function setDiagnosticDescription(billId, billingItemId, diagnosticDescripton) {
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	var inputElements = billingItem.getElementsByTagName("input");
	
	if (inputElements != null && inputElements.length > 0) {
		inputElements[4].value = diagnosticDescripton;
	}
}

/**
 * function checkIfLastBillingItem
 * 
 * Returns true if the billing item with id 'billingItemId' is the last billing item
 * in the bill with bill id 'id'; false otherwise.
 */ 
function checkIfLastBillingItem(id, billingItemId) {
	var billingItem = document.getElementById("billing_item"+id+"_"+billingItemId);
	var lastBillingItem = billingItem.parentNode.lastChild;
	
	// We want the last element, so we may have to find it
	while (lastBillingItem.nodeType!=1) {
		lastBillingItem = lastBillingItem.previousSibling;
	}
	
	return (billingItem === lastBillingItem);
}

/**
 * function isMoveBetweenBills
 * 
 * Returns true if the event 'evt' represents a 'move between bills' event; false otherwise
 */ 
function isMoveBetweenBills(evt) {
	return (isUpArrowKey(evt) || isDownArrowKey(evt)) && !isShiftKey(evt);
}

function isMoveBetweenBillingItems(evt) {
	return (isUpArrowKey(evt) || isDownArrowKey(evt)) && isShiftKey(evt);
}

/**
 * 
 */ 
function isSaveBill(evt) {
	return isEnterKey(evt);
}

/**
 * function moveBetweenBills
 * 
 * Will move the cursor focus from one bill to either the previous or next bill
 * (depending on user input) relative to the bill with id 'id'.  
 * Focus will go to the first text field of the previous/next bill.  
 * If there is no previous or next bill, nothing will happen.
 */ 
function moveBetweenBills(evt, id) {	
	if (isUpArrowKey(evt)) {
		moveToPreviousBill(id);
	} else if(isDownArrowKey(evt)) {
		moveToNextBill(id);
	}
}

/**
 * 
 */ 
function moveToNextBill(currentBillId) {
	var nextBillId = getNextBillId(currentBillId);
	
	// skip bills that are already saved
	while (isValidBillId(nextBillId) && isSaved(nextBillId))
		nextBillId = getNextBillId(nextBillId);
	
	if (isValidBillId(nextBillId)) {
		moveFromBillToBill(currentBillId, nextBillId);
	}
}

/**
 * 
 */ 
function moveToPreviousBill(currentBillId) {
	var previousBillId = getPreviousBillId(currentBillId);
	
	// skip bills that are already saved
	while (isValidBillId(previousBillId) && isSaved(previousBillId))
		previousBillId = getPreviousBillId(previousBillId);
	
	if (isValidBillId(previousBillId)) {
		moveFromBillToBill(currentBillId, previousBillId);
	}
}

/**
 * 
 */ 
function moveFromBillToBill(moveFromId, moveToId) {
	hideBillDetails(moveFromId);
	showBillDetails(moveToId);
	setFocusOnFirstInputField(moveToId);
}

/**
 * 
 */ 
function moveBetweenBillingItems(evt, billId) {	
	if (isUpArrowKey(evt)) {
		moveToPreviousBillingItem(billId);
	} else if(isDownArrowKey(evt)) {
		moveToNextBillingItem(billId);
	}
}

/**
 * 
 */
function moveToNextBillingItem(billId, billingItemIndex) {
	billingItemIndex = billingItemIndex || -1;
	
	// if billingItemId is less than 0, set focus to first input field of the next billing item 
	// (relative to the billing item that has the active input field as defined by document.activeElement)
	if (billingItemIndex < 0) {	
		var billingItems = document.getElementById("billing_items"+billId);
		var rowElements = billingItems.getElementsByTagName("tr");
		
		for (var i=0; i < rowElements.length; i++) {
			var inputElements = rowElements[i].getElementsByTagName("input");
			for (var j=0; j < inputElements.length; j++) {
				if (inputElements[j] == document.activeElement) {
					// set focus to first input element of the next billing item
					if (rowElements[i+1] != null && rowElements[i+1] != undefined) {
						setFocusOnFirstInputFieldByIndex(billId, i+1);
						return;
					}
				}
			}
		}
	} else {
		setFocusOnFirstInputFieldByIndex(billId, billingItemIndex+1);
	}
}

/**
 * 
 */
function moveToPreviousBillingItem(billId, billingItemIndex) {
	billingItemIndex = billingItemIndex || -1;
	
	// if billingItemId is less than 0, set focus to first input field of the next billing item 
	// (relative to the billing item that has the active input field as defined by document.activeElement)
	if (billingItemIndex < 0) {	
		var billingItems = document.getElementById("billing_items"+billId);
		var rowElements = billingItems.getElementsByTagName("tr");
		
		for (var i=0; i < rowElements.length; i++) {
			var inputElements = rowElements[i].getElementsByTagName("input");
			for (var j=0; j < inputElements.length; j++) {
				//alert(inputElements[j] + " " + document.activeElement);
				if (inputElements[j] == document.activeElement) {
					// set focus to first input element of the next billing item
					if (rowElements[i-1] != null && rowElements[i-1] != undefined) {
						setFocusOnFirstInputFieldByIndex(billId, i-1);
						return;
					}
				}
			}
		}
	} else {
		setFocusOnFirstInputFieldByIndex(billId, billingItemIndex-1);
	}
}

/**
 * 
 */ 
function isValidBillId(billId) {
	if (billId < 0 || billId > totalNumberOfBills)
		return false;
	
	return true;
}



/**
 * 
 */ 
function saveBill(evt, id) {
	var elem = document.getElementById("bill_details"+id);
	removeClass('incompleted', elem);
	addClass('completed', elem);
	
	// convert input elements to span elements (i.e. uneditable text)
	var rows = elem.getElementsByTagName("tr");
	for (var i=0; i < rows.length; i++) {
		var cells = rows[i].getElementsByTagName("td");
		for (var j=0; j < cells.length; j++) {
			var replacementElement = document.createElement("span");
			
			if (cells[j] == undefined)
				continue;
			
			var inputElement = cells[j].getElementsByTagName("input")[0];
			if (inputElement == null)
				continue;
				
			replacementElement.innerHTML = inputElement.value;
			cells[j].removeChild(inputElement);
			cells[j].appendChild(replacementElement);
		}
	}
	
	// hide all 'buttons'
	var rows = elem.getElementsByTagName("a");
	for (var i=0; i < rows.length; i++) {
		addClass('hide_button', rows[i]);
	}
	
	
	
	elem = document.getElementById("bill"+id);
	removeClass('no-bills', elem);
	addClass('completed', elem);
	
	
}

function isSaved(billId) {
	var elem = document.getElementById("bill"+billId);
	
	return hasClass("completed", elem);
}

/**
 * 
 */ 
function addBillingItem(id) {
	//Create an input type dynamically.
	var element = document.createElement("tr");	
	var billingItemId = getId();
	element.setAttribute("id", "billing_item"+id+"_"+billingItemId);
	
	
	var onkeydown = "onkeydown=\"";
	onkeydown+= "if (isTabKey(event)) {";
	onkeydown+= "	hideAllServiceCodeLookups("+id+"); ";
	onkeydown+= "	return true; ";
	onkeydown+= "}";
	onkeydown+= "if (isSaveBill(event)) {";
	onkeydown+= "	saveBill(event, "+id+"); ";
	onkeydown+= "	moveToNextBill("+id+"); ";
	onkeydown+= "}";
	onkeydown+= "if (isMoveBetweenBills(event)) {";
	onkeydown+= "	moveBetweenBills(event, "+id+"); ";
	onkeydown+= "}";
	onkeydown+= "if (isMoveBetweenBillingItems(event)) {";
	onkeydown+= "	moveBetweenBillingItems(event, "+id+");";
	onkeydown+= "}\"";
	
	var totalOnkeydown = "onkeydown=\"";
	totalOnkeydown+= "if (isTabKey(event)) {";
	totalOnkeydown+= "	hideAllServiceCodeLookups("+id+"); ";
	totalOnkeydown+= "	if (checkIfLastBillingItem("+id+", "+billingItemId+")) {";
	totalOnkeydown+= "		addBillingItem("+id+"); ";
	totalOnkeydown+= "	} ";
	totalOnkeydown+= "} ";
	totalOnkeydown+= "if (isSaveBill(event)) {";
	totalOnkeydown+= "	saveBill(event, "+id+"); ";
	totalOnkeydown+= "	moveToNextBill("+id+"); ";
	totalOnkeydown+= "}";
	totalOnkeydown+= "if (isMoveBetweenBills(event)) {";
	totalOnkeydown+= "	moveBetweenBills(event, "+id+"); ";
	totalOnkeydown+= "} ";
	totalOnkeydown+= "if (isMoveBetweenBillingItems(event)) {";
	totalOnkeydown+= "	moveBetweenBillingItems(event, "+id+");";
	totalOnkeydown+= "}";
	totalOnkeydown+= "return true;\"";
	
	var onkeyup = "onkeyup=\"";
	onkeyup+= "if (this.value.length == 0) {";
	onkeyup+= "	hideServiceCodeLookup("+id+", "+billingItemId+");";
	onkeyup+= "	hideDiagnosticCodeLookup("+id+", "+billingItemId+");";
	onkeyup+= "} else { ";
	onkeyup+= "	if (isAlphaNumericKey(event) || isBackspaceKey(event) || isDeleteKey(event)) {";
	onkeyup+= "		if (this.name.indexOf('bill_code') == 0) {";
	onkeyup+= "			showAvailableServiceCodes("+id+", "+billingItemId+", this.value);";
	onkeyup+= "		} else if (this.name.indexOf('dx_code') == 0) {";
	onkeyup+= "			showAvailableDiagnosticCodes("+id+", "+billingItemId+", this.value);";
	onkeyup+= "		} else if (this.name.indexOf('dx_desc') == 0) {";
	onkeyup+= "			showAvailableDiagnosticCodes("+id+", "+billingItemId+", '', this.value);";
	onkeyup+= "		}";
	onkeyup+= "	}";
	onkeyup+= "}";
	onkeyup+= "return true; \"";
	
	var htmlString = "<td> <a class=\"button\" href=\"\"  tabindex=\"-1\" onclick=\"deleteBillingItem("+id+", "+billingItemId+"); return false;\">X</a></td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"bill_code"+id+"\" "+onkeydown+" "+onkeyup+" /> <div id=\"service_code_lookup"+id+"_"+billingItemId+"\" class=\"lookup_box\" style=\"display:none;\"></div> </td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"amount"+id+"\" "+onkeydown+" /> </td>";
	htmlString += "<td> <input type=\"text\" size=\"3\" name=\"units"+id+"\" "+onkeydown+" /> </td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"dx_code"+id+"\" "+onkeydown+" "+onkeyup+" /> <div id=\"diagnostic_code_lookup"+id+"_"+billingItemId+"\" class=\"lookup_box\" style=\"display:none;\"></div> </td>";
	htmlString += "<td> <input type=\"text\" size=\"12\" name=\"dx_desc"+id+"\" "+onkeydown+" "+onkeyup+" /> <div id=\"diagnostic_desc_lookup"+id+"_"+billingItemId+"\" class=\"lookup_box\" style=\"display:none;\"></div> </td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"total"+id+"\" "+totalOnkeydown+" /> </td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"sli_code"+id+"\" disabled=\"disabled\" /> </td>";
	element.innerHTML = htmlString;
	
	var billingItems = document.getElementById("billing_items"+id);
	
	//Append the element in page (in span).
	billingItems.appendChild(element);
	
	element.focus();
}

/**
 * 
 */ 
function deleteBillingItem(id, billingItemId) {	
	var billingItem = document.getElementById("billing_item"+id+"_"+billingItemId);
	billingItem.parentNode.removeChild(billingItem);
}

/**
 * 
 */ 
function submitBill(id) {
	var result = confirm('Are you sure you want to submit this bill?');
	
	return result;
}

/**
 * 
 */ 
function setFocusOnFirstInputField(billId, billingItemId) {
	billingItemId = billingItemId || -1;
	
	// if billingItemId is less than 0, set focus to first input field of first billing item
	if (billingItemId < 0) {
		var firstBillingItem = document.getElementById("billing_items"+billId).getElementsByTagName("tr")[0];
		var firstInputField = firstBillingItem.getElementsByTagName("input")[0];
		firstInputField.focus();
		return;
	}
	
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	
	if (billingItem != null && billingItem != undefined) {
		billingItem.getElementsByTagName("input")[0].focus();
	}
}

/**
 * 
 */ 
function setFocusOnFirstInputFieldByIndex(billId, billingItemIndex) {
	billingItemIndex = billingItemIndex || 0;

	var billingItems = document.getElementById("billing_items"+billId);
	var rowElements = billingItems.getElementsByTagName("tr");
	
	if (rowElements[billingItemIndex] != null && rowElements[billingItemIndex] != undefined) {
		rowElements[billingItemIndex].getElementsByTagName("input")[0].focus();
	}
}

/**
 * function getNextBillId
 * 
 * Returns the id of the bill after the bill with id 'id'.
 * If there is no bill, or if there is no bill with id 'id',
 * -1 is returned.
 */ 
function getNextBillId(id) {
	var nextBillId = id+1;
	
	if (nextBillId > totalNumberOfBills)
		return -1;
	
	var bill = document.getElementById("bill"+nextBillId);
	while (bill == null && nextBillId <= totalNumberOfBills) {
		nextBillId++;
		bill = document.getElementById("bill"+nextBillId);
	}
	
	// if there is no next bill, return -1
	if (bill == null || nextBillId > totalNumberOfBills) {
		return -1;
	}
	
	return nextBillId;
}

/**
 * function getPreviousBillId
 * 
 * Returns the id of the bill before the bill with id 'id'.
 * If there is no bill, or if there is no bill with id 'id',
 * -1 is returned.
 */ 
function getPreviousBillId(id) {
	var previousBillId = id-1;
	
	if (previousBillId < 0)
		return -1;
	
	var bill = document.getElementById("bill"+previousBillId);
	while (bill == null && nextBillId > 0) {
		previousBillId--;
		bill = document.getElementById("bill"+previousBillId);
	}
	
	// if there is no previous bill, return -1
	if (bill == null || previousBillId < 0) {
		return -1;
	}
	
	return previousBillId;	
}

function showAvailableServiceCodes(billId, billingItemId, serviceCode) {
	getBillingCodes(billId, billingItemId, serviceCode);
	document.getElementById("service_code_lookup"+billId+"_"+billingItemId).style.display = "";
}

function hideServiceCodeLookup(billId, billingItemId) {
	document.getElementById("service_code_lookup"+billId+"_"+billingItemId).style.display = "none";
}

function hideAllServiceCodeLookups(billId) {
	var bill = document.getElementById("billing_items"+billId);
	var divElements = bill.getElementsByTagName("div");
	
	if (divElements == null)
		return;
	
	for (var i=0; i < divElements.length; i++) {
		if (divElements[i].id.indexOf("service_code_lookup"+billId+"_") == 0)
			divElements[i].style.display = "none";
	}
}

function showAvailableDiagnosticCodes(billId, billingItemId, diagnosticCode, diagnosticDescription) {
	getDiagnosticCodes(billId, billingItemId, diagnosticCode, diagnosticDescription);
	if (diagnosticCode)
		document.getElementById("diagnostic_code_lookup"+billId+"_"+billingItemId).style.display = "";
	else if (diagnosticDescription)
		document.getElementById("diagnostic_desc_lookup"+billId+"_"+billingItemId).style.display = "";
}

function hideDiagnosticCodeLookup(billId, billingItemId) {
	document.getElementById("diagnostic_code_lookup"+billId+"_"+billingItemId).style.display = "none";
}

function hideDiagnosticDescriptionLookup(billId, billingItemId) {
	document.getElementById("diagnostic_desc_lookup"+billId+"_"+billingItemId).style.display = "none";
}

function hideAllDiagnosticLookups(billId) {
	var bill = document.getElementById("billing_items"+billId);
	var divElements = bill.getElementsByTagName("div");
	
	if (divElements == null)
		return;
	
	for (var i=0; i < divElements.length; i++) {
		if (divElements[i].id.indexOf("diagnostic_code_lookup"+billId+"_") == 0)
			divElements[i].style.display = "none";
		if (divElements[i].id.indexOf("diagnostic_desc_lookup"+billId+"_") == 0)
			divElements[i].style.display = "none";
	}
}

/**
 * 
 */ 
function showMoreDetails(billId, demographicNo, appointmentNo) {
	// load details if not already loaded
	var element = document.getElementById("billing_history"+billId);
	var billDetailsElement = element;
	
	element = document.getElementById("appointment_notes"+billId);
	var appointmentNotesElement = element;
	
	var contents = (billDetailsElement.innerHTML.trim) ? billDetailsElement.innerHTML.trim() : billDetailsElement.innerHTML.replace(/^\s+/,'');
	if (contents == "" || contents.toLowerCase().indexOf("loading") != -1) {
		//billDetailsElement.innerHTML = formatBills( getBillsForDemographic(billId, demographicNo) );
		getBillsForDemographic(billId, demographicNo);
	}
	
	contents = (appointmentNotesElement.innerHTML.trim) ? appointmentNotesElement.innerHTML.trim() : appointmentNotesElement.innerHTML.replace(/^\s+/,'');
	if (contents == "" || contents.toLowerCase().indexOf("loading") != -1) {
		//appointmentNotesElement.innerHTML = formatAppointmentNotes( getAppointmentNotes(billId, appointmentNo) );
		getAppointmentNotes(billId, appointmentNo);
	}
	
	// show the details
	document.getElementById("more_details"+billId).style.display = "";
	document.getElementById("more_details_button"+billId).onclick = function() { hideMoreDetails(billId, demographicNo, appointmentNo); return false; }
	document.getElementById("more_details_button"+billId).innerHTML = "less";
}

/**
 * 
 */ 
function hideMoreDetails(billId, demographicNo, appointmentNo) {
	// hide the details
	document.getElementById("more_details"+billId).style.display = "none";
	document.getElementById("more_details_button"+billId).onclick = function() { showMoreDetails(billId, demographicNo, appointmentNo); return false; }	
	document.getElementById("more_details_button"+billId).innerHTML = "more";
}

/**
 * function getId
 * 
 * Keeps track of and returns the next available id for a billing item.
 */ 
var getId = (function () {
  return function() {
    return incrementingId++;
  };
}());


/**
 * 
 */ 
function createXMLHttpRequest() {
	// See http://en.wikipedia.org/wiki/XMLHttpRequest
	// Provide the XMLHttpRequest class for IE 5.x-6.x:
	if( typeof XMLHttpRequest == "undefined" ) XMLHttpRequest = function() {
		try { return new ActiveXObject("Msxml2.XMLHTTP.6.0") } catch(e) {}
		try { return new ActiveXObject("Msxml2.XMLHTTP.3.0") } catch(e) {}
		try { return new ActiveXObject("Msxml2.XMLHTTP") } catch(e) {}
		try { return new ActiveXObject("Microsoft.XMLHTTP") } catch(e) {}
	throw new Error( "This browser does not support XMLHttpRequest." )
	};
	return new XMLHttpRequest();
}

/**
 * 
 */ 
function getBillsHandler(billId) {
	return function parseResponse() {
		if(this.readyState == 4 && this.status == 200) {
			var json = this.responseText;
			var json = eval('(' + this.responseText +')');
			
			// remove the current bill(s) from the array
			if (json.length != 0) {
				for (var i = 0; i < json.length;) { 
					if (json[i]['status'] == "O") {
						json.splice(i, 1);
					}
					i++;
				}
			}
			
			var billString = "";
			if (json.length == 0) {
				billString+= "<tbody><tr><td>No billing history</td></tr></tbody>";
			} else {
				billString+= "<tbody>";
				
				for (var i = 0; i < json.length; i++) { 
				    //alert(json[i]);
				    
				    if (i != 0)
						billString+= "<tr><td class=\"space\"></td></tr>";
				    
				    billString+= "<tr>";
					billString+= "	<th>Id</th>";
					billString+= "	<th>Date</th>";
					billString+= "	<th>Time</th>";
					billString+= "	<th>Total</th>";
					billString+= "	<th>Paid</th>";
					billString+= "	<th>Status</th>";
					billString+= "</tr>";
				    
				    billString+= "<tr>";
				    billString+= wrapTD(json[i]['id']);
				    billString+= wrapTD(json[i]['billing_date']);
				    billString+= wrapTD(json[i]['billing_time']);
				    billString+= wrapTD(json[i]['total']);
				    billString+= wrapTD(json[i]['paid']);
				    billString+= wrapTD(json[i]['status']);
				    billString+= "</tr>";
				    
					billString+= "<tr>";
					billString+= "	<th>Billing Code</th>";
					billString+= "	<th>Amount</th>";
					billString+= "	<th>Units</th>";
					billString+= "	<th>Dx Code</th>";
					billString+= "	<th>Dx Description</th>";
					billString+= "	<th>Total</th>";
					//billString+= "	<th>SLI Code</th>";
					billString+= "</tr>";
				    
				    var billingItemString = "";	
				    if (json[i]['bill'].length) {
					    for (var j = 0; j < json[i]['bill'].length; j++) { 
							//alert(billingItem);
							billingItemString+= "<tr>";
						    billingItemString+= wrapTD(json[i]['bill'][j]['item']);
						    billingItemString+= wrapTD(json[i]['bill'][j]['fee']);
						    billingItemString+= wrapTD(json[i]['bill'][j]['units']);
						    billingItemString+= wrapTD(json[i]['bill'][j]['dx']);
						    billingItemString+= wrapTD(json[i]['bill'][j]['description']);
						    billingItemString+= wrapTD(json[i]['bill'][j]['total']);		    
						    billingItemString+= "</tr>";
						}
					} else {
						var billingItem = json[i]['bill'];
					    billingItemString+= "<tr>";
					    billingItemString+= wrapTD(billingItem['item']);
					    billingItemString+= wrapTD(billingItem['fee']);
					    billingItemString+= wrapTD(billingItem['units']);
					    billingItemString+= wrapTD(billingItem['dx']);
					    billingItemString+= wrapTD(billingItem['description']);
					    billingItemString+= wrapTD(billingItem['total']);		    
					    billingItemString+= "</tr>";
					}
					
					billString+= billingItemString;
				}
				
				billString+= "</tbody>";
			}
			
			var element = document.getElementById("billing_history"+billId);
			element.innerHTML = billString;
	
			
			//alert('Success. Result: ' + json);
		}else if (this.readyState == 4 && this.status != 200) {
			//alert('Something went wrong...');
			var element = document.getElementById("billing_history"+billId);
			element.innerHTML = "<tbody><tr><td>An error occured.</td></tr></tbody>";
		}
	};
}

/**
 * 
 */ 
function wrapTD(text) {
	return "<td>" + text + "</td>";
}

/**
 * 
 */ 
function getAppointmentNotesHandler(billId) {
	return function parseResponse() {
		if(this.readyState == 4 && this.status == 200) {
			var json = this.responseText;
			var json = eval('(' + this.responseText +')');	
			
			var notesString = "";
			if (json.length == 0) {
				notesString+= "<tbody><tr><td>No appointment notes</td></tr></tbody>";
			} else {
				notesString+= "<tbody>";
				
				notesString+= "<tr>";
				notesString+= "	<th>Date &amp; Time</th>";
				notesString+= "	<th>Note</th>";
				notesString+= "</tr>";
				for (var i = 0; i < json.length; i++) { 			    
				    notesString+= "<tr>";
				    notesString+= wrapTD(json[i]['observation_date']);
				    notesString+= wrapTD(json[i]['note']);
				    notesString+= "</tr>";
				}
				
				notesString+= "</tbody>";
			}
			
			var element = document.getElementById("appointment_notes"+billId);
			element.innerHTML = notesString.replace(/\n/g, '<br>');
			
			//alert('Success. Result: ' + notesString);
		} else if (this.readyState == 4 && this.status != 200) {
			//alert('Something went wrong...');
			var element = document.getElementById("appointment_notes"+billId);
			element.innerHTML = "<tbody><tr><td>An error occured.</td></tr></tbody>";
		}
	};
}

/**
 * 
 */ 
function getBillingCodesHandler(billId, billingItemId) {
	return function parseResponse() {
		if(this.readyState == 4 && this.status == 200) {
			var json = this.responseText;
			var json = eval('(' + this.responseText +')');	
			
			var serviceCodesString = "";
			if (json.length != 0) {	
				var serviceCodesString = "<ul>";
				var onclick = "onclick=\"";
				onclick += "setServiceCode("+billId+", "+billingItemId+", extractServiceCode(this));";
				onclick += "hideServiceCodeLookup("+billId+", "+billingItemId+");";
				onclick += "setFocusOnFirstInputField("+billId+", "+billingItemId+");";
				onclick += "\"";
				for (var i = 0; i < json.length; i++) { 			    
				    serviceCodesString+= "<li "+onclick+">";
				    serviceCodesString+= "<b><span>" + json[i]['service_code'] + "</span></b>";
				    serviceCodesString+= " ";
				    serviceCodesString+= json[i]['description'];
				    serviceCodesString+= "</li>";
				}
				serviceCodesString += "</ul>";
			}
			
			var element = document.getElementById("service_code_lookup"+billId+"_"+billingItemId);
			element.innerHTML = serviceCodesString;
			
			//alert('Success. Result: ' + serviceCodesString);
		} else if (this.readyState == 4 && this.status != 200) {
			//alert('Something went wrong...');
			var element = document.getElementById("service_code_lookup"+billId+"_"+billingItemId);
			element.innerHTML = "An error occured.";
		}
	};
}

/**
 * 
 */ 
function extractServiceCode(item){
	if (item == null)
		return "";
		
	var spanElements = item.getElementsByTagName("span");
	
	if (spanElements != null && spanElements.length > 0) {
		return spanElements[0].innerHTML;
	}
	
	return "";
}

/**
 * 
 */ 
function getDiagnosticCodeHandler(billId, billingItemId, diagnosticCode, description) {
	return function parseResponse() {
		if(this.readyState == 4 && this.status == 200) {
			var json = this.responseText;
			var json = eval('(' + this.responseText +')');	
			
			var serviceCodesString = "";
			if (json.length != 0) {	
				var serviceCodesString = "<ul>";
				var onclick = "onclick=\"";
				onclick += "setDiagnosticCode("+billId+", "+billingItemId+", extractDiagnosticCode(this));";
				onclick += "setDiagnosticDescription("+billId+", "+billingItemId+", extractDiagnosticDescription(this));";
				onclick += "hideDiagnosticCodeLookup("+billId+", "+billingItemId+");";
				onclick += "hideDiagnosticDescriptionLookup("+billId+", "+billingItemId+");";
				onclick += "setFocusOnFirstInputField("+billId+", "+billingItemId+");";
				onclick += "\"";
				for (var i = 0; i < json.length; i++) { 			    
				    serviceCodesString+= "<li "+onclick+">";
				    serviceCodesString+= "<b><span>" + json[i]['diagnostic_code'] + "</span></b>";
				    serviceCodesString+= " ";
				    serviceCodesString+= "<span>"+ json[i]['description'] + "</span>";
				    serviceCodesString+= "</li>";
				}
				serviceCodesString += "</ul>";
			}
			
			if (diagnosticCode) {
				var element = document.getElementById("diagnostic_code_lookup"+billId+"_"+billingItemId);
				element.innerHTML = serviceCodesString;
			} else {
				var element = document.getElementById("diagnostic_desc_lookup"+billId+"_"+billingItemId);
				element.innerHTML = serviceCodesString;
			}
			
			//alert('Success. Result: ' + serviceCodesString);
		} else if (this.readyState == 4 && this.status != 200) {
			//alert('Something went wrong...');
			if (diagnosticCode) {
				var element = document.getElementById("diagnostic_code_lookup"+billId+"_"+billingItemId);
				element.innerHTML = "An error occured.";
			} else {
				var element = document.getElementById("diagnostic_desc_lookup"+billId+"_"+billingItemId);
				element.innerHTML = "An error occured.";
			}
			
		}
	};
}

/**
 * 
 */ 
function extractDiagnosticCode(item){
	if (item == null)
		return "";
		
	var spanElements = item.getElementsByTagName("span");
	
	if (spanElements != null && spanElements.length > 0) {
		return spanElements[0].innerHTML;
	}
	
	return "";
}

/**
 * 
 */ 
function extractDiagnosticDescription(item){
	if (item == null)
		return "";
		
	var spanElements = item.getElementsByTagName("span");
	
	if (spanElements != null && spanElements.length > 1) {
		return spanElements[1].innerHTML;
	}
	
	return "";
}

/**
 * 
 */ 
function getBillsForDemographic(billId, demographicNo) {
	var AJAX = createXMLHttpRequest();
	AJAX.onreadystatechange = getBillsHandler(billId);
	AJAX.open("GET", "reports/getBills.jsp?demographicNo="+demographicNo);
	AJAX.send("");
}

/**
 * 
 */ 
function getAppointmentNotes(billId, appointmentNo) {
	var AJAX = createXMLHttpRequest();
	AJAX.onreadystatechange = getAppointmentNotesHandler(billId);
	AJAX.open("GET", "reports/getAppointmentNotes.jsp?appointmentNo="+appointmentNo);
	AJAX.send("");
}

/**
 * 
 */ 
function getBillingCodes(billId, billingItemId, serviceCode) {
	var AJAX = createXMLHttpRequest();
	AJAX.onreadystatechange = getBillingCodesHandler(billId, billingItemId);
	AJAX.open("GET", "reports/getBillingCodes.jsp?serviceCode="+serviceCode);
	AJAX.send("");
}

/**
 * 
 */ 
function getDiagnosticCodes(billId, billingItemId, diagnosticCode, description) {
	var AJAX = createXMLHttpRequest();
	AJAX.onreadystatechange = getDiagnosticCodeHandler(billId, billingItemId, diagnosticCode, description);
	AJAX.open("GET", "reports/getDiagnosticCodes.jsp?diagnosticCode="+diagnosticCode+"&diagnosticDescription="+description);
	AJAX.send("");
}
