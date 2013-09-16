// global objects with patient/invoice info
var invoices = {'clinical' : new Array() , 'hospital' : new Array(), 'offsite': new Array()};
var bscList = {};
var patList = new Array();

var selected_id = -1;
var prev_id;

// invoice storing/restoring functions

fill_invoice_info = function(invoice, fields){
	// variable declaration
	var container = fields.closest('div'); // gets parent container, either clinical, offsite, or hospital

	var containerID = '#' + container.prop('id');

	if(invoice.demo == ""){
		$('#demo-name-search').val("");
		$('#demo-hin-search').val("");
		$('#demo-dob-search').val("");
	} else { 
		$('#demo-name-search').val(invoice.demo.name);
		$('#demo-hin-search').val(invoice.demo.health_card);
		$('#demo-dob-search').val(invoice.demo.dob);
	}

	var status = fields.find('#invStatus');
	fill_combobox(status, invoice.status);

	var admission = fields.find('#admission_date input');
	admission.val(invoice.start);


	// fill rdoc
	var doc = fields.find('#rdoctor');
	fill_combobox(doc, invoice.rdoctor); 

	// fill sli code
	var code = fields.find('#sli_code');
	fill_combobox(code, invoice.sli_code); 

	// fill manual text
	var manual = fields.find('#manual_text');
	manual.val(invoice.manual);

	// fill notes text
	var notes = fields.find('#b_notes');
	notes.val(invoice.notes);

	fill_dx(invoice.dx_codes, fields, containerID);


	fill_items(invoice.items, fields, containerID);


};

save_invoice_info = function(invoices, fields){
	// variable declaration
	var invoice = invoices[prev_id];	//load selected invoice
	var containerID = '#' + fields.closest('div').prop('id');
	if(containerID == "#hospital" || containerID == "#offsite"){
		var admD = fields.find('#admission_date input').val();
		invoice.start = admD;
		invoice.end = admD;
	}
	var status = fields.find('#invStatus').val();
	var rdoc = fields.find('#rdoctor').val();
	var sli = fields.find('#sli_code').val();
	var man = fields.find('#manual_text').val();
	var notes = fields.find('#b_notes').val();
	var dx = new Array();

	// get all dx codes
	fields.find('#dx-space .diagnostic').each(function(){
		dx.push($(this).find('#dx_code').val());
	});

	// update invoice info
	invoice.status = status;
	invoice.saveInvoiceInfo(rdoc, sli, dx, man, notes);
	var items = []
	// get items
	fields.find('#invoice-items .item').each(function(){
		if($(this).find('#b_code').val() != null){
			var i = new item();
			if(containerID == "#hospital"){
				i.from = $(this).find('#from-date input').val();
				i.days = $(this).find('#days').val();
				
				var d1 = invoice.end.split("-");
				var d2 = i.from.split("-");
				var date1 = new Date(d1[0], d1[1], d1[2]);
				var date2 = new Date(d2[0], d2[1], d2[2]);
				date2.setDate(date2.getDate() + parseInt(i.days));
				
				if (date2 > date1){
					invoice.end = date2.getFullYear() + "-";
					if( date2.getMonth() < 10){ invoice.end += "0"; }
					invoice.end += date2.getMonth() + "-";
					if( date2.getDate() < 10){ invoice.end += "0"; }
					invoice.end += date2.getDate();
				}
			}
			i.code = $(this).find('#b_code').val();
			i.amount = parseFloat($(this).find('#amount').val()).toFixed(2);
			i.updateUnits(parseFloat($(this).find('#units').val()).toFixed(1));
			i.percent = parseFloat($(this).find('#percent').val()).toFixed(2);
			i.total = parseFloat($(this).find('#l_total').val()).toFixed(2);
			items.push(i);

		}

	});

	invoice.saveItems(items);
	invoices[prev_id] = invoice;
	update_row(prev_id, fields, invoices);
};

update_row = function(id, fields, invoices){
	// variable declaration
	var table = fields.closest('div').find('#invList');
	var batch_total = table.closest('#batch-invoices').closest('div').find('#batch-total-amt');
	var row = table.find('tbody #row'+id);
	var invoice = invoices[id];
	var total = 0;

	// update information in table
	row.find('.servStart').html(invoice.start);
	row.find('.servEnd').html(invoice.end);
	row.find('.remarks').html(invoice.manual);
	row.find('.notes').html(invoice.notes);
	row.find('.amount').html(invoice.inv_amount);
	// update batch total
	table.find('tbody tr').each(function(){
		total += parseFloat($(this).find('.amount').html());
	});
	batch_total.val(total.toFixed(2));

};

