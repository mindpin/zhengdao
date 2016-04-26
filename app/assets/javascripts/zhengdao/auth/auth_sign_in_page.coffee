@AuthSignInPage = React.createClass
  render: ->
    <div className='auth-sign-in-page'>
      <div className='ui container stackable grid'>

        <div className='six wide column'>
          <div className='customer-logo' />
        </div>

        <div className='eight wide column'>
          <div className='product-logo' />
          <div className='ui segment'>
            <div className='head'>
              <i className='icon sign in' />
              <span className='sign-in link'>工作人员登录</span>
            </div>
            <SignInForm submit_url={'/auth/do_sign_in'} jump={'/dashboard-guide'} />
          </div>
        </div>

      </div>
    </div>