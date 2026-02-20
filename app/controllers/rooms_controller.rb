class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = current_user.rooms.recent
    @owned_rooms = current_user.owned_rooms.recent
    @new_room = Room.new
  end

  def show
    @messages = @room.messages.includes(:user).recent
    @message = Message.new
    @room_memberships = @room.room_memberships.includes(:user)
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.owned_rooms.build(room_params)
    
    if @room.save
      # Add the creator as a member
      @room.room_memberships.create(user: current_user)
      redirect_to @room, notice: 'Chat room created successfully!'
    else
      @rooms = current_user.rooms.recent
      @owned_rooms = current_user.owned_rooms.recent
      @new_room = @room
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Room updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: 'Room deleted successfully!'
  end

  private

  def set_room
    @room = Room.find(params[:id])
    # Ensure user has access to this room
    unless @room.members.include?(current_user) || @room.user == current_user
      redirect_to rooms_path, alert: 'You do not have access to this room.'
    end
  end

  def room_params
    params.require(:room).permit(:name, :description)
  end
end
