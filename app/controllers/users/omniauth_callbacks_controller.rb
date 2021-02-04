class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :facebook
  
  def facebook
    #Creates a new user or returns user if they are already signed up
    @user = User.from_omniauth(request.env["omniauth.auth"])
  
    if @user.persisted?
      #If the user was found or properly created
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      #If a new user couldnt be created with facebook for some reason
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra)
      flash[:warning] = "Failed to register/login with Faceobok"
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:warning] = "Failed to login with Facebook"
    redirect_to new_user_session_path
    
  end
  
end