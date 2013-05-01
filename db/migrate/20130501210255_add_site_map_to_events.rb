class AddSiteMapToEvents < ActiveRecord::Migration
  def change
    add_column :events, :site_map, :string
  end
end
