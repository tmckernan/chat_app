class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :content, presence: true, length: { maximum: 1000 }

  after_create_commit { chat_message }

  def chat_message
    broadcast_append_to "chatroom_#{chatroom.id}_messages",
                          target: "messages",
                                  partial: "messages/message",
                                  locals: { message: self }
  end
end
