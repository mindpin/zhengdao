@ManagerIndexPage = React.createClass
  render: ->
    <div className='manager-index-page'>
      <div className='ui icon message warning'>
        <i className='icon info circle' />
        你正以超级管理身份登录，你可以在此进行人员管理，查看患者档案，以及查看系统信息
      </div>

      <RolesFuncs data={@props.data.funcs} />
    </div>

@WizardIndexPage = React.createClass
  render: ->
    <div className='manager-index-page'>
      <div className='ui icon message warning'>
        <i className='icon info circle' />
        你正以导诊身份登录，你可以在此进行患者登记，调度挂号队列，以及查看资源状态
      </div>

      <div className='dashboard-search'>
        <SiteSearch placeholder='根据姓名/身份证/手机号查找患者' url={@props.data.search_url} />
      </div>

      <RolesFuncs data={@props.data.funcs} />
    </div>

@DoctorIndexPage = React.createClass
  render: ->
    <div className='manager-index-page'>
      <div className='ui icon message warning'>
        <i className='icon info circle' />
        你正以医师身份登录，你可以在此处理患者就诊队列，安排诊疗环节和记录信息
      </div>

      <RolesFuncs data={@props.data.funcs} />
    </div>

@CureIndexPage = React.createClass
  render: ->
    <div className='manager-index-page'>
      <div className='ui icon message warning'>
        <i className='icon info circle' />
        你正以治疗师身份登录，你可以在此处理患者治疗队列
      </div>

      <RolesFuncs data={@props.data.funcs} />
    </div>