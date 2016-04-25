@DemoAdminHeader = React.createClass
  displayName: 'DemoAdminHeader'
  render: ->
    <div className='page-admin-head'>
      <div className='ui basic segment'>
        <div className='ui basic segment'>
          <h2 className='ui header page-title'>
            <span>{@props.data.title}</span>
            <div className='sub header'>{@props.data.desc}</div>
          </h2>
        </div>

        <div className='ui basic segment secondry-nav'>
          <div className='ui pointing menu'>
            {
              idx = 0
              for item in @props.data.secondary_items
                klass = ['item']
                if (link = @props.data.links?[idx])?
                  href = "#{link}.html"
                  klass.push 'active' if window.get_page_name() == link
                else
                  href = 'javascript:;'
                  klass.push 'disabled'
                <a key={idx++} className={klass.join(' ')} href={href}>{item}</a>
            }
          </div>
        </div>
      </div>
    </div>

  statics:
    Clinic: React.createClass
      displayName: 'DemoAdminHeader.Clinic'
      render: ->
        data =
          title: '店面与人员信息管理'
          desc: '设置分公司与门店机构，部门人员，以及诊疗室，床位信息'
          secondary_items: [
            '分公司信息', '店面信息', '部门信息', '人员信息', '诊疗室与床位信息'
          ],
          links: [
            'clinic', 'clinic-branch', 'clinic-department', 'clinic-person', 'clinic-room'
          ]

        <DemoAdminHeader data={data} />

    Patient: React.createClass
      displayName: 'DemoAdminHeader.Patient'
      render: ->
        data =
          title: '患者信息管理'
          desc: '查看与管理患者档案，病历，以及诊疗回访信息'
          secondary_items: [
            '患者名单', '诊疗记录'
          ],
          links: [
            'patient'
          ]

        <DemoAdminHeader data={data} />

    Register: React.createClass
      displayName: 'DemoAdminHeader.Register'
      render: ->
        data =
          title: '挂号分诊管理'
          desc: '导诊查看诊疗资源，预约与挂号信息，以及进行过号分诊处理'
          secondary_items: [
            '诊疗资源看板', '预约信息', '挂号信息', '分诊管理'
          ]

        <DemoAdminHeader data={data} />

    Charge: React.createClass
      displayName: 'DemoAdminHeader.Charge'
      render: ->
        data =
          title: '收费项目管理'
          desc: '设置收费项目， VIP 等级'
          secondary_items: [
            '收费项目定义', 'VIP 等级定义'
          ]
          links: [
            'charge', 'charge-vip'
          ]

        <DemoAdminHeader data={data} />

    # Plan: React.createClass
    #   displayName: 'DemoAdminHeader.Plan'
    #   render: ->
    #     data =
    #       title: '诊疗方案管理'
    #       desc: '设置各阶段诊疗方案录入项构成'
    #       secondary_items: [
    #         '方案定义', '录入项定义', '诊断模板管理'
    #       ]

    #     <DemoAdminHeader data={data} />

    Resource: React.createClass
      displayName: 'DemoAdminHeader.Resource'
      render: ->
        data =
          title: '药品耗材管理'
          desc: '管理药品耗材的库存信息'
          secondary_items: [
            '库存项目定义', '入库管理', '出库管理', '在库盘点'
          ]
          links: [
            'resource', 'resource-in', 'resource-out', 'resource-balance'
          ]

        <DemoAdminHeader data={data} />

    System: React.createClass
      displayName: 'DemoAdminHeader.System'
      render: ->
        data =
          title: '基础数据定义'
          desc: '定义系统其它功能用到的基础数据'
          secondary_items: [
            '人员岗位定义', '诊疗项目定义', '录入项定义'
          ],
          links: [
            'system', 'system-project', 'system-input-item'
          ]

        <DemoAdminHeader data={data} />