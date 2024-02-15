class OfflineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "OfflineChannel"
  end

  def unsubscribed
  end
end
