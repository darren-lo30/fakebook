# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
User.create(first_name: "John", last_name: "Smith", username: "js", email: "john_smith@gmail.com", password: "test123", password_confirmation: "test123")
User.create(first_name: "Donald", last_name: "Smith", username: "ds", email: "donald_smith@gmail.com", password: "test12345", password_confirmation: "test12345")
Friendship.create(user_id: User.first.id, friend_id: User.second.id)