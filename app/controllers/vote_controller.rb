class VoteController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  befole_filter :current_user?, only: [:edit, :update, :destroy]

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id

    if @vote.save
      redirect_to poll_vote_show_path(@vote),
                  flash: { success: "Created casted a vote!" }
    else
      render 'new'
    end
  end

  def show
    @vote = Vote.find(params[:id])
  end

  def index
  end

  private

  def vote_params
    params.require(:vote).permit(:question,
                                 :vote_min,
                                 :vote_max,
                                 :start_date,
                                 :start_time,
                                 :finish_date,
                                 :finish_time)
  end

  def current_user?
    @vote = Vote.find(params[:id]).user == current_user
  end
end
