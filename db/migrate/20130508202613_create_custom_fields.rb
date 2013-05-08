class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :event
    end
    add_index :custom_fields, :event_id
  end
end
