@ManagerFactGroupsNewPage = React.createClass
  render: ->
    <FactGroupForm 
      submit_url={@props.data.submit_url} 
      group_list_url={@props.data.group_list_url}
      cancel_url={@props.data.cancel_url}
    />

@ManagerFactGroupsEditPage = React.createClass
  render: ->
    <FactGroupForm 
      fact_group={@props.data.fact_group}
      submit_url={@props.data.submit_url} 
      group_list_url={@props.data.group_list_url}
      cancel_url={@props.data.cancel_url}
      update={true}
    />

FactGroupForm = React.createClass
  displayName: 'FactGroupForm'
  getInitialState: ->
    # console.log @props.fact_group

    sub_type = 'tag'
    sub_type = 'group' if @props.fact_group?.children?.length > 0

    tags = @props.fact_group?.fact_tags?.map((x)-> x.name) || [] 

    sub_type: sub_type

    name:   @props.fact_group?.name || ''
    tags:   tags # 字符串数组
    groups: @props.fact_group?.children || [] # 对象

    is_adding_group: false

  render: ->
    if @state.is_adding_group
      <div className='ui segment'>
        <AddingGroup 
          cancel={=> @setState is_adding_group: false}
          group_list_url={@props.group_list_url}
          except_ids={@state.groups.map (x)-> x.id}
          add_group={@add_group}
        />
      </div>

    else
      <div className='ui segment'>
        <div className='fact-group-form ui form'>
          <div className='field'>
            <label>标签组名称</label>
            <input type='text' value={@state.name} onChange={@change_name} />
          </div>
          {
            checked1 = @state.sub_type == 'group'
            checked2 = @state.sub_type == 'tag'

            <div className='field'>
              <div className='ui radio checkbox' style={marginRight: '2.5rem'}>
                <input name='sub' type='radio' value='tag' checked={checked2} onChange={@sub} />
                <label>关联标签值</label>
              </div>
              <div className='ui radio checkbox'>
                <input name='sub' type='radio' value='group' checked={checked1} onChange={@sub} />
                <label>关联子级标签组</label>
              </div>
            </div>
          }
          {
            if @state.sub_type == 'group'
              <GroupsField 
                groups={@state.groups} 
                adding_group={@adding_group}
                remove_group={@remove_group}
              />
          }
          {
            if @state.sub_type == 'tag'
              <TagsField tags={@state.tags} ref='tag_ipt' />
          }
          <div className='field' style={marginTop: '2rem'}>
            <a className='ui button green' onClick={@save}>
              <i className='icon check' /> 保存
            </a>
            <a href={@props.cancel_url} className='ui button'>取消</a>
          </div>
        </div>
      </div>

  sub: (evt)->
    @setState sub_type: evt.target.value

  change_name: (evt)->
    @setState name: evt.target.value

  add_group: (group)->
    groups = @state.groups
    groups.push group
    @setState groups: groups

  remove_group: (group)->
    groups = @state.groups
    groups = groups.filter (x)-> x.id != group.id
    @setState groups: groups

  save: ->
    data = 
      switch @state.sub_type
        when 'group'
          name: @state.name
          child_ids: @state.groups.map (x)-> x.id

        when 'tag'
          name: @state.name
          tags: @refs.tag_ipt?.get_tags()

    # console.log data

    if @props.update
      jQuery.ajax
        type: 'put'
        url: @props.submit_url
        data:
          fact_group: data

      .done (res)=>
        location.href = @props.cancel_url

    else
      jQuery.ajax
        type: 'post'
        url: @props.submit_url
        data:
          fact_group: data

      .done (res)=>
        location.href = @props.cancel_url

  adding_group: ->
    @setState is_adding_group: true

TagsField = React.createClass
  getInitialState: ->
    tags: @props.tags

  render: ->
    style = 
      borderTop: 'solid 1px #ececec'
      paddingTop: '1rem'
      position: 'relative'

    list_style =
      marginTop: '1rem'
      background: '#ffffdc'

    value = @state.tags.join ','

    <div className='field' style={style}>
      <label>标签值</label>
      <div className="ui fluid selection search multiple dropdown" style={list_style}>
        <input type='hidden' ref='input' value={value} />
        <div className="default text">输入标签值</div>
      </div>
    </div>

  componentDidMount: ->
    # console.log @state.tags

    jQuery(ReactDOM.findDOMNode @)
      .find('.ui.dropdown').dropdown
        allowAdditions: true
        onAdd: (addedValue, addedText, $addedChoice)=>
          tags = @state.tags
          tags.push addedValue if tags.indexOf(addedValue) == -1
          @setState tags: tags

        onRemove: (removedValue, removedText, $removedChoice)=>
          tags = @state.tags
          tags = tags.filter (x)-> x != removedValue
          # console.log tags
          @setState tags: tags

  get_tags: ->
    @state.tags.map (x)-> x



GroupsField = React.createClass
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
      border: 'solid 1px #ececec'
      minHeight: '2rem'
      background: '#ffffdc'

    console.log @props.groups

    <div className='field' style={style}>
      <label>标签组</label>
      <a className='ui button mini blue' style={btn_style} onClick={@add}>
        <i className='icon plus' /> 添加标签组
      </a>
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
      @setState list_groups: res

  cancel: ->
    @props.cancel()

  change: (group)->
    =>
      @setState checked_group: group

  save: ->
    @props.cancel()
    @props.add_group @state.checked_group