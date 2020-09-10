class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.references :requester, foreign_key: { to_table: "User" }
      t.references :requestee, foreign_key: { to_table: "User" }
      t.timestamps
    end
  end
end
