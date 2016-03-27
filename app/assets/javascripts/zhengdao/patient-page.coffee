@DemoAdminPatientPage = React.createClass
  render: ->
    <div className="ui basic segment special-page">
    <div className="ui basic segment">
    <div className="ui five cards">
      {
        idx = 0
        for i in [1..18]
          <div key={idx++} className="ui card">
            <div className="image">
              <img src="http://i.teamkn.com/i/VEseRzHk.png" />
            </div>
            <div className="content">
              <div className="header">王大锤</div>
              <div className="description">
                <span>男</span>
                <i className='icon male' />
                <span>33 岁</span>
              </div>
            </div>
            <div className="extra content">
              <span>
                <i className='icon first aid' />
                <span>3 次诊疗</span>
              </span>
            </div>
          </div>
      }
    </div>
    </div>
    </div>