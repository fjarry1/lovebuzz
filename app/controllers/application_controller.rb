class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthdate])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:birthdate])
  end

  def currently_playing
    url = "me/player/currently-playing"
    if user_signed_in? && !(current_user.spotify_id.nil?)
      response = RSpotify.resolve_auth_request(current_user.spotify_id, url)
      if response
        @title = response["item"]["name"]
        @artist = response["item"]["artists"][0]["name"]
      else
        @title = "Baby Shark"
        @artist = "Pinkfong"
      end
      # return response if RSpotify.raw_response
      # Track.new response["item"]
    else
      @title = "Baby Shark"
      @artist = "Pinkfong"
    end
  end
end
