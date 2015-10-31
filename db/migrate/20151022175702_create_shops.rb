class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :address
      t.integer :user_id
      t.has_attached_file :avatar
      t.timestamps null: false
    end
  end
end
