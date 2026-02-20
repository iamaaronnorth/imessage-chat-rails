class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room
  before_action :set_message, only: [:destroy]

  def create
    @message = @room.messages.build(message_params)
    @message.user = current_user

    if @message.save
      # Touch the room to update its updated_at timestamp
      @room.touch
      
      # The message will be broadcasted automatically via the after_create_commit callback
      respond_to do |format|
        format.html { redirect_to @room }
        format.turbo_stream
      end
    else
      @messages = @room.messages.includes(:user).recent
      @room_memberships = @room.room_memberships.includes(:user)
      render 'rooms/show', status: :unprocessable_entity
    end
  end

  def destroy
    if @message.user == current_user || @room.user == current_user
      @message.destroy
      respond_to do |format|
        format.html { redirect_to @room }
        format.turbo_stream
      end
    else
      redirect_to @room, alert: 'You can only delete your own messages.'
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
    unless @room.members.include?(current_user) || @room.user == current_user
      redirect_to rooms_path, alert: 'You do not have access to this room.'
    end
  end

  def set_message
    @message = @room.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
