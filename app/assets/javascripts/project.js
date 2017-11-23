$(document).ready(function($) {
  $('body').on('click', '.btn-add-task', function(event) {
    event.preventDefault();
    var url = window.location.pathname + '/tasks';
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
      if (data.status == true) {
        position.find('.position-add-task').before(data.task);
        position.find('.item-new-task').hide();
        position.find('.footer-board a').show();
        $('.connected').sortable({
          connectWith: '.connected'
        });
      } else {
        alert('error')
      }
    })
  });
});

$(function() {
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
});

$(function() {
  $('.connected').sortable({
    connectWith: '.connected',
    placeholder: 'ui-sortable-placeholder',
    receive: function( event, ui ) {
      event.preventDefault();
      var id_task = ui.item.data('id-task');
      var status_task = $(this).data('status-request');
      var url = window.location.pathname + '/tasks/' + id_task;
      console.log(id_task + " " + status_task);

      $.ajax({
        url: url,
        method: 'PATCH',
        dataType: 'JSON',
        data: {task: {status: status_task}},
      })
      .done(function(data) {
        console.log(data);
      })

    }
  });
});

$(function(){
  $('body').on('click', '.icon-close-modal', function() {
    $('.modal').modal('hide');
  });

  $('body').on('click', '.show-description-task', function(){
    $('.description-task').toggle();
  });

  $('.btn-show-menu-project').on('click', function(){
    $('.side-bar-menu-project').toggle();
  });
});

$(function(){
  $('.search-member').keyup(function(event) {
    var key_word = $(this).val();
    $.ajax({
      url: '/users',
      type: 'GET',
      dataType: 'JSON',
      data: {key_word: key_word},
    })
    .done(function(data) {
      console.log(data);
      $('.list-member-result').html(data.list_user);
    });
  });

// add user to team
  $('body').on('click', '.user-item', function(){
    event.stopPropagation();
    var id_user = $(this).data('user-id');
    var team_id = $('#team_id').val();
    var object_user = $(this);

    $.ajax({
      url: '/teams/' + team_id,
      type: 'PUT',
      dataType: 'json',
      data: {user: id_user},
    })
    .done(function(data) {
      if (data.status == 'success'){
        object_user.fadeOut('500');
      }else {
        alert('Not add user for team');
      }
    });    
  });
});