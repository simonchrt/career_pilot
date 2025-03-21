class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job_listing
  has_many :application_steps, dependent: :destroy

  validates :status, presence: true
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

  enum status: {
    bookmarked: "bookmarked",
    applying: "applying",
    applied: "applied",
    screening: "screening",
    interviewing: "interviewing",
    offer: "offer",
    rejected: "rejected",
    accepted: "accepted",
    withdrawn: "withdrawn"
  }, _prefix: true

  def days_since_applied
    return nil if applied_date.nil?
    (Date.today - applied_date).to_i
  end

  def days_since_last_update
    last_step = application_steps.order(date: :desc).first
    return nil if last_step.nil?
    (Date.today - last_step.date.to_date).to_i
  end
end
