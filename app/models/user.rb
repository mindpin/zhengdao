class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :name, type: String

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  validates :name, presence: true
  validates :name, length: {in: 2..20}, :if => Proc.new {|user|
    user.name.present?
  }

  # -------------------

  field :role
  field :roles, default: [] # wizard, doctor, pe, cure, admin
  field :login
  validates :login, presence: true, uniqueness: { case_sensitive: false }

  def email_required?; false; end
  def email_changed?; false; end

  belongs_to :store

  scope :with_role, ->(role) {
    where roles: role
  }

  scope :without_role, ->(role) {
    where :roles.ne => role
  }

  def role_strs
    re = {}

    self.roles.each {|role|
      re[role.to_sym] = {
        admin:  '管理员',
        wizard: '导诊',
        doctor: '医师',
        pe:     '体检师',
        cure:   '治疗师',
      }[role.to_sym]
    }

    re
  end

  def add_role!(role)
    self.roles.push role
    self.roles.uniq!
    self.save
  end

  def add_roles!(roles)
    roles.each {|role|
      self.roles.push role
    }
    self.roles.uniq!
    self.save
  end

  def set_roles!(roles)
    self.roles = roles
    self.roles.uniq!
    self.save
  end

  def has_role?(role)
    self.roles.map(&:to_s).include? role.to_s
  end
end
