# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :poll do
    association :user
    question    BetterLorem.w(8, true)
    start       DateTime.now - 5.minutes
    finish      DateTime.now + 2.hours
    vote_min    0
    vote_max    5
  end
end
