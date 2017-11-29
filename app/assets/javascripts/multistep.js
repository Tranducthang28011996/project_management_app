$(function(){
	$('body').on('click', '.next-step', function(event) {
		event.stopPropagation();
		var next_step = '.step-' + $(this).data('change-window');
		var parent = $(this).closest('.multi-dropdown');

		parent.find('.main').removeClass('main');
		parent.find(next_step).addClass('main');
	});

	$('body').on('click', '.pop-over-header-back-btn', function(event) {
		event.stopPropagation();
		var parent = $(this).closest('.multi-dropdown');

		parent.find('.main').each(function() {
			$(this).removeClass('main')
		});;
		parent.find('.step-1').addClass('main');
	});

	$('body').on('click', '.pop-over-header-close-btn', function(event) {
		event.stopPropagation();
		var parent = $(this).closest('.dropdown-menu');
		parent.click();

		parent.find('.main').each(function() {
			$(this).removeClass('main')
		});;

		parent.find('.step-1').addClass('main');
	});

});