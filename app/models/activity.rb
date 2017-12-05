class Activity < ApplicationRecord
  attr_accessor :creator

  enum action_type: [
    :add_task,
    :move_task,
    :update_info_task,
    :assign_member,
    :move_member,
    :comment_task
  ]

  after_find :load_creator
  after_create_commit :send_notification

  belongs_to :task
  belongs_to :user

  private

  def load_creator
    @creator = User.find_by id: creator_id
  end

  def send_notification
    load_creator
    ActivityBroadcastJob.perform_later self
  end
end
