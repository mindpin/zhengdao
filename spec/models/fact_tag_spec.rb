require 'rails_helper'

RSpec.describe FactTag, type: :model do
  it "创建 FactTag" do
    name = '无子女'
    fact_tag = FactTag.create(name: name)
    expect(fact_tag.valid?).to eq(true)
    expect(fact_tag.name).to eq(name)
  end

  it "FactTag name 不能为空" do
    fact_tag = FactTag.create(name: '')
    expect(fact_tag.valid?).to eq(false)
  end

end
