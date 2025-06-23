class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :user_id, uniqueness: { scope: :chatroom_id, message: "is already a member of this chatroom" }

  after_create_commit { broadcast_append_to "chatroom_#{chatroom.id}_members", target: "chatroom_#{chatroom.id}_members_list", partial: "chatrooms/member", locals: { user: user } }
  after_destroy_commit { broadcast_remove_to "chatroom_#{chatroom.id}_members", target: "member_#{user.id}" }
end
