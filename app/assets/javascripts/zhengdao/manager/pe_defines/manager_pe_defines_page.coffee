@ManagerPeDefinesPage = React.createClass
  render: ->
    { AddButton } = ManagerOps
    
    <div className='manager-pe-defines-page'>
      <PageDesc text='管理体检项定义' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加体检项' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.pe_defines

    columns = [
      {title: '体检项名称', dataIndex: 'name', key: 'name'}
      {title: '描述', dataIndex: 'desc', key: 'desc'}
      {title: '标签组', key: 'fact_groups_count', render: (x)->
        x.fact_groups.length
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