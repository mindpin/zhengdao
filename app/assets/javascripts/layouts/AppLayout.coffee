module.exports = AppLayout = React.createClass
  render: ->
    <div className='app-layout'>
      <YieldComponent component={window.content_component} />
    </div>