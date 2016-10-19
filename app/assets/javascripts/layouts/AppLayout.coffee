module.exports = AppLayout = React.createClass
  render: ->
    style = {
      padding: 20
    }

    <div className='app-layout' style={style}>
      <YieldComponent component={window.content_component} />
    </div>