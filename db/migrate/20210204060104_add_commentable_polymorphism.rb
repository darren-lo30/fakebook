class AddCommentablePolymorphism < ActiveRecord::Migration[5.2]
  def change
    remove_reference :comments, :parent_comment, null: true, foreign_key: {to_table: :comments}
    add_reference :comments, :commentable, polymorphic: true
    remove_reference :comments, :post
  end
end
