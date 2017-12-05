App.cable.subscriptions.create("ActivityChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    if ($('#project_id').val() == data.project_id) {
      $('.list-activity-menu[data-project-id=' + data.project_id + ']').prepend(data.message);
      $('.modal .list-activity[data-task-id=' + data.task_id + ']').prepend(data.message);
    }
  },
});
