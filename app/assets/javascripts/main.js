jQuery(document).ready(function($) {
	$(document).foundation();

	$('.star').on('click', function() {
		$(this).toggleClass('voted');
	});
});