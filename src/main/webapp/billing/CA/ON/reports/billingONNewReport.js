/**
 * 
 * totalNumberOfBills (int), incrementingId (int), demographicNumbers (Array), and appointmentNumbers (Array) are required for this script.
 */ 

/**
 * Setup our hotkeys for the page
 */ 
document.onkeydown = function(evt) {
	// fix for Internet Explorer
	if (!evt)
		evt = event;
		
	if (isShowMoreDetails(evt)) {
	}
	
	if (isSubmitBillsKey(evt)) {
		setSubmit();
		submitBills();
	}
}

/**
 * Stop the given event from propagating up to parent elements.
 * 
 * Why do this? Some elements don't want to allow events to propogate up (i.e. clicking a checkbox on a bill shouldn't open the bill)
 */ 
function  preventEventPropagation(event) {
   if (event.stopPropagation){
       event.stopPropagation();
   } else if(window.event){
      window.event.cancelBubble = true;
   }
}




function previousPage() {
	var elem = document.getElementsByName('current_page')[0];
	jumpToPage(parseInt(elem.value, 10) - 1);
}

function nextPage() {
	var elem = document.getElementsByName('current_page')[0];
	jumpToPage(parseInt(elem.value, 10) + 1);
}

function jumpToPage(pageNum) {
	if (pageNum <= 0)
		return;
	
	var elem = document.getElementsByName('current_page')[0];
	elem.value = pageNum;
	
	document.forms['serviceform'].submit();
}


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
	if (!isSaved(id)) {
		var elem = document.getElementById("bill_details"+id);
		removeClass('hide_bill', elem);
		addClass('show_bill', elem);
		document.getElementById("bill"+id).onclick = function() { hideBillDetails(id); }
		//setFocusOnAdmissionDateField(id);
		setFocusOnInputField(id);
	}
}

/**
 * 
 */ 
function hideBillDetails(id) {
	if (!isSaved(id)) {
		var elem = document.getElementById("bill_details"+id);
		removeClass('show_bill', elem);
		addClass('hide_bill', elem);
		document.getElementById("bill"+id).onclick = function() { showBillDetails(id); }
	}
	
	hideAllServiceCodeLookups(id);
}

/**
 * 
 */ 
function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

function isCurrency(n) {
	if (n == null || n === 'undefined')
		return false;
		
	n = n.replace('$', '').replace(',', '');
	
	return isNumber(n);
}

function formatCurrencyAsFloat(n) {
	if (n == null || n === 'undefined')
		return '';
	
	if (isNumber(n))
		return parseFloat(n);
	
	n = n.replace('$', '').replace(',', '');
	
	return parseFloat(n);
}

/** This function taken from http://stackoverflow.com/questions/149055/how-can-i-format-numbers-as-money-in-javascript */
/* 
decimal_sep: character used as deciaml separtor, it defaults to '.' when omitted
thousands_sep: char used as thousands separator, it defaults to ',' when omitted
*/
Number.prototype.formatCurrency = function(decimals, decimal_sep, thousands_sep) {
	var n = this,
		c = isNaN(decimals) ? 2 : Math.abs(decimals), //if decimal is zero we must take it, it means user does not want to show any decimal
		d = decimal_sep || '.', //if no decimal separator is passed we use the dot as default decimal separator (we MUST use a decimal separator)
		
		/*
		according to [http://stackoverflow.com/questions/411352/how-best-to-determine-if-an-argument-is-not-sent-to-the-javascript-function]
		the fastest way to check for not defined parameter is to use typeof value === 'undefined' 
		rather than doing value === undefined.
		*/   
		t = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep, //if you don't want to use a thousands separator you can pass empty string as thousands_sep value
		
		sign = (n < 0) ? '-' : '',
		
		//extracting the absolute value of the integer part of the number and converting to string
		i = parseInt(n = Math.abs(n).toFixed(c)) + '', 
		
		j = ((j = i.length) > 3) ? j % 3 : 0; 
		
	return sign + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : ''); 
}

Number.prototype.toMoney = function(decimals, decimal_sep, thousands_sep, currency_string) {
	currency_string = (typeof currency_string === 'undefined') ? '$' : currency_string;
	
	return currency_string + this.formatCurrency(decimals, decimal_sep, thousands_sep);
}


function isAlphaNumericKey(evt) {
	var keynum;
	var keychar;
	var charcheck;
	
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	
	// hack for function keys
	if (keynum >= 112 && keynum <= 123)
		return;
	
	keychar = String.fromCharCode(keynum);
	
	charcheck = /[a-zA-Z0-9]/;
	
	return charcheck.test(keychar);
}

function isNumericKey(evt) {
	var keynum;
	var keychar;
	var charcheck;
	
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	keychar = String.fromCharCode(keynum);
	
	charcheck = /[0-9]/;
	
	return charcheck.test(keychar);
}

/**
 * Returns true if the key pressed results in a '$', a '.' or a numeric character (i.e. 0-9)
 */ 
function isCurrencyKey(evt) {
	keynum = (evt.which) ? evt.which : evt.keyCode;
	
	return keynum == 190 || (isShiftKey(evt) && keynum == 52) || isNumericKey(evt);
}

