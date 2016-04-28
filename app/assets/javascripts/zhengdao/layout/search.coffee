@SiteSearch = React.createClass
  getInitialState: ->
    query: @props.query || ''
    placeholder: @props.placeholder || '搜索...'
    url: @props.url || '/search'

  render: ->
    <div className='ui icon input'>
      <input type='text' placeholder={@state.placeholder} value={@state.query} onChange={@change} onKeyPress={@enter_submit} />
      <i className='search link icon' onClick={@search}></i>
    </div>

  change: (evt)->
    @setState query: evt.target.value

  search: ->
    if not jQuery.is_blank(@state.query)
      Turbolinks.visit "#{@state.url}/#{@state.query}"

  enter_submit: (evt)->
    if evt.which is 13
      @search()