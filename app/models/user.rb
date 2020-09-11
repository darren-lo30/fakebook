class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  validates :first_name, :last_name, :username, presence: true
  validates :username, uniqueness: true

  #Setting up friend relations
  #Friends where the user requested to be friends with
  has_many :friendships, dependent: :destroy
  has_many :user_requested_friends, through: :friendships, source: :friend

  #Friends where the friend requested to be friends with the user
  has_many :inverse_friendships, foreign_key: :friend_id, class_name: "Friendship", dependent: :destroy
  has_many :friend_requested_friends, through: :inverse_friendships, source: :user
  
  #Posts
  has_many :posts, foreign_key: "poster_id"

  def friends
    user_requested_friends + friend_requested_friends
  end
end
