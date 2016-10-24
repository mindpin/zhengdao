module UserFormer
  extend ActiveSupport::Concern

  included do
    former "User" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :login
      field :roles
      field :role_strs, ->(instance) { instance.role_strs }
      field :store, ->(instance) {
        store = instance.store
        store.blank? ? {} : {id: store.id.to_s, name: store.name}
      }
      field :edit_url, ->(instance) {
        edit_manager_user_path(instance)
      }

      logic :role_menus, ->(instance) {
        re = {}
        instance.roles.each { |role|
          re[role.to_s] = 
            case role.to_s
            when 'admin'
              [
                {
                  subkey: 'sub-basic',
                  subicon: 'setting',
                  subname: '基本项',
                  menus: [
                    {name: '店面管理', icon: 'hospital', href: manager_stores_path},
                    {name: '人员管理', icon: 'doctor', href: manager_users_path},
                  ]
                },
                {
                  subkey: 'sub-business',
                  subicon: 'setting',
                  subname: '业务项',
                  menus: [
                    {name: '治疗项目维护', icon: 'book', href: manager_pay_defines_path},
                    {name: '体检项目维护', icon: 'book', href: manager_pe_defines_path},
                    {name: '体检字典维护', icon: 'tag', href: manager_pe_facts_path},
                    {name: '患者档案', icon: 'newspaper', href: manager_patients_path},
                  ]
                },
                {
                  subkey: 'sub-demo',
                  subicon: 'setting',
                  subname: '演示',
                  menus: [
                    {name: '业务过程', icon: 'checkered flag', href: manager_business_graph_path},
                    {name: '诊疗流程', icon: 'checkered flag', href: manager_patient_graph_path},
                    {name: '体检示例', icon: 'checkered flag', href: manager_pe_demo_path},
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
        re
      }
    end
  end
end
