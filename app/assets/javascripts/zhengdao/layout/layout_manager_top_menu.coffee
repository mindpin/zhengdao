@LayoutManagerTopMenu = React.createClass
  render: ->
    <div className='layout-top-menu manager ui menu top fixed'>
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
        <a key='sign-out' className='item' href='/'>登出</a>
      </div>
    </div>

  do_sign_out: ->
    jQuery.ajax
      url: @props.data.sign_out_url
      type: 'delete'
    .done =>
      location.href = @props.data.sign_out_to_url