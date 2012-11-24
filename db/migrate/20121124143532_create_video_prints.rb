class CreateVideoPrints < ActiveRecord::Migration
  def change
    create_table :video_prints do |t|
      t.integer :ticket_id

      t.timestamps
    end
  end
end
