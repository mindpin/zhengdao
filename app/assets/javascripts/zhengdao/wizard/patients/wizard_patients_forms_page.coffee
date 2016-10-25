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

    <div style={@form_style()}>
      <Form onSubmit={@submit}>
        <FormItem {...iprops} label='姓名'>
        {getFieldDecorator('name', {initialValue: model?.name, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='性别'>
        {getFieldDecorator('gender', {initialValue: model?.gender, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Select>
            <Option value='MALE'>男</Option>
            <Option value='FEMALE'>女</Option>
          </Select>
        )}
        </FormItem>

        <FormItem {...iprops} label='年龄'>
        {getFieldDecorator('age', {initialValue: model?.age, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='身份证号'>
        {getFieldDecorator('id_card', {initialValue: model?.id_card, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='手机号'>
        {getFieldDecorator('mobile_phone', {initialValue: model?.mobile_phone, rules: [
          {required: true, message: '必须要填'}
        ]})(
          <Input />
        )}
        </FormItem>

        <FormItem {...iprops} label='症状描述'>
        {getFieldDecorator('symptom_desc', {initialValue: model?.symptom_desc, rules: [
        ]})(
          <Input type='textarea' rows={4} />
        )}
        </FormItem>

        <FormItem {...iprops} label='个人病史'>
        {getFieldDecorator('personal_pathography', {initialValue: model?.personal_pathography, rules: [
        ]})(
          <Input type='textarea' rows={4} />
        )}
        </FormItem>

        <FormItem {...iprops} label='家族病史'>
        {getFieldDecorator('family_pathography', {initialValue: model?.family_pathography, rules: [
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
      console.log data
      return if errors

      jQuery.ajax
        type: @props.method
        url: @props.data.submit_url
        data:
          "#{@props.model}": data
      .done (res)=>
        if window.current_role == 'wizard'
          return location.href = res.wizard_show_url

        if window.current_role == 'admin'
          return location.href = res.manager_show_url



@WizardPatientsNewPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='POST' model='patient' />
)

@ManagerPatientEditPage = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='PUT' model='patient' />
)