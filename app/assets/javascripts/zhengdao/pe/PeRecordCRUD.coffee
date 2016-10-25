ModelForm = React.createClass
  mixins: [CRUDMixin]

  render: ->
    { Form, Input, Button, Icon, Select } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props.form

    iprops = {
      labelCol: { span: 3 }
      wrapperCol: { span: 16 }
    }

    model = @props.data[@props.model]

    <div style={@form_style()}>
      <Form onSubmit={@submit}>
        {
          model?.sentences.map (s, idx)->
            <FormItem key={s.id} {...iprops} label='记录'>
              <div style={lineHeight: '1.5', padding: '7px 0'}>
                <SentenceShow sentence={s} />
              </div>
            </FormItem>
        }

        <FormItem {...iprops} label='操作'>
          <a className='ant-btn ant-btn-primary ant-btn-lg' style={marginLeft: 8} 
            href={model.new_sentence_url}
          >
            <Icon type='plus' /> 增加一条记录
          </a>
          <a className='ant-btn ant-btn-lg' style={marginLeft: 8} href={@props.data.cancel_url}>
            返回
          </a>
        </FormItem>
      </Form>
    </div>

@PeRecordFormPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='PUT' model='pe_record' />
)
