/*	initializing clinic-specific functionality.
 *  these functions should all refer to items generated from forms.jsp
 *  */

initialize_billing();
insert_invoice(new invoice);
set_selected(0);

$("#b_provider").on('blur', function(){
	var sel = $("#b_provider_val").val();
	if(sel){
		$('#group_no').val(providers[sel].group);
		$(' #billing-center').val(providers[sel].b_ctr);
	}else {		//val == "" does not trigger change.
		$('#group_no').val("0000");
		clear_combobox( $('#provider'));
		$(' #billing-center').val("Hamilton");
	}
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
	batch["billDate"] = today.getFullYear() + "/" + (today.getMonth()+1) + "/" + today.getDate();
	batch["billTime"] = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
	batch["location"] = $("#location_val").val();
	
	batch_save("offsite", batch); //hoping contentID is universal
	return false;			
});

$('#demo-name-search').typeahead({
	source: function(query, process){
		return $.get('getDemographic.jsp', 
			{source: "name", query: query}, 
			function(data){
				temp = JSON.parse(data);
				$.each(temp, function( i, x){	demoList[x.id]=x;	} );
				return process($.map(demoList, function(x){ return x.name; }));
			});
		},
	items:5,
	updater: function(demo){
		var d = "";
		for(key in demoList){ if(demoList[key].name == demo){ d =key; break; }}
		selected.inv.demo = new demographic(demoList[d]);
		selected.inv.rdoctor = demoList[d].rdoctor;
		selected.inv.rdocNum = demoList[d].rdocNum;
		save_invoice_info();
		load_invoice_info();
		return demo;
	}
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
	if(prev > $('#invList_body tbody tr').length-1){ 
		insert_invoice(new invoice());
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

