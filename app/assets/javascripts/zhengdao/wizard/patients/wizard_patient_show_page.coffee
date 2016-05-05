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

    <div className='wizard-patient-show'>
      <div className='tabs'>
        <div className='item active'>
          <a className='label' href={patient.wizard_show_url}>基本信息</a>
        </div>
        <div className='item'>
          <a className='label' href={patient.records_url}>就诊记录</a>
        </div>
        <div className='item button'>
          <a className='ui button green mini' href={patient.new_record_url}>
            <i className='icon plus' /> 新增挂号
          </a>
        </div>
      </div>
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

    <div className='wizard-patient-show'>
      <div className='tabs'>
        <div className='item'>
          <a className='label' href={patient.wizard_show_url}>基本信息</a>
        </div>
        <div className='item active'>
          <a className='label' href={patient.records_url}>就诊记录</a>
        </div>
        <div className='item button'>
          <a className='ui button green mini' href={patient.new_record_url}>
            <i className='icon plus' /> 新增挂号
          </a>
        </div>
      </div>

      <div className='patient-records'>
        <div className='records common-item-list'>
        {
          for record in @props.data.records
            worker_name = if record.worker? then record.worker.name else '未指定'

            <a key={record.id} className='record item' href='javascript:;'>
              <i className='icon calendar left' />
              <i className='icon angle right' />
              <div className='content'>
                <div className='date'>
                  {record.reg_kind_str}预约, {record.time_str}, {record.period_str}
                </div>
                <div className='worker'>
                  <span>指定医师：</span>
                  <span>{worker_name}</span>
                </div>
              </div>
            </a>
        }
        </div>
      </div>
    </div>