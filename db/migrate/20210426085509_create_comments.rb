class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :dance_id
      t.integer :music_id
      t.integer :stage_id
      t.text :content

      t.timestamps
    end
    add_index :comments, :dance_id
    add_index :comments, :music_id
    add_index :comments, :stage_id
  end
end
