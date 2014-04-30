class Poll < ActiveRecord::Base
  belongs_to :user
  has_many   :votes

  attr_accessor :start_date, :finish_date
end
