@ManagerPayDefinesPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div className='manager-pay-defines-page'>
      <PageDesc text='管理治疗项目定义' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加治疗项' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.pay_defines

    columns = [
      {title: '治疗项名称', dataIndex: 'name', key: 'name'}
      {title: '描述', key: 'desc', render: (x)->
        <pre>{x.desc}</pre>
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

# ---------------

ModelForm = React.createClass
  mixins: [CRUDMixin]

  render: ->
    { Form, Input, Button, Icon } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props.form

    iprops = {
      labelCol: { span: 4 }
      wrapperCol: { span: 16 }
    }

    model = @props.data[@props.model]

    <div style={@form_style()}>
      <Form onSubmit={@submit}>
        <FormItem {...iprops} label='名称'>
        {getFieldDecorator('name', {initialValue: model?.name, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='描述'>
        {getFieldDecorator('desc', {initialValue: model?.desc, rules: [
        ]})(
          <Input type='textarea' rows={8} />
        )}
        </FormItem>

        {@submit_btns()}
      </Form>
    </div>

@ManagerPayDefinesNewPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='POST' model='pay_define' />
)

@ManagerPayDefinesEditPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='PUT' model='pay_define' />
)