class Note < ApplicationRecord

 belongs_to :application
    belongs_to :author, class_name: "User", foreign_key: :author_id
    
    validates :body, presence: true
    validates :body, length: {minimum: 3, maximum: 2000}

    scope :recent, -> { order(created_at: :desc) }
end
