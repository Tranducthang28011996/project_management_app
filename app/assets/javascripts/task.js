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

  $('body').on('click', '.btn-edit-task', function(event){
    event.stopPropagation();
    alert(1);
  });

  $('body').on('change', '.checked-task', function(event) {
    event.preventDefault();
    var id_label = $(this).closest('.item-label-modal').data('label-id');
    var id_task = $('#task_id').val();
    var checked;
    if ($(this).is(':checked') == true) {
      checked = 'checked';
    } else {
      checked = 'unchecked';
    }
    var url = '/update-label/' + id_task
    $.ajax({
      url: url,
      type: 'PATCH',
      dataType: 'JSON',
      data: {task: {label_id: id_label, checked: checked}},
    })
    .done(function(data) {
      $('body .block-label-modal').html(data.data.label_in_modal);
      $('body #block-label-item-task-' + data.data.task_id).html(data.data.label_in_show_project);
    });    
  });
});