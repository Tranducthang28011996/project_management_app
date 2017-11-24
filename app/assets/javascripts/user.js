$(function(){
	$('#user_avatar').on('change', function(event) {
		event.preventDefault();
		$(this).closest('form').submit();
	});
});