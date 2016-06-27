require 'rails_helper'

RSpec.describe User, type: :model do
  it "创建用户" do
    user = create(:user)
    expect(User.count).to eq(1)
  end

  it "可以给用户添加单一角色" do
    user = create(:user)
    user.add_role! :admin
    expect(User.last.has_role? :admin).to eq(true)
  end

  it "可以给用户添加多个角色" do
    user = create(:user)
    user.add_roles! [:admin, :wizard]
    expect(User.last.has_role? :admin).to eq(true)
    expect(User.last.has_role? :wizard).to eq(true)
  end

  it "可以给用户直接设置多个角色" do
    user = create(:user)
    user.add_roles! [:admin, :wizard]
    user.set_roles! [:wizard, :pe]
    expect(User.last.has_role? :admin).to eq(false)
    expect(User.last.has_role? :wizard).to eq(true)
    expect(User.last.has_role? :pe).to eq(true)
  end

  it "可以根据角色查找用户" do
    user1 = create(:user)
    user2 = create(:user)
    user1.add_roles! [:admin, :wizard]
    user2.add_roles! [:wizard, :pe]

    expect(User.with_role(:wizard).count).to eq(2)
    expect(User.with_role(:wizard)).to eq([user1, user2])

    expect(User.with_role(:pe).count).to eq(1)
    expect(User.with_role(:admin).count).to eq(1)

    expect(User.with_role(:cure).count).to eq(0)
  end

  it "可以查询不属于某个角色的用户" do
    user1 = create(:user)
    user2 = create(:user)
    user1.add_roles! [:admin, :wizard]
    user2.add_roles! [:wizard, :pe]

    expect(User.without_role(:wizard).count).to eq(0)
    expect(User.without_role(:pe).count).to eq(1)
    expect(User.without_role(:admin).count).to eq(1)
    expect(User.without_role(:cure).count).to eq(2)
  end

  it "可以获取用户角色字符串" do
    user1 = create(:user)
    user2 = create(:user)
    user1.add_roles! [:admin, :wizard]
    user2.add_roles! [:wizard, :pe]

    expect(user1.role_strs).to eq({
      admin: '管理员', wizard: '导诊'
    })
    expect(user2.role_strs).to eq({
      wizard: '导诊', pe: '体检师'  
    })
  end
end