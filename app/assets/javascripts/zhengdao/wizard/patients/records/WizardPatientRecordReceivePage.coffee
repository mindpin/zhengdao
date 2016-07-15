@WizardPatientRecordReceivePage = React.createClass
  getInitialState: ->
    record = @props.data.record
    reg_worker_id = record.reg_worker_id
    
    next_visit_worker_id = 
      if record.landing_status == 'NOT_HERE'
        record.reg_worker_id
      else
        record.next_visit_worker_id

    return {
      reg_worker_id: reg_worker_id
      next_visit_worker_id: next_visit_worker_id
    }


  render: ->
    patient = @props.data.patient
    record = @props.data.record
    constraint_workers = @props.data.constraint_workers

    <div className='wizard-patient-record-receice-page'>
      {
        if record.landing_status == 'NOT_HERE'
          <div className='ui message warning'>
            正在对挂号进行接诊处理，确认后，当前患者将交由对应医师/体检师/治疗师接待
          </div>
      }
      <div className='ui segment'>
        <ActiveRecordInfo patient={patient} record={record} />
      </div>

      {
        status =
          <div className='ui segment'>
            <div>当前状态：{record.landing_status_str}</div>
          </div>

        assign_form = 
          <WizardPatientRecordReceivePage.Assign 
            parent={@} 
            data={record} 
            constraint_workers={constraint_workers} 
          />

        select_btn = (message)=>
          <div className='ui segment'>
            {
              klass = new ClassName
                'ui button green': true
                'disabled': jQuery.is_blank(@state.next_visit_worker_id)

              <a className={klass} onClick={@confirm_next_visit_worker(message)}>
                <i className='icon check' /> 确定分配
              </a>
            }
          </div>


        if record.landing_status == 'FINISH'
          <div>
            {status}

            <div className='ui segment'>
              {
                klass = new ClassName
                  'ui button green mini': true

                <a className={klass} onClick={@confirm_go_away}>
                  <i className='icon sign out' /> 确认离馆
                </a>
              }
            </div>
          </div>


        else if record.landing_status == 'NOT_HERE'
          if record.is_today
            # 接待挂号时，由导诊选择治疗师/体检师

            <div>
              {status}
              {assign_form}
              {select_btn '确定接待该挂号患者吗？'}
            </div>
          else
            <div className='ui segment'>不在预约日期，现在不能处理</div>


        else
          # 医师分配治疗或体检时，由导诊选择治疗师/体检师

          <div>
            {status}
            {assign_form}
            {select_btn '确定这样指定吗？'}
          </div>
      }
    </div>


  confirm_next_visit_worker: (message)->
    =>
      if jQuery('#next-visit-worker-select').length
        next_visit_worker_id = jQuery('#next-visit-worker-select').val()
        next_visit_worker_id = null if next_visit_worker_id == 'none'
      else
        next_visit_worker_id = @state.next_visit_worker_id

      @_confirm_next_visit_worker message, next_visit_worker_id


  _confirm_next_visit_worker: (message, next_visit_worker_id)->
    console.log "next_visit_worker_id:", next_visit_worker_id

    if jQuery.is_blank(next_visit_worker_id)
      alert '错误：未选择任何接诊人'
      return

    jQuery.modal_confirm
      text: message
      yes: =>
        jQuery.ajax
          type: 'PUT'
          url: @props.data.record.wizard_do_receive_url
          data:
            next_visit_worker_id: next_visit_worker_id
        .done (res)->
          Turbolinks.visit '/wizard/queue'


  confirm_go_away: ->
    jQuery.modal_confirm
      text: '确定该患者离馆吗？'
      yes: =>
        jQuery.ajax
          type: 'PUT'
          url: @props.data.record.wizard_do_receive_url
        .done (res)->
          Turbolinks.visit '/wizard/queue'

  statics:
    Assign: React.createClass
      getInitialState: ->
        open: false
        worker_id: @props.data.reg_worker_id

      render: ->
        record = @props.data
        constraint_workers = @props.constraint_workers

        if @state.open == false
          <div className='ui segment'>
            {
              if record.landing_status == 'NOT_HERE'
                <div>
                <span style={lineHeight: '36px'}>指定{record.reg_worker_str}：{record.reg_worker_name}</span>
                <a className='ui button' style={float: 'right'} onClick={@open}>选择{record.reg_worker_str}({constraint_workers.length})</a>
                </div>
              else if record.landing_status == 'WAIT_FOR_ASSIGN_PE'
                <div>
                <a className='ui button' onClick={@open}>选择体检师({constraint_workers.length})</a>
                </div>
              else if record.landing_status == 'WAIT_FOR_ASSIGN_CURE'
                <div>
                <a className='ui button' onClick={@open}>选择治疗师({constraint_workers.length})</a>
                </div>

            }
          </div>
        else
          <div className='ui segment select-workers'>
            <select id='next-visit-worker-select' className='ui dropdown' onChange={@select_worker_id} value={@state.worker_id} ref='select'>
              <option value={'none'}>请选择</option>
            {
              for worker in constraint_workers
                <option key={worker.id} value={worker.id}>{worker.name}</option>
            }
            </select>
          </div>

      open: ->
        @setState open: true

      select_worker_id: (evt)->
        worker_id = evt.target.value
        worker_id = null if worker_id == 'none'

        @setState worker_id: worker_id
        @props.parent.setState next_visit_worker_id: worker_id

      componentDidUpdate: ->
        $dom = jQuery React.findDOMNode @refs.select
        $dom.dropdown()