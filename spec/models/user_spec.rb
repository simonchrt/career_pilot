require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).allow_blank }
  end

  describe 'associations' do
    it { should have_many(:oauth_providers).dependent(:destroy) }
  end

  describe '#full_name' do
    context 'when first_name and last_name are present' do
      let(:user) { build(:user, first_name: 'John', last_name: 'Doe') }

      it 'returns the full name' do
        expect(user.full_name).to eq('John Doe')
      end
    end

    context 'when first_name is nil' do
      let(:user) { build(:user, first_name: nil, last_name: 'Doe', email: 'john.doe@example.com') }

      it 'returns the last name' do
        expect(user.full_name).to eq('Doe')
      end
    end

    context 'when both names are nil' do
      let(:user) { build(:user, first_name: nil, last_name: nil, email: 'john.doe@example.com') }

      it 'returns the email username' do
        expect(user.full_name).to eq('john.doe')
      end
    end
  end
end
