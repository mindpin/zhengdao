module.exports = VectorLayout = React.createClass
  render: ->
    <div className='vector-layout'>
      <YieldComponent component={window.content_component} />
    </div>