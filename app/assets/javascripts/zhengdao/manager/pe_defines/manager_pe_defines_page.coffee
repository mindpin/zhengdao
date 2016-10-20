@ManagerPeDefinesPage = React.createClass
  render: ->
    <div className='manager-pe-defines-page'>
      <PageDesc text='管理体检项定义' />

      <ManagerPeDefinesPage.Table data={@props.data} />
    </div>

  statics:
    Table: React.createClass
      render: ->
        table_data = {
          fields:
            name: '体检项名称'
            desc: '描述'
            fact_groups_count: '标签组'
            ops: '操作'
          data_set: @props.data.pe_defines.map (x)->
            id: Math.random()
            name: x.name
            desc: x.desc
            fact_groups_count: x.fact_groups.length
            unit_price: x.unit_price
            ops:
              <a href={x.edit_url} className='ui button basic mini'><i className='icon edit' /> 修改</a>
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
              <i className='icon plus' /> 添加体检项
            </a>
          </div>
          <ManagerTable data={table_data} title='体检项目管理' />
        </div>
