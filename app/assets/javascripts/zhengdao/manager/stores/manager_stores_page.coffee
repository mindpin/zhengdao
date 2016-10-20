@ManagerStoresPage = React.createClass
  render: ->
    <div className='manager-stores-page'>
      <PageDesc text='管理店面信息' />

      <ManagerStoresPage.Table data={@props.data} />
    </div>

  statics:
    Table: React.createClass
      render: ->
        table_data = {
          fields:
            name: '店面名称'
            location: '地址'
            phone_number: '电话'
            principal: '负责人'
            ops: '操作'
          data_set: @props.data.stores.map (x)->
            id: x.id
            name: x.name
            location: x.location
            phone_number: x.phone_number
            principal: x.principal
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
            <AddButton href={@props.data.new_url} text='添加店面' />
          </ManagerOps>
          
          <ManagerTable data={table_data} title='店面管理' />
        </div>
