class ActivityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "activity_channel"
    # stream_from "task_channel_#{params['chat_room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
