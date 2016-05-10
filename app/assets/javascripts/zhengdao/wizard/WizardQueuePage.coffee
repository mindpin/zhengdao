@WizardQueuePage = React.createClass
  render: ->
    queue = @props.data.queue

    klass1 = new ClassName
      'item': true
      'active': queue == 'reg'

    klass2 = new ClassName
      'item': true
      'active': queue == 'landing'

    klass3 = new ClassName
      'item': true
      'active': queue == 'finish'

    records = @props.data.records

    <div className='wizard-queue-page with-tabs'>
      <div className='tabs'>
        <div className={klass1}>
          <a className='label' href={@props.data.reg_queue_url}>预约({@props.data.reg_queue_count})</a>
        </div>
        <div className={klass2}>
          <a className='label' href={@props.data.landing_queue_url}>在馆({@props.data.landing_queue_count})</a>
        </div>
        <div className={klass3}>
          <a className='label' href={@props.data.finish_queue_url}>待离馆({@props.data.finish_queue_count})</a>
        </div>
      </div>

      {
        if queue == 'reg'
          <div className='reg-colors'>
            <div><span className='today-color' /> 今天</div>
            <div><span className='other-day-color' /> 将来</div>
          </div>
      }

      <PatientRecordsQueue data={@props.data.records} />
    </div>