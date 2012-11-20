class AddPaymentColumnsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :unpaid, :boolean
  end
end
