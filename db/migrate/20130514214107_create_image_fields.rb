class CreateImageFields < ActiveRecord::Migration
  def change
    create_table :image_fields do |t|
      t.string :image
    end
  end
end
