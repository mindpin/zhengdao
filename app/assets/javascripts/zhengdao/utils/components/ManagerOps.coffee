{ Icon } = antd

@ManagerOps = React.createClass
  render: ->
    <div style={marginBottom: '10px'}>
      {@props.children}
    </div>

  statics:
    AddButton: React.createClass
      render: ->
        <a className='ant-btn ant-btn-primary ant-btn-lg' href={@props.href}>
          <Icon type='plus-circle-o' />
          <span style={marginLeft: '0.5rem'}>{@props.text}</span>
        </a>