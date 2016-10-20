@ManagerFactGroupsPage = React.createClass
  render: ->
    <div className='manager-fact-groups-page'>
      <PageDesc text='管理体检记录用标签组' />

      <Table data={@props.data} />
    </div>

Table = React.createClass
  render: ->
    table_data = {
      fields:
        name: '组名'
        children: '子级组/标签'
        ops: '操作'
      data_set: @props.data.fact_groups.map (x)->
        if x.children.length > 0
          children =
            <div>
            {
              for child in x.children
                <div key={child.id}><i className='icon circle thin' /> {child.name}</div>
            }
            </div>

        if x.fact_tags.length > 0
          children =
            <div>
            {
              for tag in x.fact_tags
                <div key={tag.id}><i className='icon tag' /> {tag.name}</div>
            }
            </div>

        id: x.id
        name: x.name
        children: children
        ops:
          <div>
            <a href={x.edit_url} className='ui button mini basic'>
              <i className='icon pencil' /> 编辑
            </a>
          </div>

      th_classes: {
      }
      td_classes: {
        ops: 'collapsing'
      }
      unstackable: true
    }

    <div>
      <div className='ui segment basic ops'>
        <a href={@props.data.new_url} className='ui button green'>
          <i className='icon plus' /> 添加标签组
        </a>
      </div>
      <ManagerTable data={table_data} title='标签组管理' />
    </div>