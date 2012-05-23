$(function () {
	var $code = $("#codearea");

	$code.keyup(render);

	$code.keydown(function(e) {
		if (e.which === 9) { // tab key
			xxx("  ");
			e.preventDefault();
		}
	} );

	function xxx(x) {
		x = " " + x + " ";
		$code.insertAtCaret(x);
		render();
		$code[0].focus();
	}

	$("#manual li").click( function() {
		var x = $(this).find('textarea').val();
		xxx(x);
	});

	$("#ins-inline").click( function() {
		xxx(" $ a + b $ ");
	});
	$("#ins-block").click( function() {
		xxx("\n$$\na + b\n$$");
	});
});

function render() {
	var text = $("#codearea").val();
	text = convertTextToMathJaxReady(text);
	$("#preview_div").html(text);
	MathJax.Hub.queue.Push(["Typeset", MathJax.Hub, "preview_div"]);
}
function addExample() {
	$("#codearea").val($("#example").val());
	render();
}
function clearInput() {
	$("#codearea").val("");
	$("#codearea").focus();
	render();
}