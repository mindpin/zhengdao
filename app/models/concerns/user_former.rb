module UserFormer
  extend ActiveSupport::Concern

  included do

    former "User" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :login
      field :role
      field :role_str, ->(instance) {
        {'wizard' => '导诊', 'doctor' => '医师', 'pe' => '体检师', 'cure' => '治疗师'}[instance.role]
      }
      field :edit_url, ->(instance) {
        edit_manager_user_path(instance)
      }

      logic :funcs, ->(instance) {
        case instance.role
        when 'admin'
          [
            {
              name: '人员管理',
              icon: 'doctor',
              url: manager_users_path
            },
            {
              name: '患者档案',
              icon: 'newspaper',
              url: manager_path
            },
            {
              name: '系统信息',
              icon: 'configure',
              url: manager_sysinfo_path
            }
          ]
        end
      }
    end

  end
end
