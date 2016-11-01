@CurePatientRecordVisitPage = React.createClass
  getInitialState: ->
    record: @props.data.record

    selected_pe_items: []
    selected_cure_items: []

  render: ->
    patient = @props.data.patient

    <div className='doctor-patient-record-visit-page'>
      <div className='ui message warning'>
        为患者填写治疗记录
      </div>

      <PatientBaseInfo patient={patient} />

      {
        record = @props.data.record
        if record.landing_status == 'WAIT_FOR_CURE'
          <div className='patient-base-info'>
          {
            for cure_record in @props.data.cure_records
              <SaveableRecord key={cure_record.id} label={cure_record.name} record={cure_record} />
          }
          {
            <div className='field' style={padding: '1rem', paddingLeft: '7rem'}>
              <a className='ui button green mini' onClick={@confirm}><i className='icon send' /> 记录填写完毕</a>
            </div>
          }
          </div>

        else if record.landing_status == 'BACK_TO_DOCTOR'
          <div className='patient-base-info'>
            <div className='field' style={padding: '1rem'}>患者已由医师继续处理</div>
          </div>

        else if record.landing_status == 'FINISH'
          <div className='patient-base-info'>
            <div className='field' style={padding: '1rem'}>患者正待离馆确认</div>
          </div>
      }
    </div>

  confirm: ->
    text = '治疗记录填写完毕<br/>结束治疗过程，确定吗？'

    jQuery.modal_confirm
      text: text
      yes: =>
        jQuery.ajax
          type: 'PUT'
          url: @state.record.back_to_doctor_url
        .done (res)->
          window.location.reload()

SaveableRecord = React.createClass
  getInitialState: ->
    conclusion: @props.record.conclusion
    editing: false

  render: ->
    <div className='field'>
      <label>{@props.label}</label>

      <div className='icontent'>
        {
          if not @state.editing
            <div>
            {
              if not jQuery.is_blank @state.conclusion
                <div style={marginBottom: '0.5rem'}>{@state.conclusion}</div>
            }
            <a className='ui button mini' onClick={@open_textarea}><i className='icon pencil' /> 编辑</a>
            </div>
          else
            <div>
            <div className='ui form'>
            <textarea value={@state.conclusion} rows=5 onChange={@change} placeholder='填写治疗记录'></textarea>
            </div>
            <a className='ui button mini' onClick={@save}><i className='icon save' /> 保存</a>
            </div>

        }
      </div>
    </div>

  open_textarea: ->
    @setState editing: true

  save: ->
    @setState editing: false
    jQuery.ajax
      type: 'PUT'
      url: @props.record.update_url
      data:
        record:
          conclusion: @state.conclusion
    .done (res)->
      console.log res

  change: (evt)->
    @setState conclusion: evt.target.value