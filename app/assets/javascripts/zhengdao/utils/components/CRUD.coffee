{ Form, Button, Icon } = antd
FormItem = Form.Item

@CRUDMixin = {
  submit: (evt)->
    if @_submit
      @_submit(evt)
      return

    evt.preventDefault()

    @props.form.validateFields (errors, data) => 
      console.log data
      return if errors

      # jQuery.ajax
      #   type: @props.method
      #   url: @props.data.submit_url
      #   data:
      #     "#{@props.model}": data
      # .done (res)=>
      #   location.href = @props.data.cancel_url

  submit_btns: ->
    <FormItem wrapperCol={ span: 16, offset: 4 }>
      <Button type="primary" htmlType="submit">
        <Icon type='check' /> 确定保存
      </Button>
      <a className='ant-btn ant-btn-lg' style={marginLeft: 8} href={@props.data.cancel_url}>
        取消
      </a>
    </FormItem>

  form_style: ->
    padding: '2rem 1rem 1rem' 
    backgroundColor: 'white'
    maxWidth: 800
}