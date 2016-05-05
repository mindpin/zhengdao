@ManagerPayDefinesPage = React.createClass
  render: ->
    <div className='manager-pay-defines-page'>
      <div className='ui icon message warning'>
        <i className='icon yen' />
        管理收费项目定义
      </div>

      <ManagerPayDefinesPage.Table data={@props.data} />
    </div>

  statics:
    Table: React.createClass
      render: ->
        table_data = {
          fields:
            name: '收费项名称'
            unit_price: '单价'
            ops: '操作'
          data_set: @props.data.pay_defines.map (x)->
            id: x.id
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
            <a href={@props.data.new_url} className='ui button green'>
              <i className='icon plus' /> 添加收费项
            </a>
          </div>
          <ManagerTable data={table_data} title='收费项目管理' />
        </div>
