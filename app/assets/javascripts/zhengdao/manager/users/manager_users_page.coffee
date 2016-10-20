@ManagerUsersPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div className='manager-users-page'>
      <PageDesc text='管理工作人员角色信息与登录信息' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加人员' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.users

    columns = [
      {title: '用户名', key: 'names', render: (x)->
        "#{x.name}(#{x.login})"
      }
      {title: '角色', key: 'role_str', render: (x)->
        <TableTags data={x.role_strs} />
      }
      {title: '店面', key: 'store', render: (x)->
        x.store?.name || <span style={color: '#ccc'}>无</span>
      }
      {title: '操作', key: 'ops', render: (x)->
        <TableEditButton href={x.edit_url} text='修改' />
      }
    ]

    <Table
      columns={columns}
      dataSource={data_source}
      bordered
      size='middle'
      rowKey='id'
    />