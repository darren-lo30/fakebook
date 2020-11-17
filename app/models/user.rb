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
  has_many :posts, foreign_key: :author_id

  #Friend requests
  has_many :sent_friend_requests, foreign_key: :requester_id, class_name: "FriendRequest", dependent: :destroy
  has_many :received_friend_requests, foreign_key: :requestee_id, class_name: "FriendRequest", dependent: :destroy

  has_many :outgoing_requested_friends, through: :sent_friend_requests, source: :requestee
  has_many :incoming_requested_friends, through: :received_friend_requests, source: :requester

  #Likes
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  #Comments
  has_many :comments, foreign_key: :commenter_id, dependent: :destroy

  #Profile picture
  has_one_attached :profile_picture

  def friends
    user_requested_friends + friend_requested_friends
  end

  def get_like_on_post(post_id)
    return likes.find_by(likeable_id: post_id, likeable_type: "Post")
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
