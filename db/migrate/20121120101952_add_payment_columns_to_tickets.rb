class AddPaymentColumnsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :unpaid, :boolean, :default => true
  end
end
