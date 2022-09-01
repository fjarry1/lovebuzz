require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "106e098a58c248dd85e1b5689b0ccc27", "acbc5e92d6f545ffa93545d5eb192c5a", scope: 'user-read-currently-playing user-read-email user-read-private'
end

OmniAuth.config.allowed_request_methods = [:post, :get]
