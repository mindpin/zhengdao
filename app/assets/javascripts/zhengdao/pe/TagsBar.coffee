@TagsBar = React.createClass
  render: ->
    <div className='react-tags-bar'>
    {
      for tag, idx in @props.tags
        <Tag key={idx} tag={tag} />
    }
    </div>

Tag = React.createClass
  render: ->
    tag = @props.tag
    if tag.className?
      klass = "tag #{tag.className}"
    else
      klass = 'tag'

    <div className={klass}>{tag.name}</div>