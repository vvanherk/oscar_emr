
var asInitVals = new Array();

var invList = $('#offsite #invList').dataTable({
	"sScrollY": "100px",
	"bSort": "true",
	"bPaginate": false,
	"bJQueryUI":true,
	"aoColumns": [
 			 { "sWidth": "7%"},
 			 {"sWidth":"20%"},
 			 {"sWidth":"10%"},
 			 {"sWidth":"10%"},
			 {"sWidth":"20%"},
 			 null
		 ],
	"oLanguage": {
            "sSearch": "Search all columns:"
        },
        "sDom": 'rt<"bottom"><"clear">'
});

$( '#offsite .dataTables_scrollBody').css('overflow-y', 'auto').css('overflow-x', 'hidden');

create_invList_row('#offsite', [' ', ' ', ' ', ' ', ' ', '0.00']);
invoices['offsite'][0] = new invoice();
$('#offsite #invList tbody').children('#row0').trigger('click');
