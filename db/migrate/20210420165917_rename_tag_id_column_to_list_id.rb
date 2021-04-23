class RenameTagIdColumnToListId < ActiveRecord::Migration[6.0]
  def change
    rename_column :list_maps, :tag_id, :list_id
  end
end
