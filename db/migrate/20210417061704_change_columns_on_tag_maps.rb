class ChangeColumnsOnTagMaps < ActiveRecord::Migration[6.0]
  def up
    change_column :tag_maps, :music_id, :integer, null: true
    change_column :tag_maps, :dance_id, :integer, null: true
    change_column :tag_maps, :stage_id, :integer, null: true
  end

  def down
    change_column :tag_maps, :music_id, :integer, null: false
    change_column :tag_maps, :dance_id, :integer, null: false
    change_column :tag_maps, :stage_id, :integer, null: false
  end
end
