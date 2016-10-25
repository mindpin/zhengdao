@PePatientRecordVisitPage = React.createClass
  getInitialState: ->
    record: @props.data.record

  render: ->
    patient = @props.data.patient

    <div className='doctor-patient-record-visit-page'>
      <PatientBaseInfo patient={patient} />
      <Actions {...@props} />
    </div>


Actions = React.createClass
  render: ->
    switch @props.data.record.landing_status
      when 'WAIT_FOR_PE'
        <PEDeal 
          patient_record={@props.data.record} 
          pe_records={@props.data.pe_records} 
        />

      when 'BACK_TO_DOCTOR'
        <NoDeal text='患者已由医师继续处理' />

      when 'FINISH'
        <NoDeal text='患者正待离馆确认' />