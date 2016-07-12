require 'rails_helper'

RSpec.describe FactObject, type: :model do
  it "FactObject 创建" do
    fg1 = create(:has_children_factory_group)
    fg2 = create(:has_children_factory_group)
    fg3 = create(:has_tags_factory_group)

    fo = FactObject.create(fact_groups: [fg1, fg2, fg3])
    expect(fo.valid?).to eq(true)
    fo = FactObject.find fo.id
    expect(fo.fact_groups.to_a).to match([fg1, fg2, fg3])
  end

end
