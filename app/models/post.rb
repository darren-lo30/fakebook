class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
