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

  def connexion
  end

  def geolocalize
    @user = current_user
    @user.latitude = params[:latitude]
    @user.longitude = params[:longitude]
    @user.save
  end

  def match?
    @user_1 = current_user
    @user_2 = User.find(params[:id])
    @match = Match.where("(user_1_id = #{@user_1.id} OR user_2_id = #{@user_1.id}) AND (user_1_id = #{@user_2.id} OR user_2_id = #{@user_2.id})").first
    if @match.nil?
      Match.create(user_1_id: @user_1.id,
                   user_2_id: @user_2.id,
                   track_id: 1)
      redirect_to home_path
    else
      @match.status = "Favorable"
      @match.save
      redirect_to matches_path
    end
  end

  def no
    @user_1 = current_user
    @user_2 = User.find(params[:id])
    @match = Match.where("(user_1_id = #{@user_1.id} OR user_2_id = #{@user_1.id}) AND (user_1_id = #{@user_2.id} OR user_2_id = #{@user_2.id})").first
    if @match.nil?
      Match.create(user_1_id: @user_1.id,
                   user_2_id: @user_2.id,
                   track_id: 1,
                   status: "Declined")
    else
      @match.status = "Declined"
      @match.save
    end
    redirect_to home_path
  end
end
