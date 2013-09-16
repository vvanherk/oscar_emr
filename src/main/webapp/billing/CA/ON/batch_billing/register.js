add_row = function(frmBtn){
	
	// clone row
	row = $( ' .item_master').clone();
	row.attr('class', 'row-fluid visible item');
	
	// make visible
	row.css('display', 'block');
	row.css('position','relative');

	// change autocomplete/onclick of new row's children
	var item = row.find('#item');
	var units = row.find('#units');
	var amount = row.find('#amount');
	var description = row.find('#description');
	var total = row.find('#l_total');
	var btn_add = row.find('#add_row');
	var btn_del = row.find('#delete_row');


	// only happens for new rows
	if(frmBtn){
		btn_del.attr('class', 'btn visible')
		btn_del.css('display', 'block');

		// delete button on click
		btn_del.click(function(){
			$(this).closest('.row-fluid').remove();
		});
	}

	// item autocomplete rules here
	item.typeahead({
		source: Object.keys(all_items),
		items:10,
		updater: function(item){
			description.val(all_items[item].description);
			amount.val(all_items[item].value.toFixed(2));
			units.val(1);
			update(row);
			return item;
		}
	});

	// description autocomplete rules here

	// units on change here
	units.change(function(){
		update($(this).closest('.row-fluid'));
	});

	// button on click listener
	btn_add.click(function(){
		// boolean indicates that this is a button click
		add_row(true);
	});

	// add to form
	$('#invoice-details-body').append(row);

	// return row for further modifications
	return row;
};
load_buttons = function(){
	var oper = $('#register #operations');
	var proc = $('#register #procedures');
	var item = $('#register #items');

	// operations load
	for(var i = 0; i < operations.length; i+=2){
		var row_div = jQuery('<div/>', {
			class: 'row-fluid'
		});
		for(var j = 0; j < 2;j++){
			var o = operations[i+j];
			var contain1 = jQuery('<div/>',{
				class: 'span6'
			});
			var btn1 = jQuery('<button/>', {
				class : 'btn',
				id: 'btn' + (i+j),
				style : 'height:75px; width:100%'
			});
			btn1.append(o.key).append(jQuery('<br/>')).append(o.description).append(jQuery('<br/>')).append(o.value.toFixed(2));
			// change button properties
			btn1.click(function(){
				var row = null;
				var id = parseInt($(this).prop('id').substr(3));
				var o = operations[id];
				$("#register #invoice-details-body .item").each(function(){
					if(row == null){
						var parent_row = $(this).closest('.row-fluid');
						var item = parent_row.find('#item').val();
						var units = parseInt(parent_row.find('#units').val());
						if(isNaN(units)){
							units = 0;
						}
						if(item == o.key){
							row = parent_row;
							units++;
							parent_row.find('#units').val(units);
							update(row);
						}
						else if(item=="" || item == null){
							parent_row.find('#item').val(o.key);
							parent_row.find('#description').val(o.description);
							parent_row.find('#amount').val(o.value.toFixed(2));
							parent_row.find('#units').val(1);
							row = parent_row;
							update(row);
						}
					}
				});
				if(row == null){
					row = add_row(true);
					row.find('#item').val(o.key);
					row.find('#description').val(o.description);
					row.find('#amount').val(o.value.toFixed(2));
					row.find('#units').val(1);
					update(row);
				}
			});
			contain1.append(btn1);
			row_div.append(contain1);
		}
		oper.append(row_div);
	}


	// procedures s load
	for(var i = 0; i < procedures.length; i+=2){
		var row_div = jQuery('<div/>', {
			class: 'row-fluid'
		});
		for(var j = 0; j < 2;j++){
			var o = procedures[i+j];
			var contain1 = jQuery('<div/>',{
				class: 'span6'
			});
			var btn1 = jQuery('<button/>', {
				class : 'btn',
				id: 'btn' + (i+j),
				style : 'height:75px; width:100%'
			});
			btn1.append(o.key).append(jQuery('<br/>')).append(o.description).append(jQuery('<br/>')).append(o.value.toFixed(2));
			// change button properties
			btn1.click(function(){
				var row = null;
				var id = parseInt($(this).prop('id').substr(3));
				var o = procedures[id];
				$("#register #invoice-details-body .item").each(function(){
					if(row == null){
						var parent_row = $(this).closest('.row-fluid');
						var item = parent_row.find('#item').val();
						var units = parseInt(parent_row.find('#units').val());
						if(isNaN(units)){
							units = 0;
						}
						if(item == o.key){
							row = parent_row;
							units++;
							parent_row.find('#units').val(units);
							update(row);
						}
						else if(item=="" || item == null){
							parent_row.find('#item').val(o.key);
							parent_row.find('#description').val(o.description);
							parent_row.find('#amount').val(o.value.toFixed(2));
							parent_row.find('#units').val(1);
							row = parent_row;
							update(row);
						}
					}
				});
				if(row == null){
					row = add_row(true);
					row.find('#item').val(o.key);
					row.find('#description').val(o.description);
					row.find('#amount').val(o.value.toFixed(2));
					row.find('#units').val(1);
					update(row);
				}
			});
			contain1.append(btn1);
			row_div.append(contain1);
		}
		proc.append(row_div);
	}


	// itemss load
	for(var i = 0; i < items.length; i+=2){
		var row_div = jQuery('<div/>', {
			class: 'row-fluid'
		});
		for(var j = 0; j < 2;j++){
			var o = items[i+j];
			var contain1 = jQuery('<div/>',{
				class: 'span6'
			});
			var btn1 = jQuery('<button/>', {
				class : 'btn',
				id: 'btn' + (i+j),
				style : 'height:75px; width:100%'
			});
			btn1.append(o.key).append(jQuery('<br/>')).append(o.description).append(jQuery('<br/>')).append(o.value.toFixed(2));
			// change button properties
			btn1.click(function(){
				var row = null;
				var id = parseInt($(this).prop('id').substr(3));
				var o = items[id];
				$("#register #invoice-details-body .item").each(function(){
					if(row == null){
						var parent_row = $(this).closest('.row-fluid');
						var item = parent_row.find('#item').val();
						var units = parseInt(parent_row.find('#units').val());
						if(isNaN(units)){
							units = 0;
						}
						if(item == o.key){
							row = parent_row;
							units++;
							parent_row.find('#units').val(units);
							update(row);
						}
						else if(item=="" || item == null){
							parent_row.find('#item').val(o.key);
							parent_row.find('#description').val(o.description);
							parent_row.find('#amount').val(o.value.toFixed(2));
							parent_row.find('#units').val(1);
							row = parent_row;
							update(row);
						}
					}
				});
				if(row == null){
					row = add_row(true);
					row.find('#item').val(o.key);
					row.find('#description').val(o.description);
					row.find('#amount').val(o.value.toFixed(2));
					row.find('#units').val(1);
					update(row);
				}
			});
			contain1.append(btn1);
			row_div.append(contain1);
		}
		item.append(row_div);
	}
};	

update = function(row){
	// variable declaration
	var amount = parseFloat(row.find('#amount').val());
	var units = parseInt(row.find('#units').val());
	var prev_total = parseFloat(row.find('#l_total').val());
	if(isNaN(prev_total)){
		prev_total = 0;
	}
	var new_total = amount*units;
	var table = $("#register .invoice-details");
	var prev_subtotal = parseFloat(table.find('#subtotal').html().substr(1));
	if(isNaN(prev_subtotal)){
		prev_subtotal = 0;
	}
	var new_subtotal = prev_subtotal - prev_total + new_total;

	// update invoice info
	row.find('#l_total').val(new_total.toFixed(2));

	// update subtotal, taxes, and total
	table.find('#subtotal').html('$' + new_subtotal.toFixed(2));
	table.find('#taxes').html('$' + (new_subtotal*0.13).toFixed(2));
	table.find('#total').html('$' + (new_subtotal*1.13).toFixed(2));
};

add_row(false);
load_buttons();

