class UserMailer < ApplicationMailer
  default from: 'user_mailer@gmail.com'

  def welcome_email
    @user = params[:user]
    @temporary_password = params[:temporary_password]
    mail(to: @user.email, subject: "Welcome to fakebook")
  end
end
