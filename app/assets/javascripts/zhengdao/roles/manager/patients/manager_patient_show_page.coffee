PatientTabs = React.createClass
  render: ->
    patient = @props.data

    klass1 = new ClassName
      'item': true
      'active': @props.active == 1

    klass2 = new ClassName
      'item': true
      'active': @props.active == 2

    klass3 = new ClassName
      'item': true
      'active': @props.active == 3

    <div className='tabs'>
      <div className={klass1}>
        <a className='label' href={patient.manager_show_url}>基本信息</a>
      </div>
      <div className={klass2}>
        <a className='label' href={patient.manager_active_record_info_url}>就诊信息</a>
      </div>
      <div className={klass3}>
        <a className='label' href={patient.manager_records_info_url}>病历档案({patient.records_count})</a>
      </div>
    </div>


@ManagerPatientShowPage = React.createClass
  render: ->
    patient = @props.data.patient

    <div className='wizard-patient-show with-tabs'>
      {
        if patient.records_count == 0
          <div className='ui message warning'>
            患者目前没有挂号记录
          </div>
      }

      <PatientTabs data={patient} active={1} />
      <PatientBaseInfo patient={patient} />
      <div style={padding: '0 1rem'}>
        <a className='ui button green' href={"/manager/patients/#{patient.id}/edit"} >
          <i className='icon edit' /> 修改信息
        </a>
      </div>
    </div>

@ManagerPatientRecordsPage = React.createClass
  render: ->
    patient = @props.data.patient

    <div className='wizard-patient-show with-tabs'>
      <PatientTabs data={patient} active={3} />

      <div className='patient-records'>
        <div className='records common-item-list'>
        {
          if patient.records_count == 0
            <div className='ui segment basic'>
              该患者目前没有就诊记录
            </div>
        }
        {
          for record in @props.data.patient.records
            worker_name = if record.worker? then record.worker.name else '未指定'
            href = "/manager/records/#{record.id}/visit"

            <a key={record.id} className='record item' href={href}>
              <i className='icon calendar left' />
              <i className='icon angle right' />
              <div className='content'>
                <div className='date'>
                  {record.reg_kind_str}预约, {record.time_str}, {record.period_str}
                </div>
                <div className='worker'>
                  <span>指定{record.reg_worker_str}：</span>
                  <span>{record.reg_worker_name}</span>
                </div>
              </div>
            </a>
        }
        </div>
      </div>
    </div>

@ManagerPatientActiveRecordInfoPage = React.createClass
  render: ->
    patient = @props.data.patient
    active_record = patient.active_record
    
    <div className='wizard-patient-show with-tabs'>
      <PatientTabs data={patient} active={2} />
      {
        if active_record?
          <ActiveRecordInfo patient={patient} record={active_record} />
        else
          <div className='tab-content'>
            <div className='desc' style={padding: '1rem 0'}>
              患者目前未就诊
            </div>
          </div>
      }
    </div>