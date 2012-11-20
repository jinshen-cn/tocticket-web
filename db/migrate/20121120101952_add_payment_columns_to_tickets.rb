class AddPaymentColumnsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :unpaid, :boolean, :default => true
    add_column :tickets, :pay_at_door, :boolean, :default => false
  end
end
