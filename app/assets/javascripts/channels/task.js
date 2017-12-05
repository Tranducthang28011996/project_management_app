App.cable.subscriptions.create("TaskChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    if ($('#project_id').val() == data.project_id && $('#current_user').val() != data.user_id) {
      $('body .task-item[data-id-task=' + data.object_id + ']').remove();
      $('body .task-board[data-status-request=' + data.status + ']').prepend(data.message);
    }
  },
});
