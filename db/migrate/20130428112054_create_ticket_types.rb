class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.string :name
      t.decimal :price, :precision => 6, :scale => 2
      t.integer :capacity

      t.integer :event_id
    end
  end
end
