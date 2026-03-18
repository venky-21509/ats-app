class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.references :company, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :location
      t.string :job_type
      t.integer :status
      t.date :closes_at
      t.references :created_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