fill_items = function(items, fields, containerID){
	var items_space = fields.find('#invoice-items');
	var length = items_space.find('.item').length;

	//destroy all rows
	for(var i=0; i < length; i++){
		// remove row
		items_space.find('#item' + i).remove();
	}

	if(items.length < 2){
		create_item_row(containerID, false);
	}
	else{
		// add rows
		for(var i = 0; i < items.length; i++){
			if(i==0){
				create_item_row(containerID, false);
			}else{
				create_item_row(containerID, true)
			}
		}
	}

	// fill rows with item info
	for(var i = 0; i < items.length; i++){
		var row = fields.find('#item' + i);
		var item = items[i];
		
		// fill boxes
		if(containerID == "#hospital"){
			row.find('#from-date input').val(item.from);
			row.find('#days').val(item.days);
		}
		row.find('#b_code').val(item.code);
		if(item.code != ""){ row.find('#description').val(bscList[item.code].desc); }
		row.find('#amount').val(item.amount);
		row.find('#units').val(item.units);
		row.find('#percent').val(item.percent);
		row.find('#l_total').val(item.total);
	}
};

fill_dx = function(codes, fields, containerID){
	var length = 0;
	var dx_space = fields.find('#dx-space');
	dx_space.find('.diagnostic').each(function(){
		length++;
	});

	// destroy all rows
	for(var i = 0; i< length; i ++){
		// remove the specified row
		dx_space.find('#dx'+i).remove();
	}

	if(codes.length < 2){
		create_dx_row(containerID, false);
	}
	else{
		// add rows
		for(var i = 0; i < codes.length; i++){
			if(i==0){
				create_dx_row(containerID, false);
			}else{
				create_dx_row(containerID, true)
			}
		}
	}

	// fill rows with values
	for(var i=0; i < codes.length; i++){
		fields.find('#dx' + i).find('#dx_code').val(codes[i]);
		fields.find('#dx' + i).find('#dx_description').val(dxCodes[codes[i]]);
	}

};

fill_combobox =  function( tar, val){	//really terrible implementation. :/
	var target = tar.parent();
	var input = target.find('.combobox');
	var btn = target.find('.dropdown-toggle');
	btn.trigger('click');	//list needs to be generated
	var menu = target.find('ul'); 
	menu.children().removeClass('active');
	menu.children('[data-value="'+ val +'"]').addClass('active');
	

	if( menu.children('.active').length == 0){

		if(val == "First"){
			menu.children(':eq(0)').addClass('active');
		}

   		input.val('')
    		target.removeClass('combobox-selected')
	}
	menu.trigger('click');
};

show_inv_details = function(row, contentID){		// **NEEDS** TO BE FIXED

	// get 
	var id = parseInt(row.attr('id').slice(3));
	prev_id = selected_id;
	selected_id = id;

	if(contentID == "#clinical"){
		var i = invoices["clinical"][id];
		var master = invoices["clinical"];
		
	}
	else if(contentID == "#offsite"){
		var i = invoices['offsite'][id];
		var master = invoices['offsite'];
	}
	else{
		var i = invoices['hospital'][id];
		var master = invoices['hospital'];
	}

	var invoice = $(contentID + ' #invoice-detail');
	
	// save info in fields
	if(prev_id !== -1){
		save_invoice_info(master, invoice);
	}

	// fill fields
	fill_invoice_info(i, invoice);
};

//for initializing newly loaded html as javascipt functions.
tab_load = function(contentID){
	$(contentID + " .combobox").combobox();	
	$(contentID + " .datepicker").datetimepicker({pickTime:false});
	$(contentID + ' .datepicker input').focus(function(){
		$(this).closest('.datepicker').find('span').click();
	});
	$(contentID + ' .datepicker input').blur(function(){
		$('.bootstrap-datetimepicker-widget').css('display', 'none');
	});

	// adjust datatable headers on resize
	$(window).resize(function(){
		$('#invList').dataTable().fnAdjustColumnSizing();
	});

	$(contentID + " #b_provider").on('blur', function(){
		var sel = $(contentID + " #b_provider_val").val();
		$(contentID + ' #group_no').val(providers[sel].group);
		fill_combobox($(contentID + ' #provider'), $(contentID + " #b_provider").val());
		$(contentID + ' #billing-center').val(providers[sel].b_ctr);
	});
	
	$("#create-list").on('click', function(){
		if($('#invList').find('.dataTables_empty').length == 0){
			$.each($('#invList tbody tr'), function(i, x){
				$('#invList').dataTable().fnDeleteRow( x );
			});
			invoices["clinical"] = [];
			$('#invoice-detail input').val('');
		}
		else{
			$('#invoice-detail').removeClass('invisible');
		}

		$.ajax({
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
					create_invList_row ('#clinical',
					['<input id="demo" type="checkbox">',
					inv.date, inv.time, inv.demo.name, 
					inv.demo.health_card, inv.demo.dob, 
					inv.manual, inv.notes, inv.description, 
					inv.inv_amount]);
				});
			invoices["clinical"] = $.map(response, function(inv){		//use extend
				var newInvoice = new invoice();
				inv.demo = new demographic(inv.demo);
				$.extend(newInvoice, inv)
				return newInvoice;
			});
			$('#invList tbody').children('#row0').trigger('click');
		});


	});

	fill_combobox($(contentID+' #billing-type'), 'OHIP');
	fill_combobox($(contentID+' #location'), 'First');

	$('#save-batch').click( function(){
			batch_save(contentID.slice(1));
			return false;			
		});


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

	$('#admission_date input').on('blur', function(){
		var tar = $(contentID + " #items-space :eq(0)").find("#from-date input");
		tar.val($('#admission_date input').val());
	});

	// create dx row
	create_dx_row(contentID, false);

	// create item row
	create_item_row(contentID, false);

