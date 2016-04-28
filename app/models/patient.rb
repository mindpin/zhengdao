class Patient
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :id_card
  field :mobile_phone
  field :symptom_desc
  field :personal_pathography
  field :family_pathography

  validates :name, presence: true, uniqueness: true
  validates :name, length: {in: 2..10}, :if => Proc.new {|user|
    user.name.present?
  }

  validates :id_card, presence: true, uniqueness: true
  validates :mobile_phone, presence: true
end