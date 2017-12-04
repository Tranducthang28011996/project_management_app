App.cable.subscriptions.create("ActivityChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    $('.list-activity-menu').prepend(data.message)
  },
});
