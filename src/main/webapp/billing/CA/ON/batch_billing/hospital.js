/*	Initializing hospital-specific functionality.
 *  These functions should all refer to items generated from forms.jsp.
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

// Hospital bills need to be rearranged to sort by patient and date
$('#save-batch').click( function(){
	var today = new Date();
	var generalised_invs = [];	
	var errorMessage = "";
	
	save_invoice_info();
	
	for( var i = 0; i < invoices.length; i++) { 
		var this_inv = invoices[i];
		
		// Admission Date is required unless SLI Code is HED (Hospital Emergency Department), HOP (Hospital Out-Patient) or HRP (Hospital Referred Patient).
		if (this_inv.admission_date == "" && !(this_inv.sli_code == " HED | Hospital Emergency Department " || this_inv.sli_code == " HOP | Hospital Out-Patient " || this_inv.sli_code == " HRP | Hospital Referred Patient "))
		{
			errorMessage += "Please select an admission date for " + this_inv.name + "." + "\n";
		}
	}
		
	// Display a list of validation errors, if any.
	if (errorMessage != "")
	{
		alert(errorMessage);
		return false;
	}
			
	for( var i = 0; i < invoices.length; i++) { 
		var this_inv = invoices[i];
		var this_inv_trans = [];
		
		for(var k=0; k < this_inv.items.length; k++){
			var this_item = this_inv.items[k];
			
			for( var j = 0; j < this_item.days; j++){
				var insert_i = -1;
				var chk_date = new Date(this_item.from);
					chk_date.setDate(chk_date.getDate()+j);
					chk_date = chk_date.getFullYear() +"-"+ (chk_date.getMonth()+1) +"-"+ (chk_date.getDate()+1);
					
				if(this_inv_trans.length > 0){
					insert_i = $.map(this_inv_trans, function(x) {  return x.date; }).indexOf(chk_date);
				}
				if(insert_i > -1){
					this_inv_trans[insert_i].items.push($.extend(new item(), this_item));
				} else {
					var trans_inv = new invoice();
					$.extend(true, trans_inv, this_inv);
					trans_inv.items.length = 0;
					trans_inv.items.push($.extend(new item(), this_item));
					trans_inv.date = chk_date;
					this_inv_trans.push(trans_inv);
				}
			}
		}
		
		generalised_invs = generalised_invs.concat(this_inv_trans);
	}
	
	var batch = {};
	batch["b_provider"] = $("#b_provider_val").val();
	batch["provider"] = $("#provider_val").val();
	batch["billDate"] = today.getFullYear() + "/" + (today.getMonth()+1) + "/" + today.getDate();
	batch["billTime"] = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
	batch["location"] = $("#location_val").val();
	
	batch_save("hospital", batch, generalised_invs);
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
		if(selected.inv.rdoctor != ""){	fill_combobox($('#rdoctor'), selected.inv.rdoctor); }
		if(selected.inv.sli == ""){	fill_combobox($('#location'), "First"); }
		update_table_row(selected.inv, selected.row);
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
		next = $('#invList_body tbody tr').length;
		insert_invoice(new invoice());
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

// Set From Date in the first billing item to Admission Date.
$('#admission_date input').on('blur', function() {
	var $fromDate = $('#items-space #item0 #from');
	$fromDate.val($('#admission_date input').val());
});
