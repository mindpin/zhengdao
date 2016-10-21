@ManagerUsersPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div>
      <PageDesc text='管理工作人员角色信息与登录信息' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加人员' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.users

    columns = [
      {title: '用户名', key: 'names', render: (x)->
        "#{x.name}(#{x.login})"
      }
      {title: '角色', key: 'role_str', render: (x)->
        <TableTags data={x.role_strs} />
      }
      {title: '店面', key: 'store', render: (x)->
        x.store?.name || <span style={color: '#ccc'}>无</span>
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
    { Form, Input, Button, Icon, Select } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props.form

    iprops = {
      labelCol: { span: 4 }
      wrapperCol: { span: 16 }
    }

    model = @props.data[@props.model]

    <div style={padding: '2rem 1rem 1rem', backgroundColor: 'white'}>
      <Form onSubmit={@submit}>
        <FormItem {...iprops} label='姓名'>
        {getFieldDecorator('name', {initialValue: model?.name, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='登录名'>
        {getFieldDecorator('login', {initialValue: model?.login, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        {
          if @props.method is 'POST'
            <FormItem {...iprops} label='密码'>
            {getFieldDecorator('password', {rules: [
              {required: true, message: '必须要填'}
              {range: true, min: 4, message: '密码至少四位'}
            ]})(
              <Input type='password' />
            )}
            </FormItem>
        }

        {
          if @props.method is 'PUT'
            <FormItem {...iprops} label='重设密码'>
            {getFieldDecorator('password', {rules: [
              {range: true, min: 4, message: '密码至少四位'}
            ]})(
              <Input type='password' placeholder='不填则不会修改原来的密码' />
            )}
            </FormItem>
        }


        <FormItem {...iprops} label='角色'>
        {getFieldDecorator('roles', {initialValue: model?.roles, rules: [
          {type: 'array', required: true, message: '必须要填'}
        ]})(
          <Select 
            multiple
          >
            <Option value='wizard'><Icon type='solution' /> 导诊</Option>
            <Option value='doctor'><Icon type='solution' /> 医师</Option>
            <Option value='pe'><Icon type='solution' /> 体检师</Option>
            <Option value='cure'><Icon type='solution' /> 治疗师</Option>
          </Select>
        )}
        </FormItem>

        <FormItem {...iprops} label='店面'>
        {getFieldDecorator('store_id', {initialValue: model?.store?.id, rules: [
        ]})(
          <Select>
          {
            for s in @props.data.stores
              <Option key={s.id} value={s.id}><Icon type='home' /> {s.name}</Option>
          }
          </Select>
        )}
        </FormItem>

        {@submit_btns()}
      </Form>
    </div>


@ManagerUsersNewPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='POST' model='user' />
)

@ManagerUsersEditPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='PUT' model='user' />
)