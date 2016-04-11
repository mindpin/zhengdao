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
          <FreeWorkers.Worker key={idx} data={worker} queue={@props.queue} />
      }
      </div>
    </div>

  statics:
    Worker: React.createClass
      render: ->
        if @props.data?
          <div className='item worker' onClick={@click}>
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

      click: ->
        if not @props.data.busy
          jQuery.open_modal <FreeWorkers.Assign queue={@props.queue} />

    Assign: React.createClass
      render: ->
        <div className='worker-assign'>
          <div className='header'>队列分配</div>
          <div>以下就诊者符合条件，请从中选择：</div>
          <div className='ui celled list'>
          {
            for p, idx in @props.queue[0...5]
              <div key={idx} className='item patient'>
                <div className='content'>
                  <i className='icon user' />
                  <span>{p.name}</span>
                </div>
              </div>
          }
          </div>
        </div>