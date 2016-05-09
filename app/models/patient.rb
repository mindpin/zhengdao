class Patient
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name # 姓名
  field :gender # 性别
  field :age # 年龄
  field :id_card # 身份证
  field :mobile_phone # 手机号
  field :symptom_desc # 症状描述
  field :personal_pathography # 个人病史
  field :family_pathography # 家族病史

  has_many :patient_records # 挂号及在馆活动记录

  validates :name, presence: true, uniqueness: true
  validates :name, length: {in: 2..10}, :if => Proc.new {|user|
    user.name.present?
  }

  validates :id_card, presence: true, uniqueness: true
  validates :mobile_phone, presence: true

  # 患者当前活动挂号记录
  def active_record
    patient_records.where(is_active: true).first
  end
end