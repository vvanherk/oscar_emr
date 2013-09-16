

// Table initialization. Needs reevaluation (dataTables seems like a very heavy plugin.

var clinInvList = $('#clinical #invList').dataTable({
	"sScrollY": "100px",
	"bSort": "true",
	"bPaginate": false,
	"bJQueryUI":true,
	"aoColumns": [
 			 { "sWidth": "1%", "bSortable": false},
 			 {"sWidth":"3%"},
 			 {"sWidth":"3%"},
 			 {"sWidth":"10%"},
 			 {"sWidth":"5%"},
 			 {"sWidth":"5%"},
 			 {"sWidth":"16%"},
 			 {"sWidth":"16%"},
 			 null,
 			{"sWidth":"7%"}
		 ],
	"sDom": 'rt<"bottom"><"clear">'
});

$( '#clinical .dataTables_scrollBody').css('overflow-y', 'auto').css('overflow-x', 'hidden').css('width', '100%');

