
alter table formONAREnhanced add pg1_year11 varchar(10) default NULL;
alter table formONAREnhanced add  pg1_sex11 char(1) default NULL;
alter table formONAREnhanced add  pg1_oh_gest11 varchar(5) default NULL;
alter table formONAREnhanced add  pg1_weight11 varchar(6) default NULL;
alter table formONAREnhanced add  pg1_length11 varchar(6) default NULL;
alter table formONAREnhanced add  pg1_place11 varchar(20) default NULL;
alter table formONAREnhanced add  pg1_svb11 tinyint(1) default NULL;
alter table formONAREnhanced add  pg1_cs11 tinyint(1) default NULL;
alter table formONAREnhanced add  pg1_ass11 tinyint(1) default NULL;
alter table formONAREnhanced add  pg1_oh_comments11 varchar(80) default NULL;

alter table formONAREnhanced add pg1_year12 varchar(10) default NULL;
alter table formONAREnhanced add  pg1_sex12 char(1) default NULL;
alter table formONAREnhanced add  pg1_oh_gest12 varchar(5) default NULL;
alter table formONAREnhanced add  pg1_weight12 varchar(6) default NULL;
alter table formONAREnhanced add  pg1_length12 varchar(6) default NULL;
alter table formONAREnhanced add  pg1_place12 varchar(20) default NULL;
alter table formONAREnhanced add  pg1_svb12 tinyint(1) default NULL;
alter table formONAREnhanced add  pg1_cs12 tinyint(1) default NULL;
alter table formONAREnhanced add  pg1_ass12 tinyint(1) default NULL;
alter table formONAREnhanced add  pg1_oh_comments12 varchar(80) default NULL;

alter table formONAREnhanced add pg1_comments2AR1 text;

create table BornTransmissionLog(
	id integer not null auto_increment,
	submitDateTime timestamp not null,
	success tinyint(1) default 0,
	filename varchar(100) not null,
	primary key(id)
);

alter table formONAREnhanced add pg2_date55 date default NULL;
alter table formONAREnhanced add pg2_gest55 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht55 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt55 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn55 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR55 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr55 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl55 char(3) default NULL;
alter table formONAREnhanced add pg2_BP55 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments55 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date56 date default NULL;
alter table formONAREnhanced add pg2_gest56 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht56 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt56 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn56 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR56 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr56 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl56 char(3) default NULL;
alter table formONAREnhanced add pg2_BP56 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments56 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date57 date default NULL;
alter table formONAREnhanced add pg2_gest57 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht57 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt57 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn57 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR57 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr57 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl57 char(3) default NULL;
alter table formONAREnhanced add pg2_BP57 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments57 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date58 date default NULL;
alter table formONAREnhanced add pg2_gest58 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht58 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt58 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn58 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR58 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr58 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl58 char(3) default NULL;
alter table formONAREnhanced add pg2_BP58 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments58 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date59 date default NULL;
alter table formONAREnhanced add pg2_gest59 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht59 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt59 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn59 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR59 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr59 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl59 char(3) default NULL;
alter table formONAREnhanced add pg2_BP59 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments59 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date60 date default NULL;
alter table formONAREnhanced add pg2_gest60 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht60 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt60 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn60 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR60 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr60 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl60 char(3) default NULL;
alter table formONAREnhanced add pg2_BP60 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments60 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date61 date default NULL;
alter table formONAREnhanced add pg2_gest61 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht61 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt61 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn61 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR61 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr61 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl61 char(3) default NULL;
alter table formONAREnhanced add pg2_BP61 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments61 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date62 date default NULL;
alter table formONAREnhanced add pg2_gest62 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht62 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt62 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn62 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR62 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr62 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl62 char(3) default NULL;
alter table formONAREnhanced add pg2_BP62 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments62 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date63 date default NULL;
alter table formONAREnhanced add pg2_gest63 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht63 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt63 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn63 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR63 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr63 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl63 char(3) default NULL;
alter table formONAREnhanced add pg2_BP63 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments63 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date64 date default NULL;
alter table formONAREnhanced add pg2_gest64 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht64 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt64 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn64 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR64 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr64 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl64 char(3) default NULL;
alter table formONAREnhanced add pg2_BP64 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments64 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date65 date default NULL;
alter table formONAREnhanced add pg2_gest65 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht65 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt65 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn65 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR65 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr65 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl65 char(3) default NULL;
alter table formONAREnhanced add pg2_BP65 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments65 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date66 date default NULL;
alter table formONAREnhanced add pg2_gest66 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht66 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt66 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn66 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR66 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr66 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl66 char(3) default NULL;
alter table formONAREnhanced add pg2_BP66 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments66 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date67 date default NULL;
alter table formONAREnhanced add pg2_gest67 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht67 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt67 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn67 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR67 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr67 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl67 char(3) default NULL;
alter table formONAREnhanced add pg2_BP67 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments67 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date68 date default NULL;
alter table formONAREnhanced add pg2_gest68 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht68 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt68 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn68 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR68 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr68 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl68 char(3) default NULL;
alter table formONAREnhanced add pg2_BP68 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments68 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date69 date default NULL;
alter table formONAREnhanced add pg2_gest69 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht69 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt69 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn69 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR69 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr69 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl69 char(3) default NULL;
alter table formONAREnhanced add pg2_BP69 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments69 varchar(255) default NULL;

