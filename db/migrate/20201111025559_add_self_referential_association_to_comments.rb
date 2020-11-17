class AddSelfReferentialAssociationToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :parent_comment, null: true, foreign_key: {to_table: :comments}
  end
end
