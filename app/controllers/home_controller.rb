class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = current_user.posts.build
  end
end
