class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :chatrooms, through: :memberships
  has_many :messages, dependent: :destroy

  validates :display_name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 20 }

  def member_of?(chatroom)
    chatrooms.include?(chatroom)
  end
end
