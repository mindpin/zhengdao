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
        <SVGImage {...@props} src={src} key={src} />
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
        {...@props}
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
    adding: false

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
        add_area={@add_area} 
        add_area_done={@add_area_done} 
      />

      <div ref='toucher'
        {...toucher_props}
      >
        <div className='points-area' ref='area' style={style}>
          <img src={@props.src} width={w} height={h} style={img_style} />
        </div>
        <Drawer 
          key='drawer' 
          toucher={@} 
          ref='drawer' 
          adding={@state.adding}
          areas={@props.data.pe_define.svg_areas}
        />
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
      return if @state.scale >= 4
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


  add_area: ->
    @setState adding: true

  add_area_done: (areas)->
    @setState adding: false

    jQuery.ajax
      url: @props.data.savg_svg_areas_url
      type: 'PUT'
      data:
        areas: JSON.stringify areas
    .done (res)->
      console.log res


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
          <Button type='primary' onClick={@props.add_area}><Icon type='plus' /> 添加区域</Button>
        else
          <Button onClick={@props.add_area_done}>
            <Icon type='close' /> 取消添加
          </Button>
      }
      </div>
    </div>


Drawer = React.createClass
  getInitialState: ->
    areas: @props.areas || []
    hover_area_idx: null

  render: ->
    className = if @props.adding then 'drawer' else 'drawer a'

    <div>
      <div className={className}>
        <canvas ref='canvas' width={3000} height={3000} />
      </div>
      <Areas
        ref='areas'
        areas={@state.areas} 
        set_hover_area={(idx)=>
          @setState hover_area_idx: idx
        }
        delete_area_by_idx={(idx)=>
          areas = @state.areas
          areas = areas.filter (x, i)->
            i != idx
          @setState areas: areas
          @draw_areas()
          @props.toucher.add_area_done areas
        }
      />
    </div>

  componentDidMount: ->
    { Path, Point, Tool } = paper

    canvas = ReactDOM.findDOMNode @refs.canvas
    @top_offset = jQuery(canvas).offset().top

    @tool = new Tool() if not @tool
    @path = null
    @start_point = null
    @has_drag = false

    paper.setup(canvas)
    @draw()
    paper.view.draw()

  componentDidUpdate: ->
    @draw_areas()

  componentWillUnmount: ->
    @path.remove() if @path
    @tool.remove()

  draw: ->
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

  mouse_up: (evt)->
    return if not @has_drag
    @path.add @start_point
    @path.closed = true
    # path.fullySelected = true
    @path.fillColor = 'rgba(255, 0, 0, 0.1)'
    @path.simplify(20)
    @save()

  save: ->
    data = @path.exportJSON(asString: false)
    raw_segments = data[1].segments
    segments = @trans raw_segments
    @path.remove()

    areas = @state.areas
    areas.push {
      segments: segments
    }
    @setState areas: areas
    @draw_areas()
    @props.toucher.add_area_done areas

  draw_areas: ->
    { Path, Point, Tool } = paper

    @areas_paths ||= []
    @areas_paths.forEach (path)->
      path.remove()

    @state.areas.forEach (area, idx)=>
      segments = area.segments
      path = new Path {
        strokeColor: '#E4141B'
        strokeWidth: 2
        strokeCap: 'round'
        fillColor: 'rgba(255, 0, 0, 0.1)'
        closed: true
        segments: @untrans segments
        dashArray: [10, 10]
      }

      if @state.hover_area_idx == idx
        path.strokeWidth = 3
        path.dashArray = null
        path.fillColor = 'rgba(255, 0, 0, 0.3)'

      @areas_paths.push path


  # 转换绘图坐标到记录坐标
  trans: (segments)->
    toucher = @props.toucher

    segments.map (arrs)=>
      arr = arrs[0]
      data = toucher._trans_points arr[0], arr[1]
      [
        [data.cx, data.cy]
        arrs[1].map (x)-> x / toucher.state.scale
        arrs[2].map (x)-> x / toucher.state.scale
      ]

  # 将记录坐标转回绘图坐标
  untrans: (segments)->
    toucher = @props.toucher

    segments.map (arrs)=>
      arr = arrs[0]
      data = toucher._untrans_points arr[0], arr[1]
      [
        [data.window_x, data.window_y]
        arrs[1].map (x)-> x * toucher.state.scale
        arrs[2].map (x)-> x * toucher.state.scale
      ]


Areas = React.createClass
  render: ->
    { Icon } = antd

    <div className='areas'>
    {
      @props.areas.map (area, idx)=>
        <div key={idx} className='area'
          onMouseEnter={@enter(idx)}
          onMouseLeave={@leave(idx)}
        >
          <span>区域{idx}</span>
          <div className='delete' onClick={@delete(idx)}>
            <Icon type='delete' />
          </div>
        </div>
    }
    </div>

  enter: (idx)->
    => @props.set_hover_area idx

  leave: (idx)->
    => @props.set_hover_area null

  delete: (idx)->
    =>
      antd.Modal.confirm {
        title: '删除区域'
        content: '确定要删除吗？'
        onOk: =>
          @props.delete_area_by_idx idx
      } 