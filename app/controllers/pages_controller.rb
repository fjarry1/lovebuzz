class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # return unless user_signed_in?

    @users = User.all

    url = "me/player/currently-playing"
    response = RSpotify.resolve_auth_request(current_user.spotify_id, url)
    @title = response["item"]["name"]
    @artist = response["item"]["artists"][0]["name"]
    # return response if RSpotify.raw_response
    # Track.new response["item"]
  end

  def profil
    @user = User.find(params[:id])
  end

  def geolocalize
    puts "TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST"
    @user = current_user
    @user.latitude = params[:latitude]
    @user.longitude = params[:longitude]
    @user.save
    puts "END END END END END END END END END END"
  end
end
