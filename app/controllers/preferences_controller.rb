class PreferencesController < ApplicationController
  def show
    @user = current_user
    @preference = current_user.preference
  end

  def new
    @user = current_user
    @preference = Preference.new
  end

  def create
    @preference = Preference.new(preference_params)
    @user = current_user
    @preference.user = @user
    if @preference.save
      redirect_to user_show_preference_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
    @preference = current_user.preference
  end

  def update
    @user = current_user
    @preference = @user.preference
    if @preference.update(preference_params)
      redirect_to user_show_preference_path(@user), notice: "Preferences were successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def preference_params
    params.require(:preference).permit(:max_age, :min_age, :max_distance, :gender)
  end
end
