class MatchesController < ApplicationController

  def index
    @matches = current_user.all_matches
  end

  def show
    @match = Match.find(params[:id])
    @message = Message.new
  end

  def create
    puts "================================="
    puts params
    puts "================================="

    Match.create(user_1: current_user, user_2: User.find(params[:user_id]))
  end
end
