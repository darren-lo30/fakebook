class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_user
  before_action :sanitize_status_param, only: :update
  

  #Show all of the user's friends
  def index
    #Get user's current friends and incoming and outgoing pending friend requests
    @friends = current_user.friends
    @pending_incoming_friends = current_user.incoming_requested_friends
    @pending_outgoing_friends = current_user.outgoing_requested_friends

    @new_people = User.all.select {|u| !(u == current_user || @friends.include?(u) || 
      @pending_incoming_friends.include?(u) || @pending_outgoing_friends.include?(u))}
  end

  #Send a friend request
  def create
    friend_to_add = User.find_by(username: params[:friend_username])
    unless friend_to_add.nil? 
      friend_request = current_user.sent_friend_requests.build(requestee_id: friend_to_add.id)
      if friend_request.save
        flash[:success] = "Succesfully added @#{friend_to_add.username} as a friend!"
      else
        flash[:warning] = friend_request.errors.full_messages.to_sentence
      end
    else
      flash[:warning] = "Could not find a user with that username!"
    end

    redirect_to user_friends_path(current_user)
  end

  #Accept or decline a friend request
  def update
    friend_request = FriendRequest.find(params[:friend_request_id])
    friend = User.find(friend_request.requester_id)
    
    flash_message = "#{params[:status].capitalize} friend request from @#{friend.username}"
    if params[:status] == "accepted"
      #Create the friendship and delete the request
      current_user.inverse_friendships.create(user_id: friend.id)
      flash[:success] = flash_message
    elsif params[:status] == "declined" || params[:status] == "cancelled"
      flash[:danger] = flash_message
    end
    
    friend_request.destroy
    redirect_to user_friends_path(current_user)
  end

  #Remove a friend
  def destroy
    Friendship.destroy(params[:id])
    friend = User.find(params[:friend_id])
    flash[:danger] = "Removed @#{friend.username} as a friend!"
    redirect_to user_friends_path(current_user)
  end

  private
  
  def verify_user
    #Ensure that current user can only affect their own friend records

    if params[:action] == 'destroy'
      #Verify friendship
      friendship = Friendship.find(params[:id])
      redirect_to user_friends_path(current_user) if 
        current_user.id != friendship.friend_id && current_user.id != friendship.user_id
    elsif params[:action] == 'update'
      friend_request = FriendRequest.find(params[:friend_request_id])
      redirect_to user_friends_path(current_user) if 
        current_user.id != friend_request.requester_id && current_user.id != friend_request.requestee_id
    else
      user = User.find_by(id: params[:user_id])
      redirect_to user_friends_path(current_user) if !user || user != current_user
    end
  end
  

  def sanitize_status_param
    #Ensures that the status param used in the update controller is an option
    params.require(:status)
    unless %w[accepted declined cancelled].include? params[:status]
      flash[:warning] = "That is not a valid command!"
      redirect_to user_friends_path(current_user)
    end
  end

end
