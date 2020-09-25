class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  
  def self.find_friendship(user1, user2)
    Friendship.where("user_id = ? and friend_id = ?", user1.id, user2.id).or(Friendship.where("user_id = ? and friend_id = ?", user2.id, user1.id)).first
  end
end
