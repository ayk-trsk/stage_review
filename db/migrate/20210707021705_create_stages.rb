class CreateStages < ActiveRecord::Migration[5.2]
  def change
    create_table :stages do |t|
      t.string :name, null: false
      t.integer :genre_id, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.text :detail

      t.timestamps
    end
  end
end
