class Technology < ApplicationRecord
  has_many :job_technologies, dependent: :destroy
  has_many :job_listings, through: :job_technologies

  validates :name, presence: true, uniqueness: true

  enum category: {
    language: "language",
    framework: "framework",
    library: "library",
    database: "database",
    tool: "tool",
    platform: "platform"
  }, _prefix: true
end
