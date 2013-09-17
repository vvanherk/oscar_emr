function popupOscarRx(vheight,vwidth,varpage) {
var page = varpage;
windowprops = "height="+vheight+",width="+vwidth+",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=yes,screenX=0,screenY=0,top=0,left=0";
var popup=window.open(varpage, "oscarRx_appt", windowprops);
if (popup != null) {
if (popup.opener == null) {
popup.opener = self;
}
popup.focus();
}
}