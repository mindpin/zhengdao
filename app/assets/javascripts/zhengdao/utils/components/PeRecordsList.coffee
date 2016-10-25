@PeRecordsList = React.createClass
  render: ->
    pe_records = @props.pe_records

    <div className='patient-base-info'>
      {
        for pe_record in pe_records
          <div className='field' key={pe_record.id}>
            <label>{pe_record.name}</label>
            {
              if pe_record.sentences.length
                <div className='icontent'>
                {
                  pe_record.sentences.map (s, idx)->
                    <SentenceShow key={s.id} sentence={s} />
                }
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

    <div className='patient-base-info'>
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