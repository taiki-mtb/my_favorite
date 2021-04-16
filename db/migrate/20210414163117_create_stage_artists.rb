class CreateStageArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :stage_artists do |t|
      t.references :stage, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
