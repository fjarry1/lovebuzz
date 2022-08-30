class MatchesController < ApplicationController

  def index
    @matches = current_user.all_matches
  end

  def show
    @match = Match.find(params[:id])
    @message = Message.new
  end
end
