@WizardQueuePage = React.createClass
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

    <div className='wizard-queue-page with-tabs'>
      <div className='tabs'>
        <div className={klass1}>
          <a className='label' href={@props.data.reg_queue_url}>预约({@props.data.reg_queue_count})</a>
        </div>
        <div className={klass2}>
          <a className='label' href={@props.data.landing_queue_url}>在馆(0)</a>
        </div>
      </div>

      <div className='reg-colors'>
        <div><span className='today-color' /> 今天</div>
        <div><span className='other-day-color' /> 将来</div>
      </div>

      <PatientRecordsQueue data={@props.data.records} />
    </div>