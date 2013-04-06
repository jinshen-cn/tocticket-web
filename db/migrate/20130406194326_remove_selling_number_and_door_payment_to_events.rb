class RemoveSellingNumberAndDoorPaymentToEvents < ActiveRecord::Migration
  def up
    remove_column :events, :door_payment
    remove_column :events, :selling_deadline
  end

  def down
    add_column :events, :selling_deadline, :datetime
    add_column :events, :door_payment, :boolean
  end
end
