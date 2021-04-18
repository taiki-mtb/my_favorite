class AddColumnsToTagMaps < ActiveRecord::Migration[6.0]
  def change
  	add_column :tag_maps, :tag_id, :integer
  	add_index :tag_maps, :tag_id
  end
end
