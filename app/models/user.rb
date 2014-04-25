class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable,
  # :timeoutable
  # :omniauthable
  devise :confirmable,
         :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :polls
  has_many :votes
end
