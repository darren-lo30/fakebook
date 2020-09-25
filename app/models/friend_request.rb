class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"

  validate :check_user_uniqueness, :check_friend_request_redundancy
  
  private 
  #Checks that the friend request is unique both ways
  #Ensures user has not sent request to friend already, or friend has not sent request to user already
  def check_user_uniqueness

  end

  #Checks that the two users are not already friends
  def check_friend_request_redundancy
  end
end
