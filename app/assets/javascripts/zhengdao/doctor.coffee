@DoctorSelectPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='index.html' />
          <span>医师</span>
        </h2>

        <div className='select'>
          <div className="ui cards three">
            <a className="card" href='doctor-patient-list.html'>
              <div className="content">
                <div className='yunwen' />
                <div className="ui header"><span>患者队列</span></div>
              </div>
            </a>
            <a className="card" href='doctor-paiban.html'>
              <div className="content">
                <div className='yunwen' />
                <div className="ui header"><span>我的排班</span></div>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>


@DoctorPatientListPage = React.createClass
  render: ->
    <div className='zd-patient-list-page'>
      <div className='ui container'>
        <DoctorPatientListPage.Dates />
        <DoctorPatientListPage.List />
      </div>
    </div>

  statics:
    Dates: React.createClass
      render: ->
        dates = [
          ['12-08，星期二，上午', '8/10']
          ['12-08，星期二，下午', '14/20']
          ['12-09，星期三，上午', '2/10']
          ['12-09，星期三，下午', '1/20']
        ]

        <div className='dates'>
          <h2 className='ui header topbar'>
            <TopbarBack href='doctor.html' />
            就诊日期
          </h2>
          <div className='dlist'>
          {
            for date, idx in dates
              klass = new ClassName {
                'ditem': true
                'active': idx == 0
              }

              <a key={idx} className={klass} href='javascript:;'>
                <span>{date[0]}</span>
                <span className='persons-number'>
                  <span>{date[1]}</span>
                  <i className='icon chevron right' />
                </span>
              </a>
          }
          </div>
        </div>

    List: React.createClass
      render: ->
        patients = [
          ['301', '王大锤', '男']
          ['302', '张本煜', '男']
          ['303', '小爱', '女']
          ['304', '孔连顺', '女']
          ['305', '刘循子墨', '男']
          ['306', '易小星', '男']
          ['307', '至尊玉', '男']
          ['308', '葛布', '女']
        ]

        <div className='list'>
          <h2 className='ui header topbar'>患者队列</h2>
          <div className='plist'>
          {
            for patient, idx in patients
              klass = new ClassName {
                'pitem': true
              }

              <a key={idx} className={klass} href='doctor-patient-info.html'>
                <span className='ui label'>{patient[0]}</span>
                <span> - </span>
                <span>{patient[1]}</span>
                <span> - </span>
                <span>{patient[2]}</span>
                <span className='tail'>
                  <i className='icon chevron right' />
                </span>
              </a>
          }
          </div>
        </div>


@DoctorPatientInfoPage = React.createClass
  getInitialState: ->
    active: 0
  render: ->
    <div className='zd-patient-info-page doctor-pinfo'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='doctor-patient-list.html' />
          <span>患者信息</span>
        </h2>

        <div className='table-div'>

          <PatientInfo />

          {
            klass0 = new ClassName
              'item': true
              'active': @state.active == 0
            klass1 = new ClassName
              'item': true
              'active': @state.active == 1
            klass2 = new ClassName
              'item': true
              'active': @state.active == 2
            klass3 = new ClassName
              'item': true
              'active': @state.active == 3

            <div className="ui four item menu">
              <a className={klass0} onClick={@select0}>首页</a>
              <a className={klass1} onClick={@select1}>诊断</a>
              <a className={klass2} onClick={@select2}>体检</a>
              <a className={klass3} onClick={@select3}>治疗</a>
            </div>
          }

        <div className='timeline'>
          {
            timeline_data = [
              {
                kind: '挂号'
                date: '2015-12-03'
                info: [
                  ['预约医师', '李海峰（副主任医师 - 内科）']
                  ['就诊时间', '2015-12-08（星期二）下午']
                  ['门诊类型', '专家门诊（14元）']
                ]
                jiaofei: false
              }
              {
                kind: '治疗'
                date: '2015-11-16'
                info: [
                  ['预约床位', '201（双人房-东向）']
                  ['治疗时间', '2015-11-05 14:00']
                  ['治疗记录', <a href='javascript:;'>查看详情</a>]
                ]
                jiaofei: true
              }
              {
                kind: '体检'
                date: '2015-11-16'
                info: [
                  ['体检医师', '游琼']
                  ['就诊时间', '2015-11-16（星期一）上午']
                  ['体检报告', <a href='javascript:;'>查看详情</a>]
                ]
                jiaofei: true
              }
              {
                kind: '诊断'
                date: '2015-11-05'
                info: [
                  ['主治医师', '李海峰']
                  ['就诊时间', '2015-11-05（星期四）上午']
                  ['诊断报告', <a href='doctor-zhenduan.html'>查看详情</a>]
                ]
                jiaofei: true
              }
              {
                kind: '挂号'
                date: '2015-11-03'
                info: [
                  ['预约医师', '李海峰']
                  ['预约时间', '2015-11-05（星期四）上午']
                  ['门诊类型', '专家门诊']
                ]
              }
            ]
            for item, idx in timeline_data
              if @state.active == 0
                display = true
              else
                display = ['', '诊断', '体检', '治疗'][@state.active] == item.kind

              if display
                <div key={idx} className='tl-item'>
                  {
                    if item.jiaofei != undefined
                      if item.jiaofei
                        <div className='jiaofei ui label green'>已缴费</div>
                      else
                        <div className='jiaofei ui label red'>未缴费</div>
                  }
                  <div className='dh'>
                    <span className='dlabel'>{item.kind}</span>
                    <span className='date'> - {item.date}</span>
                  </div>
                  {
                    for arr, idx1 in item.info
                      <div key={idx1}>
                        <span>{arr[0]}：</span>
                        {arr[1]}
                      </div>
                  }
                </div>
          }
        </div>

        </div>
      </div>
    </div>

  select0: ->
    @setState active: 0
  select1: ->
    @setState active: 1
  select2: ->
    @setState active: 2
  select3: ->
    @setState active: 3

