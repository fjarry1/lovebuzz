# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    redirect_to root_path
  end

  # méthode ci-dessous pour récupérer la track jouée, copié collé de la doc en dévellopement
  # def currently_playing
  #   url = "me/player/currently-playing"
  #   response = RSpotify.resolve_auth_request(@user.id, url)
  #   return response if RSpotify.raw_response
  #   Track.new response["item"]
  # end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
