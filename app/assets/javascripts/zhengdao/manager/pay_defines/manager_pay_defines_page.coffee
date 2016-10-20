@ManagerPayDefinesPage = React.createClass
  render: ->
    <div className='manager-pay-defines-page'>
      <PageDesc text='管理治疗项目定义' />
      <ManagerPayDefinesPage.Table data={@props.data} />
    </div>

  statics:
    Table: React.createClass
      render: ->
        table_data = {
          fields:
            name: '治疗项名称'
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

        { AddButton } = ManagerOps

        <div>
          <ManagerOps>
            <AddButton href={@props.data.new_url} text='添加治疗项' />
          </ManagerOps>

          <ManagerTable data={table_data} title='治疗项目管理' />
        </div>
