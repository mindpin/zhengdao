@ManagerStoresNewPage = React.createClass
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
        post={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='店面名称：' name='name' required />
        <TextInputField {...layout} label='地址：' name='location' required />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url

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
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url
