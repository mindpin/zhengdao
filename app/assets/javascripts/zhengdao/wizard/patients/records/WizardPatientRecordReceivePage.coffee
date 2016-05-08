@WizardPatientRecordReceivePage = React.createClass
  getInitialState: ->
    reg_worker_id: @props.data.record.reg_worker_id
    next_visit_worker_id: @props.data.record.reg_worker_id

  render: ->
    patient = @props.data.patient
    record = @props.data.record
    constraint_workers = @props.data.constraint_workers

    <div className='wizard-patient-record-receice-page'>
      <div className='ui message warning'>
        正在对挂号进行接诊处理，确认后，当前患者将交由对应医师/体检师/治疗师接待
      </div>
      <div className='ui segment'>
        <ActiveRecordInfo patient={patient} record={record} />
      </div>

      {
        if record.is_today
          <div>
            <WizardPatientRecordReceivePage.Assign parent={@} data={record} constraint_workers={constraint_workers} />

            <div className='ui segment'>
              {
                klass = new ClassName
                  'ui button green': true
                  'disabled': jQuery.is_blank(@state.next_visit_worker_id)

                console.log @state.next_visit_worker_id

                <a className={klass} onClick={@confirm_receive}><i className='icon check' /> 确定</a>
              }
            </div>
          </div>
        else
          <div className='ui segment'>预约日期未到，现在不能处理</div>
      }


    </div>

  confirm_receive: ->
    jQuery.modal_confirm
      text: '确定接待该挂号吗？'
      yes: =>
        jQuery.ajax
          type: 'PUT'
          url: @props.data.record.wizard_do_receive_url
          data:
            next_visit_worker_id: @state.next_visit_worker_id
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
            <span style={lineHeight: '36px'}>指定{record.reg_worker_str}：{record.reg_worker_name}</span>
            <a className='ui button' style={float: 'right'} onClick={@open}>选择{record.reg_worker_str}({constraint_workers.length})</a>
          </div>
        else
          <div className='ui segment select-workers'>
            <div style={marginBottom: '1rem'}>请选择:</div>
            <div>
            {
              for worker in constraint_workers
                klass = new ClassName
                  'worker': true
                  'selected': @state.worker_id == worker.id

                console.log @state.worker_id, worker.id

                <div key={worker.id} className={klass} onClick={@select(worker.id)}>
                  <i className='icon check green' />
                  {worker.name}
                </div>
            }
            </div>
          </div>

      open: ->
        @setState open: true

      select: (worker_id)->
        =>
          @setState worker_id: worker_id
          @props.parent.setState next_visit_worker_id: worker_id