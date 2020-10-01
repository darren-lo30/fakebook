class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = current_user.posts.build
    user_ids = current_user.friends.pluck(:id) << current_user.id
    @feed_posts = Post.where(author_id: user_ids)
  end
end
