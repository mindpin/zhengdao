@WizardPatientsNewPage = React.createClass
  render: ->
    {
      TextInputField
      TextAreaField
      Submit
    } = DataForm

    layout =
      label_width: '6rem'

    roles =
      'wizard': '导诊'
      'doctor': '医师'
      'pe': '体检师'
      'cure': '治疗师'

    <div className='ui segment'>
      <SimpleDataForm
        model='patient'
        post={@props.data.submit_url}
        done={@done}
        cancel={@cancel}
      >
        <TextInputField {...layout} label='姓名：' name='name' required />
        <TextInputField {...layout} label='身份证号：' name='id_card' required />
        <TextInputField {...layout} label='手机号：' name='mobile_phone' required />
        <TextAreaField  {...layout} label='症状描述：' name='symptom_desc' />
        <TextAreaField  {...layout} label='个人病史：' name='personal_pathography' />
        <TextAreaField  {...layout} label='家族病史：' name='family_pathography' />
        <Submit {...layout} text='确定保存' with_cancel='取消' />
      </SimpleDataForm>
    </div>

  done: (res)->
    Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url