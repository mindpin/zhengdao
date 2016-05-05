class UserState
  include Mongoid::Document
  include Mongoid::Timestamps

  field :on_gurad # true: 在岗 false: 不在岗
  field :on_visit # true: 接诊 false: 空闲

  belongs_to :visiting_patient # 接诊患者
end