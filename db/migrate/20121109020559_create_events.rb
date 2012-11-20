class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :celebrated_at
      t.text :address
      t.decimal :price, :precision => 6, :scale => 2
      t.text :info
      t.string :url
      t.datetime :selling_deadline
      t.integer :capacity
      t.boolean :door_payment
      
      t.integer  :organizer_id
      
      t.timestamps
    end
  end
end
