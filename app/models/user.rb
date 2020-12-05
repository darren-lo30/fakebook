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

  #Omniauth
  devise :omniauthable, omniauth_providers: %i[facebook]


  def friends
    user_requested_friends + friend_requested_friends
  end

  def get_like_on_post(post_id)
    return likes.find_by(likeable_id: post_id, likeable_type: "Post")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).or(where(email: auth.info.email)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.username = auth.info.email
      
      #Grabs the profile picture from facebook
      image_link = auth.info.image.split('?').first
      facebook_profile_picture = open(image_link)
      user.profile_picture.attach(io: facebook_profile_picture, filename: 'profile-picture.jpg')
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"]
        user.first_name = data["info"]["first_name"]
        user.last_name = data["info"]["last_name"]
        user.email = data["info"]["email"] if user.email.blank?
      end
    end
  end

end
