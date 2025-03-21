class ApplicationStep < ApplicationRecord
  belongs_to :application

  validates :step_type, presence: true
  validates :date, presence: true

  enum step_type: {
    application_sent: "application_sent",
    resume_updated: "resume_updated",
    portfolio_updated: "portfolio_updated",
    company_research: "company_research",
    initial_contact: "initial_contact",
    phone_screening: "phone_screening",
    technical_test: "technical_test",
    technical_interview: "technical_interview",
    hr_interview: "hr_interview",
    reference_check: "reference_check",
    offer_received: "offer_received",
    negotiation: "negotiation",
    decision_made: "decision_made",
    follow_up: "follow_up"
  }, _prefix: true

  scope :upcoming, -> { where('next_action_date >= ?', Date.today).order(next_action_date: :asc) }
  scope :overdue, -> { where('next_action_date < ?', Date.today) }
  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
end
