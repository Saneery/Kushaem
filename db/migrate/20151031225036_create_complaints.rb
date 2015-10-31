class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.integer :user_id
      t.integer :shop_id
      t.text :message
      t.timestamps null: false
    end
  end
end
