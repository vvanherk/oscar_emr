<%--

    Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
    This software is published under the GPL GNU General Public License.
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

    This software was written for the
    Department of Family Medicine
    McMaster University
    Hamilton
    Ontario, Canada

--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page
	import="oscar.oscarDemographic.data.*,java.util.*,oscar.oscarPrevention.*,oscar.oscarLab.ca.on.*,oscar.util.*,oscar.oscarLab.*,oscar.scratch.*"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/oscar-tag.tld" prefix="oscar"%>
<%@ taglib uri="/WEB-INF/rewrite-tag.tld" prefix="rewrite"%>

<%
   //<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
//    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
//
   ////
  
  //int demographic_no = Integer.parseInt(request.getParameter("demographic_no")); 
  String demographic_no = request.getParameter("demographic_no");  
  String user_no = (String) request.getSession().getAttribute("user");
  
  ScratchData scratchData = new ScratchData();
  Hashtable hashtable = scratchData.getLatest(user_no);
  
  
  String uuid = String.valueOf(System.nanoTime());
  String text = "";
  String id = "";
  
  if (hashtable != null){
      text = (String) hashtable.get("text");
      id   = (String) hashtable.get("id");
  }
  

      
%>




<html:html locale="true">

<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/global.js"></script>
<title>Scratch</title>
<!--I18n-->

<link rel="stylesheet" type="text/css"
	href="../share/css/OscarStandardLayout.css">

<script type="text/javascript" src="../share/javascript/Oscar.js"></script>
<script type="text/javascript" src="../share/javascript/prototype.js"></script>

<script type="text/javascript">
    var dirty = 0; 
    var currentText = "";


    function setDirty(){
        dirty = 1;
        $('dirty').value = 1
        $('savebutton').disabled = '';
        document.title = 'dirty';
    }

    function fixHeightOfTheText(){
        var t = document.getElementById("thetext");
        var h = window.innerHeight ? window.innerHeight : t.parentNode.offsetHeight;
        t.style.height = (h - t.offsetTop - 80) + "px";
    }
    window.onresize = fixHeightOfTheText;

    window.setInterval(autoSave,30000);

    function autoSave(){
        checkScratch()
    }

    ///this function submits the data to the action using ajax. OnComplete the function followUp will be called 
    function checkScratch(){
	var url = "../Scratch.do";
	var data = Form.serialize('scratch'); 
        new Ajax.Request(url, {method: 'post',postBody: data,asynchronous:true,onComplete: followUp}); 
    }

    function followUp(origRequest){
        //alert(origRequest.responseText);
        document.title = document.title + ' 1 ';
        log('top');
        var hash = origRequest.responseText.parseQuery(); 
        var latestId = hash['id'];
        var latestText = hash['text'];
        var windowId = hash['windowId'];
        //alert($F('dirty'));
        log('dirty '+$F('dirty'));
        if ( $F('dirty') == 0 ){
            //alert("curr " + $F('curr_id') + " " + latestId );
            log('dirty == 0');
            if ($F('curr_id') < latestId ){
                log('curr_id was less than latestId');
                //alert("updating with "+latestId+ " "+ decode(latestText));
                $('curr_id').value = latestId; 
                $('thetext').value = decode(latestText);  
            }
            setClean();
        }else{  //bigger probs
            log('dirty == 1 currid '+$F('curr_id')+ ' latestId  '+latestId);
            if ($F('curr_id') < latestId ){
                log('curr_id << latestId');
                if($F('windowId') == windowId ){
                    $('curr_id').value =latestId;
                    log('window ids match');
		    
		    if (latestText==null) latestText="";
                    if ( $F('thetext') == decode(latestText) ){
                        log('should set clean');
                        setClean();
                    }else{
                        log('not setting clean');
                        log($F('thetext'));
                        log(latestText);
                    }
                }else{
                    alert("Concurreny Issue");
                }
            }
        }
   
    }

    function log(val){
        $('log').value = $('log').value +'\n'+ val; 
    }

    function setClean(){
        $('dirty').value = 0;
        dirty = 0;
        $('savebutton').disabled = 'true';
        document.title = 'clean';
	<%-- refresh parent window scratch_pad link --%>
	if (opener.callRefreshTabAlerts) opener.callRefreshTabAlerts("oscar_scratch");
    }

    function decode(str) {
        return unescape(str.replace(/\+/g, " "));
    }

    <%-- Since IE does not capture [BS] & [Del] in onKeypress event, this function takes care of it.--%>
    function catchDel(e) {
	if (window.event) { //Internet Explorer
	    if (e.keyCode==8 || e.keyCode==46) { //[Backspace] or [Delete] pressed
		setDirty();
	    }
	}
    }
    </script>

</head>

<body class="BodyStyle">
<table class="MainTable" id="scrollNumber1">
	<tr class="MainTableTopRow">
		<td class="MainTableTopRowLeftColumn">scratch</td>
		<td class="MainTableTopRowRightColumn">
		<table class="TopStatusBar">
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td style="text-align: right"><oscar:help keywords="pad" key="app.top1"/> | <a
					href="javascript:popupStart(300,400,'About.jsp')"><bean:message
					key="global.about" /></a> | <a
					href="javascript:popupStart(300,400,'License.jsp')"><bean:message
					key="global.license" /></a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="MainTableLeftColumn" valign="top" id="tablelle"
			style="height: 100%"><input type="button"
			onclick="checkScratch()" id="savebutton" value="save" /></td>

		<td valign="top" class="MainTableRightColumn">
		<form id="scratch" action=""><input type="hidden"
			name="providerNo" value="<%=user_no%>" /> <input type="hidden"
			name="id" id="curr_id" value="<%=id%>" /> <input type="hidden"
			name="windowId" id="windowId" value="<%=uuid%>" /> <input
			type="hidden" name="dirty" value="0" id="dirty" /> <textarea
			name="scratchpad" id="thetext" style="width: 100%" rows="50"
			cols="50" onkeypress="javascript: setDirty()"
			onkeydown="javascript: catchDel(event)"><%=text%></textarea> <textarea
			style="display: none;" id="log" rows="100" cols="100"></textarea></form>
		</td>
	</tr>
	<tr>
		<td class="MainTableBottomRowLeftColumn">&nbsp;</td>
		<td class="MainTableBottomRowRightColumn" valign="top">&nbsp;</td>
	</tr>
</table>

<script type="text/javascript">
fixHeightOfTheText(); // fix it first time in.
setClean();
</script>
</body>
</html:html>
