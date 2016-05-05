class PatientRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :reg_kind # 挂号类型 DOCTOR, PE, CURE
  field :reg_date, type: Date # 挂号日期
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

  def worker
    User.where(id: self.worker_id).first
  end

  def self.reg_kinds
    { 'DOCTOR' => '普通', 'PE' => '体检', 'CURE' => '治疗' }
  end

  def self.reg_periods
    { 'MORNING' => '上午', 'AFTERNOON' => '下午', 'NIGHT' => '晚间' }
  end

  def self.reg_workers
    { 'DOCTOR' => '医师', 'PE' => '体检师', 'CURE' => '治疗师' }
  end
end