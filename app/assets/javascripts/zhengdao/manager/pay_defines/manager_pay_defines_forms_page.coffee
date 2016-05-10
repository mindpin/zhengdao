@ManagerPayDefinesNewPage = React.createClass
  render: ->
    {
      TextInputField
      TextAreaField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    <div className='ui segment'>
      <SimpleDataForm
        model='pay_define'
        post={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='名称：' name='name' required />
        <TextAreaField {...layout} label='描述：' name='desc' />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url

@ManagerPayDefinesEditPage = React.createClass
  render: ->
    {
      TextInputField
      TextAreaField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    <div className='ui segment'>
      <SimpleDataForm
        model='pay_define'
        data={@props.data.pay_define}
        put={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='名称：' name='name' required />
        <TextAreaField {...layout} label='描述：' name='desc' />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url
