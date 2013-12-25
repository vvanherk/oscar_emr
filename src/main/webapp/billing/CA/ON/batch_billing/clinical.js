/**
 * Copyright (c) 2013-2014 Prylynx Corporation
 *
 * This software is made available under the terms of the
 * GNU General Public License, Version 2, 1991 (GPLv2).
 * License details are available via "gnu.org/licenses/gpl-2.0.html".
 */

/*	initializing clinic-specific functionality.
 *  these functions should all refer to items generated from forms.jsp
 *  */

initialize_billing();

$("#b_provider").on('blur', function(){
	var sel = $("#b_provider_val").val();
	if(sel){
		$('#group_no').val(providers[sel].group);
		fill_combobox( $('#provider'), $("#b_provider").val());
		$(' #billing-center').val(providers[sel].b_ctr);
		$('#provider').focus();
	}else {		//val == "" does not trigger change.
		$('#group_no').val("0000");
		clear_combobox( $('#provider'));
		$(' #billing-center').val("Hamilton");
		$('#b_provider').focus();
	}
});

$("#create-list").on('click', function(){	//Creates list based off appointments
	
	$('#invList_body tbody').children().remove();	//ensures the table does not concatenate
	invoices = [];	//removes any current invoices
	$("#items-space").children(".item").remove();
	create_item_row();
	
	if(invoices.length === 0){	//if the form is not visible, show.
		$('#invoice-detail').removeClass('invisible');
	}
	
	$.ajax({	//sends batch header to receive batch data.
		type: "POST",
		dataType: "html",
		url: "getAppointments.jsp",
		data: {	
			providerno: $('#provider_val').val(),
			from_date: $('#from-dt').val(),
			to_date: $('#to-dt').val()
		}
	}).done(function(msg){
		response=JSON.parse(msg);
		var text="";
		$.each(response, function(index, inv){
			var newInvoice = new invoice();	//converts data into js objects
			inv.demo = new demographic(inv.demo);
			$.extend(newInvoice, inv)
			insert_invoice(newInvoice);	//runs the invoice through insert function
		});
		set_selected(response.length-1);	//select first item
		$('#invStatus').focus();	//choose what item to focus on next.
	});
	
	$('#item0 #b_code').focus();

});

//autofill the comboboxes
fill_combobox($('#location'), 'First');
//ensure that the cursor begins on #b_provider
$("#b_provider").focus()

// Still testing.
$('#save-batch').click( function(){
	var today = new Date();
	
	var batch = {};
	batch["b_provider"] = $("#b_provider_val").val();
	batch["provider"] = $("#provider_val").val();
	batch["billDate"] = today.getFullYear() + "/" + (today.getMonth() + 1)+ "/" + today.getDate();
	batch["billTime"] = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
	batch["location"] = $("#location_val").val();
	
	batch_save("clinical", batch); //hoping contentID is universal
	return false;			
});

// click function on manual checkbox
$('#manualCHK').change(function(){
	if($(this).prop('checked')){
		$('#manual_text').attr("readonly", false);
		$('#manual_text').focus();
	}
	else{
		$('#manual_text').attr('readonly', true);
		$('#manual_text').blur();
	}
});


// patient selection functionality
$('#next_patient').on('click', function(){ 
	var next = parseInt(selected.id) - 1;
	if(next < 0){ 
		next = $('#invList_body tbody tr').length -1; 
	}
	set_selected(next); 
});

$('#prev_patient').on('click', function(){
	var prev = parseInt(selected.id) + 1; 
	if(prev > $(' #invList_body tbody tr').length - 1){ 
		prev = 0;
		/*else{
			if(contentID  == "#offsite"){
				invoices['offsite'][next] = new invoice();
				create_invList_row('#offsite', [' ', ' ', ' ', ' ', ' ', '0.00']);
			}
			else{						
				invoices['hospital'][next] = new invoice();
				create_invList_row('#hospital', [' ', ' ', ' ', ' ', ' ', ' ', '0.00']);
			}
		}*/
	}
	set_selected(prev);
});

// Event listener for select-all invoices checkbox. 
$("#select-all").on("click", function() {
	
	var $selectAllCheckbox = $(this);
	var $invoiceCheckboxes = $("#invList_body td.bc_apply input[type=checkbox]");
	
	select_all_invoices($selectAllCheckbox, $invoiceCheckboxes);
});

// Event listener for Clear button.
$("#clear").on("click", function() {		
	delete_checked_invoices_items();
});



