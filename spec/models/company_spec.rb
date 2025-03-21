require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:job_listings).dependent(:destroy) }
  end
end
