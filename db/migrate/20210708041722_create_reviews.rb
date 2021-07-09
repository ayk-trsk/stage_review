class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :stage_id, null: false
      t.string :title
      t.float :rate, null: false, default: 0
      t.text :body
      t.date :date
      t.string :place

      t.timestamps
    end
  end
end
