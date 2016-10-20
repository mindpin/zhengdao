@ManagerFactGroupsPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div className='manager-fact-groups-page'>
      <PageDesc text='管理体检记录用标签组' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加标签组' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.fact_groups.map (x)->
      Object.assign({}, x, {
        children: null
        child_groups: x.children
        child_tags: x.fact_tags
      })

    columns = [
      {title: '组名', dataIndex: 'name', key: 'name'}
      {title: '子级组/标签', key: 'child_facts', render: (x)->
        if x.child_groups.length
          return <TableIDTags data={x.child_groups} icon='tags-o' />
        if x.child_tags.length
          return <TableIDTags data={x.child_tags} icon='tag' />
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