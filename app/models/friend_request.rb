class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"

  validate :check_uniqueness, :check_if_already_friends

  #Finds friend request from two user ids
  def self.find_friend_request(user1_id, user2_id)
    FriendRequest.where("requester_id = ? and requestee_id = ?", user1_id, user2_id).or(Friendship.where("requester_id = ? and requestee_id = ?", user2_id, user1_id)).first
  end

  private 
  #Checks that the friend request is unique both ways
  #Ensures user has not sent request to friend already, or friend has not sent request to user already
  def check_uniqueness
    unless FriendRequest.find_friend_request(requester_id, requestee_id).nil? 
      errors.add(:base, "There is already a pending friend request to that user")
    end
  end

  #Checks that the two users are not already friends
  def check_if_already_friends
    unless Friendship.find_friendship(requester_id, requestee_id).nil?
      errors.add(:base, "You are already friends with this user")
    end
  end
end
