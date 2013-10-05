var $code;
var renderTimeout;

function scheduleRender() {
	if (renderTimeout) {
		window.clearTimeout(renderTimeout);
	}
	renderTimeout = window.setTimeout(render, 500);
}

function render() {
	var text = $code.val();
  var $div = $("#preview_div");
	text = convertTextToMathJaxReady(text);

  var pos = $div.scrollTop();
  $div.html(text);
	MathJax.Hub.queue.Push(["Typeset", MathJax.Hub, "preview_div"]);
  $div.scrollTop(pos);
}

window.newNoteInit = function() {
 	$code = $("#codearea");

 	$code.focus();
 	render();

	$code.keyup(scheduleRender);
	$code.bind('paste', scheduleRender);

	$code.keydown(function(e) {
		if (e.which === 9) { // tab key
			insertSymbol("  ");
			e.preventDefault();
		}
	} );

	function insertSymbol(x) {
		x = " " + x + " ";
		$code.insertAtCaret(x);
		$code[0].focus();
		scheduleRender();
	}

	$("#manual li").click( function() {
		var x = $(this).find('textarea').val();
		insertSymbol(x);
	});

	$("#ins-inline").click( function() {
		$code.surroundSelectedText("\\( ", " \\)");
		scheduleRender();
	});

	$("#ins-block").click( function() {
		$code.surroundSelectedText("\\[\n", "\n\\]");
		scheduleRender();
	});

}

function addExample() {
	$code.val($("#example").val());
	render();
}

function clearInput() {
	$code.val("");
	$code.focus();
	render();
}
