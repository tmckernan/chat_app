class Chatroom < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }

  after_create_commit { broadcast_append_to "chatrooms" }
  after_update_commit { broadcast_replace_to "chatrooms" }
  after_destroy_commit { broadcast_remove_to "chatrooms" }
end
