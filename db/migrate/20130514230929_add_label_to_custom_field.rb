class AddLabelToCustomField < ActiveRecord::Migration
  def change
    add_column :custom_fields, :label, :string
  end
end
