@WizardPatientRecordsNewPage = React.createClass
  getInitialState: ->
    reg_kind: null
    reg_date: new Date
    reg_period: null
    worker_id: null

  render: ->
    <div className='wizard-patient-records-new-page'>
      <div className='step'>
        <h4><i className='icon angle down' /> 挂号类型</h4>
        <div className='ct'>
          <select className='ui dropdown select0' onChange={@change_kind} value={@state.reg_kind} ref='select0'>
          {
            for reg_kind, str of @props.data.reg_kinds
              <option key={reg_kind} value={reg_kind}>{str}</option>
          }
          </select>
        </div>
      </div>
      <div className='step'>
        <h4><i className='icon angle down' /> 选择日期与时段</h4>
        <div className='ct'>
          <div className='desc'>可提前七天挂号</div>
          <select className='ui dropdown sd1' onChange={@change('reg_date')} value={@state.reg_date} ref='sd1'>
            <option value=''>请选择</option>
          {
            for date, idx in @props.data.dates
              str = jQuery.format_date(new Date(date), "M月d日 周w")
              str = "#{str} (今天)" if idx is 0

              <option key={idx} value={date}>{str}</option>
          }
          </select>

          <select className='ui dropdown sd3' onChange={@change('reg_period')} value={@state.reg_period} ref='sd3'>
            <option value=''>选择</option>
            <option value='MORNING'>上午</option>
            <option value='AFTERNOON'>下午</option>
            <option value='NIGHT'>晚间</option>
          </select>
        </div>
      </div>

      {
        if @state.reg_kind?
          worker_str = {
            'DOCTOR': '医师'
            'PE': '体检师'
            'CURE': '治疗师'
          }[@state.reg_kind]

          role = {
            'DOCTOR': 'doctor'
            'PE': 'pe'
            'CURE': 'cure'
          }[@state.reg_kind]

          workers = @props.data.workers.filter (x)->
            x.role == role

          <div className='step'>
            <h4><i className='icon angle down' /> 选择{worker_str}</h4>

            <div className='ct'>
              <select className='ui dropdown' onChange={@change('worker_id')} value={@state.worker_id} ref='select2'>
                <option value={'none'}>不指定</option>
              {
                for worker in workers
                  <option key={idx} value={worker.id}>{worker.name}</option>
              }
              </select>
            </div>
          </div>
      }
      {
        klass = new ClassName
          'ui button green': true
          'disabled': not @is_valid()

        <div className='submit'>
          <a className={klass} href='javascript:;' onClick={@submit}>
            <i className='icon check' /> 确定挂号
          </a>
        </div>
      }
    </div>

  componentDidMount: ->
    $dom = jQuery React.findDOMNode @refs.select0
    $dom.dropdown()
    @setState reg_kind: $dom.val()

    $dom = jQuery React.findDOMNode @refs.sd1
    $dom.dropdown()
    @setState reg_period: $dom.val()

    $dom = jQuery React.findDOMNode @refs.sd3
    $dom.dropdown()
    @setState reg_period: $dom.val()

  componentDidUpdate: ->
    $dom = jQuery React.findDOMNode @refs.select2
    $dom.dropdown()

  change_kind: (evt)->
    @setState 
      reg_kind: evt.target.value
      worker_id: null

  change: (name)->
    (evt)=>
      value = evt.target.value
      if name == 'worker_id' and value == 'none'
        value = null

      @setState "#{name}": value

  is_valid: ->
    (not jQuery.is_blank @state.reg_kind) and 
    (not jQuery.is_blank @state.reg_date) and 
    (not jQuery.is_blank @state.reg_period)

  submit: ->
    console.log @state
    data = @state
    jQuery.ajax
      type: 'POST'
      url: @props.data.submit_url
      data: 
        record: data
    
    .done (res)->
      console.log res