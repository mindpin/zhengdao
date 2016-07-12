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
        chilren: '子级组/标签'
        ops: '操作'
      data_set: []
      th_classes: {
      }
      td_classes: {
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
    <FactGroupForm />


FactGroupForm = React.createClass
  getInitialState: ->
    sub_type: 'tag'

    name: ''
    tags: []
    groups: []

    is_adding_group: false

  render: ->
    if @state.is_adding_group
      <div className='ui segment'>
        <AddingGroup cancel={=> @setState is_adding_group: false}/>
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
              <GroupsField groups={@state.groups} adding_group={@adding_group}/>
          }
          {
            if @state.sub_type == 'tag'
              <TagsField tags={@state.tags} />
          }
          <div className='field' style={marginTop: '2rem'}>
            <a className='ui button green' onClick={@save}>
              <i className='icon check' /> 保存
            </a>
          </div>
        </div>
      </div>

  sub: (evt)->
    @setState sub_type: evt.target.value

  change_name: (evt)->
    @setState name: evt.target.value

  save: ->
    data = 
      switch @state.sub_type
        when 'group'
          name: @state.name
          groups: @state.groups

        when 'tag'
          name: @state.name
          tags: @state.tags

    console.log data

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
      <div className='ui list groups' style={list_style}>
      </div>
    </div>

  add: ->
    @props.adding_group()


AddingGroup = React.createClass
  render: ->
    <div className='adding-group form'>
      <h3>从下列标签组中选择：</h3>
      <div className='field'>
        <a href='javascript:;' onClick={@save} className='ui button green'>确定</a>
        <a href='javascript:;' onClick={@cancel} className='ui button'>取消</a>
      </div>
    </div>

  cancel: ->
    @props.cancel()