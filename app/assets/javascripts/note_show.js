$(function() {
  var text = $("#render_div").html();
  text = convertTextToMathJaxReady(text);
  $("#render_div").html(text);
  MathJax.Hub.queue.Push(["Typeset", MathJax.Hub, "render_div"]);
});