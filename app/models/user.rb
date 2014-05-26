class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable,
  # :timeoutable
  # :omniauthable
  # devise :confirmable,
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :polls
  has_many :votes


  US_TIME_ZONES = ActiveSupport::TimeZone.us_zones.map do |zone|
    zone.to_s.gsub(/\(.*\)\s/, "")
  end

  validates_inclusion_of :time_zone, in: US_TIME_ZONES
end
