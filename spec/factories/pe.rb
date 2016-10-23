FactoryGirl.define do
  factory :pe_tag do
    sequence(:name) { |n| "tag-#{n}"}
  end

  factory :pe_fact do
    sequence(:name) { |n| "user-#{n}"}
    after(:create) do
      create_list :pe_tag, 3
    end
  end
end
