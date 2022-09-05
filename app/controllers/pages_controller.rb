class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :connexion ]

  def home
    # return unless user_signed_in?*
    @hide_overflow = true

    @users = User.where.not(id: current_user.id)

    currently_playing
  end

  def profil
    @user = User.find(params[:id])
  end

  def connexion
  end

  def geolocalize
    @user = current_user
    @user.latitude = params[:latitude]
    @user.longitude = params[:longitude]
    @user.save
  end
end
