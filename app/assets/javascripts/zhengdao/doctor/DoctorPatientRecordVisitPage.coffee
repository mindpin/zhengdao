@DoctorPatientRecordVisitPage = React.createClass
  getInitialState: ->
    record: @props.data.record

    selected_pe_items: []
    selected_cure_items: []

  render: ->
    patient = @props.data.patient

    <div className='doctor-patient-record-visit-page'>
      <div className='ui message warning'>
        填写诊断记录，安排体检以及治疗方案
      </div>

      <PatientBaseInfo patient={patient} />

      <div className='patient-base-info'>
        <SaveableField label='初诊记录' field='first_visit' record={@state.record} />
        <SaveableField label='初诊分析' field='first_visit_conclusion' record={@state.record} />
      </div>

      {
        if @state.record.landing_status == 'WAIT_FOR_DOCTOR' or @state.record.landing_status == 'BACK_TO_DOCTOR' or @state.record.landing_status == 'FINISH'

          <div>
          {
            if @state.record.pe_records.length > 0 or @state.record.landing_status == 'FINISH'
              <div className='patient-base-info'>
                <PeRecordsList pe_records={@state.record.pe_records} />
              </div>
            else
              <div className='patient-base-info'>
                <div className='field'>
                  <label>体检</label>
                  <div className='icontent'>
                    <select multiple className='ui fluid dropdown' ref='select0' onChange={@pe_change}>
                      <option value=''>添加体检项</option>
                      {
                        for pe_define in @props.data.pe_defines
                          <option key={pe_define.id} value={pe_define.id}>{pe_define.name}</option>
                      }
                    </select>
                  </div>
                </div>

                {
                  klass = new ClassName
                    'ui button green mini': true
                    'disabled': @state.selected_pe_items.length == 0

                  <div className='field' style={padding: '1rem', paddingLeft: '7rem'}>
                    <a className={klass} onClick={@confirm_pe}><i className='icon send' /> 安排体检</a>
                  </div>
                }
              </div>
          }

          {
            if @state.record.cure_records.length > 0 or @state.record.landing_status == 'FINISH'
              <div className='patient-base-info'>
                <CureRecordList cure_records={@state.record.cure_records} />
              </div>
            else
              <div className='patient-base-info'>
                <SaveableField label='治疗建议' field='cure_advice' record={@state.record} />
                <div className='field'>
                  <label>治疗</label>
                  <div className='icontent'>
                    <select multiple className='ui fluid dropdown' ref='select1' onChange={@cure_change}>
                      <option value=''>添加治疗项</option>
                      {
                        for cure_item in @props.data.cure_items
                          <option key={cure_item.id} value={cure_item.id}>{cure_item.name}</option>
                      }
                    </select>
                  </div>
                </div>
                {
                  klass = new ClassName
                    'ui button green mini': true
                    'disabled': @state.selected_cure_items.length == 0
                  <div className='field' style={padding: '1rem', paddingLeft: '7rem'}>
                    <a className={klass}  onClick={@confirm_cure}><i className='icon send' /> 安排治疗</a>
                  </div>
                }
              </div>
          }

          <div className='patient-base-info'>
            <SaveableField label='综合结论' field='conclusion' record={@state.record} />
            {
              if @state.record.landing_status != 'FINISH'
                <div className='field' style={padding: '1rem', paddingLeft: '7rem'}>
                  <a className='ui button blue mini' onClick={@confirm_finish}><i className='icon check' /> 结束诊疗流程</a>
                </div>
              else
                <div className='field' style={padding: '1rem'}>诊疗流程已结束</div>
            }
          </div>
          </div>
      
        else if @state.record.landing_status == 'WAIT_FOR_ASSIGN_PE' or @state.record.landing_status == 'WAIT_FOR_PE'
          <div className='patient-base-info'>
          {
            for pe_record in @state.record.pe_records
              <div key={pe_record.id} className='field'>
                <label>{pe_record.name}</label>
                <div className='icontent'>正在进行体检</div>
              </div>
          }
          </div>

        else if @state.record.landing_status == 'WAIT_FOR_ASSIGN_CURE' or @state.record.landing_status == 'WAIT_FOR_CURE'
          <div className='patient-base-info'>
          {
            for pe_record in @state.record.cure_records
              <div key={pe_record.id} className='field'>
                <label>{pe_record.name}</label>
                <div className='icontent'>正在进行治疗</div>
              </div>
          }
          </div>
      }


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
      '确定安排体检吗？目前安排了：'
      @props.data.pe_defines
        .filter (pd)=>
          @state.selected_pe_items.indexOf(pd.id) > -1
        .map (pd)=>
          pd.name
        .join '，'
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