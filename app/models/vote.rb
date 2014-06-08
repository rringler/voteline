class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll

  scope :created_between, ->(start, finish) do
    where("created_at >= ? AND created_at <= ?", start, finish)
  end

  validates :value, presence: true
  validate  :for_active_poll

  private

  def for_active_poll
    if Time.now < poll.start || Time.now > poll.finish
      errors.add(:created_at, "must be within the poll start and finish dates")
    end
  end
end
