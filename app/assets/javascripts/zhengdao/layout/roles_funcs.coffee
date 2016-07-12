@RolesFuncs = React.createClass
  render: ->
    <div className='roles-funcs'>
    {
      for func, idx in @props.data
        style = 
          if func.icolor
          then {color: func.icolor}
          else {}

        <a key={idx} href={func.url} className='func'>
          <i className="icon #{func.icon}" style={style} />
          <span className='text'>{func.name}</span>
        </a>
    }
    </div>