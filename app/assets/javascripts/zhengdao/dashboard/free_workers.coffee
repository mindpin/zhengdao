@FreeWorkers = React.createClass
  render: ->
    <div className='ui segment workers-status'>
      <div className='header'>
        <i className='icon list' />
        {@props.title}
      </div>

      <div className='ui celled list'>
      {
        for idx in [0...10]
          worker = @props.data[idx]
          <FreeWorkers.Worker key={idx} data={worker} />
      }
      </div>
    </div>

  statics:
    Worker: React.createClass
      render: ->
        if @props.data?
          <div className='item worker'>
            <div className='right floated content'>
              {
                if @props.data.busy
                  <div className='ui label red'>忙碌</div>
                else
                  <div className='ui label green'>空闲</div>
              }
            </div>
            <div className='content'>
              <i className='icon doctor' />
              <span>{@props.data.name}</span>
            </div>
          </div>
        else
          <div className='item'></div>