@ManagerPayDefinesPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div className='manager-pay-defines-page'>
      <PageDesc text='管理治疗项目定义' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加治疗项' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.pay_defines

    columns = [
      {title: '治疗项名称', dataIndex: 'name', key: 'name'}
      {title: '描述', dataIndex: 'desc', key: 'desc'}
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