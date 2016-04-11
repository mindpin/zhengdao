@DashboardPage = React.createClass
  render: ->
    <div className='dashboard'>{@props.children}</div>

  statics:
    Guide: React.createClass
      getInitialState: ->
        yuyue_queue: @props.data.yuyue_queue
        zaiguan_queue: @props.data.zaiguan_queue
        free_doctor: @props.data.free_doctor
        free_pe: @props.data.free_pe
        free_treat: @props.data.free_treat

      render: ->
        <DashboardPage>
          <div className='ui grid queues'>
            <div className='three column row'>
              <div className='column stat'>
                <DashboardPage.GuideStat />
              </div>
              <div className='column'>
                <PatientQueue data={@state.yuyue_queue} title='预约队列' />
              </div>
              <div className='column'>
                <PatientQueue data={@state.zaiguan_queue} title='在馆队列' />
              </div>
            </div>
          </div>

          <div className='ui grid workers'>
            <div className='three column row'>
              <div className='column'>
                <FreeWorkers data={@state.free_doctor} title='医师状态' />
              </div>
              <div className='column'>
                <FreeWorkers data={@state.free_pe} title='体检师状态' />
              </div>
              <div className='column'>
                <FreeWorkers data={@state.free_treat} title='治疗师状态' />
              </div>
            </div>
          </div>
        </DashboardPage>

    GuideStat: React.createClass
      render: ->
        <div className='ui segment'>
          <TimeClock />
          <div className='ui buttons fluid'>
            <a href='javascript:;' className='ui button basic brown large' onClick={@add_yuyue}>
              <i className='icon plus' /> 增加预约
            </a>
            <a href='javascript:;' className='ui button basic brown large'>
              <i className='icon plus' /> 增加挂号
            </a>
          </div>
        </div>

      add_yuyue: ->
        jQuery.open_modal <div>增加预约</div>

    # --------------------------------

    Doctor: React.createClass
      getInitialState: ->
        wait_queue: @props.data.yuyue_queue
        tijian_queue: @props.data.zaiguan_queue
        zhiliao_queue: @props.data.zaiguan_queue

      render: ->
        <DashboardPage>
          <div className='ui grid queues'>
            <div className='four column row'>
              <div className='column'>
                <DashboardPage.GuideStat {...@state} />
              </div>
              <div className='column'>
                <PatientQueue data={@state.wait_queue} title='待诊' />
              </div>
              <div className='column'>
                <PatientQueue data={@state.tijian_queue} title='体检中' />
              </div>
              <div className='column'>
                <PatientQueue data={@state.zhiliao_queue} title='治疗中' />
              </div>
            </div>
          </div>
        </DashboardPage>

    # -------------------------

    PE: React.createClass
      getInitialState: ->
        wait_queue: @props.data.yuyue_queue
        tijian_queue: @props.data.zaiguan_queue
        zhiliao_queue: @props.data.zaiguan_queue

      render: ->
        <DashboardPage>
          <div className='ui grid queues'>
            <div className='four column row'>
              <div className='column'>
                <DashboardPage.GuideStat {...@state} />
              </div>
              <div className='column'>
                <PatientQueue data={@state.wait_queue} title='到馆体检' />
              </div>
              <div className='column'>
                <PatientQueue data={@state.tijian_queue} title='医师推送' />
              </div>
            </div>
          </div>
        </DashboardPage>

    Treat: React.createClass
      getInitialState: ->
        wait_queue: @props.data.yuyue_queue
        tijian_queue: @props.data.zaiguan_queue
        zhiliao_queue: @props.data.zaiguan_queue

      render: ->
        <DashboardPage>
          <div className='ui grid queues'>
            <div className='four column row'>
              <div className='column'>
                <DashboardPage.GuideStat {...@state} />
              </div>
              <div className='column'>
                <PatientQueue data={@state.wait_queue} title='到馆治疗' />
              </div>
              <div className='column'>
                <PatientQueue data={@state.tijian_queue} title='医师推送' />
              </div>
            </div>
          </div>
        </DashboardPage>