// patient selection functionality
	$(contentID + ' #prev_patient').on('click', function(){
			var prev = selected_id - 1;
			if(prev < 0){ 
				var prev =  $(contentID + ' #invList tbody tr').length -1; 
			}
			$(contentID + ' #row'+ prev).trigger('click');
		} );


	$(contentID + ' #next_patient').on('click', function(){
			var next = selected_id+1; 
			if(next == $(contentID + ' #invList tbody tr').length){ 
				if(contentID == "#clinical"){	next = 0; }
				else{
					if(contentID  == "#offsite"){
						invoices['offsite'][next] = new invoice();
						create_invList_row('#offsite', [' ', ' ', ' ', ' ', ' ', '0.00']);
					}
					else{						
						invoices['hospital'][next] = new invoice();
						create_invList_row('#hospital', [' ', ' ', ' ', ' ', ' ', ' ', '0.00']);
					}
				}
			}
			$(contentID + ' #row'+ next).trigger('click');
		} );
	
};

// button call functions

create_dx_row = function(contentID, frmBtn){
	// clone row
	row = $(contentID + ' #dx_master').clone();
	row.attr('class', 'tablerow span12 diagnostic visible');
	row.attr('style', '');
	
	var num_rows =0;
	$(contentID + ' #dx-space .diagnostic').each(function(){
		num_rows++;
	});

	row.attr('id', 'dx'+ num_rows);
	// make visible
	row.css('position','relative');

	// make shortcuts for each element in row
	var code = row.find('.dxCode');
	var description = row.find('.dxDesc');
	var btn_add = row.find('#add_Dx');
	var btn_del = row.find('#delete_Dx');

	// only happens for new rows
	if(frmBtn){
		btn_del.attr('class', 'btn visible')
		btn_del.css('display', 'block');

		// delete button on click
		btn_del.click(function(){
			$(this).closest('.tablerow').remove();
		})
	}

	// code autocomplete rules here
	code.typeahead({
		source: Object.keys(dxCodes),
		items:5,
		// needed to update dx description
		updater : function(item){
			description.val(dxCodes[item]);
			return item;
		}
	});

	// description autocomplete rules here
	description.typeahead({
		source: $.map(dxCodes, function(key){ return key; }),
		items:5,
		updater: function(desc){
			for(key in dxCodes){ if(dxCodes[key] == desc){ code.val(key); break; } }
			return desc;
		}
	});
	// button on click listener
	btn_add.click(function(){
		// boolean indicates that this is a button click
		create_dx_row(contentID, true);
	});

	// add to form
	$(contentID + ' #dx-space').append(row);

	// return row for further modifications
	return row;
};

