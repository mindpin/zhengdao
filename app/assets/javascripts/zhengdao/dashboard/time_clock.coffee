@TimeClock = React.createClass
  getInitialState: ->
    status: false
  render: ->
    s0 = jQuery.format_date new Date, 'hh:mm'
    s1 = jQuery.format_date new Date, 'ss'

    <div className='time-clock'>
      <span>{s0}</span><span className='second'>:{s1}</span>
    </div>

  componentDidMount: ->
    @timer = setInterval =>
      @setState status: !@state.status
    , 10

  componentDidUnmount: ->
    clearInterval @timer