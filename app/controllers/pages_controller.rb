class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def geolocalize
    @user = current_user
    @user.latitude = params[:latitude]
    @user.longitude = params[:longitude]
    redirect_to root
  end
end