create_item_row = function(contentID, frmBtn){

	// clone row
	row = $(contentID + ' #items-master').clone();
	row.attr('class', 'tablerow row-fluid visible item');

	if(contentID != "#hospital"){
		row.attr('style', 'margin-left:10px;');
	}

	var num_rows = $(contentID + ' #invoice-items .item').length;

	row.attr('id', 'item' + num_rows);
	// make visible
	row.css('display', 'block');
	row.css('position', 'relative');

	// change autocomplete/onclick of new row's children
	var from = row.find('#from-date input');
	var days = row.find('#days');
	var code = row.find('#b_code');
	var description = row.find('#description');
	var amount = row.find('#amount');
	var units = row.find('#units');
	var percent = row.find('#percent');
	var total = row.find('#l_total');
	var btn_add = row.find('#add_item');
	var btn_del = row.find('#delete_item');
	var datepick = row.find('.datepicker');

	// only happens for new rows
	if(frmBtn){
		// delete button on click
		btn_del.click(function(){
			$(this).closest('.tablerow').remove();
		})
	}else{
		btn_del.remove();
		
	}

	if(num_rows > 0){
		var prev = $(contentID + ' #invoice-items .item :eq(' + (num_rows-1) +')');
		from.val(prev.find('#from-date input').val());
	}

	// code autocomplete rules here
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
			units.val('1.0');
			percent.val(bscList[item].percent);
			var amt = amount.val() * bscList[item].percent;
			if(contentID == '#hospital'){ amt = amt * days.val(); }
			total.val(amt.toFixed(2));
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
			units.val('1.0');
			percent.val(bscList[item].percent);
			var amt = amount.val() * bscList[item].percent;
			if(contentID == '#hospital'){ amt = amt * days.val(); }
			total.val(amt.toFixed(2));
			return desc;
		}
	});

	days.on('change', function(){
		var amt = days.val() * amount.val() * percent.val()*units.val();
		total.val(amt.toFixed(2));
	});

	units.on('change', function(){
		var amt = amount.val() * percent.val()*units.val();
		if(contentID == '#hospital'){ amt = amt * days.val(); }
		total.val(amt.toFixed(2));
	});

	// datepicker 
	datepick.datetimepicker({pickTime:false});

	// button on click listener
	btn_add.click(function(){
		// boolean indicates that this is a button click
		create_item_row(contentID, true);
	});

	// add to form
	$(contentID + ' #items-space').append(row);


	// return row for further modifications
	return row;
};


create_invList_row = function(contentID, invInfo){
	// add to form
	var insertIndex = $(contentID + ' #invList').dataTable().fnAddData( invInfo );
	// return row for further modifications
	row = $(contentID + ' #invList tbody').children(":not([id])");
	row.attr('id', 'row'+insertIndex);
	
	if(contentID == "#clinical"){
		row.children(":eq(0)").addClass("checkbox");
		row.children(":eq(1)").addClass("date");
		row.children(":eq(2)").addClass("time");
		row.children(":eq(3)").addClass("patient-name");
		row.children(":eq(4)").addClass("health-card-number");
		row.children(":eq(5)").addClass("date-of-birth");
		row.children(":eq(6)").addClass("remarks");
		row.children(":eq(7)").addClass("notes");
		row.children(":eq(8)").addClass("service-description");
		row.children(":eq(9)").addClass("amount");
	} else if( contentID == "#hospital"){
		row.children(":eq(0)").addClass("servStart");
		row.children(":eq(1)").addClass("servEnd");
		row.children(":eq(2)").addClass("patient-name");
		row.children(":eq(3)").addClass("health-card-number");
		row.children(":eq(4)").addClass("date-of-birth");
		row.children(":eq(5)").addClass("remarks");
		row.children(":eq(6)").addClass("amount");
	} else if( contentID == "#offsite"){
		row.children(":eq(0)").addClass("servStart");
		row.children(":eq(1)").addClass("patient-name");
		row.children(":eq(2)").addClass("health-card-number");
		row.children(":eq(3)").addClass("date-of-birth");
		row.children(":eq(4)").addClass("remarks");
		row.children(":eq(5)").addClass("amount");
	}

	// add on click function to each row
	row.click(function(){
		// this function is different for each page
		if ( $(this).hasClass('row_selected') ) {}
		else {
		    $(this).siblings('.row_selected').removeClass('row_selected');
		    $(this).addClass('row_selected');
		}
		show_inv_details($(this), contentID); 
	});

	return insertIndex;
	
};

batch_save = function(contentID){
	save_invoice_info(invoices[contentID], $('#' + contentID + ' #invoice-detail'));
	$.ajax({
		    type: "POST",
		    url:"batch-save.jsp",
		    data: {
			billsData: JSON.stringify(invoices[contentID]),
			batchData: JSON.stringify({
						b_provider: $('#b_provider_val').val(), 
						provider: $('#provider_val').val(), 
						billDate: $.datepicker.formatDate('yy/mm/dd', today), 
						billTime: today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds() })
		    }
		}).done(function(){ alert(decodeURIComponent(JSON.stringify(invoices[contentID]))); });
}

// miscellaneous, multi-call functions

show_warning = function(string){
	var alert = $('.warning');
	alert.html("Warning! " + string);
	alert.slideDown(500).delay(1000).slideUp(500);
};
show_success = function(string){
	var success = $('.alert-success');
	success.html('Success! ' + string);
	success.slideDown(500).delay(1000).slideUp(500);
};
show_error = function(string){
	var error = $('.alert-error');
	error.html('Error. ' + string);
	error.slideDown(500).delay(1000).slideUp(500);
};


// extend this function
$.fn.exists = function () {
    return this.length !== 0;
}

