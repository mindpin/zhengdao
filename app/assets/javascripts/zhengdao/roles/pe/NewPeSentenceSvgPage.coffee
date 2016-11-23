@NewPeSentenceSvgPage = React.createClass
  render: ->
    svg_data = @props.data?.pe_define?.svg_data

    Paper = window.VectorSVGInputPaper

    <div className='pe-define-vector-editor'>
      <Toolbar {...@props} load_svg={@load_svg}/>
      <Paper {...@props} ref='paper' svg_data={svg_data} />
    </div>

  load_svg: (svg_data)->
    @refs.paper.load_svg(svg_data)

Toolbar = React.createClass
  render: ->
    { Button, Icon } = antd

    <div className='toolbar'>
      <div style={marginTop: 9, marginRight:'1rem', float: 'left'}>
        <Button>
          <a href={@props.data.cancel_url}><Icon type='arrow-left' /> 退出</a>
        </Button>
      </div>
    </div>