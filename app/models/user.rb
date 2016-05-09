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

  field :role # wizard, doctor, pe, cure, admin
  field :login
  validates :login, presence: true, uniqueness: { case_sensitive: false }

  def email_required?; false; end
  def email_changed?; false; end

  # has_one :worker_state
  belongs_to :store

  def role_str
    {
      'wizard' => '导诊',
      'doctor' => '医师',
      'pe' => '体检师',
      'cure' => '治疗师',
    }[self.role]
  end
end
