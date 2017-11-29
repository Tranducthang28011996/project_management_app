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
      $('body .btn-date-picker').on('click', function(event) {
        event.stopPropagation();
      });
      $('#datetimepicker1').datetimepicker({
        format: 'YYYY-MM-DD hh:mm:ss'
      });
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
      $('body .list-activity').html(data.list_activities);
    });    
  });

  $('body').on('change', '.tick-user-handle-task input[type=radio][name=assignee]', function(event) {
    event.preventDefault();
    var id_user = $(this).closest('.tick-user-handle-task').data('user-on-list-assign');
    var id_task = $('#task_id').val();
    var checked;
    if ($(this).is(':checked') == true) {
      checked = 'checked';
    } else {
      checked = 'unchecked';
    }
    var url = window.location.pathname + '/tasks/' + id_task;
    $.ajax({
      url: url,
      type: 'PATCH',
      dataType: 'JSON',
      data: {task: {user_id: id_user, checked: checked}},
    })
    .done(function(data) {
      $('body .list-activity').html(data.list_activities);
      $('body .task-avatar-' + data.task.id).html(data.user);
    });    
  });

  $('body').on('click', '.item-member-modal', function(event) {
    event.stopPropagation();
    $(this).find('input[type="radio"]').prop("checked", true);
    $(this).find('input[type="radio"]').change();
  });

  $('body').on('click', '.item-label-modal', function(event) {
    event.stopPropagation();
    $(this).find('input[type="checkbox"]').trigger('click');
    // $(this).find('input[type="checkbox"]').change();
  });

  $('body').on('click', '.close-edit-description', function(event) {
    event.preventDefault();
    $('body .show-description-task').trigger('click');
  });

  $('body').on('click', '.list-member-modal', function(event) {
    event.stopPropagation();
  });

  $('body').on('click', '.change-due-date', function(event) {
    event.preventDefault();
    var task_id = $(this).data('task-id');
    var deadline;
    var check_remove = $(this).hasClass('remove-due-date');
    
    if (check_remove) {
      deadline = null;
    } else {
      deadline = $(this).closest('.form-due-date').find('input[name="deadline"]').val();
    }

    var url = window.location.pathname + '/tasks/' + task_id;
    $.ajax({
      url: url,
      type: 'PATCH',
      dataType: 'json',
      data: {task:{deadline: deadline}},
    })
    .done(function(data) {
      if (check_remove) {
        $('body .block-due-date-modal').html('');
        $('body #block-due-date-task-' + data.task.id).html('');
      } else {
        $('body .block-due-date-modal').html(data.due_date_info);
        $('body #block-due-date-task-' + data.task.id).html(data.due_date_task);
      }
    })
  });

  $('body').on('change', '.title-task', function(event) {
    event.preventDefault();
    var task_id = $('#task_id').val();
    var url = window.location.pathname + '/tasks/' + task_id;
    var name = $(this).val();
    if (name != '') {
      $.ajax({
        url: url,
        type: 'PATCH',
        dataType: 'json',
        data: {task: {name: name}},
      })
      .done(function(data) {
        if (data != undefined) {
          $('body .title-task').val(data.task.name);
          $('body #task-name-' + data.task.id).html(data.task.name);
        } else {
          alert('Vui lòng thử lại cập nhật tên của task');
        }
      })
    }
  });
});

