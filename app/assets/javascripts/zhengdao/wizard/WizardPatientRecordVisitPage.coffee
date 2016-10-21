@WizardPatientRecordVisitPage = React.createClass
  getInitialState: ->
    record: @props.data.record

    selected_pe_items: []
    selected_cure_items: []

  render: ->
    patient = @props.data.patient

    <div className='doctor-patient-record-visit-page'>
      <PatientBaseInfo patient={patient} />

      <div className='patient-base-info'>
        <div className='field'>
          <label>初诊记录</label>
          <div className='icontent'>
            {@state.record.first_visit}
          </div>
        </div>
        <div className='field'>
          <label>初诊分析</label>
          <div className='icontent'>
            {@state.record.first_visit_conclusion}
          </div>
        </div>
      </div>

      <div className='patient-base-info'>
        <PeRecordsList pe_records={@state.record.pe_records} />
      </div>

      <div className='patient-base-info'>
        <CureRecordList cure_records={@state.record.cure_records} />
      </div>

      <div className='patient-base-info'>
        <div className='field'>
          <label>综合结论</label>
          <div className='icontent'>
            {@state.record.conclusion}
          </div>
        </div>
      </div>
    </div>

  componentDidMount: ->
    jQuery(ReactDOM.findDOMNode @refs.select0)
      .dropdown()

    jQuery(ReactDOM.findDOMNode @refs.select1)
      .dropdown()

  pe_change: (evt)->
    value = jQuery(ReactDOM.findDOMNode @refs.select0)
      .dropdown('get value')
    value = value[value.length - 1] || []
    @setState selected_pe_items: value

  cure_change: (evt)->
    value = jQuery(ReactDOM.findDOMNode @refs.select1)
      .dropdown('get value')
    value = value[value.length - 1] || []
    @setState selected_cure_items: value

  confirm_pe: ->
    text = [
      '确定安排体检吗？目前安排：'
      @state.selected_pe_items.join(', ')
    ].join('<br/>')

    jQuery.modal_confirm
      text: text
      yes: =>
        # console.log @state.selected_pe_items
        jQuery.ajax
          type: 'PUT'
          url: @state.record.doctor_send_pe_url
          data:
            selected_items: @state.selected_pe_items

        .done (res)->
          window.location.reload()

  confirm_cure: ->
    citems = @props.data.cure_items
      .filter (x)=>
        @state.selected_cure_items.indexOf(x.id) > -1
      .map (x)->
        x.name

    text = [
      '确定安排治疗吗？目前安排：'
      citems.join(', ')
    ].join('<br/>')

    jQuery.modal_confirm
      text: text
      yes: =>
        jQuery.ajax
          type: 'PUT'
          url: @state.record.doctor_send_cure_url
          data:
            selected_items: citems

        .done (res)->
          window.location.reload()

  confirm_finish: ->
    text = '确定结束全部诊疗流程吗？'

    jQuery.modal_confirm
      text: text
      yes: =>
        jQuery.ajax
          type: 'PUT'
          url: @state.record.finish_url

        .done (res)->
          window.location.reload()


SaveableField = React.createClass
  getInitialState: ->
    console.log @props.record[@props.field]

    "#{@props.field}": @props.record[@props.field]
    editing: false

  render: ->
    <div className='field'>
      <label>{@props.label}</label>
      <div className='icontent'>
        {
          if not @state.editing
            <div>
            {
              if not jQuery.is_blank @state[@props.field]
                <div style={marginBottom: '0.5rem'}>{@state[@props.field]}</div>
            }
            <a className='ui button mini' onClick={@open_textarea}><i className='icon pencil' /> 编辑</a>
            </div>
          else
            <div>
            <div className='ui form'>
            <textarea value={@state[@props.field]} rows=5 onChange={@change}></textarea>
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
      url: @props.record.common_update_url
      data:
        record:
          "#{@props.field}": @state[@props.field]
    .done (res)->
      console.log res

  change: (evt)->
    @setState "#{@props.field}": evt.target.value