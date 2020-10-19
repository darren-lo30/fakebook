class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.build(post_id: @post.id)
    if like.save
      @like_id = like.id
      respond_to do |format|
        format.js
      end
    else 
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    Like.destroy(params[:id])
    
    respond_to do |format|
      format.js
    end
  end
  

end
