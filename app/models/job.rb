class Job < ApplicationRecord

 enum :status, { open: 0, closed: 1 }
  enum :job_type, { full_time: 0, part_time: 1, contract: 2, internship: 3 }

  belongs_to :company
  belongs_to :creator, class_name: "User", foreign_key: :created_by_id

  has_many :applications, dependent: :destroy
  has_many :applicants, through: :applications, source: :user

  validates :title, :description, :status, presence: true
  validates :job_type, presence: true

  scope :open_jobs,   -> { where(status: :open) }
  scope :closed_jobs, -> { where(status: :closed) }
  scope :recent,      -> { order(created_at: :desc) }

end
