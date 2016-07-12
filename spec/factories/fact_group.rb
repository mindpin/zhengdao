FactoryGirl.define do
  factory :has_tags_factory_group, class: FactGroup do
    sequence(:name){|n| "has_tags_factory_group#{n}"}
    sequence(:fact_tags) do |n|
      "tag1_#{n},tag2_#{n},tag3_#{n}".split(",").map do |tag_name|
        FactTag.create(name: tag_name)
      end
    end
  end

  factory :has_children_factory_group, class: FactGroup do
    sequence(:name){|n| "has_children_factory_group#{n}"}
    sequence(:fact_groups) do |n|
      [create(:has_tags_factory_group)]
    end
  end
end
