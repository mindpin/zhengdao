{ Alert } = antd

module.exports = YieldComponent = React.createClass
  render: ->
    { name, data } = @props.component

    try
      console.debug "render content component: ", name
      component = eval(name)
      React.createElement component, data
    catch e
      <Alert
        message='页面组件渲染错误'
        description="#{e}"
        type='error'
        showIcon
      />
