class PollController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  befole_filter :current_user?, only: [:edit, :update, :destroy]

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(poll_params)
    @poll.user_id = current_user.id

    if @poll.save
      redirect_to poll_show_path(@poll),
                  flash: { success: "Created a new poll!" }
    else
      render 'new'
    end
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def index
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def update
    if @poll.update_attributes(poll_params)
      redirect_to poll_path(@poll),
                  flash: { success: "Poll updated!" }
    else
      render 'edit'
    end
  end

  def destroy
    @poll.destroy
  end

  private

  def poll_params
    params.require(:poll).permit(:question, :start, :finish, :vote_min, :vote_max)
  end

  def current_user?
    @poll = Poll.find(params[:id]).user == current_user
  end
end
