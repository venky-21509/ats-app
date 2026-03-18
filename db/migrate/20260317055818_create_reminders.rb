class CreateReminders < ActiveRecord::Migration[8.0]
  def change
    create_table :reminders do |t|
      t.references :application, null: false, foreign_key: true
      t.string :message
      t.datetime :remind_at
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.boolean :sent, default: false, null: false

      t.timestamps
    end
  end
end
