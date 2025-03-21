# app/controllers/omniauth_callbacks_controller.rb
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    handle_oauth("GitHub")
  end

  def linkedin
    handle_oauth("LinkedIn")
  end

  private

  def handle_oauth(provider)
    auth = request.env["omniauth.auth"]
    oauth_provider = OauthProvider.where(provider: auth.provider, uid: auth.uid).first

    if oauth_provider.present?
      user = oauth_provider.user
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider)
    elsif current_user
      # Si l'utilisateur est déjà connecté, associer ce nouveau compte OAuth
      current_user.oauth_providers.create(provider: auth.provider, uid: auth.uid)
      redirect_to edit_user_registration_path
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider)
    else
      # Créer un nouvel utilisateur
      user = create_new_user(auth)
      if user.persisted?
        sign_in_and_redirect user, event: :authentication
        flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider)
      else
        session["devise.#{auth.provider}_data"] = auth.except("extra")
        redirect_to new_user_registration_url, alert: user.errors.full_messages.join("\n")
      end
    end
  end

  def create_new_user(auth)
    email = auth.info.email
    user = User.where(email: email).first_or_initialize do |u|
      u.email = email
      u.password = Devise.friendly_token[0, 20]
      u.first_name = auth.info.name.split.first if auth.info.name
      u.last_name = auth.info.name.split[1..-1].join(' ') if auth.info.name
      u.username = auth.info.nickname if auth.info.nickname
    end

    if user.save
      user.oauth_providers.create(provider: auth.provider, uid: auth.uid)
    end

    user
  end
end
