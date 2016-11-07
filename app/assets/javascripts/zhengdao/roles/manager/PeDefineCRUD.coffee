@ManagerPeDefinesPage = React.createClass
  render: ->
    { AddButton } = ManagerOps
    
    <div className='manager-pe-defines-page'>
      <PageDesc text='管理体检项定义' />

      <ManagerOps>
        <AddButton href={@props.data.new_url} text='添加体检项' />
      </ManagerOps>

      {@table()}
    </div>

  table: ->
    { Table } = antd

    data_source = @props.data.pe_defines

    columns = [
      {title: '体检项名称', dataIndex: 'name', key: 'name'}
      {title: '描述', key: 'desc', render: (x)->
        <pre>{x.desc}</pre>
      }
      {title: '关联字典特征', key: 'facts', render: (x)->
        <TableIDTags data={x.facts} icon='tags' />
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

  getInitialState: ->
    facts: @props.data[@props.model]?.facts || []

  render: ->
    { Form, Input, Button, Icon, Col, Select} = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props.form

    iprops = {
      labelCol: { span: 4 }
      wrapperCol: { span: 16 }
    }

    model = @props.data[@props.model]

    <div className='pe-define-form' style={@form_style()}>
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

        {
          if @props.method is 'PUT'
            <div>
            <FormItem {...iprops} label='关联字典特征'>
              {
                for fact in @state.facts
                  <div key={fact.id} className='linked-fact'>
                    <div>
                      <Icon type='tag' />
                      <strong>{fact.name}: </strong>
                      <a onClick={@remove_fact(fact)}>删除</a>
                    </div>
                    <div className='tag-names'>{fact.tag_names.join(', ')}</div>
                  </div>
              }

              <FactSearcher 
                url={@props.data.pe_define.search_facts_url} 
                add_fact={@add_fact}
              />
            </FormItem>

            <FormItem {...iprops} label='矢量图标注'>
              <Button><a href={@props.data.vector_url}><Icon type='setting' /> 设置</a></Button>
            </FormItem>
            </div>
        }

        {@submit_btns()}
      </Form>
    </div>

  add_fact: (fact)->
    facts = @state.facts
    
    ids = facts.map (x)-> x.id
    if ids.indexOf(fact.id) == -1
      facts.push fact
      @setState facts: facts

  remove_fact: (fact)->
    =>
      facts = @state.facts
      facts = facts.filter (x)->
        x.id != fact.id
      @setState facts: facts

  _submit: (evt)->
    evt.preventDefault()

    @props.form.validateFields (errors, data) => 
      return if errors

      _data = Object.assign({fact_ids: @state.facts.map (x)-> x.id}, data)

      jQuery.ajax
        type: @props.method
        url: @props.data.submit_url
        data:
          "#{@props.model}": _data
      .done (res)=>
        location.href = @props.data.cancel_url


FactSearcher = React.createClass
  getInitialState: ->
    fact_id: null
    value: ''
    facts: []

  render: ->
    { Input, Col, Select, Button, Icon } = antd
    InputGroup = Input.Group

    <InputGroup>
      <Select 
        combobox
        value={@state.value}
        placeholder='输入特征名'
        showArrow={false}
        filterOption={false}
        onChange={@handleChange}
        optionLabelProp='children'
        onSelect={@select}
      >
      {
        for fact in @state.facts
          <Option key={fact.id} value={fact.name} fact={fact}>
            <div className='linked-fact'>
              <div>
                <Icon type='tag' />
                <strong>{fact.name}: </strong>
              </div>
              <div className='tag-names'>{fact.tag_names.join(', ')}</div>
            </div>
          </Option>
      }
      </Select>
    </InputGroup>

  handleChange: (value)->
    @setState value: value
    @fetch value

  select: (value, o)->
    fact = o.props.fact
    @props.add_fact fact
    setTimeout =>
      @setState value: ''
    , 10

  fetch: (value)->
    if @timeout
      clearTimeout @timeout
      @timeout = null

    @current_value = value
    @timeout = setTimeout @fake, 300

  fake: ->
    jQuery.ajax
      url: @props.url
      data:
        q: @current_value
    .done (res)=>
      @setState facts: res


@ManagerPeDefinesNewPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='POST' model='pe_define' />
)

@ManagerPeDefinesEditPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='PUT' model='pe_define' />
)