function isCtrlKey(evt) {
	return (evt.ctrlKey);
}

function isAltKey(evt) {
	return (evt.altKey);
}

function isBackspaceKey(evt) {
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	return (keynum == 8);
}

function isDeleteKey(evt) {
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	return (keynum == 46);
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
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	return (keynum == 13);
}

/**
 * 
 */ 
function isUpArrowKey(evt) {
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	return (keynum == 38);
}

/**
 * 
 */ 
function isDownArrowKey(evt) {
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	return (keynum == 40);
}

/**
 * 
 */ 
function isTabKey(evt) {
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	return (keynum == 9 && !evt.shiftKey);
}

/**
 * 
 */ 
function isEscapeKey(evt) {
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	return (keynum == 27);
}

/**
 * 
 */ 
function setServiceCode(billId, billingItemId, serviceCode) {
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	var inputElements = billingItem.getElementsByTagName("input");
	
	if (inputElements != null && inputElements.length > 0) {
		inputElements[0].value = serviceCode;
	}
}

/**
 * 
 */ 
function setServiceAmount(billId, billingItemId, serviceAmount) {
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	var inputElements = billingItem.getElementsByTagName("input");
	
	if (inputElements != null && inputElements.length > 0) {
		inputElements[1].value = serviceAmount;
	}
}

/**
 * 
 */ 
function setDiagnosticCode(billId, billingItemId, diagnosticCode) {
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	var inputElements = billingItem.getElementsByTagName("input");
	
	if (inputElements != null && inputElements.length > 0) {
		inputElements[4].value = diagnosticCode;
	}
}

/**
 * 
 */ 
function setDiagnosticDescription(billId, billingItemId, diagnosticDescripton) {
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	var inputElements = billingItem.getElementsByTagName("input");
	
	if (inputElements != null && inputElements.length > 0) {
		inputElements[5].value = diagnosticDescripton;
	}
}

function setReferralDoctorName(billId, fullName) {
	var refDocContainer = document.getElementById("referral_doc_container"+billId);
	var inputElements = refDocContainer.getElementsByTagName("input");
	
	if (inputElements != null && inputElements.length > 0) {
		inputElements[0].value = fullName;
	}
}

