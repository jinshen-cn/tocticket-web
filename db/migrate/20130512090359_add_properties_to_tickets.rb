class AddPropertiesToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :properties, :text
  end
end
