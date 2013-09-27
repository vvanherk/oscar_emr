jQuery(document).ready(function(){
	jQuery("#labRow").html("<a href=\"javascript:void(0)\" onclick=\"popupOscarRx(625,1024,'../ob/OB.do?method=listForDemographic&demographicNo="+demographicNo+"\');return false;\" title\"View Consultation Reports\">ConReport</a>&nbsp;" + jQuery("#labRow").html());
});