alter table formONAREnhanced add pg2_date70 date default NULL;
alter table formONAREnhanced add pg2_gest70 varchar(6) default NULL;
alter table formONAREnhanced add pg2_ht70 varchar(6) default NULL;
alter table formONAREnhanced add pg2_wt70 varchar(6) default NULL;
alter table formONAREnhanced add pg2_presn70 varchar(6) default NULL;
alter table formONAREnhanced add pg2_FHR70 varchar(6) default NULL;
alter table formONAREnhanced add pg2_urinePr70 char(3) default NULL;
alter table formONAREnhanced add pg2_urineGl70 char(3) default NULL;
alter table formONAREnhanced add pg2_BP70 varchar(8) default NULL;
alter table formONAREnhanced add pg2_comments70 varchar(255) default NULL;

alter table ProviderPreference add eRxEnabled tinyint(1) not null;
alter table ProviderPreference add eRx_SSO_URL varchar(128);
alter table ProviderPreference add eRxUsername varchar(32);
alter table ProviderPreference add eRxPassword varchar(64);
alter table ProviderPreference add eRxFacility varchar(32);
alter table ProviderPreference add eRxTrainingMode tinyint(1) not null;

insert into access_type (name,type) values('read receptionist notes','access');
insert into access_type (name,type) values('write receptionist notes','access');
insert into access_type (name,type) values('write receptionist issues','access');
insert into access_type (name,type) values('read receptionist issues','access');
insert into access_type (name,type) values('read receptionist ticklers','access');

insert into default_role_access (role_id,access_id) values ((select role_no from secRole where role_name ='doctor'),(select access_id from access_type where name='read receptionist issues'));
insert into default_role_access (role_id,access_id) values ((select role_no from secRole where role_name ='doctor'),(select access_id from access_type where name='read receptionist notes'));
insert into default_role_access (role_id,access_id) values ((select role_no from secRole where role_name ='doctor'),(select access_id from access_type where name='write receptionist issues'));
insert into default_role_access (role_id,access_id) values ((select role_no from secRole where role_name ='doctor'),(select access_id from access_type where name='write receptionist notes'));

alter table formONAREnhanced add  sent_to_born tinyint(1) default 0;

