class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :commenter, foreign_key: { to_table: :users }
      t.references :post
      t.string :body
      t.timestamps
    end
  end
end
