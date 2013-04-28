class StructuringEventsTicketsRelationship < ActiveRecord::Migration
  def up
    remove_column :events, :price
    remove_column :events, :capacity

    remove_column :tickets, :event_id
    add_column :tickets, :ticket_type_id, :integer
  end

  def down
    add_column :events, :capacity, :integer
    add_column :events, :price, :decimal

    add_column :tickets, :event_id, :integer
    remove_column :tickets, :ticket_type_id
  end
end
