class Application < ApplicationRecord
  enum :status, {
    applied:    0,
    screening:  1,
    interview:  2,
    offer:      3,
    hired:      4,
    rejected:   5
  }

  belongs_to :job
  belongs_to :user

  has_one_attached :resume

  has_many :notes,     dependent: :destroy
  has_many :reminders, dependent: :destroy

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :job_id, message: "has already applied to this job" }
  validate :resume_format

  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :recent,    -> { order(applied_at: :desc) }

  before_validation :set_default_status
  before_create :set_applied_at

  def self.policy_class
    JobApplicationPolicy
  end

  private

  def set_default_status
    self.status ||= :applied
  end

  def set_applied_at
    self.applied_at ||= Time.current
  end

    def resume_format
        return unless resume.attached?
        unless resume.content_type.in?(%w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document))
          errors.add(:resume, "must be a PDF or Word document")
        end
     end


end