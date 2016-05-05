class PatientRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :reg_kind # 挂号类型
  field :reg_date # 挂号日期
  field :reg_period # 挂号时段
  field :worker_id # 指定医师
  field :landing_status # 在馆状态: 'NOT_HERE': 未到馆, 'LANDING': 在馆, 'LEFT': 离开

  field :first_visit # 初诊记录
  field :first_visit_conclusion # 初诊结论

  has_many :pe_records # 体检记录
  field :pe_conclusion # 体检综合结论

  has_many :cure_records # 治疗记录
  field :cure_conclusion # 治疗综合结论

  has_many :pay_items # 费用记录

  belongs_to :patient
end