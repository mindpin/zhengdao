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
        <a className='label' href={patient.wizard_show_url}>基本信息</a>
      </div>
      <div className={klass2}>
        <a className='label' href={patient.active_record_info_url}>就诊信息</a>
      </div>
      <div className={klass3}>
        <a className='label' href={patient.records_info_url}>病历档案({patient.records_count})</a>
      </div>
    </div>


@WizardPatientShowPage = React.createClass
  render: ->
    patient = @props.data.patient

    <div className='wizard-patient-show with-tabs'>
      {
        if patient.records_count == 0
          <div className='ui message warning'>
            患者信息已登记，可通过“新增挂号”发起挂号
          </div>
      }

      <PatientTabs data={patient} active={1} />
      <PatientBaseInfo patient={patient} />

    </div>

@WizardPatientRecordsPage = React.createClass
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
            href = "/wizard/records/#{record.id}/visit"

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

@WizardPatientActiveRecordInfoPage = React.createClass
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

            <div style={marginTop: '1rem', borderTop: 'solid 1px #ececec', paddingTop: '1rem'}>
              <a className='ui button green fluid' href={patient.new_record_url}>
                <i className='icon plus' /> 新增挂号
              </a>
            </div>
          </div>
      }
    </div>

@ActiveRecordInfo = React.createClass
  render: ->
    patient = @props.patient
    active_record = @props.record

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
        <label>挂号时指定{active_record.reg_worker_str}：</label> {active_record.reg_worker_name}
      </div>

      {
        if active_record.next_visit_worker_id?
          <div className='info next-visit-worker'>
            当前{active_record.next_visit_worker_info_str}
          </div>
      }

      <div className='info number'>
        <label>　就诊号({active_record.time_str})：</label>
        <span className='n'>{active_record.reg_number}</span>
      </div>


      <div style={marginTop: '1rem', borderTop: 'solid 1px #ececec', paddingTop: '1rem'}>
        <a className='ui button red fluid' onClick={@reset}>
          <i className='icon refresh' /> 重置流程
        </a>
      </div>

      <div style={marginTop: '1rem', borderTop: 'solid 1px #ececec', paddingTop: '1rem'}>
        <a className='ui button red fluid' onClick={@cancel}>
          <i className='icon trash' /> 撤销流程
        </a>
      </div>
    </div>

  reset: ->
    jQuery.modal_confirm 
      text: '是否要重置该就诊流程到挂号状态？'
      yes: =>
        jQuery.ajax
          type: 'post'
          url: "/records/#{@props.record.id}/reset"
        .done ->
          location.reload()

  cancel: ->
    jQuery.modal_confirm 
      text: '是否要撤销（作废）该流程？'
      yes: =>
        jQuery.ajax
          type: 'post'
          url: "/records/#{@props.record.id}/cancel"
        .done ->
          location.reload()