class PatientRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :reg_number # 就诊号（按每天往下排）
  field :reg_kind # 挂号类型 DOCTOR, PE, CURE
  field :reg_date, type: Date # 挂号日期
  field :reg_period # 挂号时段
  
  belongs_to :reg_worker, class_name: "User" # 挂号时指定工作人员
  belongs_to :next_visit_worker, class_name: "User" # 下一接待工作人员
  belongs_to :attending_doctor, class_name: "User" # 当前挂号记录主治医师（仅挂普通类型时）

  field :is_active, type: Boolean, default: true # 该记录是否当前活动记录
  field :is_landing, type: Boolean, default: false # 是否在店
  field :landing_status, type: String, default: 'NOT_HERE' 
  # 在店状态: 
  # 'NOT_HERE': 未在店
  # 'WAIT_FOR_DOCTOR': 待诊
  # 'WAIT_FOR_PE': 待体检
  # 'WAIT_FOR_CURE': 待治疗 
  # 'GO_AWAY': 离开

  field :first_visit # 初诊记录
  field :first_visit_conclusion # 初诊结论

  has_many :pe_records # 体检记录
  field :pe_conclusion # 体检综合结论

  has_many :cure_records # 治疗记录
  field :cure_conclusion # 治疗综合结论

  has_many :pay_items # 费用记录

  belongs_to :patient

  before_create :set_reg_number
  def set_reg_number
    last_record_of_date = 
      PatientRecord.where(reg_date: self.reg_date).desc(:reg_number).first

    if last_record_of_date.present?
      self.reg_number = last_record_of_date.reg_number + 1
    else
      self.reg_number = 1
    end
  end

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

  def self.landing_statuses
    { 'NOT_HERE' => '待接诊', 
      'WAIT_FOR_ASSIGN_PE' => '待分配体检', 'WAIT_FOR_ASSIGN_CURE' => '待分配治疗',
      'WAIT_FOR_DOCTOR' => '待诊', 'WAIT_FOR_PE' => '待体检', 'WAIT_FOR_CURE' => '待治疗',
      'GO_AWAY' => '离开'
    }
  end

  # 该挂号记录的待选 worker
  def constraint_workers(wizard)
    User.where(role: self.reg_kind.downcase, store: wizard.store)
  end

  def assign_visit_worker(next_visit_worker_id)
    self.next_visit_worker_id = next_visit_worker_id
    self.landing_status = "WAIT_FOR_#{self.reg_kind}"
    self.save
  end

  # ----------------------
  # 导诊，预约队列
  def self.wizard_reg_queue
    PatientRecord
      .where(is_active: true, landing_status: 'NOT_HERE', :reg_date.gte => Date.today)
      .asc(:reg_date)
      .asc(:reg_number)
  end

  # 导诊，在馆队列
  def self.wizard_landing_queue
    PatientRecord
      .where(is_active: true, :landing_status.in => ['WAIT_FOR_ASSIGN_PE', 'WAIT_FOR_ASSIGN_CURE'], :reg_date.gte => Date.today)
      .asc(:reg_date)
      .asc(:reg_number)
  end


  # 由指定医师处理的待诊记录
  def self.wait_of_doctor(doctor)
    PatientRecord.where(worker_id: doctor.id.to_s)
  end
end