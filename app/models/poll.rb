class Poll < ActiveRecord::Base
  belongs_to :user
  has_many   :votes

  scope :recent_start, ->(limit = 5) { order('start DESC').limit(limit) }

  validates :start,  presence: true
  validates :finish, presence: true
  validates :vote_min, presence: true
  validates :vote_max, presence: true
  validate  :valid_vote_range

  def vote_range
    (vote_min..vote_max)
  end

  def valid_vote_range
    vote_min < vote_max
  end

  def live?
    Time.now >= start && Time.now <= finish
  end
end
