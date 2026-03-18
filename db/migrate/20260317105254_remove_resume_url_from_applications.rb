class RemoveResumeUrlFromApplications < ActiveRecord::Migration[8.0]
  def change
    remove_column :applications, :resume_url, :string
  end
end
