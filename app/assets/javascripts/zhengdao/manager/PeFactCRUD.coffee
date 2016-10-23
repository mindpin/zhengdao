@ManagerPeFactsPage = React.createClass
  render: ->
    { AddButton } = ManagerOps

    <div className='manager-pay-defines-page'>
      <PageDesc text='体检特征字典维护' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加特征定义' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.pe_facts

    columns = [
      {title: '特征名', dataIndex: 'name', key: 'name'}
      {title: '可选特征值', key: 'tag_names', render: (x)->
        <TableTags data={x.tag_names} />
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
    console.log model

    <div style={padding: '2rem 1rem 1rem', backgroundColor: 'white'}>
      <Form onSubmit={@submit}>
        <FormItem {...iprops} label='特征名'>
        {getFieldDecorator('name', {initialValue: model?.name, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='可选特征值'>
        {getFieldDecorator('tag_names', {initialValue: model?.tag_names, rules: [
          {type: 'array', required: true, message: '必须要填'}
        ]})(
          <Select 
            tags
            placeholder='请输入标签'
          />
        )}
        </FormItem>

        {@submit_btns()}
      </Form>
    </div>

@ManagerPeFactsNewPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='POST' model='pe_fact' />
)

@ManagerPeFactsEditPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='PUT' model='pe_fact' />
)