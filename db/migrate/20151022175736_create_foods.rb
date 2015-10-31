class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :shop_id
      t.text :description
      t.float :price
      t.has_attached_file :image
      t.timestamps null: false
    end
  end
end
