class Company < ApplicationRecord

has_many :users, dependent: :destroy
has_many :jobs, dependent: :destroy

validates :name, presence: true
validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true

end
