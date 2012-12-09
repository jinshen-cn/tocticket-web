class AddPaypalAccountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :paypal_account, :string
  end
end
