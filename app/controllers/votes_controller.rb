class VotesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :current_user?, only: [:edit, :update, :destroy]

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id

    if @vote.save
      redirect_to poll_path(@vote.poll), success: "Voted!"
    else
      render 'new'
    end
  end

  def show
    @vote = Vote.find(params[:id])
  end

  def index
    @votes = Poll.find(params[:poll_id]).votes

    respond_to do |format|
      format.html { redirect_to poll_path(params[:poll_id]) }
      format.json { render json: @votes }
    end
  end

  def binned_votes
    @votes = Poll.find(params[:poll_id]).votes
    @binned_votes = VoteAggregator.new(@votes).high_charts_scatter_data

    respond_to do |format|
      format.json { render json: @binned_votes }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:poll_id, :value)
  end

  def current_user?
    @vote = Vote.find(params[:id]).user == current_user
  end
end
