class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.find_friendship(user1_id, user2_id)
    Friendship.where("user_id = ? and friend_id = ?", user1_id, user2_id).or(Friendship.where("user_id = ? and friend_id = ?", user2_id, user1_id)).first
  end
end
