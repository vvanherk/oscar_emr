function display(action, id) {
	if (action == 'show') {
		document.getElementById("explanation"+id).style.display = "block";
		document.getElementById("link"+id).href= "javascript:display('hide', "+id+")";
		document.getElementById("link"+id).innerHTML = "Close";
	}
	
	if (action == 'hide') {
		document.getElementById("explanation"+id).style.display = "none";
		document.getElementById("link"+id).href= "javascript:display('show', "+id+")";
		document.getElementById("link"+id).innerHTML = "Explain";
	}  
}
