class AddLikeablePolymorphism < ActiveRecord::Migration[5.2]
  def change
    remove_reference :likes, :post, foreign_key: true
    add_reference :likes, :likeable, polymorphic: true
  end
end
