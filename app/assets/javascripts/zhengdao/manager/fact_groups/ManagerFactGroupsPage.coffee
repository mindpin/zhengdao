@ManagerFactGroupsPage = React.createClass
  render: ->
    <div className='manager-fact-groups-page'>
      <div className='ui icon message warning'>
        <i className='icon add square' />
        管理体检记录用标签组
      </div>

      <Table data={@props.data} />
    </div>

Table = React.createClass
  render: ->
    table_data = {
      fields:
        name: '组名'
        chilren: '子级组/标签'
        ops: '操作'
      data_set: []
      th_classes: {
      }
      td_classes: {
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



@ManagerFactGroupsNewPage = React.createClass
  render: ->
    <div />