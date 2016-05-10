@WiazrdPatientsList = React.createClass
  render: ->
    <div className='wizard-patients-list common-item-list'>
    {
      for patient in @props.data
        <a key={patient.id} className='item' href={patient.wizard_show_url}>
          <i className='icon user left' />
          <i className='icon angle right' />
          <div className='content'>
            <div className='name'>{patient.name}</div>
            <div className='info'>当前状态：{patient.current_status_info}</div>
          </div>
        </a>
    }
    </div>