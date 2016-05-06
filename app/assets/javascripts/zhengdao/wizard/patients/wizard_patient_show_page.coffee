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

    button =
      <div className='item button'>
        <a className='ui button green mini' href={patient.new_record_url}>
          <i className='icon plus' /> 新增挂号
        </a>
      </div>

    <div className='tabs'>
      <div className={klass1}>
        <a className='label' href={patient.wizard_show_url}>基本信息</a>
      </div>
      <div className={klass2}>
        <a className='label' href={patient.records_info_url}>就诊记录({patient.records_count})</a>
      </div>
      {
        if patient.active_record?
          <div className={klass3}>
            <a className='label' href={patient.active_record_info_url}>挂号信息</a>
          </div>
        else
          {button}
      }
    </div>


@WizardPatientShowPage = React.createClass
  render: ->
    patient = @props.data.patient
    fields = {
      name: '姓名'
      id_card: '身份证号'
      mobile_phone: '手机号'
      symptom_desc: '症状描述'
      personal_pathography: '个人病史'
      family_pathography: '家族病史'
    }

    <div className='wizard-patient-show with-tabs'>
      {
        if patient.records_count == 0
          <div className='ui message warning'>
            患者信息已登记，可通过“新增挂号”发起挂号
          </div>
      }

      <PatientTabs data={patient} active={1} />

      <div className='patient-base-info'>
      {
        for field, text of fields
          <div key={field} className="field #{field}">
            <label>{text}</label>
            <div className='icontent'>{patient[field]}</div>
          </div>
      }
      </div>
    </div>

@WizardPatientRecordsPage = React.createClass
  render: ->
    patient = @props.data.patient

    <div className='wizard-patient-show with-tabs'>
      <PatientTabs data={patient} active={2} />

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

            <a key={record.id} className='record item' href='javascript:;'>
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

@WizardPatientActiveRecordInfoPage = React.createClass
  render: ->
    patient = @props.data.patient
    active_record = patient.active_record || {}

    <div className='wizard-patient-show with-tabs'>
      <PatientTabs data={patient} active={3} />

      <div className='active-record-info tab-content'>
        <div className='info'>
          <label>　就诊人：</label> {patient.name}
        </div>
        <div className='info'>
          <label>预约类型：</label> {active_record.reg_kind_str}
        </div>
        <div className='info'>
          <label>预约时间：</label> {active_record.time_weekday_str}, {active_record.period_str}
        </div>
        <div className='info'>
          <label>指定{active_record.reg_worker_str}：</label> {active_record.reg_worker_name}
        </div>
        <div className='info number'>
          <label>　就诊号({active_record.time_str})：</label> <span className='n'>{active_record.reg_number}</span>
        </div>
      </div>
    </div>