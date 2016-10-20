{ Table } = antd

@ManagerStoresPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div className='manager-stores-page'>
      <PageDesc text='管理店面信息' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加店面' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    data_source = @props.data.stores

    columns = [
      {title: '店面名称', dataIndex: 'name', key: 'name'}
      {title: '地址', dataIndex: 'location', key: 'location'}
      {title: '电话', dataIndex: 'phone_number', key: 'phone_number'}
      {title: '负责人', dataIndex: 'principal', key: 'principal'}
      {title: '操作', key: 'ops', render: (x)->
        <TableEditButton href={x.edit_url} text='修改' />
      }
    ]

    <Table
      columns={columns}
      dataSource={data_source}
      bordered
      size='middle'
    />