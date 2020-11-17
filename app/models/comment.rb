class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  belongs_to :post

  #Self referntial association so comments can comment on each other
  has_many :child_comments, class_name: "Comment", foreign_key: "parent_comment_id"
  belongs_to :parent_comment, class_name: "Comment", optional: true
  
  include Likeable
end
