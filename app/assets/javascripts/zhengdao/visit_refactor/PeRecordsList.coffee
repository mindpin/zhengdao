@PeRecordsList = React.createClass
  render: ->
    pe_records = @props.pe_records

    <div>
      {
        for pe_record in pe_records
          <div className='field' key={pe_record.id}>
            <label>{pe_record.name}</label>
            {
              saved_records = pe_record.saved_records
              if saved_records? and Object.keys(saved_records).length
                <div className='icontent'>
                  <SavedPeRecordShow saved_records={pe_record.saved_records} />
                  <a href="/patient_pe_records/#{pe_record.id}" className='ui button mini'>
                    查看体检记录
                  </a>
                </div>
              else
                <div className='icontent'>
                  <span style={color: '#999'}>体检记录未填写</span>
                </div>
            }
          </div>
      }
    </div>


@CureRecordList = React.createClass
  render: ->
    cure_records = @props.cure_records

    <div>
      {
        for cure_record in cure_records
          <div className='field' key={cure_record.id}>
            <label>{cure_record.name}</label>
            <div className='icontent'>
              {cure_record.conclusion}
            </div>
          </div>
      }
    </div>