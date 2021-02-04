class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :verify_user_is_author, only: [:edit, :update, :destroy]

  def index
      @post = current_user.posts.build
      user_ids = current_user.friends.pluck(:id) << current_user.id
    @feed_posts = Post.where(author_id: user_ids)
  end

  def show
    @comment = current_user.comments.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    else
      flash[:warning] = "Unable to save"
      rediect_to root_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Succesfully updated the post"
      redirect_to root_path
    else
      flash.now[:warning] = "Unable to update the post"
      render :edit
    end

  end

  def destroy
    @post.destroy

    flash[:danger] = "Deleted the post!"
    redirect_to root_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:body)
  end

  #Ensures that the user is the author the post
  def verify_user_is_author
    unless current_user == @post.author
      flash[:danger] = "Can not modify someone else's post!"
      redirect_to root_path
    end
  end
end
