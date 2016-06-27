@ManagerUsersNewPage = React.createClass
  render: ->
    {
      TextInputField
      PasswordField
      SelectField
      MultipleSelectField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    roles =
      'wizard': '导诊'
      'doctor': '医师'
      'pe': '体检师'
      'cure': '治疗师'

    stores_select_info = {}
    for s in @props.data.stores
      stores_select_info[s.id] = s.name

    <div className='ui segment'>
      <SimpleDataForm
        model='user'
        post={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='姓名：' name='name' required />
        <TextInputField {...layout} label='登录名：' name='login' required />
        <PasswordField {...layout} label='密码：' name='password' required />
        <MultipleSelectField {...layout} label='角色：' name='roles' values={roles} required />
        <SelectField {...layout} label='店面：' name='store_id' values={stores_select_info} />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url

@ManagerUsersEditPage = React.createClass
  render: ->
    {
      TextInputField
      PasswordField
      SelectField
      MultipleSelectField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    roles =
      'wizard': '导诊'
      'doctor': '医师'
      'pe': '体检师'
      'cure': '治疗师'

    stores_select_info = {}
    for s in @props.data.stores
      stores_select_info[s.id] = s.name

    <div className='ui segment'>
      <SimpleDataForm
        model='user'
        data={@props.data.user}
        put={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='姓名：' name='name' required />
        <TextInputField {...layout} label='登录名：' name='login' required />
        <PasswordField {...layout} label='重设密码：' name='password' />
        <MultipleSelectField {...layout} label='角色：' name='roles' values={roles} required />
        <SelectField {...layout} label='店面：' name='store_id' values={stores_select_info} />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url
