
// Table initialization. Needs reevaluation (dataTables seems like a very heavy plugin.
var asInitVals = new Array();

var hospInvList = $('#hospital #invList').dataTable({
	"sScrollY": "100px",
	"bSort": "true",
	"bPaginate": false,
	"bJQueryUI":true,
	"aoColumns": [
 			 { "sWidth": "7%"},
 			 {"sWidth":"7%"},
 			 {"sWidth":"15%"},
 			 {"sWidth":"10%"},
 			 {"sWidth":"10%"},
			 {"sWidth":"20%"},
 			 null
		 ],
	
	"sDom": 'rt<"bottom"><"clear">'
});

$( '#hospital .dataTables_scrollBody').css('overflow-y', 'auto').css('overflow-x', 'hidden');

create_invList_row('#hospital', [' ', ' ', ' ', ' ', ' ', ' ', '0.00']);

invoices['hospital'][0] = new invoice();
$('#hospital #invList tbody').children('#row0').trigger('click');
	
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
