@RoleIndexPage = React.createClass
  render: ->
    <div className='role-index-page'>
      <DESC />
      <SEARCH />
      <FUNCS />
    </div>

DESC = React.createClass
  render: ->
    data = switch window.current_role
      when 'admin'
        title: '你正在使用管理员角色。'
        text: '你可以在此进行人员管理，查看患者档案，以及查看系统信息。'
      when 'wizard'
        title: '你正在使用导诊角色。'
        text: '你可以在此进行患者登记，调度挂号队列，以及查看资源状态。'
      when 'doctor'
        title: '你正在使用医师角色。'
        text: '你可以在此处理患者就诊队列，安排诊疗环节和记录信息。'
      when 'pe'
        title: '你正在使用体检师角色。'
        text: '你可以在此处理待体检的患者队列。'
      when 'cure'
        title: '你正在使用治疗师角色。'
        text: '你可以在此处理待治疗的患者队列。'


    { Alert } = antd

    <Alert
      message={
        <span>
          <strong>{window.current_user.name}，你好！</strong> {data?.title}
        </span>
      }
      description={data?.text}
      type="info"
      showIcon
    />

FUNCS = React.createClass
  render: ->
    { Icon } = antd

    <div className='funcs'>
    {
      window.role_menus_data.map (group)->
        group.menus.map (m)->
          <a className='func' key={m.href} href={m.href}>
            <Icon type={m.icon} />
            <span className='name'>{m.name}</span>
          </a>
    }
    </div>

SEARCH = React.createClass
  render: ->
    search = switch window.current_role
      when 'admin'
        url: '/manager/search'
      when 'wizard'
        url: '/wizard/search'

    if search?
      <div className='dashboard-search'>
        <SiteSearch placeholder='根据姓名/身份证/手机号查找患者' url={search.url} />
      </div>
    else
      <div />

@SiteSearch = React.createClass
  getInitialState: ->
    query: @props.query || ''
    placeholder: @props.placeholder || '搜索...'
    url: @props.url || '/search'

  render: ->
    <div className='ui icon input'>
      <input type='text' placeholder={@state.placeholder} value={@state.query} onChange={@change} onKeyPress={@enter_submit} />
      <i className='search link icon' onClick={@search}></i>
    </div>

  change: (evt)->
    @setState query: evt.target.value

  search: ->
    if not jQuery.is_blank(@state.query)
      Turbolinks.visit "#{@state.url}/#{@state.query}"

  enter_submit: (evt)->
    if evt.which is 13
      @search()