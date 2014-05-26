class Poll < ActiveRecord::Base
  belongs_to :user
  has_many   :votes

  scope :recent_start, ->(limit = 5) { order('start DESC').limit(limit) }

  validates :start,  presence: true
  validates :finish, presence: true

  def range
    (vote_min..vote_max)
  end
end
