puts '删除 PeDefine'
PeDefine.destroy_all
puts '删除 PeFact'
PeFact.destroy_all

puts '清空 PeRecord'
PeRecord.destroy_all

puts '创建腹诊示例'
pd = PeDefine.create(name: '腹诊')

pd.facts << PeFact.create({
  name: '状态', 
  tag_names: %w{隆起 结节 凹陷 凸起 瘀点 脱屑 长痘 水槽}
})
pd.facts << PeFact.create({
  name: '形态', 
  tag_names: %w{条索状 陵状 细条状 圆形 椭圆}
})
pd.facts << PeFact.create({
  name: '硬度', 
  tag_names: %w{柔软 硬 坚实}
})
pd.facts << PeFact.create({
  name: '感受', 
  tag_names: %w{明显压痛 不明显压痛 痒 转动感 松弛 敏感 冷 热}
})
pd.facts << PeFact.create({
  name: '颜色', 
  tag_names: %w{青 黑 黄 红 白}
})