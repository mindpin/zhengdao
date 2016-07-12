require 'rails_helper'

RSpec.describe FactGroup, type: :model do
  it "创建只有 name 的 FactGroup" do
    name = '工作状态'
    fact_group = FactGroup.create(name: name)
    expect(fact_group.valid?).to eq(true)
    expect(fact_group.name).to   eq(name)
  end

  it "创建含有特征值的 FactGroup" do
    name  = '工作状态'
    tags1 = "刚入职，稳定,退休 失业 创业"
    tags2 = %w{刚入职 稳定 退休 失业 创业}

    [tags1, tags2].each do |tags|
      fact_group = FactGroup.create(name: name, tags: tags)
      expect(fact_group.valid?).to eq(true)
      fact_group = FactGroup.find fact_group.id
      tag_names = fact_group.fact_tags.map(&:name)
      expect(tag_names).to match(tags2)
    end
  end

  it "FactGroup 更新特征值" do
    name  = '工作状态'
    tags = %w{刚入职 稳定 退休 失业 创业}
    change_tags = %w{退休 失业 创业 家里蹲}

    fact_group = FactGroup.create(name: name, tags: tags)
    expect(fact_group.valid?).to eq(true)
    fact_group = FactGroup.find fact_group.id
    tag_names = fact_group.fact_tags.map(&:name)
    expect(tag_names).to match(tags)

    fact_group.tags = change_tags
    fact_group.save
    fact_group = FactGroup.find fact_group.id
    tag_names = fact_group.fact_tags.map(&:name)
    expect(tag_names).to match(change_tags)
  end

  it "创建含有子特征的 FactGroup" do
    name          = '个人状态'
    children_name = %w{健康状况 年龄}
    children = children_name.map do |child|
      FactGroup.create(name: child)
    end

    fact_group = FactGroup.create(name: name, children: children)
    fact_group = FactGroup.find fact_group.id
    expect(fact_group.valid?).to eq(true)
    expect(fact_group.children.to_a).to match(children)
  end

  it "FactGroup name 不能为空" do
    fact_group = FactGroup.create(name: '')
    expect(fact_group.valid?).to eq(false)
  end

  it "FactGroup 不能同时含有子特性和特征值" do
    name          = '个人状态'
    children_name = %w{健康状况 年龄}
    children = children_name.map do |child|
      FactGroup.create(name: child)
    end
    tags = "刚入职，稳定,退休 失业 创业"

    fact_group = FactGroup.create(name: name, children: children, tags: tags)
    expect(fact_group.valid?).to eq(false)
  end

end
