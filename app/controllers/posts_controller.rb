class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :verify_user_is_post_author, only: [:edit, :update, :destroy]

  def index
    @posts = User.find(params[:user_id]).posts
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    else
      flash[:warning] = "Unable to save"
      rediect_to home_index_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Succesfully updated the post"
      redirect_to home_index_path
    else
      flash.now[:warning] = "Unable to update the post"
      render :edit
    end

  end

  def destroy
    @post.destroy

    flash[:danger] = "Deleted the post!"
    redirect_to home_index_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end

  def verify_user_is_post_author
    unless current_user == @post.author
      flash[:danger] = "Can not modify someone else's post!"
      redirect_to home_index_path
    end
  end
end
