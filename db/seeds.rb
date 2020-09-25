# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
User.create(first_name: "Darren", last_name: "Lo", username: "AD", email: "darren_lo@gmail.com", password: "password", password_confirmation: "password")
User.create(first_name: "John", last_name: "Smith", username: "js", email: "john_smith@gmail.com", password: "test123", password_confirmation: "test123")
User.create(first_name: "Donald", last_name: "Smith", username: "ds", email: "donald_smith@gmail.com", password: "test12345", password_confirmation: "test12345")
User.create(first_name: "Jimmy", last_name: "Smith", username: "jms", email: "jimmy_smith@gmail.com", password: "test12345", password_confirmation: "test12345")
User.create(first_name: "Mary", last_name: "Jane", username: "mj", email: "mary_jane@gmail.com", password: "test12345", password_confirmation: "test12345")


Friendship.create(user_id: User.first.id, friend_id: User.find_by(first_name: "John").id)
Friendship.create(user_id: User.first.id, friend_id: User.find_by(first_name: "Donald").id)
User.first.received_friend_requests.create(requester_id: User.find_by(first_name: "Jimmy").id)
User.first.sent_friend_requests.create(requestee_id: User.find_by(first_name: "Mary").id)
