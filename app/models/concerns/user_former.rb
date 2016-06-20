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
      field :store, ->(instance) {
        store = instance.store
        if store.blank?
          {}
        else
          {id: store.id.to_s, name: store.name}
        end
      }
      field :edit_url, ->(instance) {
        edit_manager_user_path(instance)
      }

      logic :scenes, ->(instance) {
        case instance.role
        when 'admin'
          [
            {
              name: '管理功能',
              funcs: [
                {
                  name: '店面管理',
                  icon: 'hospital',
                  url: manager_stores_path
                },
                {
                  name: '人员管理',
                  icon: 'doctor',
                  url: manager_users_path
                },
                {
                  name: '治疗项管理',
                  icon: 'add square',
                  url: manager_pay_defines_path
                },
                {
                  name: '诊断项管理',
                  icon: 'add square',
                  url: manager_pe_defines_path
                },
                {
                  name: '患者档案',
                  icon: 'newspaper',
                  url: manager_patients_path
                },
                {
                  name: '系统信息',
                  icon: 'configure',
                  url: manager_sysinfo_path
                }
              ]
            }
          ]
        when 'wizard'
          [
            {
              name: '导诊',
              funcs: [
                {
                  name: '患者登记',
                  url: new_wizard_patient_path,
                  icon: 'plus circle'
                },
                {
                  name: '患者档案',
                  url: wizard_patients_path,
                  icon: 'newspaper'
                },
                {
                  name: '队列处理',
                  url: wizard_queue_path,
                  icon: 'flag'
                }
              ]
            }
          ]
        when 'doctor'
          [
            {
              name: '医师',
              funcs: [
                {
                  name: '队列处理',
                  url: doctor_queue_path,
                  icon: 'flag'
                },
                # {
                #   name: '工作日历',
                #   url: doctor_calendar_path,
                #   icon: 'calendar'
                # },
                # {
                #   name: '工作记录',
                #   url: doctor_activities_path,
                #   icon: 'list'
                # }
              ]
            }
          ]
        when 'pe'
          [
            {
              name: '体检师',
              funcs: [
                {
                  name: '队列处理',
                  url: pe_queue_path,
                  icon: 'flag'
                },
              ]
            }
          ]
        when 'cure'
          [
            {
              name: '治疗师',
              funcs: [
                {
                  name: '队列处理',
                  url: cure_queue_path,
                  icon: 'flag'
                },
              ]
            }
          ]
        else
          []
        end
      }
    end

  end
end
