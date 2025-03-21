class JobTechnology < ApplicationRecord
  belongs_to :job_listing
  belongs_to :technology

  validates :job_listing_id, uniqueness: { scope: :technology_id }
end
