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