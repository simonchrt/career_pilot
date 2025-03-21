require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'GitHub OAuth' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        provider: 'github',
        uid: '123456',
        info: {
          email: 'test@example.com',
          name: 'Test User',
          nickname: 'testuser'
        }
      })
      @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        expect {
          get :github
        }.to change(User, :count).by(1)
      end

      it 'creates a new oauth provider' do
        expect {
          get :github
        }.to change(OauthProvider, :count).by(1)
      end

      it 'redirects to root path' do
        get :github
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user exists but OAuth provider does not' do
      let!(:user) { create(:user, email: 'test@example.com') }

      it 'does not create a new user' do
        expect {
          get :github
        }.to_not change(User, :count)
      end

      it 'creates a new oauth provider' do
        expect {
          get :github
        }.to change(OauthProvider, :count).by(1)
      end
    end

    context 'when OAuth provider exists' do
      let!(:user) { create(:user, email: 'test@example.com') }
      let!(:oauth) { create(:oauth_provider, user: user, provider: 'github', uid: '123456') }

      it 'does not create a new user' do
        expect {
          get :github
        }.to_not change(User, :count)
      end

      it 'does not create a new oauth provider' do
        expect {
          get :github
        }.to_not change(OauthProvider, :count)
      end
    end
  end
end
