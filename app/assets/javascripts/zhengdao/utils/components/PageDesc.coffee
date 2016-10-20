{ Alert } = antd

@PageDesc = React.createClass
  render: ->
    text = @props.text

    <Alert
      message={<span>{text}</span>}
      type='warning'
    />