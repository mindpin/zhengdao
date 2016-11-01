{ Alert } = antd

module.exports = YieldComponent = React.createClass
  render: ->
    { name, data } = @props.component

    try
      if name?
        console.debug "render content component: ", name
        window.__last_component_name = name
      else
        console.debug 'not assign ant component'
        return <div />

      component = eval(name)
      throw "组件 #{name} 没有注册" unless component?
      React.createElement component, data
    catch e
      <Alert
        message='页面组件渲染错误'
        description="#{e}"
        type='error'
        showIcon
      />