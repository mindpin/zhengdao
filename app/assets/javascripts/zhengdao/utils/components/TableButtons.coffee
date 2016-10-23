{ Icon } = antd

@TableEditButton = React.createClass
  render: ->
    <a href={@props.href}>
      <Icon type='edit' />
      <span style={marginLeft: '0.2rem'}>{@props.text}</span>
    </a>

{ Tag } = antd

@TableTags = React.createClass
  render: ->
    <div className='table-tags'>
    {
      for key, value of @props.data
        <Tag key={key}>{value}</Tag>
    }
    </div>

{ Tag, Icon } = antd

@TableIDTags = React.createClass
  render: ->
    <div className='table-tags'>
    {
      for x in @props.data
        <Tag key={x.id}>
          {
            if @props.icon?
              <Icon type={@props.icon} />
          }
          <span style={marginLeft: '0.2rem'}>{x.name}</span>
        </Tag>
    }
    </div>