/* billing functionality with minimal referral to DOM triggers.
 * */


/* global objects with patient/invoice info
 * */
var invoices = new Array();
var bscList = {};		//billing service codes
var demoList = {};
var selected = {'inv': null, 'row': null, 'id':-1};	//contains current selected information

/* Scans the invoice list table for an active row. If none are found, returns
 * -1. If more than one are found, writes to console. 
 * */
function set_selected(sel){
	
	//remove all selection indicators, save changes. 
	var $active_class = $('#invList_body tbody').children("[class='active']");
	var id = $active_class.attr('id');
	$active_class.css('font-weight', 'normal');
	$active_class.removeClass('active');
	if(selected.id > -1){ 	save_invoice_info(); }
	selected = {'inv': null, 'row': null, 'id':-1};
	
	if($active_class.length === 0 || $active_class.attr('id') !== "row"+sel){
		//if the was not selected, make new invoice selected
		$("#row"+sel).css('font-weight', 'bold');
		$("#row"+sel).addClass('active');
		selected = {'inv': invoices[sel], 'row': $("#row"+sel)[0], 'id':sel};
		load_invoice_info();
	}
	
	return selected;
}


/* given an invoice inv and DOM table_row, replace the inner html of 
 * table row with data from inv. (inv) is required because this can be used
 * to generate a new table row for an invoice that is not selected
 * */
function update_table_row(inv, table_row){
	if(inv == null){	//if inv not given, use selected invoice
		inv = selected.inv;
	}
	var newdata = '';
	
	var $header = $('#invList_header').find('th');
	$.each($header, function(i, p){ //builds a row using the header as a template
		newdata += '<td class="'+ $(p).attr('class') +'" style="width:'+ p.style.width +'">';
		switch($(p).attr('class')){ //preserves table/jsobject mapping.
			case "bc_apply":
				newdata += '<input type="checkbox">';
				break;
			case "patient-name":
				if(inv.demo !== ""){	newdata += inv.demo.name; 	}
				break;
			case "health-card-number":
				if(inv.demo !== ""){	newdata += inv.demo.health_card;	}
				break;
			case "date-of-birth":
				if(inv.demo !== ""){	newdata += inv.demo.dob;	}
				break;
			case "date":
				newdata += inv.date;
				break;
			case "time":
				newdata +=  inv.time ;
				break;
			case "man_note":
				newdata += inv.manual;
				break;
			case "notes":
				newdata += inv.notes;
				break;
			case "service-description":
				newdata += inv.description ;
				break;
			case "amount":
				if(inv.inv_amount !== "NaN"){
					newdata += inv.inv_amount;
				} else { newdata += "0.00"; }
				break;
		}
		newdata += '</td>';
	});
		
	table_row.innerHTML = newdata;
}
/* To be used to control interaction between the HTML invoice fields and
 * the invoice object. May be moved into the invoice object. 
 *  */
function invoice_detail_map($invFields, action){
	
	$.each($invFields.find('input'), function(i, fieldData){
		switch($(fieldData).attr('id')){ //preserves input/jsobject mapping
			case 'demo-name-search':
				action(fieldData, "demo.name");
				break;
			case 'demo-hin-search':
				action(fieldData, "demo.health_card");
				break;
			case 'demo-dob-search':
				action(fieldData, "demo.dob");
				break;
			case 'service_date':
				action(fieldData, "date");
				break;
			case 'invStatus':
				action(fieldData, "status");
				break;
			case 'rdoctor':
				action(fieldData, "rdoctor");
				break;
			case 'rdoctor_val':
				action(fieldData, "rdocNum");
				break;
			case 'sli_code':
				action(fieldData, "sli_code");;
				break;
			case 'billing-type':
				action(fieldData, "btype");;
				break;
			case 'manual_text':
				action(fieldData, "manual");
				break;
			case 'b_notes':
				action( fieldData, "notes");
				break;
			case 'b_code':
				if($(fieldData).closest(".item").length > 0){
					var id = $(fieldData).closest(".item").attr('id').split('item')[1];
					action(fieldData, "item."+ id +".code");
				}
				break;
			case 'dx':
				if($(fieldData).closest(".item").length > 0){
					var id = $(fieldData).closest(".item").attr('id').split('item')[1];
					action(fieldData, "item."+ id +".dx_code");
				}
				break;
			case 'units':
				if($(fieldData).closest(".item").length > 0){
					var id = $(fieldData).closest(".item").attr('id').split('item')[1];
					action(fieldData, "item."+ id +".units");
				}
				break;
			case 'amount':
				if($(fieldData).closest(".item").length > 0){
					var id = $(fieldData).closest(".item").attr('id').split('item')[1];
					action(fieldData, "item."+ id +".amount");
				}
				break;
			case 'percent':
				if($(fieldData).closest(".item").length > 0){
					var id = $(fieldData).closest(".item").attr('id').split('item')[1];
					action(fieldData, "item."+ id +".percent");
				}
				break;
			case 'l_total':
				if($(fieldData).closest(".item").length > 0){
					var id = $(fieldData).closest(".item").attr('id').split('item')[1];
					action(fieldData, "item."+ id +".total");
				}
				break;
		}
	});
}

