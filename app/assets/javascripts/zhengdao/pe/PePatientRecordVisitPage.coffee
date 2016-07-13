@PePatientRecordVisitPage = React.createClass
  getInitialState: ->
    record: @props.data.record

    selected_pe_items: []
    selected_cure_items: []

  render: ->
    patient = @props.data.patient

    <div className='doctor-patient-record-visit-page'>
      <div className='ui message warning'>
        为患者填写体检记录
      </div>

      <PatientBaseInfo patient={patient} />

      <RecordsList {...@props} confirm={@confirm} />
    </div>

  confirm: ->
    text = '体检记录填写完毕<br/>结束体检过程，确定吗？'

    jQuery.modal_confirm
      text: text
      yes: =>
        jQuery.ajax
          type: 'PUT'
          url: @state.record.back_to_doctor_url
        .done (res)->
          window.location.reload()

RecordsList = React.createClass
  render: ->
    record = @props.data.record

    switch record.landing_status
      when 'WAIT_FOR_PE'
        <div className='patient-base-info'>
          {
            for pe_record in @props.data.pe_records
              <SaveableRecord key={pe_record.id} label={pe_record.name} record={pe_record} />
          }
          <div className='field' style={padding: '1rem', paddingLeft: '7rem'}>
            <a className='ui button green mini' onClick={@props.confirm}>
              <i className='icon send' /> 记录填写完毕
            </a>
          </div>
        </div>

      when 'BACK_TO_DOCTOR'
        <div className='patient-base-info'>
          <div className='field' style={padding: '1rem'}>患者已由医师继续处理</div>
        </div>

      when 'FINISH'
        <div className='patient-base-info'>
          <div className='field' style={padding: '1rem'}>患者正待离馆确认</div>
        </div>

SaveableRecord = React.createClass
  render: ->
    <div className='field'>
      <label>{@props.label}</label>
      <div className='icontent'>
        <SavedPeRecordShow saved_records={@props.record.saved_records} />
        <a className='ui button mini' href={@props.record.edit_url}>
          <i className='icon pencil' /> 编辑体检记录
        </a>
      </div>
    </div>