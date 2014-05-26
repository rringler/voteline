class PagesController < ApplicationController
  def index
    @polls = Poll.recent_start(5).decorate
  end
end