/* given a invoice object inv, inserts DOM and js Array
 * */
function insert_invoice(inv){	
	//add to invoice list table
	var invList = document.getElementById('invList_body');
	invList.insertRow(0); //create the newest row
	
	var $new_row = $('#invList_body tr:first'); //isolate the DOM;	
	update_table_row(inv, $new_row[0]);
	$new_row.attr("id", "row" + invoices.length);
	
	//ties row DOM object to expected functionality
	$new_row.click(function(){
		var id = $(this).attr("id").split('row')[1];
		set_selected(id);
	});
	
	//add to invoices array.
	invoices.push(inv);		
}

/* saves the selected invoice information from user input (fields)
 * requires the DOM object containing the invoice fields
 * To be called before changing the selection index 
 * */
function save_invoice_info(){
	
	//reads fields and updates the appropriate invoice property(indicated using selected_id)
	invoice_detail_map($('#invoice-detail'), function(fieldData, id){
		var temp = id.split('.');
		if(temp[0] === "item"){	//if this is an item, find item and save that
			while(selected.inv.items.length < parseInt(temp[1]) + 1)
			{	
				selected.inv.items.push(new item());
			}
			selected.inv.items[temp[1]][temp[2]] = $(fieldData).val();
		}
		else{
			if(id === "manual" ){	//check if manual should be checked or not. Buggy. Should be in load invoice??
				if($(fieldData).val() !== ''){
					$("#manualCHK").prop("checked", false);
				} else{
					$("#manualCHK").prop("checked", true);
				}
				$("#manualCHK").change();
			}
			selected.inv[id] = $(fieldData).val();
		}
		$(fieldData).val("");

	});
	
	selected.inv.update_inv_total();
	
	//update the table to reflect invoice changes.
	update_table_row(selected.inv, $("#invList_body tbody").children("#row"+selected.id)[0]);
	
	//resets the invoice details area back to blank with one item
	$("#items-space").children(".item").remove();
	create_item_row();
	
}

/* loads the selected invoice information into user input fields
 * requires the DOM object containing the invoice fields
 * To be called after changing the selection index
 * */
function load_invoice_info(){
	
	while( $('#invoice-items .item').length < selected.inv.items.length)
	{	create_item_row();		}
	
	//uses the mapping to load data into the html elements.
	invoice_detail_map($('#invoice-detail'), function(fieldData, id){
		var temp = id.split('.');
		if(temp[0] === "item" && selected.inv.items.length > 0){
			$(fieldData).val(selected.inv.items[temp[1]][temp[2]]);
			if(temp[2] === "code" && $(fieldData).val() !== ""){
				$("#item"+temp[1]).find("#description").val(bscList[$(fieldData).val()].desc);
			}
		}
		else{ 
			if($(fieldData).hasClass('combobox')){
				fill_combobox($(fieldData), selected.inv[id]);
			}
			$(fieldData).val(selected.inv[id]);
		}
	});
	
	item_total();
}

/* handles initiation of add-ons.
 * */
function initialize_billing(){
	$(" .combobox").combobox();	
	$(" .datepicker").datetimepicker({pickTime:false});
	$(' .datepicker input').focus(function(){
		$(this).closest('.datepicker').find('span').click();
	});
	$(' .datepicker input').blur(function(){
		$('.bootstrap-datetimepicker-widget').css('display', 'none');
	});

	// adjust datatable headers on resize
	$('.table-header').css('width', $(window).width() -15);
	$(window).resize(function(){
		$('.table-header').css('width', $(window).width() -15);
	});
	
	create_item_row();
	
}

/* handles back-end selection of combobox objects
 * */
function fill_combobox($tar, val){	//really terrible implementation. :/
	var $target = $tar.parent();
	var $input = $target.find('.combobox');
	var $btn = $target.find('.dropdown-toggle');
	$btn.trigger('click');	//list needs to be generated
	var $menu = $target.find('ul'); 
	$menu.children().removeClass('active');
	$menu.children('[data-value="'+ val +'"]').addClass('active');
	

	if( $menu.children('.active').length == 0){

		if(val == "First"){
			$menu.children(':eq(0)').addClass('active');
		}
   		$input.val('')
    	$target.removeClass('combobox-selected')
	}
	$menu.trigger('click');
};

/* handles back-end clearing of combobox objects
 * */
function clear_combobox($tar){	//does not work should use the above + ""
	var $target = $tar.parent();
	var $input = $target.find('.combobox');
	var $btn = $target.find('.dropdown-toggle');
	$btn.trigger('click');	//toggle the toggle
};

/* Sends off batch information to be saved into OSCAR database.
 *  */
