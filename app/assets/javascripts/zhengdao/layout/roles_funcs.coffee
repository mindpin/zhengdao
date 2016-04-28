@RolesFuncs = React.createClass
  render: ->
    <div className='roles-funcs'>
    {
      for func, idx in @props.data
        <a key={idx} href={func.url} className='func'>
          <i className="icon #{func.icon}" />
          <span className='text'>{func.name}</span>
        </a>
    }
    </div>