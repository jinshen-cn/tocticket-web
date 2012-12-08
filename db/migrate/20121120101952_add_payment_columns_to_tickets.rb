class AddPaymentColumnsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :paid, :boolean, :default => false
  end
end
