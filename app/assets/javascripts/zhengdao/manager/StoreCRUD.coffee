@ManagerStoresPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div>
      <PageDesc text='管理店面信息' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加店面' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.stores

    columns = [
      {title: '店面名称', dataIndex: 'name', key: 'name'}
      {title: '地址', dataIndex: 'location', key: 'location'}
      {title: '电话', dataIndex: 'phone_number', key: 'phone_number'}
      {title: '负责人', dataIndex: 'principal', key: 'principal'}
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

# ----------------------------------------

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
        <FormItem {...iprops} label='店面名称'>
        {getFieldDecorator('name', {initialValue: model?.name, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='地址'>
        {getFieldDecorator('location', {initialValue: model?.location, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='电话'>
        {getFieldDecorator('phone_number', {initialValue: model?.phone_number, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='负责人'>
        {getFieldDecorator('principal', {initialValue: model?.principal, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        {@submit_btns()}
      </Form>
    </div>


@ManagerStoresNewPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='POST' model='store' />
)


@ManagerStoresEditPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='PUT' model='store' />
)