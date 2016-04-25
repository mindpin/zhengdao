@PatientQueue = React.createClass
  render: ->
    <div className='ui segment patient-queue'>
      <div className='header'>
        <i className='icon list' />
        {@props.title || '患者队列'} ({@props.data.length})
      </div>
      
      <div className='ui input fluid'>
        <input type='text' placeholder='查找…' />
      </div>
      
      <div className='ui celled list'>
      {
        for idx in [0...10]
          patient = @props.data[idx]
          <PatientQueue.Patient key={idx} data={patient} click={@props.click} />
      }
      </div>
    </div>

  statics:
    Patient: React.createClass
      render: ->
        if @props.data?
          <div className='item patient' onClick={@props.click}>
            <div className='right floated content'>
              <span className='memo'>{@props.data.label}</span>
              <i className='icon chevron right' />
            </div>
            <div className='content'>
              <i className='icon user' />
              <span className='ui label mini'>{@props.data.number}</span>
              <span>{@props.data.name}</span>
            </div>
          </div>
        else
          <div className='item'></div>
