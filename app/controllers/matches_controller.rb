class MatchesController < ApplicationController

  def index
    @matches = current_user.all_matches.matched
  end

  def show
    @match = Match.find(params[:id])
    @message = Message.new
  end

  def create
    currently_playing
    if params[:like] == 'true'
      accept(params[:user_id])
    else
      reject(params[:user_id])
    end
  end

  def accept(user_id)
    @user_1 = current_user
    @user_2 = User.find(user_id)
    @match = Match.where("(user_1_id = #{@user_1.id} AND user_2_id = #{@user_2.id}) OR (user_1_id = #{@user_2.id} AND user_2_id = #{@user_1.id})").first
    if @match.nil?
      @match = Match.create(user_1: @user_1,
                   user_2: @user_2,
                   track_id: 1,
                   status: "Pending")
      # redirect_to home_path
    else
      @match.status = "Favorable"
      @match.song = params[:song]
      @match.save!
      # redirect_to matches_path, notice: "It's a Match 🎉"
    end
    respond_to do |format|
      format.html { redirect_to home_path }
      format.json do
        render json: {
          modal_html: render_to_string(partial: "pages/match", locals: { user: @user_2, match: @match }, formats: :html),
          match: @match.status == "Favorable",
          username: @user_2.full_name,
          track_name: @title,
          artist_name: @artist
        }
      end
    end
  end

  def reject(user_id)
    @user_1 = current_user
    @user_2 = User.find(user_id)
    @match = Match.where("(user_1_id = #{@user_1.id} AND user_2_id = #{@user_2.id}) OR (user_1_id = #{@user_2.id} AND user_2_id = #{@user_1.id})").first
    if @match.nil?
      @match = Match.create(user_1: @user_1,
                   user_2: @user_2,
                   track_id: 1,
                   status: "Declined")
    else
      @match.status = "Declined"
      @match.save
    end
    # redirect_to home_path
    respond_to do |format|
      format.html { redirect_to home_path }
      format.json do
        render json: { ok: 'rejected' }
      end
    end
  end
end
