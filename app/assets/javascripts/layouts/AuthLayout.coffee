module.exports = AuthLayout = React.createClass
  render: ->
    <div className='auth-layout'>
      <YieldComponent component={window.content_component} />
    </div>