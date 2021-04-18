class CreateTagMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_maps do |t|
      t.references :dance, foreign_key: true
      t.references :music, foreign_key: true
      t.references :stage, foreign_key: true

      t.timestamps
    end
  end
end
