function convertTextToMathJaxReady(a) {
    var b = a.split("\n");
    for (var c = 0; c < b.length; c++) {
        var d = 0;
        while (d < b[c].length && b[c][d] === " ") d++;
        var e = "";
        for (var f = 0; f < d; f++) e += "&nbsp;";
        e != "" && (b[c] = e + b[c])
    }
    var tmp = b.join("<br>");
    return tmp;
}