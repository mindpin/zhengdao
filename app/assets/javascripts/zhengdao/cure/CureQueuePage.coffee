@CureQueuePage = React.createClass
  render: ->
    queue = @props.data.queue

    klass1 = new ClassName
      'item': true
      'active': queue == 'wait'

    klass2 = new ClassName
      'item': true
      'active': queue == 'send'

    records = @props.data.records

    <div className='cure-queue-page with-tabs'>
      <div className='tabs'>
        <div className={klass1}>
          <a className='label' href={@props.data.wait_queue_url}>挂号({@props.data.wait_queue_count})</a>
        </div>
        <div className={klass2}>
          <a className='label' href={@props.data.send_queue_url}>医师推送({@props.data.send_queue_count})</a>
        </div>
      </div>

      <PatientRecordsQueue data={@props.data.records} />
    </div>