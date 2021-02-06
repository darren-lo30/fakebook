class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_parent, only: :create

  def create
    @like = @parent.likes.build(user_id: current_user.id)
    if @like.save
      respond_to do |format|
        format.js
      end
    else 
    end

  end

  def destroy
    like = Like.find(params[:id])
    @parent = like.likeable
    like.destroy

    respond_to do |format|
      format.js
    end
  end
end
