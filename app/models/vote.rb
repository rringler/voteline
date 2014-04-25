class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll

  validates :value, presence: true
end
