class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :random_key
      t.integer :attendees
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
