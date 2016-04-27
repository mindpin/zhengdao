@ManagerIndexPage = React.createClass
  render: ->
    <div className='manager-index-page'>
      <div className='ui icon message warning'>
        <i className='icon info circle' />
        你正以超级管理身份登录，你可以在此进行人员管理，查看患者档案，以及查看系统信息
      </div>

      <div className='manager-funcs'>
      {
        for func, idx in @props.data.funcs
          <a key={idx} href={func.url} className='func'>
            <i className="icon #{func.icon}" />
            <span className='text'>{func.name}</span>
          </a>
      }
      </div>
    </div>