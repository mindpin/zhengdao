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
          <div className='ui segment'>
            <h3><i className='icon browser' />导诊看板</h3>
          </div>

          <div className='ui grid queues'>
            <div className='three column row'>
              <div className='column stat'>
                <DashboardPage.GuideStat />
              </div>
              <div className='column'>
                <PatientQueue data={@state.yuyue_queue} title='预约队列' click={@check_yuyue} />
              </div>
              <div className='column'>
                <PatientQueue click={@open_info} data={@state.zaiguan_queue} title='在馆队列' />
              </div>
            </div>
          </div>

          <div className='ui grid workers'>
            <div className='three column row'>
              <div className='column'>
                <FreeWorkers queue={@state.zaiguan_queue} data={@state.free_doctor} title='医师状态' />
              </div>
              <div className='column'>
                <FreeWorkers queue={@state.zaiguan_queue} data={@state.free_pe} title='体检师状态' />
              </div>
              <div className='column'>
                <FreeWorkers queue={@state.zaiguan_queue} data={@state.free_treat} title='治疗师状态' />
              </div>
            </div>
          </div>
        </DashboardPage>

      check_yuyue: ->
        jQuery.open_modal <DashboardPage.CheckYuyue />

      open_info: ->
        jQuery.open_large_modal(
          <div className='pay'>
            <DoctorPatientInfoPage.Panel active={0} />
          </div>
        )



    GuideStat: React.createClass
      render: ->
        <div className='ui segment'>
          <TimeClock />
          <a href='javascript:;' style={marginBottom: '1rem'} className='ui button basic brown large fluid' onClick={@add_yuyue}>
            <i className='icon plus' /> 预约登记
          </a>
          <a href='javascript:;' style={marginBottom: '1rem'} className='ui button basic brown large fluid' onClick={@add_guahao}>
            <i className='icon plus' /> 现场挂号
          </a>
        </div>

      add_yuyue: ->
        jQuery.open_modal <DashboardPage.AddYuyue />, {
          closable: false
        }

      add_guahao: ->
        jQuery.open_modal <DashboardPage.AddYuyue />, {
          closable: false
        }

    AddYuyue: React.createClass
      render: ->
        <div className='add-yuyue'>
          <div className='header'>预约登记</div>
          <div>
            <GHXCPage.Panel />
          </div>
          <div className='actions'>
            <a className='ui button brown right labeled icon' onClick={@close}>
              确定
              <i className='icon checkmark' />
            </a>
            <a className='ui button' onClick={@close}>取消</a>
          </div>
        </div>

      close: ->
        @state.close()

    CheckYuyue: React.createClass
      render: ->
        <div>
          <ConfirmYYInfoPanel />
          <div className='actions'>
            <a className='ui button brown right labeled icon' onClick={@ok}>
              确定
              <i className='icon checkmark' />
            </a>
            <a className='ui button' onClick={@close}>取消</a>
          </div>
        </div>

      ok: ->
        jQuery.open_modal <GHYYResultPage.Panel />

      close: ->
        @state.close()

    # --------------------------------

    Doctor: React.createClass
      getInitialState: ->
        wait_queue: @props.data.zaiguan_queue.filter (x)->
          x.label == '等待初诊' || x.label == '等待复核'
        tijian_queue: @props.data.zaiguan_queue.filter (x)->
          x.label == '等待体检'
        zhiliao_queue: @props.data.zaiguan_queue.filter (x)->
          x.label == '等待治疗'

      render: ->
        <DashboardPage>
          <div className='ui segment'>
            <h3><i className='icon browser' />医师看板</h3>
          </div>

          <div className='ui grid queues'>
            <div className='three column row'>
              <div className='column'>
                <PatientQueue click={@click(1)} data={@state.wait_queue} title='待诊' />
              </div>
              <div className='column'>
                <PatientQueue click={@click(2)} data={@state.tijian_queue} title='体检中' />
              </div>
              <div className='column'>
                <PatientQueue click={@click(3)} data={@state.zhiliao_queue} title='治疗中' />
              </div>
            </div>
          </div>
        </DashboardPage>

      click: (active)->
        ->
          jQuery.open_large_modal <DoctorPatientInfoPage.Panel active={active}/>

    # -------------------------

    PE: React.createClass
      getInitialState: ->
        wait_queue: @props.data.zaiguan_queue
        tijian_queue: @props.data.zaiguan_queue
        zhiliao_queue: @props.data.zaiguan_queue

      render: ->
        <DashboardPage>
          <div className='ui segment'>
            <h3><i className='icon browser' />体检师看板</h3>
          </div>

          <div className='ui grid queues'>
            <div className='three column row'>
              <div className='column'>
                <PatientQueue click={@click} data={@state.wait_queue} title='到馆体检' />
              </div>
              <div className='column'>
                <PatientQueue click={@click} data={@state.tijian_queue} title='医师推送' />
              </div>
            </div>
          </div>
        </DashboardPage>

      click: ->
        jQuery.open_large_modal(
          <div>
            <DoctorPatientInfoPage.Panel active={1} />
            <div className='actions'>
              <a href='/zd-patient-info' target='_blank' className='ui button brown'>
                <i className='icon arrow right' />
                进入体检记录系统
              </a>
            </div>
          </div>
        )

    Treat: React.createClass
      getInitialState: ->
        wait_queue: @props.data.zaiguan_queue
        tijian_queue: @props.data.zaiguan_queue
        zhiliao_queue: @props.data.zaiguan_queue

      render: ->
        <DashboardPage>
          <div className='ui segment'>
            <h3><i className='icon browser' />治疗师看板</h3>
          </div>

          <div className='ui grid queues'>
            <div className='three column row'>
              <div className='column'>
                <PatientQueue click={@click} data={@state.wait_queue} title='到馆治疗' />
              </div>
              <div className='column'>
                <PatientQueue click={@click} data={@state.tijian_queue} title='医师推送' />
              </div>
            </div>
          </div>
        </DashboardPage>

      click: ->
        jQuery.open_large_modal <DoctorPatientInfoPage.Panel active={2} />