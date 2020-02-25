class MessagesController < ApplicationController
  
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  def index
    @messages = current_user.messages 
  end

  def show
  end

  def new
    @message = Message.new 
  end

  def create 
    @message = current_user.messages.new(message_params)
    if @message.save
      flash[:success] = "Message Created"
      redirect_to messages_path 
    else
      flash[:error] = "Error #{@message.errors.full_messages.join('\n')}"
      render :new 
    end 
  end

  def edit
  end

  def update 
    if @message.update(message_params)
      redirect_to messages_path
    else  
      render :edit 
    end 
  end 

  def destroy
    @message.destroy 
    redirect_to messages_path 
  end 

  private 
    def message_params
      params.require(:message).permit(:title, :body)
    end 

    def set_message
      @message = current_user.messages.find(params[:id])
    end 
end
