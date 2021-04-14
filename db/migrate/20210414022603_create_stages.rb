class CreateStages < ActiveRecord::Migration[6.0]
  def change
    create_table :stages do |t|
      t.string :name
      t.text :info
      t.date :from_date
      t.date :until_date
      t.string :place

      t.timestamps
    end
  end
end
