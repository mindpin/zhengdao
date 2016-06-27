FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "user#{n}"}
    sequence(:login){|n| "user#{n}"}
    password "123456"
  end
end
