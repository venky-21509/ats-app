class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { candidate: 0, staff: 1, admin: 2 }

  belongs_to :company, optional: true

  has_many :jobs, foreign_key: :created_by_id, dependent: :nullify
  has_many :applications, dependent: :destroy
  has_many :notes, foreign_key: :author_id, dependent: :destroy
  has_many :reminders, foreign_key: :created_by_id, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :role, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def company_member?
    staff? || admin?
  end

end
