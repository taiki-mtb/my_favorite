class CreateListMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :list_maps do |t|
      t.references :tag, foreign_key: true
      t.references :dance, foreign_key: true
      t.references :music, foreign_key: true
      t.references :stage, foreign_key: true

      t.timestamps
    end
  end
end
