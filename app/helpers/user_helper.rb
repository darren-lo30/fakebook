module UserHelper
  def user_profile_picture(user_id, width='', height='')
    user = User.find(user_id)

    if user.profile_picture.attached?
      image_tag user.profile_picture, size: "#{width}x#{height}", class: "rounded-circle profile-picture"
    else
        image_tag "no-profile-picture.png", size: "#{width}x#{height}", class: "rounded-circle profile-picture"
    end
  end
end
