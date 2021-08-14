class PagesController < ApplicationController
  def show
    if valid_page?
      render "pages/#{params[:page]}"
    else
      render file: "public/404.html"
    end
  end
  
  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.erb"))
  end
end


