@VectorSVGPaper = React.createClass
  getInitialState: ->
    svg_data: @props.svg_data

  render: ->
    { Alert } = antd

    <div className='paper'>
    {
      if not @state.svg_data?
        <div style={padding: '1rem'}>
        <Alert
          message='需要上传矢量图' 
          description='还没有上传矢量图，点击上方的按钮上传。矢量图必须是 SVG 格式' />
        </div>

      else
        src = @state.svg_data.file_entity_url
        <SVGImage src={src} key={src} />
    }
    </div>

  load_svg: (svg_data)->
    @setState svg_data: svg_data


SVGImage = React.createClass
  getInitialState: ->
    loaded: false
    width: null
    height: null

  render: ->
    { Spin, Alert } = antd

    if not @state.loaded
      <div>
        <div style={padding: '1rem'}>
        <Spin>
          <Alert message="正在加载图片"
            type="info"
          />
        </Spin>
        </div>
        <img style={opacity: 0} src={@props.src} onLoad={@load} ref='img' />
      </div>

    else
      <Toucher 
        width={@state.width} 
        height={@state.height}
        src={@props.src} 
      />

  load: ->
    if not @state.loaded
      $img = jQuery ReactDOM.findDOMNode @refs.img
      width = $img.width()
      height = $img.height()

      @setState
        loaded: true
        width: width
        height: height

Toucher = React.createClass
  getInitialState: ->
    width: @props.width
    height: @props.height
    x: 0
    y: 0
    scale: 1.0

    areax: 0
    areay: 0

    # 是否正在绘制区域
    adding: true

    areas: []

  render: ->
    w = @state.width
    h = @state.height

    style =
      width: w * @state.scale
      height: h * @state.scale
      left: @state.x
      top: @state.y

    img_style =
      transform: "scale(#{@state.scale})"
      transformOrigin: '0 0'

    if not @state.adding
      toucher_props =
        draggable: true
        onDragStart: @drag_start
        onMouseMove: (evt)=>
          if @on_drag
            @drag_move(evt)
          else
            @mouse_move_on_area(evt)
        onMouseUp: @drag_end
        onWheel: @do_scale
        className: 'toucher'

    else
      toucher_props =
        onMouseMove: (evt)=>
          @mouse_move_on_area(evt)
        className: 'toucher adding'

    <div>
      <Info {...@state} 
        add_fact={@add_fact} 
        save_fact={@save_fact} 
        cancel_fact={@cancel_fact}
      />

      <div ref='toucher'
        {...toucher_props}
      >
        <div className='points-area' ref='area' style={style}>
          <img src={@props.src} width={w} height={h} style={img_style} />
        </div>
        <Drawer key='drawer' toucher={@} ref='drawer' adding={@state.adding} />
      </div>
    </div>

  componentDidMount: ->
    @aim_to_center()

  aim_to_center: ->
    $toucher = jQuery ReactDOM.findDOMNode @refs.toucher
    tw = $toucher.width()
    th = $toucher.height()

    @setState
      x: (tw - @state.width) / 2
      y: (th - @state.height) / 2

  drag_start: (evt)->
    evt.preventDefault()

    @origin_x = @state.x
    @origin_y = @state.y
    @on_drag = true
    
    if evt.touches?
      @mouse_start_x = evt.touches[0].pageX
      @mouse_start_y = evt.touches[0].pageY
    else
      @mouse_start_x = evt.pageX
      @mouse_start_y = evt.pageY

  drag_move: (evt)->
    if @on_drag
      if evt.touches?
        delta_x = evt.touches[0].pageX - @mouse_start_x
        delta_y = evt.touches[0].pageY - @mouse_start_y
      else
        delta_x = evt.pageX - @mouse_start_x
        delta_y = evt.pageY - @mouse_start_y

      @setState
        x: @origin_x + delta_x
        y: @origin_y + delta_y

  drag_end: (evt)->
    @on_drag = false #if @on_drag
    evt.preventDefault()
    evt.stopPropagation()

  do_scale: (evt)->
    data = @_trans_points(evt.pageX, evt.pageY)
    @compute_scale(evt.deltaY, data.cx, data.cy)
    # @compute_scale(evt.deltaY, 0, 0)

  compute_scale: (dir, center_x, center_y)->
    i = 1.25

    if dir > 0
      return if @state.scale <= 0.2
      # 缩小
      old_scale = @state.scale
      new_scale = @state.scale / i
      new_scale = Math.round(new_scale * 100) / 100

    if dir < 0
      return if @state.scale >= 3
      # 放大
      old_scale = @state.scale
      new_scale = @state.scale * i
      new_scale = Math.round(new_scale * 100) / 100

    if dir != 0
      @setState 
        scale: new_scale
        x: @state.x - center_x * (new_scale - old_scale)
        y: @state.y - center_y * (new_scale - old_scale)

  mouse_move_on_area: (evt)->
    data = @_trans_points(evt.pageX, evt.pageY)
    @setState
      areax: Math.round data.cx
      areay: Math.round data.cy

  _trans_points: (window_x, window_y)->
    $area = jQuery ReactDOM.findDOMNode @refs.area
    offset = $area.offset()

    cx = (window_x - offset.left) / @state.scale
    cy = (window_y - offset.top) / @state.scale

    {cx: cx, cy: cy}

  _untrans_points: (cx, cy)->
    $area = jQuery ReactDOM.findDOMNode @refs.area
    offset = $area.offset()

    window_x = cx * @state.scale + offset.left
    window_y = cy * @state.scale + offset.top

    {window_x: window_x, window_y: window_y}


  add_fact: ->
    @setState adding: true

  save_fact: ->
    @setState adding: false

  cancel_fact: ->
    @setState adding: false



