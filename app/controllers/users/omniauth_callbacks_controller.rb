# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more
    @user = User.find_or_initialize_by(email: @spotify_user.email)
    # Access private data
    @user.spotify_id = @spotify_user.id
    @user.spotify_token = @spotify_user.id
    @user.token = @spotify_user.credentials["token"]
    @user.spotify_hash = @spotify_user.to_hash

    if @user.new_record?
      @user.password = Devise.friendly_token
      redirection_url = edit_user_registration_path
    else
      redirection_url = root_path
    end
    @user.save
    sign_in @user

    redirect_to redirection_url
  end

#  méthode ci-dessous pour récupérer la track jouée, copié collé de la doc, en dévelopement
#  def currently_playing
#    url = "me/player/currently-playing"
#    response = RSpotify.resolve_auth_request(@user.id, url)
#    return response if RSpotify.raw_response

#    Track.new response["item"]
#  end

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
