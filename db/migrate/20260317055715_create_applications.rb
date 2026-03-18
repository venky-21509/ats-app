class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.references :job, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.string :resume_url
      t.text :cover_letter
      t.datetime :applied_at

      t.timestamps
    end
  end
end
