class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  
  include Likeable
end