PatientInfo = React.createClass
  render: ->
    <div className='ui segment patient-info'>
      <div className='avatar' style={'backgroundImage':'url(http://i.teamkn.com/i/jdXKi54u.png)', 'backgroundSize':'cover', 'width':'120px', 'height':'120px'}></div>
      <div className='content'>
        <h3 className='ui header name'>王大锤</h3>
        <div className='info'>
          <span>男，33岁，诊疗卡号：</span>
          <span className='id'>1234567</span>
        </div>
        <div className='info'>既往史：无</div>
        <div className='info'>家族史：无</div>
      </div>
      <a href='doctor-pay.html' className='doctor-pay ui orange button'>
        <i className='icon rmb' />
        结清缴费
      </a>
    </div>


@DoctorPayPage = React.createClass
  getInitialState: ->
    pays: [
      ['基础体检', '次', '10.00', 1, '10.00']
      ['舌诊', '次', '20.00', 1, '20.00']
      ['脉诊', '次', '30.00', 1, '30.00']
    ]
  render: ->
    <div className='zd-patient-info-page pay'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='doctor-patient-info.html' />
          <span>患者信息</span>
        </h2>
        <div className='table-div'>
          <PatientInfo />

          <div className='pay-items ui segment'>
            <h3 className='ui header'>尚未缴费项</h3>

            <table className='ui celled table'>
              <thead><tr>
              <th>
                <input type="checkbox" onChange={@toggle_all} />
              </th><th>项目</th><th>单位</th><th>单价</th><th>数量</th><th>金额</th>
              </tr></thead>
              <tbody>
              {
                total = 0
                for item, idx in @state.pays
                  if item[5]
                    total = total + parseInt(item[4])
                  <tr key={idx}>
                    <td className='collapsing'>
                      <input type="checkbox" checked={item[5]} onChange={@toggle(idx)} />
                    </td>
                    <td>{item[0]}</td>
                    <td>{item[1]}</td>
                    <td>{item[2]}</td>
                    <td>{item[3]}</td>
                    <td>{item[4]}</td>
                  </tr>
              } 
              </tbody>
            </table>
            {
              <h3 className='ui header small total'>总计：¥ {total}</h3>
            }
            {
              klass = new ClassName
                'ui button orange': true
                'disabled': total is 0
              <a href='doctor-patient-info.html' className={klass}>
                <i className='icon rmb' />
                确定缴费
              </a>
            }
          </div>
        </div>
      </div>
    </div>

  toggle_all: (evt)->
    checked = evt.target.checked
    pays = @state.pays
    for p in pays
      p[5] = checked
    @setState pays: pays

  toggle: (idx)->
    (evt)=>
      checked = evt.target.checked
      pays = @state.pays
      pays[idx][5] = checked
      @setState pays: pays