class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @users = User.all
  end

  def profil
    @user = User.find(params[:id])
  end

  def connexion
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
