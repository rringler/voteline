class PagesController < ApplicationController
  def index
    @polls = Poll.recent(5).decorate
  end
end
