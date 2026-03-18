class Reminder < ApplicationRecord

    belongs_to :application
  belongs_to :creator, class_name: "User", foreign_key: :created_by_id

  validates :message, :remind_at, presence: true
  validates :remind_at, comparison: { greater_than: -> { Time.current }, message: "must be in the future" }

  scope :pending,  -> { where(sent: false).where("remind_at <= ?", Time.current) }
  scope :upcoming, -> { where(sent: false).where("remind_at > ?", Time.current).order(:remind_at) }

end