Info = React.createClass
  render: ->
    { Button, Icon } = antd

    # percent = Math.round(@props.scale * 100.0)
    percent = Math.round @props.scale * 100

    <div className='tools'>
      <div className='pos-info'>
        <div>缩放：{percent}%</div>
        <div>位置：{@props.areax}, {@props.areay}</div>
      </div>
      <div>
      {
        if not @props.adding
          <Button type='primary' onClick={@props.add_fact}><Icon type='plus' /> 添加区域</Button>
        else
          <div>
            <div style={marginBottom: '0.5rem'}>
              <Button type='primary' onClick={@props.save_fact}>
                <Icon type='check' /> 添加完毕
              </Button>
            </div>
            <div>
              <Button onClick={@props.cancel_fact}>
                <Icon type='close' /> 取消添加
              </Button>
            </div>
          </div>
      }
      </div>
    </div>


Drawer = React.createClass
  render: ->
    className = if @props.adding then 'drawer' else 'drawer a'

    <div className={className}>
      <canvas ref='canvas' width={3000} height={3000} />
    </div>

  componentDidMount: ->
    { Path, Point, Tool } = paper

    canvas = ReactDOM.findDOMNode @refs.canvas
    top_offset = jQuery(canvas).offset().top

    @tool = new Tool() if not @tool
    @path = null
    @start_point = null
    @has_drag = false

    paper.setup(canvas)
    @draw(top_offset)
    paper.view.draw()

  componentWillUnmount: ->
    @path.remove() if @path
    @tool.remove()

  draw: (top_offset)->
    { Path, Point, Tool } = paper

    @tool.onMouseDown = @mouse_down
    @tool.onMouseDrag = @mouse_drag
    @tool.onMouseUp = @mouse_up

  mouse_down: (evt)->
    { Path, Point, Tool } = paper

    @has_drag = false
    @start_point = evt.point
    @path.remove() if @path
    @path = new Path {
      # strokeColor: '#E4141B'
      strokeColor: '#3E82F7'
      strokeWidth: 3
      strokeCap: 'round'
      fillColor: null
    }
    @path.add(evt.point)

  mouse_drag: (evt)->
    @has_drag = true
    @path.add(evt.point)

  mouse_up:  (evt)->
    return if not @has_drag
    @path.add @start_point
    @path.closed = true
    # path.fullySelected = true
    @path.fillColor = 'rgba(255, 0, 0, 0.1)'
    @path.simplify(20)
    @normalize()


  normalize: ->
    { Path, Point, Tool } = paper

    data = @path.exportJSON(asString: false)
    normalize_segments = @trans data[1].segments

    @path.remove()
    @path = new Path {
      strokeColor: '#E4141B'
      strokeWidth: 3
      strokeCap: 'round'
      fillColor: 'rgba(255, 0, 0, 0.1)'
      closed: true
      segments: @untrans normalize_segments
      dashArray: [10, 10]
    }


  # 转换绘图坐标到记录坐标
  trans: (segments)->
    segments.map (arrs)=>
      arr = arrs[0]
      data = @props.toucher._trans_points arr[0], arr[1]
      [[data.cx, data.cy], arrs[1], arrs[2]]

  # 将记录坐标转回绘图坐标
  untrans: (segments)->
    segments.map (arrs)=>
      arr = arrs[0]
      data = @props.toucher._untrans_points arr[0], arr[1]
      [[data.window_x, data.window_y], arrs[1], arrs[2]]