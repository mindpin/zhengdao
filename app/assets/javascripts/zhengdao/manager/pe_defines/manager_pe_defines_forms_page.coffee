@ManagerPeDefinesNewPage = React.createClass
  getInitialState: ->
    groups: []

    is_adding_group: false

  render: ->

    if @state.is_adding_group
      <div className='ui segment'>
        <AddingGroup 
          cancel={=> @setState is_adding_group: false}
          group_list_url={@props.data.group_list_url}
          except_ids={@state.groups.map (x)-> x.id}
          add_group={@add_group}
        />
      </div>

    else
      {
        TextInputField
        TextAreaField
        Submit
      } = DataForm

      layout =
        label_width: '6rem'

      <div className='ui segment'>
        <SimpleDataForm
          model='pe_define'
          post={@props.data.submit_url}
          done={@done}
          cancel={@cancel}
          on_submit={@submit}
        >
          <TextInputField {...layout} label='名称：' name='name' required />
          <TextAreaField {...layout} label='描述：' name='desc' />

          <IncludedGroupsField 
            groups={@state.groups} 
            adding_group={@adding_group}
            remove_group={@remove_group}
          />

          <Submit {...layout} text='确定保存' with_cancel='取消' />
        </SimpleDataForm>
      </div>

  submit: (_data)->
    data = 
      name: _data.name
      desc: _data.desc
      fact_group_ids: @state.groups.map (x)-> x.id

    jQuery.ajax
      type: 'POST'
      url: @props.data.submit_url
      data:
        pe_define: data
    .done (res)->
      Turbolinks.visit @props.data.cancel_url

  cancel: ->
    Turbolinks.visit @props.data.cancel_url

  adding_group: ->
    @setState is_adding_group: true

  add_group: (group)->
    groups = @state.groups
    groups.push group
    @setState groups: groups

  remove_group: (group)->
    groups = @state.groups
    groups = groups.filter (x)-> x.id != group.id
    @setState groups: groups


IncludedGroupsField = React.createClass
  render: ->
    style = 
      borderTop: 'solid 1px #ececec'
      paddingTop: '1rem'
      position: 'relative'

    btn_style = 
      position: 'absolute'
      top: 8
      right: 0

    list_style =
      marginTop: '3rem'
      border: 'solid 1px #ececec'
      minHeight: '2rem'
      background: '#ffffdc'

    <div className='field' style={style}>
      <label>标签组</label>
      <a className='ui button mini blue' style={btn_style} onClick={@add}>
        <i className='icon plus' /> 添加标签组
      </a>
      <div className='wrapper' style={flex: 1}>
      <div className='ui divided list groups' style={list_style}>
      {
        for group in @props.groups
          <div key={group.id} className='item' style={padding: '0.5rem', lineHeight: '24px'}>
            <span>{group.name}</span>
            <a href='javascript:;' 
              className='ui button mini red' 
              onClick={@remove(group)}
              style={height: '24px', lineHeight: '24px', padding: '0 0.5rem', float: 'right'}
            >
              删除
            </a>
          </div>
      }
      </div>
      </div>
    </div>

  add: ->
    @props.adding_group()

  remove: (group)->
    =>
      @props.remove_group group


AddingGroup = React.createClass
  getInitialState: ->
    list_groups: []
    checked_group: null

  render: ->
    <div className='adding-group ui form'>
      <h3>从下列标签组中选择：</h3>
      {
        for group in @state.list_groups
          checked = @state.checked_group?.id == group.id

          <div key={group.id} className='field'>
            <div className='ui checkbox radio'>
              <input name='group' type='radio' value={group.id} checked={checked} onChange={@change(group)} />
              <label>{group.name}</label>
            </div>
          </div>
      }
      <div className='field'>
        <a href='javascript:;' onClick={@save} className='ui button green'>确定</a>
        <a href='javascript:;' onClick={@cancel} className='ui button'>取消</a>
      </div>
    </div>

  componentDidMount: ->
    jQuery.ajax
      url: @props.group_list_url
      data:
        except_ids: @props.except_ids

    .done (res)=>
      console.log res
      @setState list_groups: res

  cancel: ->
    @props.cancel()

  change: (group)->
    =>
      @setState checked_group: group

  save: ->
    @props.cancel()
    @props.add_group @state.checked_group