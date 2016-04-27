@LayoutManagerTopMenu = React.createClass
  render: ->
    mobile_back_to = @props.extend_nav_data?.mobile_back_to
    current_title = @props.extend_nav_data?.current_title

    menu_klass = new ClassName
      'layout-top-menu manager ui menu top fixed': true
      'with-mobile-back-to': mobile_back_to?

    <div>
      <div className={menu_klass}>
        <div className='left menu'>
          <a className='item mobile mobile-open icon' href='javascript:;' onClick={@mobile_toggle_sidebar}>
            <i className='icon sidebar' />
          </a>
          {
            if mobile_back_to?
              <a className='item mobile mobile-back-to icon' href={mobile_back_to}>
                <i className='icon chevron left' />
              </a>
          }
          {
            if current_title?
              <div className='item current-title'>{current_title}</div>
          }
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
          <a key='sign-out' className='item sign-out' href='javascript:;' onClick={@do_sign_out}>
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