class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast 'activity_channel', message: render_template(message),
      project_id: message.project_id, task_id: message.task_id
  end

  private

  def render_template object
    ApplicationController.renderer.render partial: 'activities/activity',
      locals: {activity: object}
  end
end
