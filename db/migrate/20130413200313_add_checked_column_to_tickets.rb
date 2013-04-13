class AddCheckedColumnToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :checked, :boolean, :default => false
  end
end