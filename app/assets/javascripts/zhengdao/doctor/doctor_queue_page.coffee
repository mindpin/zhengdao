@DoctorQueuePage = React.createClass
  render: ->
    queue = @props.data.queue

    klass1 = new ClassName
      'item': true
      'active': queue != 'pe' and queue != 'cure'

    klass2 = new ClassName
      'item': true
      'active': queue == 'pe'

    klass3 = new ClassName
      'item': true
      'active': queue == 'cure'

    records = @props.data.records

    <div className='doctor-queue-page with-tabs'>
      <div className='tabs'>
        <div className={klass1}>
          <a className='label' href={@props.data.default_queue_url}>待诊({records.length})</a>
        </div>
        <div className={klass2}>
          <a className='label' href={@props.data.pe_queue_url}>体检中(0)</a>
        </div>
        <div className={klass3}>
          <a className='label' href={@props.data.cure_queue_url}>治疗中(0)</a>
        </div>
      </div>

      <PatientRecordsQueue data={@props.data.records} />
    </div>