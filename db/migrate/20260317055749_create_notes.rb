class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.references :application, null: false, foreign_key: true
      t.text :body
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
