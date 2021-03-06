class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :email, null: false
      t.text :subject, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