function batch_save(contentID, batchInfo){
	save_invoice_info();
	$.ajax({
		type: "POST",
		dataType: "html",
		url: "batch-save.jsp",
		data:{
			invoicesType: contentID,
			invoicesData: JSON.stringify(invoices),
			batchData: JSON.stringify(batchInfo)
		}
	}).done(function(msg){
		alert(msg);
		location.reload();
	});
}

function item_total(){
	var $totals = $('#invoice-items .item').find('#l_total');
	var tot = 0;
	$.each($totals, function(i, x){
		if($(x).val() !== ""){
			tot = parseFloat(tot) + parseFloat($(x).val());
		}
	});
	$('#invoice-items #total')[0].innerHTML =  parseFloat(tot).toFixed(2);
}

// ************************************************************************* LEGACY CODE

function create_item_row (){

	// clone row
	row = $('#items-master').clone();
	row.removeClass('invisible');
	row.addClass('visible item');

	//if(contentID != "#hospital"){
		row.attr('style', 'margin-left:10px;');
	//}

	var num_rows = $('#invoice-items .item').length;

	row.attr('id', 'item' + num_rows);
	// make visible
	row.css('display', 'block');
	row.css('position', 'relative');

	// change autocomplete/onclick of new row's children
	var from = row.find('#from-date input');
	var days = row.find('#days');
	var code = row.find('#b_code');
	var description = row.find('#description');
	var dx = row.find('#dx');
	var amount = row.find('#amount');
	var units = row.find('#units');
	var percent = row.find('#percent');
	var total = row.find('#l_total');
	var btn_add = row.find('#add_item');
	var btn_del = row.find('#delete_item');
	var datepick = row.find('.datepicker');

	// only happens for new rows
	if(num_rows > 0){
		var prev = $('#invoice-items .item :eq(' + (num_rows-1) +')');
		from.val(prev.find('#from-date input').val());
		dx.val(prev.find('#dx').val());
		
		// delete button on click
		btn_del.click(function(){
			var id = $(this).closest('.tablerow').attr('id').split('item')[1];
			if(selected.inv.items.length >= id ){ //works on the assumption that the js object perfectly mimics the invoice. There is a chance it doesn't. We need to ensure that it does.
				selected.inv.items.splice(id,1);
			}
			$(this).closest('.tablerow').remove();
			$.each($('#invoice-items .item'), function(i, x){
				$(x).attr('id', 'item'+i);
			});
		});
	}else{
		btn_del.remove();
	}
	
	// code autocomplete rules here
	dx.typeahead({
		source: Object.keys(dxCodes),
		items:5,
		// needed to update dx description
		//updater : function(item){
		//	description.val(dxCodes[item]);
		//	return item;
		//}
	});
	code.typeahead({	//should be fixed so it searches bscList and only makes ajax call if more results are required
		source: function(query, process){
			return $.get('getBillServCodes.jsp', 
				{source: "code", query: query}, 
				function(data){
					temp = JSON.parse(data);
					$.each(temp, function( i, x){
						bscList[x.code]=x;
					} );
					return process(Object.keys(bscList));
				});
			},
		items:5,
		updater: function(item){
			description.val(bscList[item].desc);
			if(bscList[item].value != '.00'){
				amount.val(bscList[item].value);
			} else {
				amount.val(row.prev().find('#amount').val());
			}
			units.val('1');
			percent.val(bscList[item].percent);
			var amt = amount.val() * bscList[item].percent;
			//if(contentID == '#hospital'){ amt = amt * days.val(); }
			total.val(amt.toFixed(2));
			item_total();
			return item;
		}
	});

	// description autocomplete rules here
	description.typeahead({
		source: function(query, process){
			return $.get('getBillServCodes.jsp', 
				{source: "description", query: query}, 
				function(data){
					temp = JSON.parse(data);
					$.each(temp, function( i, x){
						bscList[x.code]=x;
					} );
					return process($.map(bscList, function(x){ return x.desc; }));
				});
			},
		items:5,
		updater: function(desc){
			var item = "";
			for(key in bscList){ if(bscList[key].desc == desc){ item =key; break; } }
			code.val(item);
			if(bscList[item].value != '.00'){
				amount.val(bscList[item].value);
			} else {
				amount.val(row.prev().find('#amount').val());
			}
			units.val('1');
			percent.val(bscList[item].percent);
			var amt = amount.val() * bscList[item].percent;
			//if(contentID == '#hospital'){ amt = amt * days.val(); }
			total.val(amt.toFixed(2));
			item_total();
			return desc;
		}
	});

	days.on('change', function(){
		var amt = days.val() * amount.val() * percent.val()*units.val();
		total.val(amt.toFixed(2));
	});

	units.on('change', function(){
		var amt = amount.val() * percent.val()*units.val();
		//if(contentID == '#hospital'){ amt = amt * days.val(); }
		total.val(amt.toFixed(2));
		item_total();
	});

	// datepicker 
	datepick.datetimepicker({pickTime:false});

	// button on click listener
	btn_add.click(function(){
		// boolean indicates that this is a button click
		create_item_row();
	});

	// add to form
	$('#items-space').append(row);


	// return row for further modifications
	return row;
};
