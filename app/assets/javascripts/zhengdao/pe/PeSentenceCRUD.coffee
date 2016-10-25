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

    facts = @props.data?.pe_define?.facts || []

    <div style={@form_style()}>
      <Form onSubmit={@submit}>
        {
          facts.map (f)->
            <FactInputer key={f.id} fact={f} iprops={iprops} getFieldDecorator={getFieldDecorator} />
        }
        {@submit_btns()}
      </Form>
    </div>


FactInputer = React.createClass
  render: ->
    { Form, Icon, Select, Input } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props

    fact = @props.fact
    <FormItem {...@props.iprops} label={fact.name}>
      {getFieldDecorator(fact.name, {initialValue: [], rules: [
      ]})(
        <Select
          tags
          placeholder='请输入'
        >
          {
            fact.tag_names.map (name, idx)->
              <Option key={idx} value={name}><Icon type='tag' /> {name}</Option>
          }
        </Select>
      )}
    </FormItem>


@NewPeSentencePage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='PUT' model='pe_record' />
)
