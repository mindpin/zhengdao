@ManagerPatientsPage = React.createClass
  render: ->
    <div className='wizard-patients-page'>
      <div className='dashboard-search'>
        <SiteSearch placeholder='根据姓名/身份证/手机号查找患者' url={@props.data.search_url} />
      </div>

      <ManagerPatientsList data={@props.data.patients} />
      <Pagination data={@props.data.paginate} />
    </div>