class Company < ApplicationRecord
  has_many :job_listings, dependent: :destroy

  validates :name, presence: true
  validates :website, url: true, allow_blank: true

  # Si vous voulez ajouter Active Storage pour le logo
  has_one_attached :logo
end
