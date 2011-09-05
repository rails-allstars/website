require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:email){|n| "user#{n}@foobar.com" }
    password 'please1234'
  end
  
  factory :event do
    start_time 1.month.from_now
    sequence(:title){|n| "title #{n}"}
    description "description"
    association :location
    organizer { Factory(:user)}
  end

  factory :location do
    sequence(:name) {|n| "#{n} location"}
    address "address"
    lat 11.11
    lng 11.11
  end
end