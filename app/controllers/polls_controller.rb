class PollsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :current_user?, only: [:edit, :update, :destroy]
  before_filter :format_poll_datetime_params, only: [:create, :update]

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(poll_params)

    if @poll.save
      redirect_to poll_path(@poll),
                  flash: { success: "Poll created!" }
    else
      render 'new'
    end
  end

  def show
    @poll = Poll.find(params[:id]).decorate
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
    params.require(:poll).permit(:user_id,
                                 :question,
                                 :start,
                                 :finish,
                                 :vote_min,
                                 :vote_max)
  end

  def current_user?
    @poll = Poll.find(params[:id]).user == current_user
  end

  def format_poll_datetime_params
    [:start, :finish].each do |date|
      params[:poll][date] = params[:poll][date].sub('T',' ').concat(':00')
    end
  end
end
