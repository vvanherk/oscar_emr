/**
 * Copyright (c) 2013-2014 Prylynx Corporation
 *
 * This software is made available under the terms of the
 * GNU General Public License, Version 2, 1991 (GPLv2).
 * License details are available via "gnu.org/licenses/gpl-2.0.html".
 */

initialize_billing();

$('#detail-trigger').click( function(){
	if($(this).hasClass('condense')){
		$('#detail').css('display', 'none');
		$('#invList_body_container').css('height', '300px');
		$(this).removeClass('condense');
		$(this).html('More Detail <i class="icon-chevron-up"></i>');
	} else
	{
		$('#detail').css('display', 'block');
		$('#invList_body_container').css('height', '150px');
		$(this).addClass('condense');
		$(this).html('Less Detail <i class="icon-chevron-down"></i>');
	}
});
