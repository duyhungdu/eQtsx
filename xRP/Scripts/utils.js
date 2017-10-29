/* $Id : utils.js 5052 2007-02-03 10:30:13Z weberliu $ */

var Browser = new Object();

Browser.isMozilla = (typeof document.implementation != 'undefined') && (typeof document.implementation.createDocument != 'undefined') && (typeof HTMLDocument != 'undefined');
Browser.isIE = window.ActiveXObject ? true : false;
Browser.isFirefox = (navigator.userAgent.toLowerCase().indexOf("firefox") != -1);
Browser.isSafari = (navigator.userAgent.toLowerCase().indexOf("safari") != -1);
Browser.isOpera = (navigator.userAgent.toLowerCase().indexOf("opera") != -1);

var Utils = new Object();

Utils.htmlEncode = function (text) {
	return text.replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

Utils.trim = function (text) {
	if (typeof (text) == "string") {
		return text.replace(/^\s*|\s*$/g, "");
	}
	else {
		return text;
	}
}

Utils.isNumeric = function (num) {
    return !isNaN(num)
}

// Validates that the input string is a valid date formatted as "mm/dd/yyyy"
Utils.isValidDate = function (dateString) {
    // First check for the pattern
    if (!/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(dateString))
        return false;

    // Parse the date parts to integers
    var parts = dateString.split("/");
    var day = parseInt(parts[1], 10); //  
    var month = parseInt(parts[0], 10);
    var year = parseInt(parts[2], 10);

    // Check the ranges of month and year
    if (year < 1000 || year > 3000 || month == 0 || month > 12)
        return false;

    var monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    // Adjust for leap years
    if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
        monthLength[1] = 29;

    // Check the range of the day
    return day > 0 && day <= monthLength[month - 1];
}

Utils.isEmpty = function (val) {
	switch (typeof (val)) {
		case 'string':
			return Utils.trim(val).length == 0 ? true : false;
			break;
		case 'number':
			return val == 0;
			break;
		case 'object':
			return val == null;
			break;
		case 'array':
			return val.length == 0;
			break;
		default:
			return true;
	}
}

Utils.isNumber = function (val) {
	var reg = /^[\d|\.|,]+$/;
	return reg.test(val);
}

Utils.isInt = function (val) {
	if (val == "") {
		return false;
	}
	var reg = /\D+/;
	return !reg.test(val);
}

Utils.isEmail = function (email) {
	var reg1 = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)/;

	return reg1.test(email);
}

Utils.isTel = function (tel) {
	var reg = /^[\d|\-|\s|\_]+$/; //只允许使用数字-空格等

	return reg.test(tel);
}

Utils.fixEvent = function (e) {
	var evt = (typeof e == "undefined") ? window.event : e;
	return evt;
}

Utils.srcElement = function (e) {
	if (typeof e == "undefined") e = window.event;
	var src = document.all ? e.srcElement : e.target;

	return src;
}

Utils.isTime = function (val) {
	var reg = /^\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}$/;

	return reg.test(val);
}

Utils.x = function (e) { //当前鼠标X坐标
	return Browser.isIE ? event.x + document.documentElement.scrollLeft - 2 : e.pageX;
}

Utils.y = function (e) { //当前鼠标Y坐标
	return Browser.isIE ? event.y + document.documentElement.scrollTop - 2 : e.pageY;
}

Utils.request = function (url, item) {
	var sValue = url.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
	return sValue ? sValue[1] : sValue;
}

Utils.$ = function (name) {
	return document.getElementById(name);
}
 
function rowindex(tr) {
	if (Browser.isIE) {
		return tr.rowIndex;
	}
	else {
		table = tr.parentNode.parentNode;
		for (i = 0; i < table.rows.length; i++) {
			if (table.rows[i] == tr) {
				return i;
			}
		}
	}
}

document.getCookie = function (sName) {
	// cookies are separated by semicolons
	var aCookie = document.cookie.split("; ");
	for (var i = 0; i < aCookie.length; i++) {
		// a name/value pair (a crumb) is separated by an equal sign
		var aCrumb = aCookie[i].split("=");
		if (sName == aCrumb[0])
			return decodeURIComponent(aCrumb[1]);
	}

	// a cookie with the requested name does not exist
	return null;
}

document.setCookie = function (sName, sValue, sExpires) {
	var sCookie = sName + "=" + encodeURIComponent(sValue);
	if (sExpires != null) {
		sCookie += "; expires=" + sExpires;
	}

	document.cookie = sCookie;
}

document.removeCookie = function (sName, sValue) {
	document.cookie = sName + "=; expires=Fri, 31 Dec 1999 23:59:59 GMT;";
}

function getPosition(o) {
	var t = o.offsetTop;
	var l = o.offsetLeft;
	while (o = o.offsetParent) {
		t += o.offsetTop;
		l += o.offsetLeft;
	}
	var pos = { top: t, left: l };
	return pos;
}

function cleanWhitespace(element) {
	var element = element;
	for (var i = 0; i < element.childNodes.length; i++) {
		var node = element.childNodes[i];
		if (node.nodeType == 3 && !/\S/.test(node.nodeValue))
			element.removeChild(node);
	}
}