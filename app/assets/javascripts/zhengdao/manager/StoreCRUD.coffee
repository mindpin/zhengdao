@ManagerStoresPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div className='manager-stores-page'>
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


ModelForm = React.createClass
  render: ->
    { Form, Input, Button, Icon } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props.form

    iprops = {
      labelCol: { span: 4 }
      wrapperCol: { span: 16 }
    }

    <div style={padding: '2rem 1rem 1rem', backgroundColor: 'white'}>
      <Form onSubmit={@submit}>
        <FormItem {...iprops} label='店面名称'>
        {getFieldDecorator('name', {rules: [
          {required: true, message: '店面名称必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='地址'>
        {getFieldDecorator('location', {rules: [
          {required: true, message: '地址必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='电话' required>
        {getFieldDecorator('phone_number', {rules: [
          {required: true, message: '电话必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='负责人' required>
        {getFieldDecorator('principal', {rules: [
          {required: true, message: '负责人必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem wrapperCol={ span: 16, offset: 4 }>
          <Button type="primary" htmlType="submit">
            <Icon type='check' /> 确定保存
          </Button>
          <a className='ant-btn ant-btn-lg' style={marginLeft: 8} href={@props.data.cancel_url}>
            取消
          </a>
        </FormItem>
      </Form>
    </div>

  submit: (evt)->
    evt.preventDefault()

    @props.form.validateFields (errors, data) => 
      return if errors

      jQuery.ajax
        type: 'POST'
        url: @props.data.submit_url
        data:
          store: data
      .done (res)=>
        location.href = @props.data.cancel_url

@ManagerStoresNewPage = antd.Form.create()(ModelForm)




@ManagerStoresEditPage = React.createClass
  render: ->
    {
      TextInputField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    <div className='ui segment'>
      <SimpleDataForm
        model='store'
        data={@props.data.store}
        put={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='店面名称：' name='name' required />
        <TextInputField {...layout} label='地址：' name='location' required />
        <TextInputField {...layout} label='电话：' name='phone_number' required />
        <TextInputField {...layout} label='负责人：' name='principal' required />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url