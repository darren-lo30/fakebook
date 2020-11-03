class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: :destroy
  before_action :verify_user_is_author, only: :destroy

  def create
    comment = current_user.comments.build(comment_params)
    comment.post_id = params[:post_id]
    
    if comment.save
      flash[:success] = "Comment posted"
    else
      flash[:warning] = "Comment could not be posted"
    end

    redirect_to post_path(Post.find(params[:post_id]))
  end

  def destroy
    Comment.destroy(@comment)
    flash[:danger] = "Deleted the comment"
    
    redurect_to :back
  end

  private
  
  def comment_params
    params.require(:post).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  #Ensures that the user is the author of the comment
  def verify_user_is_author
    unless current_user == @comment.author
      flash[:danger] = "Can not modify someone else's post!"
      redirect_to home_index_path
    end
  end
end
