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
                    {name: '店面管理', icon: 'environment', href: manager_stores_path},
                    {name: '人员管理', icon: 'user', href: manager_users_path},
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
                    {name: '患者档案', icon: 'file-text', href: manager_patients_path},
                  ]
                },
                {
                  subkey: 'sub-demo',
                  subicon: 'setting',
                  subname: '演示',
                  menus: [
                    {name: '业务过程', icon: 'eye', href: manager_business_graph_path},
                    {name: '诊疗流程', icon: 'eye', href: manager_patient_graph_path},
                    {name: '体检示例', icon: 'eye', href: manager_pe_demo_path},
                  ]
                }
              ]
            when 'wizard'
              [
                {
                  subkey: 'sub-dz',
                  subicon: 'setting',
                  subname: '导诊功能',
                  menus: [
                    {name: '患者登记', icon: 'plus', href: new_wizard_patient_path},
                    {name: '患者档案', icon: 'file-text', href: wizard_patients_path},
                    {name: '队列处理', icon: 'clock-circle-o', href: wizard_queue_path},
                  ]
                }
              ]
            when 'doctor'
              [
                {
                  subkey: 'sub-ys',
                  subicon: 'setting',
                  subname: '医师功能',
                  menus: [
                    {name: '队列处理', icon: 'clock-circle-o', href: doctor_queue_path},
                  ]
                }
              ]
            when 'pe'
              [
                {
                  subkey: 'sub-tjs',
                  subicon: 'setting',
                  subname: '医师功能',
                  menus: [
                    {name: '队列处理', icon: 'clock-circle-o', href: pe_queue_path},
                  ]
                }
              ]
            when 'cure'
              [
                {
                  subkey: 'sub-zls',
                  subicon: 'setting',
                  subname: '医师功能',
                  menus: [
                    {name: '队列处理', icon: 'clock-circle-o', href: cure_queue_path},
                  ]
                }
              ]
            end
        }
        re
      }
    end
  end
end
