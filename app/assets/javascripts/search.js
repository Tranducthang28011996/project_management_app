$(document).ready(function() {
  show_task_detail();

  $('body').on('click', '.btn-search', function() {
    var keyword = $(this).parents('.form-search-project').find('.search-input').val();

    if (keyword && keyword != null) {
      $.ajax({
        url: '/search',
        method: 'GET',
        data: {
          keyword: keyword
        },
        dataType: 'JSON',
        success: function(response) {
          if (response.status) {
            $('.form-search-project .result').html(response.html);
            $('.form-search-project .result').removeClass('hide');
          }
        }
      });
    }
  });

  $('body').on('keypress', '.search-input', function(e) {
    if(e.which == 13) {
      $('.btn-search').click();
    }
  });

  $('body').on('click', '.task-name', function() {
    var project_id = $(this).parents('.task').attr('project-id');
    var task_id = $(this).parents('.task').attr('task-id');

    window.location.href = '/projects/' + project_id + '?task_id=' + task_id;
  });

  $(document).bind('click', function(e) {
    if(!$(e.target).is('.form-search-project, .form-search-project *')) {
      $('.form-search-project .result').addClass('hide');
    }
  });
});

function show_task_detail() {
  var url = new URL(window.location.href);
  var task_id = url.searchParams.get('task_id');

  if (task_id && task_id != null) {
    var url = window.location.pathname + '/tasks/' + task_id;

    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'JSON'
    })
    .done(function(data) {
      $('body .modal-body').html(data.task);
    });
    $('.task-item[data-id-task='+ task_id +']').click();
  }
}