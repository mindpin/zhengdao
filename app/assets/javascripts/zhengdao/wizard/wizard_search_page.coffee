@WizardSearchPage = React.createClass
  render: ->
    <div className='wizard-search-page'>
      <div className='dashboard-search'>
        <SiteSearch placeholder='根据姓名/身份证/手机号查找患者' url={@props.data.search_url} query={@props.data.query} />
      </div>

      <div className='patients'>
      {
        for patient in @props.data.patients
          <a key={patient.id} className='item' href={patient.wizard_show_url}>
            <i className='icon user' />
            <i className='icon angle right' />
            <div className='content'>
              <div className='name'>{patient.name}</div>
              <div className='info'>{patient.mobile_phone}, {patient.id_card}</div>
            </div>
          </a>
      }
      </div>
    </div>