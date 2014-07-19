# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email                 { "email#{rand}@gmail.com" }
    password              "abcdef"
    password_confirmation "abcdef"

    factory :user_with_time_zone do
      time_zone             "Pacific Time (US & Canada)"
    end

    factory :confirmed_user do
      confirmed_at        DateTime.now - 1.day
    end
  end
end
