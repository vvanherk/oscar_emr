
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
	

