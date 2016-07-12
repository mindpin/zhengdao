@ManagerFactGroupsPage = React.createClass
  render: ->
    <div className='manager-fact-groups-page'>
      <div className='ui icon message warning'>
        <i className='icon tags' />
        管理体检记录用标签组
      </div>

      <Table data={@props.data} />
    </div>

Table = React.createClass
  render: ->
    table_data = {
      fields:
        name: '组名'
        children: '子级组/标签'
        ops: '操作'
      data_set: @props.data.fact_groups.map (x)->
        if x.children.length > 0
          children =
            <div>
            {
              for child in x.children
                <div key={child.id}><i className='icon circle thin' /> {child.name}</div>
            }
            </div>

        if x.fact_tags.length > 0
          children =
            <div>
            {
              for tag in x.fact_tags
                <div key={tag.id}><i className='icon tag' /> {tag.name}</div>
            }
            </div>

        id: x.id
        name: x.name
        children: children
        ops:
          <div>
            <a href='javascript:;' className='ui button mini '>
              <i className='icon pencil' /> 编辑
            </a>
            <a href='javascript:;' className='ui button mini red'>
              <i className='icon trash' /> 删除
            </a>
          </div>

      th_classes: {
      }
      td_classes: {
        ops: 'collapsing'
      }
      unstackable: true
    }

    <div>
      <div className='ui segment basic ops'>
        <a href={@props.data.new_url} className='ui button green'>
          <i className='icon plus' /> 添加标签组
        </a>
      </div>
      <ManagerTable data={table_data} title='标签组管理' />
    </div>



@ManagerFactGroupsNewPage = React.createClass
  render: ->
    <FactGroupForm 
      submit_url={@props.data.submit_url} 
      group_list_url={@props.data.group_list_url}
      cancel_url={@props.data.cancel_url}
    />


FactGroupForm = React.createClass
  displayName: 'FactGroupForm'
  getInitialState: ->
    sub_type: 'tag'

    name: ''
    tags: [] # 字符串数组
    groups: [] # 对象

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
              <TagsField tags={@state.tags} />
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
          tags: @state.tags

    jQuery.ajax
      type: 'post'
      url: @props.submit_url
      data:
        fact_group: data

    .done (res)=>
      location.href = @props.submit_url

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

    <div className='field' style={style}>
      <label>标签值</label>
      <div className="ui fluid selection search multiple dropdown" style={list_style}>
        <input type='hidden' ref='input' />
        <div className="default text">输入标签值</div>
      </div>
    </div>

  componentDidMount: ->
    jQuery(React.findDOMNode @)
      .find('.ui.dropdown').dropdown
        allowAdditions: true
        onAdd: (addedValue, addedText, $addedChoice)=>
          tags = @state.tags
          tags.push addedValue
          @setState tags: tags

        onRemove: (removedValue, removedText, $removedChoice)=>
          tags = @state.tags
          tags = tags.filter (x)-> x != removedValue
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