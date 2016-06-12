@WizardSearchPage = React.createClass
  render: ->
    <div className='wizard-search-page'>
      <div className='dashboard-search'>
        <SiteSearch placeholder='根据姓名/身份证/手机号查找患者' url={@props.data.search_url} query={@props.data.query} />
      </div>

      <WiazrdPatientsList data={@props.data.patients} />
    </div>