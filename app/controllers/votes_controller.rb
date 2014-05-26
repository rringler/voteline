class VotesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :current_user?, only: [:edit, :update, :destroy]

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id

    respond_to do |format|
      if @vote.save
        format.html { redirect_to poll_path(@vote.poll), success: "Voted!" }
        format.js   { render 'polls/show', locals: { poll: @vote.poll.decorate } }
      else
        format.html { render 'new' }
      end
    end
  end

  def show
    @vote = Vote.find(params[:id])
  end

  def index
  end

  private

  def vote_params
    params.require(:vote).permit(:poll_id,
                                 :value)
  end

  def current_user?
    @vote = Vote.find(params[:id]).user == current_user
  end
end
