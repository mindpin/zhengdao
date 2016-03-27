@TijianSelectPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='index.html' />
          <span>体检</span>
        </h2>

        <div className='select'>
          <div className="ui cards three">
            <a className="card" href='zd-patient-list.html'>
              <div className="content">
                <div className='yunwen' />
                <div className="ui header"><span>患者队列</span></div>
              </div>
            </a>
            <a className="card" href='tijian-paiban.html'>
              <div className="content">
                <div className='yunwen' />
                <div className="ui header"><span>我的排班</span></div>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>

@ZDPatientListPage = React.createClass
  render: ->
    <div className='zd-patient-list-page'>
      <div className='ui container'>
        <ZDPatientListPage.Dates />
        <ZDPatientListPage.List />
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
            <TopbarBack href='tijian.html' />
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

              <a key={idx} className={klass} href='zd-patient-info.html'>
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