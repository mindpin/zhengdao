@VectorSVGInputPaper = React.createClass
  getInitialState: ->
    svg_data: @props.svg_data

  render: ->
    { Alert } = antd

    <div className='paper'>
    {
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
      <div>
        <Toucher
          {...@props}
          width={@state.width} 
          height={@state.height}
          src={@props.src} 
          show_modal={@show_modal}
        />
        <RecordModal {...@props} ref='modal' />
      </div>

  show_modal: (areas)->
    @refs.modal.show(areas)

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
        onClick: @do_click

    <div>
      <Info {...@state} 
        add_area={@add_area} 
        add_area_done={@add_area_done} 
        add_area_cancel={@add_area_cancel}
      />

      <div ref='toucher'
        {...toucher_props}
        style={cursor: 'pointer'}
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
          search_facts_url={@props.data.pe_define.search_facts_url}
          show_modal={@props.show_modal}
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

  do_click: (evt)->
    @refs.drawer.mouse_down evt.pageX, evt.pageY

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

  add_area_cancel: ->
    @setState adding: false


Info = React.createClass
  render: ->
    { Button, Icon } = antd

    # percent = Math.round(@props.scale * 100.0)
    percent = Math.round @props.scale * 100

    <div className='tools'>
      <div className='pos-info' style={marginBottom: 0}>
        <div>缩放：{percent}%</div>
        <div>位置：{@props.areax}, {@props.areay}</div>
      </div>
    </div>


Drawer = React.createClass
  getInitialState: ->
    areas: @props.areas || []
    hover_area_idx: null

  render: ->
    className = 'drawer a'

    <div>
      <div className={className}>
        <canvas ref='canvas' width={3000} height={3000} />
      </div>
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

  #   @tool.onMouseDown = @mouse_down

  mouse_down: (x, y)->
    { Path, Point, Tool } = paper

    point = new Point(x, y)

    pointed_areas = []
    @areas_paths.forEach (path, idx)=>
      if path.contains point
        pointed_areas.push @state.areas[idx]

    @show_modal pointed_areas

  show_modal: (pointed_areas)->
    return if pointed_areas.length is 0
    @props.show_modal pointed_areas

  draw_areas: ->
    { Path, Point, Tool } = paper

    @areas_paths ||= []
    @areas_paths.forEach (path)->
      path.remove()
    @areas_paths = []

    @state.areas.forEach (area, idx)=>
      segments = area.segments
      path = new Path {
        strokeColor: '#E4141B'
        strokeWidth: 1
        strokeCap: 'round'
        fillColor: 'rgba(255, 0, 0, 0.1)'
        closed: true
        segments: @untrans segments
        dashArray: [10, 10]
      }

      if @state.hover_area_idx == idx
        path.strokeWidth = 2
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


RecordModal = React.createClass
  getInitialState: ->
    visible: false
    areas: []

  render: ->
    { Modal } = antd

    names = @state.areas.map (x)-> x.name

    <Modal
      visible={@state.visible}
      title='添加图形区域记录'
      onOk={@handle_ok}
      onCancel={@handle_cancel}
    >
      <TheForm {...@props} area_names={names} key={names} ref='the_form'/>
    </Modal>

  show: (areas)->
    @setState 
      areas: areas
      visible: true

  handle_ok: ->
    @submit()
    @setState visible: false

  handle_cancel: ->
    @setState visible: false

  submit: ->
    form = @refs.the_form.getForm()

    form.validateFields (errors, data) => 
      return if errors

      facts = @props.data?.pe_define?.facts || []

      _data = []

      area_names = data['svg-area-names']
      _data.push {
        area_names: area_names
      }

      # 标签值
      facts.forEach (f)->
        values = data[f.name]
        if values.length
          _data.push {
            fact: f.name
            values: values
          }

      # 自定义描述
      user_custom = jQuery.trim(data['user-custom'])
      if user_custom != ''
        _data.push {
          custom: user_custom
        }

      console.log _data

      json = JSON.stringify _data

      jQuery.ajax
        type: 'POST'
        url: @props.data.submit_url
        data:
          "sentence_data_json": json
      .done (res)=>
        location.href = @props.data.cancel_url


# ---------------------------

ModelForm = React.createClass
  mixins: [CRUDMixin]

  getInitialState: ->
    facts: @props.data?.pe_define?.facts || []

  render: ->
    { Form, Input, Button, Icon, Select } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props.form

    iprops = {
      labelCol: { span: 4 }
      wrapperCol: { span: 16 }
    }

    define = @props.data?.pe_define
    area_names = @props.area_names

    <div style={@form_style()}>
      <Form onSubmit={@submit}>
        <FormItem {...iprops} label='图形区域'>
          {getFieldDecorator('svg-area-names', {initialValue: area_names, rules: [
          ]})(
            <Select
              tags
              placeholder='请输入'
            >
              {
                area_names.map (name, idx)->
                  <Option key={idx} value={name}><Icon type='tag' /> {name}</Option>
              }
            </Select>
          )}
        </FormItem>
        {
          @state.facts.map (f)->
            <FactInputer key={f.id} fact={f} iprops={iprops} getFieldDecorator={getFieldDecorator} />
        }
        <FormItem {...iprops} label='自定义描述'>
          {getFieldDecorator('user-custom', {initialValue: '', rules: [
          ]})(
            <Input type='textarea' rows={4} />
          )}
        </FormItem>
      </Form>
    </div>

FactInputer = React.createClass
  render: ->
    { Form, Icon, Select, Input } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props

    fact = @props.fact
    <FormItem {...@props.iprops} label={fact.name}>
      {getFieldDecorator(fact.name, {initialValue: [], rules: [
      ]})(
        <Select
          tags
          placeholder='请输入'
        >
          {
            fact.tag_names.map (name, idx)->
              <Option key={idx} value={name}><Icon type='tag' /> {name}</Option>
          }
        </Select>
      )}
    </FormItem>

TheForm = antd.Form.create()(
  React.createClass
    render: ->
      <ModelForm {...@props} method='POST' refs='mform'/>
)