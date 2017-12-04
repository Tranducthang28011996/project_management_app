class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast 'activity_channel', message: render_template(message)
  end

  private

  def render_template object
    ApplicationController.renderer.render partial: 'activities/activity',
      locals: {activity: object}
  end
end
