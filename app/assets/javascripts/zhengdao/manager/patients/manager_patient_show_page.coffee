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
        <a className='label' href={patient.manager_records_info_url}>就诊记录({patient.records_count})</a>
      </div>
      {
        if patient.active_record?
          <div className={klass3}>
            <a className='label' href={patient.manager_active_record_info_url}>挂号信息</a>
          </div>
      }
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
    active_record = patient.active_record || {}

    <div className='wizard-patient-show with-tabs'>
      <PatientTabs data={patient} active={3} />

      <ActiveRecordInfo patient={patient} record={active_record} />
    </div>



@ManagerPatientEditPage = React.createClass
  render: ->
    {
      TextInputField
      TextAreaField
      SelectField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    roles =
      'wizard': '导诊'
      'doctor': '医师'
      'pe': '体检师'
      'cure': '治疗师'

    gender_values = 
      'MALE': '男'
      'FEMALE': '女'

    console.log @props.data

    <div className='ui segment'>
      <SimpleDataForm
        model='patient'
        data={@props.data.patient}
        post={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='姓名：' name='name' required />
        <SelectField {...layout} label='性别：' name='gender' values={gender_values} required />
        <TextInputField {...layout} label='年龄：' name='age' required />
        <TextInputField {...layout} label='身份证号：' name='id_card' required />
        <TextInputField {...layout} label='手机号：' name='mobile_phone' required />
        <TextAreaField  {...layout} label='症状描述：' name='symptom_desc' />
        <TextAreaField  {...layout} label='个人病史：' name='personal_pathography' />
        <TextAreaField  {...layout} label='家族病史：' name='family_pathography' />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit res.wizard_show_url

  cancel: ->
    Turbolinks.visit "/manager/patients/#{@props.data.patient.id}"