function escapeXss(string) {
  var entityMap = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "/": '&#x2F;'
  };

  return String(string).replace(/[&<>"'\/]/g, function (s) {
    return entityMap[s];
  });
}

function convertTextToMathJaxReady(string) {
  //  This one just append &nbsp to beginning of lines

  if (!string) return "";

  var lines = string.split("\n");
  for (var i = 0; i < lines.length; i++) {
    var d = 0;
    while (d < lines[i].length && lines[i][d] === " ") d++;
    var e = "";
    for (var f = 0; f < d; f++) e += "&nbsp;";
    e != "" && (lines[i] = e + lines[i])
  }
  return lines.join("<br>");
}

$(function () {
  $.fn.extend({
    insertAtCaret: function (myValue) {
      return this.each(function (i) {
        if (document.selection) {
          //For browsers like Internet Explorer
          this.focus();
          sel = document.selection.createRange();
          sel.text = myValue;
          this.focus();
        }
        else if (this.selectionStart || this.selectionStart == '0') {
          //For browsers like Firefox and Webkit based
          var startPos = this.selectionStart;
          var endPos = this.selectionEnd;
          var scrollTop = this.scrollTop;
          this.value = this.value.substring(0, startPos) + myValue + this.value.substring(endPos, this.value.length);
          this.focus();
          this.selectionStart = startPos + myValue.length;
          this.selectionEnd = startPos + myValue.length;
          this.scrollTop = scrollTop;
        } else {
          this.value += myValue;
          this.focus();
        }
      })
    }
  });

});

$.fn.selectRange = function (start, end) {
  return this.each(function () {
    if (this.setSelectionRange) {
      this.focus();
      this.setSelectionRange(start, end);
    } else if (this.createTextRange) {
      var range = this.createTextRange();
      range.collapse(true);
      range.moveEnd('character', end);
      range.moveStart('character', start);
      range.select();
    }
  });
};