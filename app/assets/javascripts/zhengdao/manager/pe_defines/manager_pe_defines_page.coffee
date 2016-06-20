@ManagerPeDefinesPage = React.createClass
  render: ->
    <div className='manager-pe-defines-page'>
      <div className='ui icon message warning'>
        <i className='icon add square' />
        管理诊断项目定义
      </div>

      <ManagerPeDefinesPage.Table data={@props.data} />
    </div>

  statics:
    Table: React.createClass
      render: ->
        table_data = {
          fields:
            name: '诊断项名称'
            ops: '操作'
          data_set: @props.data.pe_defines.map (x)->
            id: Math.random()
            name: x.name
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
            <a href={@props.data.new_urla} className='ui button green'>
              <i className='icon plus' /> 添加诊断项
            </a>
          </div>
          <ManagerTable data={table_data} title='诊断项目管理' />
        </div>
