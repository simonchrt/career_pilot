require 'rails_helper'

RSpec.describe OauthProvider, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    subject { build(:oauth_provider, user: user) }

    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:provider).scoped_to(:user_id) }
    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