function setReferralDoctorId(billId, refDocId) {
	var element = document.getElementById("referral_doc_no"+billId);
	
	if (element != null && element != undefined) {
		element.value = refDocId;
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
	return isEnterKey(evt) && !isShiftKey(evt);
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
	//setFocusOnInputField(moveToId);
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
						setFocusOnInputField_By_RelativeBillingItemIndex(billId, i+1);
						return;
					}
				}
			}
		}
		
		// if no billing item input elements have focus, set focus on first input element of first billing item
		if (rowElements.length > 0) {
			var inputElements = rowElements[0].getElementsByTagName("input");
			if (inputElements.length > 0) {
				setFocusOnInputField_By_RelativeBillingItemIndex(billId, 0);
				return;
			}
		}
		
	} else {
		setFocusOnInputField_By_RelativeBillingItemIndex(billId, billingItemIndex+1);
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
						setFocusOnInputField_By_RelativeBillingItemIndex(billId, i-1);
						return;
					}
				}
			}
		}
	} else {
		setFocusOnInputField_By_RelativeBillingItemIndex(billId, billingItemIndex-1);
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


function setBillUneditable(billId) {
	
}

function setBillEditable(billId) {
	
}

function validateBill(billId) {
	var result = true;
		
	$('#bill_details' + billId + ' > *').find('input').each(function () {
	    //alert($(this).text()); // "this" is the current element in the loop
	    //alert("#"+$(this).attr('id'));
	    
	    if ($(this).attr('id') !== undefined) {
		    if (!$("#submitbillingform").validate().element( "#"+$(this).attr('id') )) {
				result = false;
				return false;
			}
		}
	});
	
	
	return result;
}

function validateAdmissionTime(billId) {
	$('#submitbillingform').validate().element( '#admission_date'+billId);
}

/**
 * 
 */ 
function saveBill(billId) {
	if (!validateBill(billId)) {
		return false;
	}	
	
	var elem = document.getElementById("bill_details"+billId);
	removeClass('incompleted', elem);
	addClass('completed', elem);
	
	// convert input elements to span elements (i.e. uneditable text)
	var rows = elem.getElementsByTagName("tr");
	for (var i=0; i < rows.length; i++) {
		var cells = rows[i].getElementsByTagName("td");
		for (var j=0; j < cells.length; j++) {
			var replacementElement = document.createElement("span");
			replacementElement.className = "saved_element";
			
			if (cells[j] == undefined)
				continue;
			
			var inputElement = cells[j].getElementsByTagName("input")[0];
			if (inputElement == null)
				continue;
				
			replacementElement.innerHTML = inputElement.value;
			inputElement.style.visibility = "hidden";
			inputElement.style.display = "none";
			//cells[j].removeChild(inputElement);
			cells[j].appendChild(replacementElement);
		}
	}
	
	elem = document.getElementById("bill"+billId);
	removeClass('no-bills', elem);
	addClass('completed', elem);
	
	var inputElement = document.createElement("input");
	inputElement.type = "hidden";
	inputElement.name = "bill_saved"+billId;
	inputElement.className = "bill_saved";
	elem.appendChild(inputElement);
	
	// hide all input and input related elements
	var rows = elem.getElementsByClassName("billing_button");
	for (var i=0; i < rows.length; i++) {
		addClass('hide_element', rows[i]);
	}
	var rows = elem.getElementsByClassName("dropdown");
	for (var i=0; i < rows.length; i++) {
		addClass('hide_element', rows[i]);
	}
	var rows = elem.getElementsByClassName("checkbox");
	for (var i=0; i < rows.length; i++) {
		addClass('hide_element', rows[i]);
	}
	var rows = elem.getElementsByClassName("input_element_label");
	for (var i=0; i < rows.length; i++) {
		addClass('hide_element', rows[i]);
	}	
	
	// hide the 'more details' table
	hideMoreDetails(billId, demographicNumbers[billId], appointmentNumbers[billId]);
	
	//elem = document.getElementById("bill"+billId);
	
	// setup unsave function (if user clicks on the bill, they can re-open it for editing)
	document.getElementById("bill"+billId).onclick = function() { unsaveBill(billId); showBillDetails(billId); }
	
	return true;
}

/**
 * 
 */ 
function unsaveBill(billId) {
	var elem = document.getElementById("bill_details"+billId);
	removeClass('completed', elem);
	//addClass('incompleted', elem);
	
	// delete elements of class 'saved_element' and show input elements
	var rows = elem.getElementsByTagName("tr");
	for (var i=0; i < rows.length; i++) {
		var cells = rows[i].getElementsByTagName("td");
		for (var j=0; j < cells.length; j++) {
			if (cells[j] == undefined)
				continue;
			
			var replacementElement = cells[j].getElementsByClassName("saved_element")[0];
			if (replacementElement == null)
				continue;
				
			var inputElement = cells[j].getElementsByTagName("input")[0];
			if (inputElement == null)
				continue;

			inputElement.style.visibility = "visible";
			inputElement.style.display = "";
			//cells[j].removeChild(inputElement);
			//cells[j].appendChild(replacementElement);
			cells[j].removeChild(replacementElement);
		}
	}
	
	elem = document.getElementById("bill"+billId);
	removeClass('no-bills', elem);
	removeClass('completed', elem);
	
	var inputElement = elem.getElementsByClassName("bill_saved")[0];
	if (inputElement != undefined)
		elem.removeChild(inputElement);
	
	// hide all input and input related elements
	var rows = elem.getElementsByClassName("billing_button");
	for (var i=0; i < rows.length; i++) {
		removeClass('hide_element', rows[i]);
	}
	var rows = elem.getElementsByClassName("dropdown");
	for (var i=0; i < rows.length; i++) {
		removeClass('hide_element', rows[i]);
	}
	var rows = elem.getElementsByClassName("checkbox");
	for (var i=0; i < rows.length; i++) {
		removeClass('hide_element', rows[i]);
	}
	var rows = elem.getElementsByClassName("input_element_label");
	for (var i=0; i < rows.length; i++) {
		removeClass('hide_element', rows[i]);
	}
	
	// hide the 'more details' table
	//hideMoreDetails(billId, demographicNumbers[billId], appointmentNumbers[billId]);
}

/**
 * 
 */ 
function isSaved(billId) {
	var elem = document.getElementById("bill"+billId);
	
	return hasClass("completed", elem);
}

/**
 * 
 */ 
function addBillingItem(id) {
	//Create an input type dynamically.
	//var element = document.createElement("tr");	
	var billingItemId = getId();
	//element.setAttribute("id", "billing_item"+id+"_"+billingItemId);
	
	var onkeydown = "onkeydown=\"";
	onkeydown+= "if (isTabKey(event)) {";
	onkeydown+= "	hideAllLookups("+id+"); ";
	onkeydown+= "	return true; ";
	onkeydown+= "}";
	onkeydown+= "var lookupIsOpen = isLookupOpen("+id+");";
	onkeydown+= "if (!lookupIsOpen) {";
	onkeydown+= "	if (isSaveBill(event)) {";
	onkeydown+= "		if (saveBill("+id+")) { ";
	onkeydown+= "			moveToNextBill("+id+"); ";
	onkeydown+= "		}";
	onkeydown+= "	}";
	onkeydown+= "	if (isMoveBetweenBills(event)) {";
	onkeydown+= "		moveBetweenBills(event, "+id+"); ";
	onkeydown+= "	}";
	onkeydown+= "} else {";
	onkeydown+= "	if (isMoveBetweenLookupItems(event)) {";
	onkeydown+= "		moveBetweenLookupItems(event, "+id+");";
	onkeydown+= "	}";
	onkeydown+= "	if (isSelectLookupItem(event)) {";
	onkeydown+= "		selectLookupItem("+id+");";
	onkeydown+= "	}";
	onkeydown+= "	if (isEscapeKey(event)) {";
	onkeydown+= "		hideAllLookups("+id+");";
	onkeydown+= "	}";
	onkeydown+= "}";
	onkeydown+= "if (isMoveBetweenBillingItems(event)) {";
	onkeydown+= "	moveBetweenBillingItems(event, "+id+");";
	onkeydown+= "}";
	onkeydown+= "if (isShowMoreDetails(event)) {";
	onkeydown+= "	toggleMoreDetails("+id+", "+demographicNumbers[id]+", "+appointmentNumbers[id]+");";
	onkeydown+= "}";
	onkeydown+= "\"";
	
	var totalOnkeydown = "onkeydown=\"";
	totalOnkeydown+= "if (isTabKey(event)) {";
	totalOnkeydown+= "	hideAllServiceCodeLookups("+id+"); ";
	totalOnkeydown+= "	if (checkIfLastBillingItem("+id+", "+billingItemId+")) {";
	totalOnkeydown+= "		addBillingItem("+id+"); ";
	totalOnkeydown+= "	} ";
	totalOnkeydown+= "} ";
	totalOnkeydown+= "if (isSaveBill(event)) {";
	totalOnkeydown+= "	if (saveBill("+id+")) { ";
	totalOnkeydown+= "		moveToNextBill("+id+"); ";
	totalOnkeydown+= "	}";
	totalOnkeydown+= "}";
	totalOnkeydown+= "if (isMoveBetweenBills(event)) {";
	totalOnkeydown+= "	moveBetweenBills(event, "+id+"); ";
	totalOnkeydown+= "} ";
	totalOnkeydown+= "if (isMoveBetweenBillingItems(event)) {";
	totalOnkeydown+= "	moveBetweenBillingItems(event, "+id+");";
	totalOnkeydown+= "}";
	totalOnkeydown+= "return true;\"";
	
	var totalOnKeyup = "onkeyup=\"";
	totalOnKeyup+= "updateBillTotal("+id+");";
	totalOnKeyup+= "return true;\"";
	
	var onkeyup = "onkeyup=\"";
	onkeyup+= "if (this.value.length == 0) {";
	onkeyup+= "	hideServiceCodeLookup("+id+", "+billingItemId+");";
	onkeyup+= "	hideDiagnosticCodeLookup("+id+", "+billingItemId+");";
	onkeyup+= "	if (this.id.indexOf('amount') == 0 || this.id.indexOf('units') == 0) {";
	onkeyup+= "		updateBillingItemTotal("+id+", "+billingItemId+");";
	onkeyup+= "		updateBillTotal("+id+");";
	onkeyup+= "	}";
	onkeyup+= "} else { ";
	onkeyup+= "	if (isAlphaNumericKey(event) || isBackspaceKey(event) || isDeleteKey(event)) {";
					// show diagnostic/service codes lookup list
	onkeyup+= "		if (this.id.indexOf('bill_code') == 0) {";
	onkeyup+= "			showAvailableServiceCodes("+id+", "+billingItemId+", this.value);";
	onkeyup+= "		} else if (this.id.indexOf('dx_code') == 0) {";
	onkeyup+= "			showAvailableDiagnosticCodes("+id+", "+billingItemId+", this.value);";
	onkeyup+= "		} else if (this.id.indexOf('dx_desc') == 0) {";
	onkeyup+= "			showAvailableDiagnosticCodes("+id+", "+billingItemId+", '', this.value);";
	onkeyup+= "		}";
					// update total if units/amount values change
	onkeyup+= "		else if (this.id.indexOf('amount') == 0 || this.id.indexOf('units') == 0 || this.id.indexOf('percent') == 0) {";
	onkeyup+= "			if (isNumericKey(event) || isBackspaceKey(event) || isDeleteKey(event)) {";
	onkeyup+= "				updateBillingItemTotal("+id+", "+billingItemId+");";
	onkeyup+= "				updateBillTotal("+id+");";
	onkeyup+= "			}";
	onkeyup+= "		}";
	onkeyup+= "	}";
	onkeyup+= "}";
	onkeyup+= "return true; \"";

	var firstDxCode = getInputFieldValue(id, 0, 4);
	var firstDxDescription = getInputFieldValue(id, 0, 5);
	
	firstDxCode = firstDxCode || "";
	firstDxDescription = firstDxDescription || "";
	
	var htmlString = "<tr id='billing_item"+id+"_"+billingItemId+"'>";
	htmlString += "<td> <a class=\"billing_button\" href=\"\"  tabindex=\"-1\" onclick=\"deleteBillingItem("+id+", "+billingItemId+"); updateBillTotal("+id+"); return false;\">X</a></td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"bill_code"+id+"\" id=\"bill_code"+id+"_"+billingItemId+"\" autocomplete=\"off\" "+onkeydown+" "+onkeyup+" /> <div id=\"service_code_lookup"+id+"_"+billingItemId+"\" class=\"lookup_box\" style=\"display:none;\"></div> </td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"amount"+id+"\" id=\"amount"+id+"_"+billingItemId+"\" class='currency' "+onkeydown+" "+onkeyup+" /> </td>";
	htmlString += "<td> <input type=\"text\" size=\"3\" name=\"units"+id+"\" id=\"units"+id+"_"+billingItemId+"\" value=\"1\" "+onkeydown+" "+onkeyup+" /> </td>";
	htmlString += "<td> <input type=\"text\" size=\"3\" name=\"percent"+id+"\" id=\"percent"+id+"_"+billingItemId+"\" value=\"1.0\" "+onkeydown+" "+onkeyup+" /> </td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"dx_code"+id+"\" id=\"dx_code"+id+"_"+billingItemId+"\" value=\""+firstDxCode+"\" autocomplete=\"off\" "+onkeydown+" "+onkeyup+" /> <div id=\"diagnostic_code_lookup"+id+"_"+billingItemId+"\" class=\"lookup_box\" style=\"display:none;\"></div> </td>";
	htmlString += "<td> <input type=\"text\" size=\"12\" name=\"dx_desc"+id+"\" id=\"dx_desc"+id+"_"+billingItemId+"\" value=\""+firstDxDescription+"\" autocomplete=\"off\" "+onkeydown+" "+onkeyup+" /> <div id=\"diagnostic_desc_lookup"+id+"_"+billingItemId+"\" class=\"lookup_box\" style=\"display:none;\"></div> </td>";
	htmlString += "<td> <input type=\"text\" size=\"6\" name=\"total"+id+"\" id=\"total"+id+"_"+billingItemId+"\" class='currency' "+totalOnkeydown+" "+totalOnKeyup+" /> </td>";
	htmlString += "</tr>";
	//htmlString += "<td> <input type=\"text\" size=\"6\" name=\"sli_code"+id+"\" id=\"sli_code"+id+"_"+billingItemId+"\" disabled=\"disabled\" /> </td>";
	//element.innerHTML = htmlString;
	
	//alert(element);
	//$('#billing_items'+id+'').append(element);
	
	$(htmlString).appendTo('#billing_items'+id+'');
	$("#billing_item"+id+"_"+billingItemId).focus();
	
	//var billingItems = document.getElementById("billing_items"+id);
	
	//Append the element in page (in span).
	//billingItems.appendChild(element);
	
	//element.focus();
}

/**
 * 
 */ 
function deleteBillingItem(id, billingItemId) {	
	var billingItem = document.getElementById("billing_item"+id+"_"+billingItemId);
	billingItem.parentNode.removeChild(billingItem);
}

function isDeleteBillingItemKey(evt) {
	return isDeleteKey(evt) && evt.altKey;
}

/**
 * 
 */ 
function isSubmitFlagSet() {
	return submitFlag;
}

function submitBills() {
	$('#submit_billing').trigger('click');
	//document.getElementById('submit_billing').click();
	//document.forms['submitbillingform'].submit();
}

var submitFlag = false;
var setSubmit = (function () {
	return function() {
		submitFlag = true;
	};
}());

function isSubmitBillsKey(evt) {
	return isEnterKey(evt) && isShiftKey(evt);
}


var selectAllFlag = false;
var toggleSelectAllBills = (function () {
	return function() {
		var inputElements = document.getElementsByName("select_bill");
		
		if (inputElements == null)
			return;
		
		if (selectAllFlag) {
			selectAllFlag = false;
		} else {
			selectAllFlag = true;
		}
		
		for (var i=0; i < inputElements.length; i++) {
			inputElements[i].checked = selectAllFlag;
		}
	};
}());

function setFocusOnReferralDoctorInput(billId) {
	var refDocInput = document.getElementById("referral_full_name"+billId);
	refDocInput.focus();
}

function setFocusOnAdmissionDateField(billId) {
	var admissionDateItem = document.getElementById("admission_date"+billId);
	
	if (admissionDateItem != null && admissionDateItem != undefined) {
		admissionDateItem.focus();
	}
}

/**
 * 
 */ 
function setFocusOnInputField(billId, billingItemId, inputIndex) {
	billingItemId = billingItemId || -1;
	inputIndex = inputIndex || 0;
	
	// if billingItemId is less than 0, set focus to inputNumber input field of first billing item
	if (billingItemId < 0) {
		var firstBillingItem = document.getElementById("billing_items"+billId).getElementsByTagName("tr")[0];
		var inputField = firstBillingItem.getElementsByTagName("input")[inputIndex];
		if (inputField != undefined)
			inputField.focus();
		return;
	}
	
	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);
	
	if (billingItem != null && billingItem != undefined) {
		billingItem.getElementsByTagName("input")[inputIndex].focus();
	}
}

