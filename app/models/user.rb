class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [:github, :linkedin]

  has_many :oauth_providers, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :job_listings, through: :applications

  validates :email, presence: true, uniqueness: true
  validates :username, uniqueness: true, allow_blank: true

  def full_name
  [first_name, last_name].compact.join(' ').presence || email.split('@').first
  end
end
