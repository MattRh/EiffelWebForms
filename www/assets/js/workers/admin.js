function escape(text) {
	var entityMap = {
		'&': '&amp;',
		'<': '&lt;',
		'>': '&gt;',
		'"': '&quot;',
		"'": '&#39;',
		'/': '&#x2F;',
		'`': '&#x60;',
		'=': '&#x3D;'
	};

	return String(text).replace(/[&<>"'`=\/]/g, function(s) {
		return entityMap[s];
	});
}

function prepare(text) {
	return escape(text).replace(/(\\n)+/g, "<br>");
}

$(function() {

	$('.show_pass').hover(function() {
		$(this).siblings('input[type="password"]').attr('type', 'text');
	}, function() {
		$(this).siblings('input[type="text"]').attr('type', 'password');
	});

})