INSERT INTO `eform` (`form_name`, `subject`, `form_date`, `form_time`, `status`, `form_html`, `patient_independent`) 
VALUES 
('Rich Text Letter','Rich Text Letter Generator','2012-06-01','10:00:00','0','<html><head>\n<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">\n\n<title>Rich Text Letter</title>\n<style type=\"text/css\">\n.butn {width: 140px;}\n</style>\n\n<style type=\"text/css\" media=\"print\">\n.DoNotPrint {display: none;}\n\n</style>\n<script language=\"javascript\" type=\"text/javascript\" src=\"${oscar_javascript_path}jquery/jquery-1.4.2.js\"></script>\n\n<script language=\"javascript\">\nvar needToConfirm = false;\n\n//keypress events trigger dirty flag for the iFrame and the subject line\ndocument.onkeyup=setDirtyFlag\n\n\nfunction setDirtyFlag() {\n	needToConfirm = true; \n}\n\nfunction releaseDirtyFlag() {\n	needToConfirm = false; //Call this function if dosent requires an alert.\n	//this could be called when save button is clicked\n}\n\n\nwindow.onbeforeunload = confirmExit;\n\nfunction confirmExit() {\n	if (needToConfirm)\n	return \"You have attempted to leave this page. If you have made any changes without clicking the Submit button, your changes will be lost. Are you sure you want to exit this page?\";\n}\n\n</script>\n\n\n\n</head><body bgcolor=\"FFFFFF\" onload=\"Start();\">\n\n\n<!-- START OF EDITCONTROL CODE --> \n\n<script language=\"javascript\" type=\"text/javascript\" src=\"${oscar_javascript_path}eforms/editControl.js\"></script>\n<script language=\"javascript\" type=\"text/javascript\" src=\"${oscar_javascript_path}eforms/APCache.js\"></script>\n<script language=\"javascript\" type=\"text/javascript\" src=\"${oscar_javascript_path}eforms/imageControl.js\"></script>\n<script language=\"javascript\" type=\"text/javascript\" src=\"${oscar_javascript_path}eforms/faxControl.js\"></script>\n<script language=\"javascript\" type=\"text/javascript\" src=\"${oscar_javascript_path}eforms/signatureControl.jsp\"></script>\n<script language=\"javascript\" type=\"text/javascript\" src=\"${oscar_javascript_path}eforms/printControl.js\"></script>\n\n<script language=\"javascript\">\n	//put any of the optional configuration variables that you want here\n	cfg_width = \'840\'; //editor control width in pixels\n	cfg_height = \'520\'; //editor control height in pixels\n	cfg_editorname = \'edit\'; //the handle for the editor                  \n	cfg_isrc = \'../eform/displayImage.do?imagefile=\'; //location of the button icon files\n	cfg_filesrc = \'../eform/displayImage.do?imagefile=\'; //location of the html files\n	cfg_template = \'blank.rtl\'; //default style and content template\n	cfg_formattemplate = \'<option value=\"\"> loading... </option></select>\';\n	//cfg_layout = \'[all]\';             //adjust the format of the buttons here\n	cfg_layout = \'<table style=\"background-color:ccccff; width:840px\"><tr id=control1><td>[bold][italic][underlined][strike][subscript][superscript]|[left][center][full][right]|[unordered][ordered][rule]|[undo][redo]|[indent][outdent][select-all][clean]|[table]</td></tr><tr id=control2><td>[select-block][select-face][select-size][select-template]|[image][clock][date][spell][help]</td></tr></table>[edit-area]\';\n	insertEditControl(); // Initialise the edit control and sets it at this point in the webpage\n\n	\n	function gup(name, url)\n	{\n		if (url == null) { url = window.location.href; }\n		name = name.replace(/[\\[]/,\"\\\\\\[\").replace(/[\\]]/,\"\\\\\\]\");\n		var regexS = \"[\\\\?&]\"+name+\"=([^&#]*)\";\n		var regex = new RegExp(regexS);\n		var results = regex.exec(url);\n		if (results == null) { return \"\"; }\n		else { return results[1]; }\n	}\n	var demographicNo =\"\";\n\n	jQuery(document).ready(function(){\n		demographicNo = gup(\"demographic_no\");\n		if (demographicNo == \"\") { demographicNo = gup(\"efmdemographic_no\", jQuery(\"form\").attr(\'action\')); }\n		if (typeof signatureControl != \"undefined\") {\n			signatureControl.initialize({\n				sigHTML:\"../signature_pad/tabletSignature.jsp?inWindow=true&saveToDB=true&demographicNo=\",\n				demographicNo:demographicNo,\n				refreshImage: function (e) {\n					var html = \"<img src=\'\"+e.storedImageUrl+\"&r=\"+ Math.floor(Math.random()*1001) +\"\'></img>\";\n					doHtml(html);		\n				},\n				signatureInput: \"#signatureInput\"	\n			});\n		}		\n	});\n		\n	var cache = createCache({\n		defaultCacheResponseHandler: function(type) {\n			if (checkKeyResponse(type)) {\n				doHtml(cache.get(type));\n			}			\n			\n		},\n		cacheResponseErrorHandler: function(xhr, error) {\n			alert(\"Please contact an administrator, an error has occurred.\");			\n			\n		}\n	});	\n	\n	function checkKeyResponse(response) {		\n		if (cache.isEmpty(response)) {\n			alert(\"The requested value has no content.\");\n			return false;\n		}\n		return true;\n	}\n	\n	function printKey (key) {\n		var value = cache.lookup(key); \n		if (value != null && checkKeyResponse(key)) { doHtml(cache.get(key)); } 		  \n	}\n	\n	function submitFaxButton() {\n		document.getElementById(\'faxEForm\').value=true;\n		needToConfirm=false;\n		document.getElementById(\'Letter\').value=editControlContents(\'edit\');\n		setTimeout(\'document.RichTextLetter.submit()\',1000);\n	}\n	\n	cache.addMapping({\n		name: \"_SocialFamilyHistory\",\n		values: [\"social_family_history\"],\n		storeInCacheHandler: function(key,value) {\n			cache.put(this.name, cache.get(\"social_family_history\").replace(/(<br>)+/g,\"<br>\"));\n		},\n		cacheResponseHandler:function () {\n			if (checkKeyResponse(this.name)) {				\n				doHtml(cache.get(this.name));\n			}	\n		}\n	});\n	\n	\n	cache.addMapping({name: \"template\", cacheResponseHandler: populateTemplate});	\n	\n	cache.addMapping({\n		name: \"_ClosingSalutation\", \n		values: [\"provider_name_first_init\"],	\n		storeInCacheHandler: function (key,value) {\n			if (!cache.isEmpty(\"provider_name_first_init\")) {\n				cache.put(this.name, \"<p>Yours Sincerely<p>&nbsp;<p>\" + cache.get(\"provider_name_first_init\") + \", MD\");\n			}\n		},\n		cacheResponseHandler:function () {\n			if (checkKeyResponse(this.name)) {				\n				doHtml(cache.get(this.name));\n			}	\n		}\n	});\n	\n	cache.addMapping({\n		name: \"_ReferringBlock\", \n		values: [\"referral_name\", \"referral_address\", \"referral_phone\", \"referral_fax\"], 	\n		storeInCacheHandler: function (key, value) {\n			var text = \n				(!cache.isEmpty(\"referral_name\") ? cache.get(\"referral_name\") + \"<br>\" : \"\") \n			  + (!cache.isEmpty(\"referral_address\") ? cache.get(\"referral_address\") + \"<br>\" : \"\")\n			  + (!cache.isEmpty(\"referral_phone\") ? \"Tel: \" + cache.get(\"referral_phone\") + \"<br>\" : \"\")\n			  + (!cache.isEmpty(\"referral_fax\") ? \"Fax: \" + cache.get(\"referral_fax\") + \"<br>\" : \"\");						  						 \n			cache.put(this.name, text)\n		},\n		cacheResponseHandler: function () {\n			if (checkKeyResponse(this.name)) {\n				doHtml(cache.get(this.name));\n			}\n		}\n	});\n	\n	cache.addMapping({\n		name: \"letterhead\", \n		values: [\"clinic_name\", \"clinic_fax\", \"clinic_phone\", \"clinic_addressLineFull\", \"doctor\", \"doctor_contact_phone\", \"doctor_contact_fax\", \"doctor_contact_addr\"], \n		storeInCacheHandler: function (key, value) {\n			var text = genericLetterhead();\n			cache.put(\"letterhead\", text);\n		},\n		cacheResponseHandler: function () {\n			if (checkKeyResponse(this.name)) {\n				doHtml(cache.get(this.name));\n			}\n		}\n	});\n	\n	cache.addMapping({\n		name: \"referral_nameL\", \n		values: [\"referral_name\"], \n		storeInCacheHandler: function(_key,_val) { \n		if (!cache.isEmpty(\"referral_name\")) {\n				var mySplitResult =  cache.get(\"referral_name\").toString().split(\",\");\n				cache.put(\"referral_nameL\", mySplitResult[0]);\n			} \n		}\n	});\n	\n	cache.addMapping({\n		name: \"complexAge\", \n		values: [\"complexAge\"], \n		cacheResponseHandler: function() {\n			if (cache.isEmpty(\"complexAge\")) { \n				printKey(\"age\"); \n			}\n			else {\n				if (checkKeyResponse(this.name)) {\n					doHtml(cache.get(this.name));\n				}\n			}\n		}\n	});\n	\n	// Setting up many to one mapping for derived gender keys.\n	var genderKeys = [\"he_she\", \"his_her\", \"gender\"];	\n	var genderIndex;\n	for (genderIndex in genderKeys) {\n		cache.addMapping({ name: genderKeys[genderIndex], values: [\"sex\"]});\n	}\n	cache.addMapping({name: \"sex\", values: [\"sex\"], storeInCacheHandler: populateGenderInfo});\n	\n	function isGenderLookup(key) {\n		var y;\n		for (y in genderKeys) { if (genderKeys[y] == key) { return true; } }\n		return false;\n	}\n	\n	function populateGenderInfo(key, val){\n		if (val == \'F\') {\n			cache.put(\"sex\", \"F\");\n			cache.put(\"he_she\", \"she\");\n			cache.put(\"his_her\", \"her\");\n			cache.put(\"gender\", \"female\");				\n		}\n		else {\n			cache.put(\"sex\", \"M\");\n			cache.put(\"he_she\", \"he\");\n			cache.put(\"his_her\", \"him\");\n			cache.put(\"gender\", \"male\");				\n		}\n	}\n	\n	function Start() {\n		\n			$.ajax({\n				url : \"efmformrtl_templates.jsp\",\n				success : function(data) {\n					$(\"#template\").html(data);\n					loadDefaultTemplate();\n				}\n			});\n	\n			$(\".cacheInit\").each(function() { \n				cache.put($(this).attr(\'name\'), $(this).val());\n				$(this).remove();				\n			});\n			\n			// set eventlistener for the iframe to flag changes in the text displayed \n			var agent = navigator.userAgent.toLowerCase(); //for non IE browsers\n			if ((agent.indexOf(\"msie\") == -1) || (agent.indexOf(\"opera\") != -1)) {\n				document.getElementById(cfg_editorname).contentWindow\n						.addEventListener(\'keypress\', setDirtyFlag, true);\n			}\n				\n			// set the HTML contents of this edit control from the value saved in Oscar (if any)\n			var contents = document.getElementById(\'Letter\').value\n			if (contents.length == 0) {\n				parseTemplate();\n			} else {\n				seteditControlContents(cfg_editorname, contents);\n			}\n	}\n\n	function htmlLine(text) {\n		return text.replace(/\\r?\\n/g,\"<br>\");\n	}\n\n	function genericLetterhead() {\n		// set the HTML contents of the letterhead\n		var address = \'<table border=0><tbody><tr><td><font size=6>\'\n				+ cache.get(\'clinic_name\')\n				+ \'</font></td></tr><tr><td><font size=2>\'\n				+ cache.get(\'doctor_contact_addr\')\n				+ \' Fax: \' + cache.get(\'doctor_contact_fax\')\n				+ \' Phone: \' + cache.get(\'doctor_contact_phone\')\n				+ \'</font><hr></td></tr></tbody></table><br>\';\n		\n		return address;\n	}\n\n	function fhtLetterhead() {\n		// set the HTML contents of the letterhead using FHT colours\n		var address = cache.get(\'clinic_addressLineFull\')\n				+ \'<br>Fax:\' + cache.get(\'clinic_fax\')\n				+ \' Phone:\' + cache.get(\'clinic_phone\');\n		if (cache.contains(\"doctor\") && cache.get(\'doctor\').indexOf(\'zapski\') > 0) {\n			address = \'293 Meridian Avenue, Haileybury, ON P0J 1K0<br> Tel 705-672-2442 Fax 705-672-2384\';\n		}\n		address = \'<table style=\\\'text-align: right;\\\' border=\\\'0\\\'><tbody><tr style=\\\'font-style: italic; color: rgb(71, 127, 128);\\\'><td><font size=\\\'+2\\\'>\'\n				+ cache.get(\'clinic_name\')\n				+ \'</font> <hr style=\\\'width: 100%; height: 3px; color: rgb(212, 118, 0); background-color: rgb(212, 118, 0);\\\'></td> </tr> <tr style=\\\'color: rgb(71, 127, 128);\\\'> <td><font size=\\\'+1\\\'>Family Health Team<br> &Eacute;quipe Sant&eacute; Familiale</font></td> </tr> <tr style=\\\'color: rgb(212, 118, 0); \\\'> <td><small>\'\n				+ address + \'</small></td> </tr> </tbody> </table>\';\n		return address;\n	}\n\n	var formIsRTL = true;\n\n</script>\n\n<!-- END OF EDITCONTROL CODE -->\n\n\n<form method=\"post\" action=\"\" name=\"RichTextLetter\" >\n\n<textarea name=\"Letter\" id=\"Letter\" style=\"width:600px; display: none;\"></textarea>\n\n<div class=\"DoNotPrint\" id=\"control3\" style=\"position:absolute; top:20px; left: 860px;\">\n\n<!-- Letter Head -->\n<input type=\"button\" class=\"butn\" name=\"AddLetterhead\" id=\"AddLetterhead\" value=\"Letterhead\" onclick=\"printKey(\'letterhead\');\">\n<br>\n\n<!-- Referring Block -->\n<input type=\"button\" class=\"butn\" name=\"AddReferral\" id=\"AddReferral\" value=\"Referring Block\" onclick=\"printKey(\'_ReferringBlock\');\">\n<br>\n\n<!-- Patient Block -->\n<input type=\"button\" class=\"butn\" name=\"AddLabel\" id=\"AddLabel\" value=\"Patient Block\" onclick=\"printKey(\'label\');\">\n<br>\n<br> \n\n<!-- Social History -->\n<input type=\"button\" class=\"butn\" name=\"AddSocialFamilyHistory\" value=\"Social History\" onclick=\"var hist=\'_SocialFamilyHistory\';printKey(hist);\">\n<br>\n\n<!--  Medical History -->\n<input type=\"button\"  class=\"butn\" name=\"AddMedicalHistory\" value=\"Medical History\" width=30 onclick=\"printKey(\'medical_history\'); \">\n<br>\n\n<!--  Ongoing Concerns -->\n\n<input type=\"button\" class=\"butn\" name=\"AddOngoingConcerns\" value=\"Ongoing Concerns\" onclick=\"var hist=\'ongoingconcerns\'; printKey(hist);\">\n<br>\n\n<!-- Reminders -->\n<input type=\"button\" class=\"butn\" name=\"AddReminders\" value=\"Reminders\"\n	onclick=\"var hist=\'reminders\'; printKey(hist);\">\n<br>\n\n<!-- Allergies -->\n<input type=\"button\" class=\"butn\" name=\"Allergies\" id=\"Allergies\" value=\"Allergies\" onclick=\"printKey(\'allergies_des\');\">\n<br>\n\n<!-- Prescriptions -->\n<input type=\"button\" class=\"butn\" name=\"Medlist\" id=\"Medlist\" value=\"Prescriptions\"	onclick=\"printKey(\'druglist_trade\');\">\n<br>\n\n<!-- Other Medications -->\n<input type=\"button\" class=\"butn\" name=\"OtherMedicationsHistory\" value=\"Other Medications\" onclick=\"printKey(\'other_medications_history\'); \">\n\n<br>\n\n<!-- Risk Factors -->\n<input type=\"button\" class=\"butn\" name=\"RiskFactors\" value=\"Risk Factors\" onclick=\"printKey(\'riskfactors\'); \">\n<br>\n\n<!-- Family History -->\n<input type=\"button\" class=\"butn\" name=\"FamilyHistory\" value=\"Family History\" onclick=\"printKey(\'family_history\'); \">\n<br>\n<br>\n\n<!-- Patient Name --> \n<input type=\"button\" class=\"butn\" name=\"Patient\" value=\"Patient Name\" onclick=\"printKey(\'first_last_name\');\">\n<br>\n\n<!-- Patient Age -->\n<input type=\"button\" class=\"butn\" name=\"PatientAge\" value=\"Patient Age\" onclick=\"var hist=\'ageComplex\'; printKey(hist);\">\n\n<br>\n\n<!-- Patient Label -->\n<input type=\"button\" class=\"butn\" name=\"label\" value=\"Patient Label\" onclick=\"hist=\'label\';printKey(hist);\">\n<br>\n\n<input type=\"button\" class=\"butn\" name=\"PatientSex\" value=\"Patient Gender\" onclick=\"printKey(\'sex\');\">\n<br>\n<br>\n\n<!-- Closing Salutation -->\n<input type=\"button\" class=\"butn\" name=\"Closing\" value=\"Closing Salutation\" onclick=\"printKey(\'_ClosingSalutation\');\">\n<br>\n\n<!--  Current User -->\n<input type=\"button\" class=\"butn\" name=\"User\" value=\"Current User\" onclick=\"var hist=\'current_user\'; printKey(hist);\">\n<br>\n\n<!-- Attending Doctor -->\n<input type=\"button\" class=\"butn\" name=\"Doctor\" value=\"Doctor (MRP)\" onclick=\"var hist=\'doctor\'; printKey(hist);\">\n<br>\n<br>\n\n</div>\n\n\n<div class=\"DoNotPrint\" >\n<input onclick=\"viewsource(this.checked)\" type=\"checkbox\">\nHTML Source\n<input onclick=\"usecss(this.checked)\" type=\"checkbox\">\nUse CSS\n	<table><tr><td>\n		 Subject: <input name=\"subject\" id=\"subject\" size=\"40\" type=\"text\">		 \n	 </td></tr></table>\n\n \n <div id=\"signatureInput\">&nbsp;</div>\n\n <div id=\"faxControl\">&nbsp;</div>\n \n<br>\n\n<input value=\"Submit\" name=\"SubmitButton\" type=\"submit\" onclick=\"needToConfirm=false;document.getElementById(\'Letter\').value=editControlContents(\'edit\');  document.RichTextLetter.submit()\">\n<input value=\"Print\" name=\"PrintSaveButton\" type=\"button\" onclick=\"document.getElementById(\'edit\').contentWindow.print();needToConfirm=false;document.getElementById(\'Letter\').value=editControlContents(\'edit\');  setTimeout(\'document.RichTextLetter.submit()\',1000);\">\n<input value=\"Reset\" name=\"ResetButton\" type=\"reset\">\n<input value=\"Print\" name=\"PrintButton\" type=\"button\" onclick=\"document.getElementById(\'edit\').contentWindow.print();\">\n\n\n    	</div>\n\n</form>\n\n</body></html>','0');


