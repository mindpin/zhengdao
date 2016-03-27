@DemoAdminTable = React.createClass
  displayName: 'DemoAdminTable'
  render: ->
    <div className='demo-admin-table ui basic segment'>
      {
        if @props.data.filters?
          <DemoAdminTable.Filter data={@props.data.filters} />
      }
      
      <DemoAdminTable.Table data={@props.data} />
    </div>

  statics:
    Table: React.createClass
      render: ->
        <div className='ui basic segment table-table'>
          <table className='ui celled table'>
            <thead><tr>
              {
                if not @props.data.no_edit
                  <th></th>
              }
              {
                for name, text of @props.data.fields
                  <th key={name}>{text}</th>
              }
            </tr></thead>
            <tbody>
            {
              idx = 0
              for sdata in @props.data.sample || [{}, {}, {}]
                <tr key={idx++}>
                  {
                    if not @props.data.no_edit
                      <DemoAdminTable.EditTD />
                  }
                  {
                    for name, text of @props.data.fields
                      value = sdata[name]
                      if (manage = @props.data.manage?[name])?
                        link = @props.data.manage_links?[name]
                        <DemoAdminTable.ManageTD key={name} value={value} manage={manage} link={link} />
                      else
                        <DemoAdminTable.CommonTD key={name} value={value} />

                  }
                </tr>
            }
            </tbody>
            <DemoAdminTable.Tfoot data={@props.data} />
          </table>
        </div>

    ManageTD: React.createClass
      render: ->
        [icon, btn_text] = @props.manage
        link = @props.link || 'javascript:;'
        <td className='manage collapsing'>
          <a className='ui compact mini manage button teal basic' href={link}>
            <i className="icon #{icon}" />
            <span>{btn_text}</span>
          </a>
          <DemoAdminTable.TDValue data={@props.value} />
        </td>

    CommonTD: React.createClass
      render: ->
        <td>
          <DemoAdminTable.TDValue data={@props.value} />
        </td>

    EditTD: React.createClass
      render: ->
        <td className='collapsing'>
          <a className='ui compact mini button edit teal'>
            <i className='icon pencil' />
            <span>修改</span>
          </a>
        </td>

    TDValue: React.createClass
      render: ->
        if not @props.data?
          <span className='value'>&nbsp;</span> 
        else if typeof(@props.data) is 'object'
          <div className='value labels'>
          {
            for key, value of @props.data
              <div key={key} className='ui label'>
                <span>{key}</span>
                {
                  if value?
                    <div className='detail'>{value}</div>
                }
              </div>
          }
          </div>
        else
          <span className='value'>{@props.data}</span>

    Filter: React.createClass
      render: ->
        <div ref='filters' className='ui basic segment table-filter'>
        {
          for key, sdata of @props.data
            <div key={key} className="ui floating labeled icon dropdown button mini">
              <i className="filter icon"></i>
              <span className="text disabled">选择{sdata.text}</span>
              <div className="menu">
                <div className="header">
                  <i className="tags icon"></i>
                  <span>根据{sdata.text}过滤</span>
                </div>
                {
                  idx = 0
                  for value in sdata.values
                    <DemoAdminTable.FilterDropDownItem key={idx++} data={value} />
                }
              </div>
            </div>
        }
        </div>

      componentDidMount: ->
        jQuery(@refs.filters).find('.ui.dropdown').dropdown()

    FilterDropDownItem: React.createClass
      render: ->
        if Array.isArray @props.data
          <div className="item">
            <i className="dropdown icon"></i>
            <span>{@props.data[0]}</span>
            <div className='menu'>
            {
              idx = 0
              for value in @props.data[1]
                <DemoAdminTable.FilterDropDownItem key={idx++} data={value} />
            }
            </div>
          </div>
        else
          <div className="item">
            <span>{@props.data}</span>
          </div>

    Tfoot: React.createClass
      render: ->
        <tfoot><tr>
          {
            if not @props.data.no_edit
              <th></th>
          }
          <th colSpan={Object.keys(@props.data.fields).length}>
            <DemoAdminTable.AddButton data={@props.data.add_button} />
            <DemoAdminTable.Pagination />
          </th>
        </tr></tfoot>

    Pagination: React.createClass
      render: ->
        <div className='ui right floated pagination menu'>
          <a className='icon item'><i className='icon left chevron' /></a>
          <a className='item active'>1</a>
          <a className='item'>2</a>
          <a className='item'>3</a>
          <a className='icon item'><i className='icon right chevron' /></a>
        </div>

    AddButton: React.createClass
      render: ->
        if @props.data?
          <a className='ui labeled icon button green'>
            <i className='icon add' />
            <span>{@props.data}</span>
          </a>
        else
          <div></div>

    # -----------------

    Company: React.createClass
      render: ->
        data =
          fields:
            name: '分公司名称'
            address: '地址'
            phone: '电话'
            director: '负责人'
            underlings: '下辖店面'
          manage:
            underlings: ['list', '设置']
          manage_links:
            underlings: 'clinic-branch.html'
          add_button: '增加分公司'
          sample: [
            {
              name: '苏州分公司'
              address: '江苏省苏州市园区娄东路 ** 号'
              phone: '0512-12345678'
              director: '张仲景'
              underlings: '3'
            },
            {
              name: '北京分公司'
              address: '北京市朝阳区北苑路 ** 号'
              phone: '010-12345678'
              director: '孙思邈'
              underlings: '2'
            }
          ]
        <DemoAdminTable data={data} />

    Clinic: React.createClass
      render: ->
        data = 
          fields: 
            name: '店面名称'
            address: '地址'
            phone: '电话'
            director: '负责人'
            belongs_to: '所属分公司'
            beds: '床位数'
          manage:
            beds: ['list', '设置']
          manage_links:
            beds: 'clinic-room.html'
          add_button: '增加店面'
          filters: 
            belongs_to:
              text: '分公司' 
              values: ['苏州分公司', '北京分公司']
          sample: [
            {
              name: '奥体分店'
              address: '北京朝阳区惠新西街 ** 号'
              phone: '010-12345677'
              director: '扁鹊'
              belongs_to: '北京分公司'
              beds: '100'
            },
            {
              name: '芍药居分店'
              address: '北京朝阳区文学馆路 ** 号'
              phone: '010-12345676'
              director: '钱乙'
              belongs_to: '北京分公司'
              beds: '150'
            }
          ]

        <DemoAdminTable data={data} />

    Department: React.createClass
      render: ->
        data = 
          fields: 
            name: '部门名称'
            persons: '部门人员'
          manage:
            persons: ['list', '设置']
          manage_links:
            persons: 'clinic-person.html'
          add_button: '增加部门'
          filters: 
            belongs_to:
              text: '店面' 
              values: [
                ['苏州分公司', ['园区分店', '虎丘区分店', '吴中区分店']]
                ['北京分公司', ['奥体分店', '芍药居分店']]
              ]
          sample: [
            {
              name: '行政部'
              persons: 3
            },
            {
              name: '体检部'
              persons: 10
            },
            {
              name: '诊疗部'
              persons: 10
            },
            {
              name: '后勤部'
              persons: 5
            }
          ]

        <DemoAdminTable data={data} />

    Person: React.createClass
      render: ->
        data = 
          fields: 
            name: '姓名'
            age: '年龄'
            gender: '性别'
            post: '岗位'
            company: '所属分公司'
            clinic: '店面'
            department: '部门'
          add_button: '增加人员'
          filters: 
            clinic:
              text: '店面' 
              values: [
                ['苏州分公司', ['园区分店', '虎丘区分店', '吴中区分店']]
                ['北京分公司', ['奥体分店', '芍药居分店']]
              ]
            department:
              text: '部门'
              values: ['行政部', '体检部', '诊疗部', '后勤部']
          sample: [
            {
              name: '顾慎为'
              age: '32'
              gender: '男'
              post: '体检师'
              company: '北京分公司'
              clinic: '奥体分店'
              department: '体检部'
            }
            {
              name: '霍允'
              age: '29'
              gender: '女'
              post: '助理'
              company: '北京分公司'
              clinic: '奥体分店'
              department: '行政部'
            }
            {
              name: '宁七味'
              age: '53'
              gender: '男'
              post: '诊疗师'
              company: '北京分公司'
              clinic: '奥体分店'
              department: '诊疗部'
            }
            {
              name: '江水瑶'
              age: '42'
              gender: '女'
              post: '诊疗师'
              company: '北京分公司'
              clinic: '奥体分店'
              department: '诊疗部'
            }
          ]

        <DemoAdminTable data={data} />

    Room: React.createClass
      render: ->
        data = 
          fields: 
            name: '诊疗室名称'
            clinic: '所属店面'
            projects: '诊疗项目与床位'
          add_button: '增加诊疗室'
          manage:
            projects: ['setting layout', '调整']
          filters: 
            clinic:
              text: '店面' 
              values: [
                ['苏州分公司', ['园区分店', '虎丘区分店', '吴中区分店']]
                ['北京分公司', ['奥体分店', '芍药居分店']]
              ]
          sample: [
            {
              name: '第一诊疗室'
              clinic: '奥体分店'
              projects: {
                '五官检查': null
                '胸腹检查': 2
              }
            }
            {
              name: '第二诊疗室'
              clinic: '奥体分店'
              projects: {
                '推拿': 10
                '针灸': 10
              }
            }
            {
              name: '第三诊疗室'
              clinic: '奥体分店'
              projects: {
                '刮痧': 10
                '火罐': 10
              }
            }
          ]

        <DemoAdminTable data={data} />

    Post: React.createClass
      render: ->
        data = 
          fields: 
            name: '岗位名称'
            desc: '岗位描述'
            privilege: '岗位权限'
          add_button: '增加岗位'
          manage:
            privilege: ['setting layout', '调整']
          sample: [
            {
              name: '行政管理'
              desc: '**********'
              privilege:
                '店面人员管理': null
                '患者信息管理': null
            }
            {
              name: '导诊'
              desc: '**********'
              privilege:
                '挂号分诊操作': null
            }
            {
              name: '医师'
              desc: '**********'
              privilege:
                '诊疗报告录入': null
                '收费项选取': null
            }
            {
              name: '诊疗师'
              desc: '**********'
              privilege:
                '诊疗报告录入': null
                '收费项选取': null
            }
            {
              name: '后勤助理'
              desc: '**********'
              privilege:
                '药品耗材管理': null
            }
          ]

        <DemoAdminTable data={data} />

    Project: React.createClass
      render: ->
        data = 
          fields: 
            name: '诊疗项目名称'
            type: '类型'
            need_bed: '需要床位'
            input_type: '报告录入方式'
            need_photo:  '需要拍照'
            input_items: '包含录入项'
            template: '模板'
          add_button: '增加诊疗项目'
          filters: 
            type:
              text: '类型' 
              values: ['诊断', '治疗']
          manage:
            input_items: ['list', '设置']
            template: ['setting layout', '调整']
          manage_links:
            input_items: 'system-input-item.html'
          sample: [
            {
              name: '常规体检'
              type: '诊断'
              need_bed: '否'
              input_type: '普通录入'
              input_items: 44
              need_photo: '否'
              template: '有'
            }
            {
              name: '面诊'
              type: '诊断'
              need_bed: '否'
              input_type: '触点录入'
              input_items: 13
              need_photo: '是'
              template: '有'
            }
            {
              name: '背诊'
              type: '诊断'
              need_bed: '是'
              input_type: '触点录入'
              input_items: 9
              need_photo: '是'
              template: '有'
            }
            {
              name: '推拿'
              type: '治疗'
              need_bed: '是'
              input_type: '普通录入'
              input_items: 10
              need_photo: '是'
              template: '有'
            }
          ]

        <DemoAdminTable data={data} />

    InputItem: React.createClass
      render: ->
        data = 
          fields: 
            name: '录入项名称'
            type: '类型'
            unit: '单位'
            values: '枚举值'
          add_button: '增加录入项'
          filters: 
            type:
              text: '类型' 
              values: ['填空', '长记录', '数值', '单选枚举', '多选枚举', '拍照']
          sample: [
            {
              name: '面部照片'
              type: '拍照'
              unit: ''
              values: ''
            }
            {
              name: '舌形'
              type: '多选枚举'
              unit: ''
              values: '老舌, 嫩舌, 胖大, 瘦薄, 芒刺, 裂纹, 齿痕, 光滑'
            }
            {
              name: '体重'
              type: '数值'
              unit: 'kg'
              values: ''
            }
            {
              name: '健康评估'
              type: '长记录'
              unit: ''
              values: ''
            }
            {
              name: '睡眠时间'
              type: '填空'
              unit: ''
              values: ''
            }
          ]

        <DemoAdminTable data={data} />

    ChargeItem: React.createClass
      render: ->
        data = 
          fields: 
            name: '收费项名称'
            price: '单价'
            unit: '单位'
            project: '关联诊疗项'
            resource: '关联药品耗材'
          add_button: '增加收费项'
          sample: [
            {
              name: '体检费'
              price: '¥ 100.00'
              unit: '次'
              project: {
                '常规体检': null
              }
            }
            {
              name: '针灸治疗费'
              price: '¥ 50.00'
              unit: '小时'
              project: {
                '针灸': null
              }
            }
            {
              name: '复诊费'
              price: '¥ 100.00'
              unit: '次'
              project: {
                '面诊' : null
                '背诊' : null
                '脉诊' : null
              }
            }
            {
              name: '板蓝根'
              price: '¥ 8.00'
              unit: 'kg'
              resource: {
                '板蓝根': null
              }
            }
          ]

        <DemoAdminTable data={data} />

    VIP: React.createClass
      render: ->
        data = 
          fields: 
            name: 'VIP 等级'
            desc: '说明'
            off: '折扣'
          add_button: '增加 VIP 等级'
          sample: [
            {
              name: '黄金会员'
              off: '9 折'
            }
            {
              name: '白金会员'
              off: '8.5 折'
            }
            {
              name: '钻石会员'
              off: '8 折'
            }
          ]

        <DemoAdminTable data={data} />

    ResourceItem: React.createClass
      render: ->
        data = 
          fields: 
            name: '库存项目名称'
            desc: '保存方式'
            expire: '有保质期'
            unit: '单位'
          add_button: '增加库存项目'
          sample: [
            {
              name: '板蓝根'
              desc: '干燥保存'
              expire: '是'
              unit: 'kg'
            }
            {
              name: '医用酒精'
              desc: '密封保存'
              expire: '否'
              unit: 'kg'
            }
            {
              name: '棉签'
              desc: '干燥保存'
              expire: '否'
              unit: 'kg'
            }
            {
              name: '玻璃火罐'
              desc: '避光保存'
              expire: '否'
              unit: 'kg'
            }
          ]

        <DemoAdminTable data={data} />

    ResourceIn: React.createClass
      render: ->
        data = 
          fields: 
            name: '入库项目'
            count: '入库数量'
            time: '入库时间'
            person: '操作人'
          no_edit: true
          add_button: '入库登记'
          sample: [
            {
              name: '板蓝根'
              count: '100 kg'
              time: '2015-12-18 17:30'
              person: '孙思邈'
            }
            {
              name: '板蓝根'
              count: '50 kg'
              time: '2015-12-18 17:30'
              person: '孙思邈'
            }
            {
              name: '医用酒精'
              count: '10 kg'
              time: '2015-12-18 17:30'
              person: '孙思邈'
            }
          ]

        <DemoAdminTable data={data} />

    ResourceOut: React.createClass
      render: ->
        data = 
          fields: 
            name: '出库项目'
            count: '出库数量'
            time: '出库时间'
            usage: '用途'
            person: '操作人'
          no_edit: true
          sample: [
            {
              name: '板蓝根'
              count: '10 kg'
              time: '2015-12-18 17:30'
              usage: '过期销毁'
              person: '张仲景'
            }
            {
              name: '医用酒精'
              count: '5 kg'
              time: '2015-12-18 17:30'
              usage: '第一诊疗室储备'
              person: '张仲景'
            }
            {
              name: '玻璃火罐'
              count: '50 个'
              time: '2015-12-18 17:30'
              usage: '第二诊疗室储备'
              person: '张仲景'
            }
          ]

        <DemoAdminTable data={data} />

    ResourceBalance: React.createClass
      render: ->
        data = 
          fields: 
            name: '库存项目'
            count: '在库数量'
            operation: '最近操作'
          no_edit: true
          manage: {
            operation: ['list', '明细']
          }
          sample: [
            {
              name: '板蓝根'
              count: '200 kg'
              operation: '2015-12-18 17:30, 出库, 孙思邈'
            }
            {
              name: '医用酒精'
              count: '100 kg'
              operation: '2015-12-18 17:30, 出库, 孙思邈'
            }
            {
              name: '棉签'
              count: '200 kg'
              operation: '2015-12-18 17:30, 出库, 孙思邈'
            }
            {
              name: '玻璃火罐'
              count: '1000 个'
              operation: '2015-12-18 17:30, 出库, 孙思邈'
            }
          ]

        <DemoAdminTable data={data} />