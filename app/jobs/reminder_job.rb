class ReminderJob < ApplicationJob
  queue_as :default

  def perform
    pending_reminders = Reminder.where(sent: false).where("remind_at <= ?", Time.current)
    pending_reminders.each do |reminder|
      application = reminder.application
      candidate = application.user
      job_title = application.job.title
      Rails.logger.info "Sending reminder ##{reminder.id} for #{candidate.full_name} -#{job_title}"

      reminder.update_column(:sent, true)
    end
  end
end