/**
 * 
 */ 
function setFocusOnInputField_By_RelativeBillingItemIndex(billId, billingItemIndex, inputIndex) {
	billingItemIndex = billingItemIndex || 0;
	inputIndex = inputIndex || 0;

	var billingItems = document.getElementById("billing_items"+billId);
	var rowElements = billingItems.getElementsByTagName("tr");
	
	if (rowElements[billingItemIndex] != null && rowElements[billingItemIndex] != undefined) {
		rowElements[billingItemIndex].getElementsByTagName("input")[inputIndex].focus();
	}
}

/**
 * 
 */ 
function setFocusOnFirstLookupItem(element) {
	if (element == null || element == undefined)
		return;
	
	var ulElement = element.getElementsByTagName("ul")[0];
	if (ulElement == null || ulElement == undefined)
		return;
		
	var firstLiElement = ulElement.getElementsByTagName("li")[0];
	if (firstLiElement == null || firstLiElement == undefined)
		return;
	
	addClass("highlighted", firstLiElement);
	
	//firstLiElement.focus();
}

/**
 * 
 */ 
function getInputFieldValue(billId, billingItemId, inputIndex) {
	billingItemId = billingItemId || -1;
	inputIndex = inputIndex || 0;
	
	// if billingItemId is less than 0, get value of inputIndex input field of first billing item
	if (billingItemId < 0) {
		var firstBillingItem = document.getElementById("billing_items"+billId).getElementsByTagName("tr")[0];

		if (firstBillingItem != null && firstBillingItem != undefined) {
			var inputField = firstBillingItem.getElementsByTagName("input")[inputIndex];

			if (inputField != undefined)
				return inputField.value;
		}
		return;
	}

	var billingItem = document.getElementById("billing_item"+billId+"_"+billingItemId);

	if (billingItem != null && billingItem != undefined) {
		return billingItem.getElementsByTagName("input")[inputIndex].value;
	}
	
	return;
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

function showAvailableReferralDoctors(billId, name) {
	getReferralDoctors(billId, name);
	var elem = document.getElementById("referral_doc_lookup"+billId);
	elem.style.display = "";
}

function hideReferralDoctorsLookup(billId) {
	document.getElementById("referral_doc_lookup"+billId).style.display = "none";
}

function hideAllReferralDoctorLookups(billId) {
	var bill = document.getElementById("bill_details"+billId);
	var divElements = bill.getElementsByTagName("div");
	
	if (divElements == null)
		return;
	
	for (var i=0; i < divElements.length; i++) {
		if (divElements[i].id.indexOf("referral_doc_lookup"+billId) == 0)
			divElements[i].style.display = "none";
	}
}

function showAvailableServiceCodes(billId, billingItemId, serviceCode) {
	getBillingCodes(billId, billingItemId, serviceCode);
	var elem = document.getElementById("service_code_lookup"+billId+"_"+billingItemId);
	elem.style.display = "";
}

function hideServiceCodeLookup(billId, billingItemId) {
	document.getElementById("service_code_lookup"+billId+"_"+billingItemId).style.display = "none";
}

function hideAllServiceCodeLookups(billId) {
	var bill = document.getElementById("bill_details"+billId);
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
	var bill = document.getElementById("bill_details"+billId);
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

function hideAllLookups(billId) {
	hideAllDiagnosticLookups(billId);
	hideAllServiceCodeLookups(billId);
	hideAllReferralDoctorLookups(billId);
	
	unsetAllLookupItemsAsHighlighted(billId);
}

function isLookupOpen(billId) {
	var bill = document.getElementById("bill_details"+billId);
	var divElements = bill.getElementsByTagName("div");
	
	if (divElements == null)
		return;
		
	for (var i=0; i < divElements.length; i++) {
		if (divElements[i].id.indexOf("diagnostic_code_lookup"+billId+"_") == 0)
			if (divElements[i].style.display.indexOf("none") == -1)
				return true;
		if (divElements[i].id.indexOf("diagnostic_desc_lookup"+billId+"_") == 0)
			if (divElements[i].style.display.indexOf("none") == -1)
				return true;
		if (divElements[i].id.indexOf("service_code_lookup"+billId+"_") == 0)
			if (divElements[i].style.display.indexOf("none") == -1)
				return true;
		if (divElements[i].id.indexOf("referral_doc_lookup"+billId) == 0)
			if (divElements[i].style.display.indexOf("none") == -1)
				return true;
	}
	
	return false;
}

function isMoveBetweenLookupItems(evt) {
	return (isUpArrowKey(evt) || isDownArrowKey(evt));
}

function isSelectLookupItem(evt) {
	return isEnterKey(evt);
}

/**
 * 
 */ 
function moveBetweenLookupItems(evt, billId) {	
	if (isUpArrowKey(evt)) {
		moveToPreviousLookupItem(billId);
	} else if(isDownArrowKey(evt)) {
		moveToNextLookupItem(billId);
	}
}

/**
 * 
 */
function moveToNextLookupItem(billId) {	
	var billingItems = document.getElementById("bill_details"+billId);
	var lookups = billingItems.getElementsByTagName("ul");
	
	if (lookups == null || lookups == undefined)
		return;
	
	for (var i=0; i < lookups.length; i++) {	
		var lookupItems = lookups[i].getElementsByTagName("li");
		
		if (lookupItems == null || lookupItems == undefined)
			return;
			
		for (var j=0; j < lookupItems.length; j++) {
			if (hasClass("highlighted", lookupItems[j]) && lookupItems[j+1]) {
				unsetLookupItemAsHighlighted(lookupItems[j]);
				setLookupItemAsHighlighted(lookupItems[j+1]);
				return true;
			}
		}
	}
}

function setLookupItemAsHighlighted(elem) {
	if (elem == null || elem == undefined)
		return;
	
	if (!hasClass("highlighted", elem)) {
		addClass("highlighted", elem);
	}
	
	elem.scrollIntoView(false);
}

function unsetLookupItemAsHighlighted(elem) {
	if (elem == null || elem == undefined)
		return;
	
	if (hasClass("highlighted", elem)) {
		removeClass("highlighted", elem);
	}
}

function unsetAllLookupItemsAsHighlighted(billId) {
	var billingItems = document.getElementById("bill_details"+billId);
	var lookups = billingItems.getElementsByTagName("ul");
	
	if (lookups == null || lookups == undefined)
		return;
	
	for (var i=0; i < lookups.length; i++) {	
		var lookupItems = lookups[i].getElementsByTagName("li");
		
		if (lookupItems == null || lookupItems == undefined)
			return;
			
		for (var j=0; j < lookupItems.length; j++) {
			if (hasClass("highlighted", lookupItems[j])) {
				unsetLookupItemAsHighlighted(lookupItems[j]);
			}
		}
	}
}

function selectLookupItem(billId) {	
	var billingItems = document.getElementById("bill_details"+billId);
	var lookups = billingItems.getElementsByTagName("ul");
	
	if (lookups == null || lookups == undefined)
		return;
		
	for (var i=0; i < lookups.length; i++) {	
		var lookupItems = lookups[i].getElementsByTagName("li");
		
		if (lookupItems == null || lookupItems == undefined)
			return;
			
		for (var j=0; j < lookupItems.length; j++) {
			if (hasClass("highlighted", lookupItems[j])) {
				unsetLookupItemAsHighlighted(lookupItems[j]);
				$(lookupItems[j]).click();
				return true;
			}
		}
	}
}

/**
 * 
 */
function moveToPreviousLookupItem(billId) {	
	var billingItems = document.getElementById("bill_details"+billId);
	var lookups = billingItems.getElementsByTagName("ul");
	
	if (lookups == null || lookups == undefined)
		return;
		
	for (var i=0; i < lookups.length; i++) {	
		var lookupItems = lookups[i].getElementsByTagName("li");
		
		if (lookupItems == null || lookupItems == undefined)
			return;
			
		for (var j=0; j < lookupItems.length; j++) {
			if (hasClass("highlighted", lookupItems[j]) && lookupItems[j-1]) {
				removeClass("highlighted", lookupItems[j]);
				setLookupItemAsHighlighted(lookupItems[j-1]);
				return true;
			}
		}
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
	//document.getElementById("more_details"+billId).style.display = "";
	removeClass("hide", document.getElementById("more_details"+billId));
	document.getElementById("more_details_button"+billId).onclick = function() { hideMoreDetails(billId, demographicNo, appointmentNo); return false; }
	document.getElementById("more_details_button"+billId).innerHTML = "less";
}

/**
 * 
 */ 
function hideMoreDetails(billId, demographicNo, appointmentNo) {
	// hide the details
	//document.getElementById("more_details"+billId).style.display = "none";
	addClass("hide", document.getElementById("more_details"+billId));
	document.getElementById("more_details_button"+billId).onclick = function() { showMoreDetails(billId, demographicNo, appointmentNo); return false; }	
	document.getElementById("more_details_button"+billId).innerHTML = "more";
}

/**
 * 
 */ 
function toggleMoreDetails(billId, demographicNo, appointmentNo) {
	var elem = document.getElementById("more_details"+billId);
	
	if (hasClass("hide", elem)) {
		showMoreDetails(billId, demographicNo, appointmentNo);
	} else {
		hideMoreDetails(billId, demographicNo, appointmentNo);
	}
}

/**
 * 
 */ 
function isShowMoreDetails(evt) {
	keynum = (evt.which) ? evt.which : evt.keyCode;	
	return (keynum == 113);
}

function showBillNotes(billId) {
	removeClass("hide_element", document.getElementById("bill_notes_container"+billId));
}

function hideBillNotes(billId) {
	addClass("hide_element", document.getElementById("bill_notes_container"+billId));
}

function toggleBillNotesVisible(billId) {
	var elem = document.getElementById("bill_notes_container"+billId);
	
	if (hasClass("hide_element", elem)) {
		showBillNotes(billId);
	} else {
		hideBillNotes(billId);
	}
}

function showReferralDoctor(billId) {
	removeClass("hide_element", document.getElementById("referral_doc_container"+billId));
}

function hideReferralDoctor(billId) {
	addClass("hide_element", document.getElementById("referral_doc_container"+billId));
}

function toggleReferralDoctorVisible(billId) {
	var elem = document.getElementById("referral_doc_container"+billId);
	
	if (hasClass("hide_element", elem)) {
		showReferralDoctor(billId);
	} else {
		hideReferralDoctor(billId);
	}
}

/**
 * 
 */
function updateBillTotal(billId) {
	var bill = document.getElementById("billing_items"+billId);
	var trElements = bill.getElementsByTagName("tr");
	
	if (trElements == null)
		return;
	
	var total = parseFloat(0.0);
	
	for (var i=0; i < trElements.length; i++) {
		var tdElements = trElements[i].getElementsByTagName("input");
		for (var j=0; j < tdElements.length; j++) {
			if (tdElements[j].id.indexOf("total"+billId+"_") == 0) {
				if (isCurrency( tdElements[j].value ))
					total += formatCurrencyAsFloat( tdElements[j].value );
			}
		}
	}
	
	document.getElementById("bill_total"+billId).innerHTML = total.toMoney(2, '.', ',');
}

/**
 * 
 */
function updateBillingItemTotal(billId, billingItemId) {
	var amountElement = document.getElementById("amount"+billId+"_"+billingItemId);
	var unitsElements = document.getElementById("units"+billId+"_"+billingItemId);
	var percentElements = document.getElementById("percent"+billId+"_"+billingItemId);
	var totalElement = document.getElementById("total"+billId+"_"+billingItemId);
	
	if (amountElement == null || unitsElements == null || percentElements == null || totalElement == null)
		return;
	
	var units = formatCurrencyAsFloat(unitsElements.value);
	if (!isNumber(units))
		units = 0;
		
	var amount = formatCurrencyAsFloat(amountElement.value);
	if (!isNumber(amount))
		amount = 0;
	
	var percent = formatCurrencyAsFloat(percentElements.value);
	if (!isNumber(percent))
		percent = 0;
		
	var total = formatCurrencyAsFloat(amount) * units * percent;
	
	totalElement.value = total.formatCurrency(2, '.', ',');
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


function getReferralDoctorsHandler(billId) {
	return function parseResponse() {
		if(this.readyState == 4 && this.status == 200) {
			var json = this.responseText;
			var json = eval('(' + this.responseText +')');	
			
			var referralDocsString = "";
			if (json.length != 0) {	
				var referralDocsString = "<ul>";
				var onclick = "onclick=\"";
				onclick += "setReferralDoctorName("+billId+", extractReferralDoctorName(this));";
				onclick += "setReferralDoctorId("+billId+", extractReferralDoctorId(this));";
				onclick += "hideReferralDoctorsLookup("+billId+");";
				//onclick += "setFocusOnInputField("+billId+", "+billingItemId+", 2);";
				onclick += "\"";
				for (var i = 0; i < json.length; i++) { 			    
				    referralDocsString+= "<li "+onclick+">";
				    referralDocsString+= "<b><span>" + json[i]['last_name'] + ", " + json[i]['first_name'] + "</span></b>";
				    referralDocsString+= "<span style=\"display:none;\">" + json[i]['referral_no'] + "</span>";
				    referralDocsString+= "</li>";
				}
				referralDocsString += "</ul>";
			}
			
			var element = document.getElementById("referral_doc_lookup"+billId);
			element.innerHTML = referralDocsString;
			
			setFocusOnFirstLookupItem(element);
			
			//alert('Success. Result: ' + referralDocsString);
		} else if (this.readyState == 4 && this.status != 200) {
			//alert('Something went wrong...');
			var element = document.getElementById("referral_doc_lookup"+billId);
			element.innerHTML = "An error occured.";
		}
	};
}

/**
 * 
 */ 
function extractReferralDoctorName(item){
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
function extractReferralDoctorId(item){
	if (item == null)
		return "";
		
	var spanElements = item.getElementsByTagName("span");
	
	if (spanElements != null && spanElements.length > 0) {
		return spanElements[1].innerHTML;
	}
	
	return "";
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
				    //json[i]);
				    
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
				onclick += "setServiceAmount("+billId+", "+billingItemId+", extractServiceAmount(this));";
				onclick += "updateBillingItemTotal("+billId+", "+billingItemId+");";
				onclick += "updateBillTotal("+billId+");";
				onclick += "hideServiceCodeLookup("+billId+", "+billingItemId+");";
				onclick += "setFocusOnInputField("+billId+", "+billingItemId+", 2);";
				onclick += "\"";
				for (var i = 0; i < json.length; i++) { 			    
				    serviceCodesString+= "<li "+onclick+">";
				    serviceCodesString+= "<b><span>" + json[i]['service_code'] + "</span></b>";
				    serviceCodesString+= " ";
				    serviceCodesString+= json[i]['description'];
				    serviceCodesString+= "<span style=\"display:none;\">" + json[i]['value'] + "</span>";
				    serviceCodesString+= "</li>";
				}
				serviceCodesString += "</ul>";
			}
			
			var element = document.getElementById("service_code_lookup"+billId+"_"+billingItemId);
			element.innerHTML = serviceCodesString;
			
			setFocusOnFirstLookupItem(element);
			
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
function extractServiceAmount(item){
	if (item == null)
		return "";
		
	var spanElements = item.getElementsByTagName("span");
	
	if (spanElements != null && spanElements.length > 0) {
		return spanElements[1].innerHTML;
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
				onclick += "setFocusOnInputField("+billId+", "+billingItemId+", 6);";
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
			
			var element = null;
			if (diagnosticCode) {
				 element = document.getElementById("diagnostic_code_lookup"+billId+"_"+billingItemId);
			} else {
				element = document.getElementById("diagnostic_desc_lookup"+billId+"_"+billingItemId);
			}
			
			element.innerHTML = serviceCodesString;
			
			setFocusOnFirstLookupItem(element);
			
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


function getReferralDoctors(billId, referralDocName) {
	var AJAX = createXMLHttpRequest();
	AJAX.onreadystatechange = getReferralDoctorsHandler(billId);
	AJAX.open("GET", "reports/getReferralDoctors.jsp?full_name="+referralDocName);
	AJAX.send("");
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
