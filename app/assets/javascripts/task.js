$(function(){
	$('body').on('click', '.task-item', function(){
		var id_task = $(this).data('id-task');
		var url = window.location.pathname + '/tasks/' + id_task;

		$.ajax({
			url: url,
			type: 'GET',
			dataType: 'JSON'
		})
		.done(function(data) {
			$('body .modal-body').html(data.task);
		});
	});

	$('body').on('click', '.btn-save-description', function(event){
		event.preventDefault();
		var id_task = $('#task_id').val();
		var url = window.location.pathname + '/tasks/' + id_task;
		var description = $('.form-description-task').val();
		$.ajax({
			url: url,
			type: 'PUT',
			dataType: 'JSON',
			data: {task: {description: description}}
		})
		.done(function(data) {
			$('.form-description-task').val(data.task.description);
			$('.description-task').html(data.task.description);
			$('body .show-description-task').click();
		});
	});
});