@SignInForm = React.createClass
  getInitialState: ->
    login: if @props.admin_auth then 'admin' else ''
    password: ''
    error: null
    success: null

  render: ->
    <div className='sign-in-form ui form' ref='form'>
      {
        if not @props.admin_auth
          <div className='field'>
            <div className='ui left icon input'>
              <i className='icon user' />
              <input type='text' placeholder='账号' value={@state.login} onChange={@on_change('login')} onKeyPress={@enter_submit} />
            </div>
          </div>
      }


      <div className='field'>
        <div className='ui left icon input'>
          <i className='icon asterisk' />
          <input type='password' placeholder='密码' value={@state.password} onChange={@on_change('password')} onKeyPress={@enter_submit} />
        </div>
      </div>

      {
        if @state.error
          <div className="ui yellow message small">
            <i className='icon info circle' />
            <span>{@state.error}</span>
          </div>
      }

      {
        if @state.success
          <div className="ui green message small">
            <i className='icon checkmark' /> 
            <span>登录成功</span>
          </div>
      }

      <div className='field'>
        <a className='ui button fluid brown large' onClick={@do_submit}>登录</a>
      </div>

      {
        if false
          <div className='field'>
            <a href='javascript:;'>我忘记密码了</a>
          </div>
      }
    </div>

  on_change: (input_name)->
    (evt)=>
      @setState "#{input_name}": evt.target.value

  enter_submit: (evt)->
    if evt.which is 13
      @do_submit()

  do_submit: ->
    # 登录
    data =
      user:
        login: @state.login
        password: @state.password
        remember_me: true

    jQuery.ajax
      url: @props.submit_url
      type: "POST"
      data: data
      dataType: "json"
      success: (res)=>
        @setState
          success: true
          error: null

        if @props.jump
          location.href = @props.jump
        else
          location.reload()

      statusCode: 
        401: (res)=>
          @setState
            error: res.responseJSON?.error
            success: null