# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Chatroom.destroy_all
Membership.destroy_all
Message.destroy_all

user = User.create(
  email: 'test1@example.com',
  password: 'passw0rd',
  display_name: 'Test user 1'
)

puts "Test user 1 has been set up with #{user.email} / #{user.password}"

user2 = User.create(
  email: 'test2@example.com',
  password: 'passw0rd',
  display_name: 'Test user 2'
)

puts "Test user 2 has been set up with #{user2.email} / #{user2.password}"

chatroom = Chatroom.create(name: 'chat room 1')

puts "Chatroom #{chatroom.name} has been set up"

mem1 = Membership.create(user: user, chatroom: chatroom)

puts "#{mem1.user.display_name} has join #{mem1.chatroom.name}"

mem2 = Membership.create(user: user2, chatroom: chatroom)

puts "#{mem2.user.display_name} has join #{mem2.chatroom.name}"

message = Message.create(user: user, chatroom: chatroom, content: 'hello world')

puts "User #{message.user.display_name} has said #{message.content}"

message2 = Message.create(user: user2, chatroom: chatroom, content: 'hello world')
puts "User #{message2.user.display_name} has said #{message2.content}"
