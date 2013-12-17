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

/////////////////////////
	
/*
$('#admission_date input').on('blur', function(){
	var tar = $(contentID + " #items-space :eq(0)").find("#from-date input");
	tar.val($('#admission_date input').val());
}); */

/* 
$('#demo-name-search').typeahead({
	source: function(query, process){
		return $.get('getDemographic.jsp', 
			{source: "code", query: query}, 
			function(data){
				temp = JSON.parse(data);
				$.each(temp, function( i, x){
					patList[x.name]=x;
				} );
				return process(Object.keys(patList));
			});
		},
	items:5,
	updater: function(item){
		$('#demo-hin-search').val(patList[item].health_card);
		$('#demo-dob-search').val(patList[item].dob);

		invoices[contentID.slice(1)][selected_id].demo = new demographic(patList[item]);
		var row = $(contentID + ' #invList').find('#row' + selected_id);
		row.children('.patient-name').html(item);
		row.children('.health-card-number').html(patList[item].health_card);
		row.children('.date-of-birth').html(patList[item].dob);

		return item;
	}
}); */
