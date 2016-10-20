{ Icon } = antd

@TableEditButton = React.createClass
  render: ->
    <div>
      <a href={@props.href}>
        <Icon type='edit' />
        <span style={marginLeft: '0.2rem'}>{@props.text}</span>
      </a>
    </div>