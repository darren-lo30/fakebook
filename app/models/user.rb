class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #setting up friends
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, foreign_key: :friend_id, class_name: "Friendship"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  def all_friends
    friends.or(inverse_friends)
  end
end
