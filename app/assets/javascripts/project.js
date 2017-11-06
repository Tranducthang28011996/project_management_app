$(document).ready(function($) {
  $('.btn-create-new-project').on('click', function(e){
    e.preventDefault();
    $('.form-create-project').show();
  });

  $('.step-menu .close-icon').on('click', function(e){
    e.preventDefault();
    $('.step-menu.form-create-project').hide();
  });

  $('.form-create-project .back-icon').on('click', function(e){
    e.preventDefault();
    $(this).closest('.form-create-project').hide();
  });

  $('.footer-board a').on('click', function(event) {
    event.preventDefault();
    $(this).hide();
    $(this).closest('.task-board').find('.item-new-task').show();
    $(this).closest('.item-board').scrollTop($(this).closest('.item-board').height());
  });

  $('.btn-close-form-new-task').on('click', function(event) {
    event.preventDefault();
    $(this).closest('.task-board').find('.item-new-task').hide();
    $(this).closest('.task-board').find('.footer-board a').show();
  });

  $('body').on('click', '.btn-add-task', function(event) {
    event.preventDefault();
    var url = $(this).closest('form').attr('action');
    var status = $(this).closest('.item-board').data('type-task');
    var task_name = $(this).closest('form').find('#task_name').val();
    var position = $(this).closest('.item-board');
    var status_id;

    switch(status) {
      case "new": status_id = 1;
        break;
      case "in_process": status_id =2;
        break;
      case "resolved": status_id = 3;
        break;
      case "testing": status_id = 4;
        break;
      case "done": status_id = 5;
        break;
    }

    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'JSON',
      data: {task: {status_id: status_id, name: task_name}},
    })
    .done(function(data) {
      position.find('.footer-board').before(data.task);
      // position.find('.task-board').append();
      position.find('.item-new-task').hide();
      position.find('.footer-board a').show();
    })
  });
});