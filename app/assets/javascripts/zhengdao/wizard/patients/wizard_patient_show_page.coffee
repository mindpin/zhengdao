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