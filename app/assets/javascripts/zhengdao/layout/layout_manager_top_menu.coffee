@LayoutManagerTopMenu = React.createClass
  render: ->
    <div>
      <div className='layout-top-menu manager ui menu top fixed'>
        <div className='left menu'>
          <a className='item mobile-open icon' href='javascript:;' onClick={@mobile_toggle_sidebar}>
            <i className='icon sidebar' />
          </a>
        </div>

        <div className='right menu'>
          {
            if @props.current_user_data
              user = @props.current_user_data
              [
                <a key='avatar' className='item avatar' href='javascript:;'>
                  <img src={user.avatar.url} />
                </a>
                <a key='name' className='item' href='javascript:;'>{user.name}</a>
              ]
          }
          <a key='sign-out' className='item' href='javascript:;' onClick={@do_sign_out}>
            <i className='icon sign out' /> 登出
          </a>
        </div>
      </div>

      <div className='mobile-sidebar-overlay' onClick={@mobile_toggle_sidebar} />
    </div>

  mobile_toggle_sidebar: ->
    jQuery(document.body)
      .toggleClass('mobile-open-sidebar')

  do_sign_out: ->
    jQuery.ajax
      url: @props.data.sign_out_url
      type: 'delete'
    .done =>
      location.href = @props.data.sign_out_to_url