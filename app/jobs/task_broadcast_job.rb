class TaskBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast "task_channel", status: message.status.name,
      message: render_template(message), object_id: message.id,
      project_id: message.project_id, user_id: message.creator_id
  end

  private

  def render_template object
    ApplicationController.renderer.render partial: "tasks/item_task",
      locals: {task: object}
  end
end
