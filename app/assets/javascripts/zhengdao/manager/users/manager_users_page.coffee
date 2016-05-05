@ManagerUsersPage = React.createClass
  render: ->
    <div className='manager-users-page'>
      <div className='ui icon message warning'>
        <i className='icon doctor' />
        管理工作人员角色信息与登录信息
      </div>

      <ManagerUsersPage.Table data={@props.data} />
    </div>

  statics:
    Table: React.createClass
      render: ->
        table_data = {
          fields:
            names: '用户名'
            role_str: '角色'
            store: '店面'
            ops: '操作'
          data_set: @props.data.users.map (x)->
            id: x.id
            names: "#{x.name}(#{x.login})"
            role_str: x.role_str
            store: x.store.name || '无'
            ops:
              <a href={x.edit_url} className='ui button basic mini'><i className='icon edit' /> 修改</a>
          th_classes: {
          }
          td_classes: {
            role_str: 'collapsing'
            ops: 'collapsing'
          }
          unstackable: true
        }

        <div>
          <div className='ui segment basic ops'>
            <a href={@props.data.new_url} className='ui button green'>
              <i className='icon plus' /> 添加人员
            </a>
          </div>
          <ManagerTable data={table_data} title='人员管理' />
        </div>
