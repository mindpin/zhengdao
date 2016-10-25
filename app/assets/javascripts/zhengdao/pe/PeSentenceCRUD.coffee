ModelForm = React.createClass
  mixins: [CRUDMixin]

  getInitialState: ->
    facts: @props.data?.pe_define?.facts || []

  render: ->
    { Form, Input, Button, Icon, Select } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props.form

    iprops = {
      labelCol: { span: 4 }
      wrapperCol: { span: 16 }
    }

    <div style={@form_style()}>
      <Form onSubmit={@submit}>
        {
          @state.facts.map (f)->
            <FactInputer key={f.id} fact={f} iprops={iprops} getFieldDecorator={getFieldDecorator} />
        }
        <FormItem {...iprops} label='自定义描述'>
          {getFieldDecorator('user-custom', {initialValue: '', rules: [
          ]})(
            <Input type='textarea' rows={4} />
          )}
        </FormItem>
        {@submit_btns()}
      </Form>
    </div>

  _submit: (evt)->
    evt.preventDefault()

    @props.form.validateFields (errors, data) => 
      return if errors

      _data = []
      @state.facts.forEach (f)->
        values = data[f.name]
        if values.length
          _data.push {
            fact: f.name
            values: values
          }

      user_custom = jQuery.trim(data['user-custom'])
      if user_custom != ''
        _data.push {
          custom: user_custom
        }


      console.log _data

      json = JSON.stringify _data

      jQuery.ajax
        type: @props.method
        url: @props.data.submit_url
        data:
          "sentence_data_json": json
      .done (res)=>
        location.href = @props.data.cancel_url


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
      <ModelForm {...@props} method='POST' />
)
