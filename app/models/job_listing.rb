class JobListing < ApplicationRecord
  belongs_to :company
  has_many :applications, dependent: :destroy
  has_many :job_technologies, dependent: :destroy
  has_many :technologies, through: :job_technologies

  validates :title, presence: true
  validates :url, url: true, allow_blank: true
  validates :salary_min, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :salary_max, numericality: { greater_than: :salary_min }, allow_nil: true

  enum contract_type: {
    full_time: "full_time",
    part_time: "part_time",
    freelance: "freelance",
    internship: "internship",
    apprenticeship: "apprenticeship"
  }, _prefix: true
end
