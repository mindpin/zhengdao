@PatientRecordsQueue = React.createClass
  render: ->
    records = @props.data

    <div className='patient-records-queue'>
      <div className='common-item-list'>
      {
        for record in records
          worker_name = if record.worker? then record.worker.name else '未指定'

          patient = record.patient || {}

          <a key={record.id} className='record item' href='javascript:;'>
            <i className='icon user left' />
            <i className='icon angle right' />
            <div className='content'>
              <div className='patient'>
                {record.number}{patient.name}({patient.gender})
              </div>
              <div className='status'>
                
              </div>
            </div>
          </a>
      }
      </div>
    </div>