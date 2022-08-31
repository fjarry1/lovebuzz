def currently_playing
  url = "me/player/currently-playing"
  response = RSpotify.resolve_auth_request(@user.id, url)
  return response if RSpotify.raw_response
  Track.new response["item"]
end
