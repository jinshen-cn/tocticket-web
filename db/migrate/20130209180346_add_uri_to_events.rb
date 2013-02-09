class AddUriToEvents < ActiveRecord::Migration
  def change
    add_column :events, :uri, :string, :null => false
    add_index :events, :uri, { :unique => true }
  end
end
