function updateCLI(o)
{
	var titleCursor = document.getElementById("titleCursor"); 
	titleCursor.className = "";
	var characterCount = getSelectionStart(o);
	var blink = "";

	for (var i = characterCount; i > 0; i--) 
	{
		blink += "\xa0";
	};

	blink += "_";

	titleCursor.innerHTML = blink;
	//alert(characterCount);
	//o.style.marginLeft = "-"+characterCount/2+"em";

	var timeoutID = window.setTimeout(function () 
	{
		titleCursor.className = "blink";
	}, 2000);
}


function getSelectionStart(o) {
	if (o.createTextRange) {
		var r = document.selection.createRange().duplicate()
		r.moveEnd('character', o.value.length)
		if (r.text == '') return o.value.length
		return o.value.lastIndexOf(r.text)
	} else return o.selectionStart
}