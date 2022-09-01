class MessagesController < ApplicationController

  def create
    match = Match.find(params[:match_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.match = match
    if @message.save
      MatchChannel.broadcast_to(
        match,
        {
          html: render_to_string(partial: "message", locals: { message: @message }),
          user_id: @message.user.id,
          user_name: @message.user.full_name
        }
      )
      head :ok
    else
      render 'matches#show', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
