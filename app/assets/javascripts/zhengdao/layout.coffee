@DemoTopMenu = React.createClass
  render: ->
    <div className='ui fixed inverted menu'>
      <div className='ui container'>
        <a className='item' onClick={@show_sidebar}>
          <i className='icon sidebar' />
          <span>显示侧栏菜单</span>
        </a>
      </div>
    </div>

  show_sidebar: ->
    jQuery('body > .sidebar').sidebar('toggle')

@DemoManageSidebar = React.createClass
  render: ->
    <div className='ui left vertical inverted sidebar labeled icon menu visible'>
      <a className='item quit' href='index.html'>
        <i className="icon chevron left circle" />
      </a>

      <DemoManageSidebar.Item icon='setting' text='基础定义' link='system' />
      <DemoManageSidebar.Item icon='hospital' text='店面人员' link='clinic' />
      <DemoManageSidebar.Item icon='yen' text='收费项目' link='charge' />
      <DemoManageSidebar.Item icon='first aid' text='药品耗材' link='resource' />
      <DemoManageSidebar.Item icon='user' text='患者信息' link='patient' />
    </div>

  statics:
    Item: React.createClass
      render: ->
        href = if @props.link then "#{@props.link}.html" else 'javascript:;'
        klass = ['item blue']
        if window.get_page_prefix_name() == @props.link
          klass.push 'active'

        <a className={klass.join(' ')} href={href}>
          <i className="icon #{@props.icon}" />
          <span>{@props.text}</span>
        </a>