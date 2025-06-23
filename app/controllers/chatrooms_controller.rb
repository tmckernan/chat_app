class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: %i[ show join leave ]

  def index
    @chatrooms = Chatroom.all.order(created_at: :desc)
    @new_chatroom = Chatroom.new
  end

  def show
    @message = Message.new
    @messages = @chatroom.messages.includes(:user).order(created_at: :asc)
    @is_member = current_user.member_of?(@chatroom) # Add this method to User model later
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to @chatroom, notice: "Chatroom was successfully created."
    else
      @chatrooms = Chatroom.all # Needed if rendering index
      @new_chatroom = Chatroom.new
      flash[:alert] = "Chatroom has not been created as an error has happen"
      render :index, status: :unprocessable_entity
    end
  end

  def join
    unless current_user.member_of?(@chatroom)
      @chatroom.memberships.create(user: current_user)
      flash[:notice] = "You have joined '#{@chatroom.name}'."
    else
      flash[:alert] = "You are already a member of '#{@chatroom.name}'."
    end
    redirect_to @chatroom
  end

  def leave
    membership = current_user.memberships.find_by(chatroom: @chatroom)
    if membership
      membership.destroy
      flash[:notice] = "You have left '#{@chatroom.name}'."
    else
      flash[:alert] = "You are not a member of '#{@chatroom.name}'."
    end
    redirect_to chatrooms_path
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
