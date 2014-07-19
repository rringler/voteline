class Poll < ActiveRecord::Base
  belongs_to :user
  has_many   :votes

  scope :recent_start, ->(limit = 5) { order('start DESC').limit(limit) }

  validates :start,            presence: true
  validates :finish,           presence: true
  validates :vote_min,         presence: true
  validates :vote_max,         presence: true
  validate  :valid_vote_range, if: :vote_range_given?

  def vote_range
    (vote_min..vote_max)
  end

  def vote_range_given?
    vote_min && vote_max
  end

  def valid_vote_range
    errors.add(:base, "The minimum vote value must be less than the maximum vote value") unless vote_min < vote_max
  end

  def active?
    Time.now >= start && Time.now <= finish
  end
end
