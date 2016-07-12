@FactTagQuickRecorder = React.createClass
  render: ->
    object = @props.object
    <div className='fact-tag-quick-recorder ui segment'>
      <Recorder object={object} />
    </div>

StartUI = React.createClass
  render: ->
    <div className='start-ui'>
      <div className='ui message warning'>
        使用快速特征记录工具，能够以快捷的操作完成对客户，产品或任务特征的描述<br/>
        从而记录，管理和分享工作经验
      </div>

      <a href='javascript:;' className='ui button fluid large green' onClick={@props.start}>
        <i className='icon pencil' /> 开始记录
      </a>
    </div>


Recorder = React.createClass
  getInitialState: ->
    records: []
    adding: false

  render: ->
    <div className='recorder'>
    {
      unless @state.adding
        <div>
          <RecordsList records={@state.records} />
          <a href='javascript:;' className='ui button fluid large green' onClick={@add}>
            <i className='icon plus' /> 增加一条记录
          </a>
        </div>
      else
        <FactSelector object={@props.object} add_record={@add_record} cancel={@cancel} />
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

  cancel: ->
    @setState
      adding: false

RecordsList = React.createClass
  render: ->
    if @props.records.length
      <div className='records-list'>
      {
        for record, idx in @props.records
          tags = record.map (x)->
            name: x.fact_name || x.tag_name
            className: if x.tag_name then 'tag-value' else null

          <TagsBar key={idx} tags={tags} />
      }
      </div>
    else
      <div />


FactSelector = React.createClass
  getInitialState: ->
    stack: []
    current: @props.object

  render: ->
    <div className='selector'>
      <SelectorTopbar object={@props.object} cancel={@props.cancel} />

      <StackTags stack={@state.stack} />
      <CurrentFacts facts={@state.current.facts} select={@select_fact} />
      <CurrentTags tags={@state.current.tags} select={@select_tag} />
      <CustomForm />
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
    <div className='selector-topbar'>
      <a href='javascript:;' className='back' onClick={@back}>
        <i className='icon chevron left' />
      </a>
      <span>描述{@props.object.object_name}特征</span>
    </div>

  back: ->
    @props.cancel()


StackTags = React.createClass
  render: ->
    if @props.stack.length
      tags = @props.stack.map (x)->
        name: x.fact_name || x.tag_name
        className: if x.tag_name then 'tag-value' else null

      <TagsBar tags={tags} />
    else
      <div />

CurrentFacts = React.createClass
  render: ->
    if @props.facts
      <div>
        <div className='tip'>选择要记录的特征：</div>
        <div className='facts'>
          {
            for fact, idx in @props.facts
              <Fact key={idx} fact={fact} select={@props.select} />
          }
          <AddFact />
        </div>
      </div>
    else
      <div />

Fact = React.createClass
  render: ->
    fact = @props.fact

    if fact.facts
      selected_children = fact.facts.filter (x)->
        x.selected == true
      fact.selected = true if selected_children.length == fact.facts.length

    if fact.selected
      name = 
        <span>{fact.fact_name} <span className='ui label'>已选</span></span>
      klass = 'fact selected'
    else
      name =
        <span>{fact.fact_name}</span>
      klass = 'fact'

    <a className={klass} onClick={@select(fact)}>
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
    if @props.tags
      <div>
        <div className='tip'>选择要记录的特征描述：</div>
        <div className='tags'>
          {
            for tag, idx in @props.tags
              <Tag key={idx} tag={tag} select={@props.select} />
          }
        </div>
      </div>
    else
      <div />

Tag = React.createClass
  render: ->
    tag = @props.tag

    <a className='tag' onClick={@select(tag)}>
      <i className='icon tag' /> {tag.tag_name}
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