alter table ProviderPreference add column encryptedMyOscarPassword varbinary(255);

CREATE TABLE `PrintResourceLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  resourceName varchar(100) NOT NULL,
  resourceId varchar(50) NOT NULL,
  dateTime timestamp not null,
  providerNo varchar(10),
  externalLocation varchar(200),
  externalMethod varchar(100),
  PRIMARY KEY (`id`)
);

ALTER TABLE `RemoteIntegratedDataCopy` DROP KEY `RIDopy_demo_dataT_sig_fac_arch`, ADD KEY `RIDopy_demo_dataT_sig_fac_arch` (`demographic_no`,`datatype`(165),`signature`(165),`facilityId`,`archived`);

ALTER TABLE `drugReason` DROP KEY `codingSystem`, ADD KEY `codingSystem` (`codingSystem`(30),`code`(30));

CREATE TABLE `eyeform_macro_def` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `macroName` varchar(255),
  `lastUpdated` datetime,
  `copyFromLastImpression` tinyint(1),
  `impressionText` text,
  `planText` text,
  PRIMARY KEY (`id`)
);

CREATE TABLE `eyeform_macro_billing` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `macroId` int(11),
  `billingServiceCode` varchar(50),
  `multiplier` double,
  PRIMARY KEY (`id`)
);

INSERT INTO `issue` (`code`, `description`, `role`, `update_date`, `priority`, `type`)
VALUES
	('eyeformFollowUp', 'Follow-Up Item for Eyeform', 'nurse', NOW(), NULL, 'system'),
	('eyeformCurrentIssue', 'Current Presenting Issue Item for Eyeform', 'nurse', NOW(), NULL, 'system'),
	('eyeformPlan', 'Plan Item for Eyeform', 'nurse', NOW(), NULL, 'system'),
	('eyeformImpression', 'Impression History Item for Eyeform', 'nurse', NOW(), NULL, 'system'),
	('eyeformProblem', 'Problem List Item for Eyeform', 'nurse', NOW(), NULL, 'system');

