require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT"], ENV["SPOTIFY_SECRET"], scope: 'user-read-currently-playing user-read-email user-read-private'
end

OmniAuth.config.allowed_request_methods = [:post, :get]
