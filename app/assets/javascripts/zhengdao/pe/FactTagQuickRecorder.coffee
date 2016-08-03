@FactTagQuickRecorder = React.createClass
  render: ->
    object = @props.object
    <div className='fact-tag-quick-recorder ui segment'>
      <Recorder object={object} saved_records={@props.saved_records} ref='re' />
    </div>

  get_records: ->
    # console.log @refs.re.state.records

    @refs.re.state.records.map (record)->
      record.map (x)->
        id: x.id
        name: x.name
        type: x.type


Recorder = React.createClass
  getInitialState: ->
    records: @props.saved_records || []
    adding: false

  render: ->
    <div className='recorder'>
    {
      unless @state.adding
        <div>
          <RecordsList records={@state.records} remove_record={@remove_record} />
          <a href='javascript:;' className='ui button fluid large green' onClick={@add}>
            <i className='icon plus' /> 增加一条记录
          </a>
        </div>
      else
        <FactSelector 
          object={@props.object} 
          add_record={@add_record}
          cancel={@cancel} 
        />
    }
    </div>

  add: ->
    @setState adding: true

  add_record: (record)->
    records = @state.records
    records.push record

    @setState 
      records: records
      adding: false

  remove_record: (record)->
    records = @state.records
    records = records.filter (x)->
      record != x

    @setState 
      records: records
      adding: false

  cancel: ->
    @setState
      adding: false

RecordsList = React.createClass
  render: ->
    # console.log @props.records

    if Object.keys(@props.records).length > 0
      <div className='records-list'>
      {
        for idx, record of @props.records
          tags = record.map (x)->
            name: x.name
            className: if x.type == 'tag' then 'tag-value' else null

          <div key={idx} style={position: 'relative'}>
            <TagsBar tags={tags} />
            <a 
              href='javascript:;' 
              onClick={@remove(record)}
              style={
                position: 'absolute',
                top: 5,
                right: 5,
                height: 26,
                lineHeight: '26px',
                color: 'white'
                backgroundColor: '#666'
                padding: '0 10px'
                borderRadius: 3
              }
            >删除</a>
          </div>
      }
      </div>
    else
      <div />

  remove: (record)->
    =>
      @props.remove_record(record)

FactSelector = React.createClass
  getInitialState: ->
    stack: []
    current: @props.object

  render: ->
    # console.log @props.object

    <div className='selector'>
      <SelectorTopbar object={@props.object} cancel={@props.cancel} />

      <StackTags stack={@state.stack} />
      <CurrentFacts fact_groups={@state.current.children} select={@select_fact} />
      <CurrentTags fact_tags={@state.current.fact_tags} select={@select_tag} />
    </div>

  select_fact: (fact)->
    stack = @state.stack
    stack.push fact
    @setState
      stack: stack
      current: fact

  select_tag: (tag)->
    stack = @state.stack
    fact = stack[stack.length - 1]
    fact.selected = true
    stack.push tag
    
    @props.add_record stack



SelectorTopbar = React.createClass
  render: ->
    <div className='selector-topbar' style={paddingLeft: '0.5rem'}>
      <a href='javascript:;' className='ui button mini' onClick={@back}>
        <i className='icon chevron left' /> 后退
      </a>
    </div>

  back: ->
    @props.cancel()


StackTags = React.createClass
  render: ->
    if @props.stack.length
      tags = @props.stack.map (x)->
        name: x.name
        className: if x.type == 'tag' then 'tag-value' else null

      <TagsBar tags={tags} />
    else
      <div />

CurrentFacts = React.createClass
  render: ->
    if @props.fact_groups?.length
      <div>
        <div className='tip'>选择要记录的特征：</div>
        <div className='facts'>
          {
            for fact_group in @props.fact_groups
              <Fact key={fact_group.id} fact={fact_group} select={@props.select} />
          }
        </div>
      </div>
    else
      <div />

Fact = React.createClass
  render: ->
    fact = @props.fact

    if fact.children?.length
      selected_children = fact.children.filter (x)->
        x.selected == true
      # console.log selected_children.length
      # console.log fact.children.length
      # console.log selected_children.length == fact.children.length

      fact.selected = true if selected_children.length == fact.children.length

    if fact.selected
      name = 
        <span>{fact.name} <span className='ui label'>已选</span></span>
      klass = 'fact selected'
    else
      name =
        <span>{fact.name}</span>
      klass = 'fact'

    <a href='javascript:;' className={klass} onClick={@select(fact)}>
      <i className='icon angle right' /> {name}
    </a>

  select: (fact)->
    =>
      @props.select(fact)


AddFact = React.createClass
  render: ->
    <a className='fact add-fact' onClick={@custom_fact}>
      <i className='icon pencil' /> + 添加自定义特征
    </a>

  custom_fact: ->
    console.log 1


CurrentTags = React.createClass
  render: ->
    if @props.fact_tags?.length
      <div>
        <div className='tip'>选择要记录的特征描述：</div>
        <div className='tags'>
          {
            for fact_tag in @props.fact_tags
              <Tag key={fact_tag.id} tag={fact_tag} select={@props.select} />
          }
        </div>
      </div>
    else
      <div />

Tag = React.createClass
  render: ->
    tag = @props.tag

    <a href='javascript:;' className='tag' onClick={@select(tag)}>
      <i className='icon tag' /> {tag.name}
    </a>

  select: (tag)->
    =>
      @props.select(tag)


CustomForm = React.createClass
  render: ->
    <div>
      <div className='tip'>或者补充自定义特征</div>
      <div className='custom ui form'>
        <div className='field fact-name'>
          <input placeholder='输入特征名' />
        </div>
        <div className='field'>
          <textarea placeholder='输入特征描述' rows={3} />
        </div>
        <a href='javascript:;' className='ui button green fluid'>
          <i className='icon check' /> 写好了
        </a>
      </div>
    </div>