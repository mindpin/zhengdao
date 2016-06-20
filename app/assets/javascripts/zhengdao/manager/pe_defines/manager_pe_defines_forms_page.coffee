@ManagerPeDefinesNewPage = React.createClass
  render: ->
    {
      TextInputField
      TextAreaField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    <div className='ui segment'>
      <SimpleDataForm
        model='pe_define'
        post={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='名称：' name='name' required />
        <TextAreaField {...layout} label='描述：' name='desc' />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url

@ManagerPeDefinesEditPage = React.createClass
  render: ->
    {
      TextInputField
      TextAreaField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    <div className='ui segment'>
      <SimpleDataForm
        model='pe_define'
        data={@props.data.pe_define}
        put={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='名称：' name='name' required />
        <TextAreaField {...layout} label='描述：' name='desc' />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
      <div style={marginBottom: '2rem'} />
      <Table items={@props.data.pe_define.data} />
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url

Table = React.createClass
  render: ->
    # console.log @props.items

    table_data = {
      fields:
        name: '子项'
        values: '标签'
        # ops: '操作'
      data_set: @props.items.map (x)=>
        id: Math.random()
        name: x.label
        values:
          <div>
          <div style={overflow: 'hidden'}>
            {
              for value, idx in x.values
                <div key={idx} style={float: 'left', margin: '0 5px 5px 0', border: 'solid 1px #ececec', backgroundColor: '#ffffda', padding: '0 5px'}>{value}</div>
            }
          </div>
          <div>
            <a href='javascript:;' className='ui button basic mini'><i className='icon edit' /> 修改标签</a>
          </div>
          </div>
      th_classes: {
      }
      td_classes: {
        ops: 'collapsing'
      }
      unstackable: true
    }

    <div>
      <ManagerTable data={table_data} title='诊断项目管理' />
    </div>