SVGToucher = React.createClass
  displayName: 'SVGToucher'
  render: ->
    @points = [
      {x: 293, y: 78, text: '大椎'}
      {x: 293, y: 107, text: '陶道'}
      {x: 293, y: 152, text: '身柱'}
      {x: 294, y: 222, text: '神道'}
      {x: 294, y: 252, text: '灵台'}
      {x: 294, y: 282, text: '至阳'}
      {x: 295, y: 342, text: '筋缩'}
      {x: 295, y: 365, text: '中枢'}
      {x: 295, y: 391, text: '脊中'}
      {x: 296, y: 472, text: '命门'}
      {x: 297, y: 534, text: '腰阳关'}

      {x: 274, y: 583, text: '上髎'}
      {x: 273, y: 600, text: '次髎'}
      {x: 274, y: 624, text: '中髎'}
      {x: 277, y: 644, text: '下髎'}

      {x: 298, y: 653, text: '腰俞'}
      {x: 299, y: 722, text: '长强'}

      {x: 344, y: 78, text: '肩中俞'}
      {x: 368, y: 99, text: '肩外俞'}

      {x: 396, y: 96, text: '肩井'}
      {x: 397, y: 114, text: '天臑'}
      {x: 396, y: 135, text: '曲坦'}
      {x: 440, y: 133, text: '秉风'}
      {x: 438, y: 192, text: '天宗'}
      {x: 476, y: 153, text: '臑俞'}
      {x: 481, y: 224, text: '肩贞'}

      {x: 367, y: 126, text: '附分'}
      {x: 367, y: 156, text: '魄户'}
      {x: 367, y: 190, text: '膏肓'}
      {x: 367, y: 219, text: '神堂'}
      {x: 367, y: 248, text: '意喜'}
      {x: 367, y: 279, text: '隔关'}
      {x: 367, y: 339, text: '魂门'}
      {x: 367, y: 363, text: '阳纲'}
      {x: 368, y: 389, text: '意舍'}
      {x: 368, y: 410, text: '胃仓'}
      {x: 368, y: 436, text: '盲门'}
      {x: 369, y: 466, text: '志室'}
      {x: 372, y: 599, text: '胞盲'}

      {x: 333, y: 106, text: '大杼'}
      {x: 333, y: 129, text: '风门'}
      {x: 331, y: 152, text: '肺俞'}
      {x: 331, y: 188, text: '厥阴俞'}
      {x: 332, y: 219, text: '心俞'}
      {x: 332, y: 249, text: '督俞'}
      {x: 331, y: 277, text: '膈俞'}
      {x: 333, y: 335, text: '肝俞'}
      {x: 332, y: 360, text: '胆俞'}
      {x: 334, y: 389, text: '脾俞'}
      {x: 334, y: 410, text: '胃俞'}
      {x: 334, y: 435, text: '三焦俞'}
      {x: 336, y: 470, text: '肾俞'}
      {x: 334, y: 500, text: '气海俞'}
      {x: 336, y: 531, text: '大肠俞'}

      {x: 336, y: 561, text: '关元俞'}
      {x: 336, y: 582, text: '小肠俞'}
      {x: 338, y: 604, text: '膀胱俞'}
      {x: 339, y: 622, text: '中膂俞'}
      {x: 341, y: 646, text: '白环俞'}
      # {x: , y: , text: ''}
      # {x: , y: , text: ''}
      # {x: , y: , text: ''}
      # {x: , y: , text: ''}
      {x: 314, y: 689, text: '会阳'}

      {x: 369, y: 646, text: '秩边'}
    ]

    <div className='svg-toucher'
      draggable
      onDragStart={@drag_start} 
      onMouseMove={@drag_move} 
      onMouseUp={@drag_end} 
      onWheel={@do_scale}

      onTouchStart={@drag_start}
      onTouchMove={@drag_move}
      onTouchEn={@drag_end}
    >
      <SVGToucher.PointsArea ref='area' template={@props.template} toucher={@} points={@points}/>
    </div>

  drag_start: (evt)->
    evt.preventDefault()

    @origin_x = @refs.area.state.x
    @origin_y = @refs.area.state.y
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


      @refs.area.setState
        x: @origin_x + delta_x
        y: @origin_y + delta_y

  drag_end: (evt)->
    @on_drag = false #if @on_drag

  do_scale: (evt)->
    $toucher = jQuery ReactDOM.findDOMNode @
    offset = $toucher.offset()
    px = evt.pageX - offset.left
    py = evt.pageY - offset.top

    # console.log px, py, @refs.area.state.x, @refs.area.state.y
    cx = (px - @refs.area.state.x) / @refs.area.state.scale
    cy = (py - @refs.area.state.y) / @refs.area.state.scale

    @refs.area.compute_scale(evt.deltaY, cx, cy)
    # @refs.area.compute_scale(evt.deltaY, 0, 0)

  do_click_idx: (idx)->
    point = @points[idx]
    [x, y] = [point.x, point.y]
    [area_x, area_y] = [@refs.area.state.x, @refs.area.state.y]
    area_scale = @refs.area.state.scale
    
    posx = area_x + x * area_scale
    posy = area_y + y * area_scale

    @props.page.show_box(point, posx, posy)

  statics:
    PointsArea: React.createClass
      getInitialState: ->
        origin_width: 595
        origin_height: 841
        x: 0
        y: 0
        scale: 1.0

      render: ->
        width = @state.origin_width * @state.scale
        height = @state.origin_height * @state.scale

        style =
          'width': "#{width}px"
          'height': "#{height}px"
          'left': "#{@state.x}px"
          'top': "#{@state.y}px"

        <div className='points-area' style={style}>
          <SVGToucher.SVG name={@props.template} width={@state.origin_width} height={@state.origin_height} scale={@state.scale} />
          {
            for pdata, idx in @props.points
              <SVGToucher.Point key={idx} idx={idx} data={pdata} scale={@state.scale} toucher={@props.toucher} />
          }
        </div>

      componentDidMount: ->
        @aim_to_center()

      aim_to_center: ->
        $toucher = jQuery ReactDOM.findDOMNode @props.toucher
        tw = $toucher.width()
        th = $toucher.height()

        @setState
          x: (tw - @state.origin_width) / 2
          y: (th - @state.origin_height) / 2

      compute_scale: (dir, center_x, center_y)->
        i = 1.1

        if dir > 0
          # 缩小
          old_scale = @state.scale
          new_scale = @state.scale / i

          @setState 
            scale: new_scale
            x: @state.x - center_x * (new_scale - old_scale)
            y: @state.y - center_y * (new_scale - old_scale)

        if dir < 0
          # 放大
          old_scale = @state.scale
          new_scale = @state.scale * i

          @setState 
            scale: new_scale
            x: @state.x - center_x * (new_scale - old_scale)
            y: @state.y - center_y * (new_scale - old_scale)

    SVG: React.createClass
      render: ->
        src = "../svg/#{@props.name}.svg"
        style = 
          'transform': "scale(#{@props.scale})"
          'transformOrigin': '0 0'
        <img src={src} width={@props.width} height={@props.height} style={style} />

    Point: React.createClass
      render: ->
        left = @props.data.x * @props.scale
        top = @props.data.y * @props.scale
        style = 
          # 'transform': "translate(#{left}px, #{top}px)"
          'left': "#{left}px"
          'top': "#{top}px"
        <div className='point' style={style}>
          <div className='circle' onClick={@click} onTouchStart={@click}></div>
          <div className='text'>{@props.data.text}</div>
        </div>

      click: (evt)->
        @props.toucher.do_click_idx @props.idx


@DiagnosisPage = React.createClass
  render: ->
    <div className='diagnosis-page'>
      <h2 className='ui header topbar'>
        <TopbarBack href='zd-patient-info.html' />
        <span>中医体检</span>
        <div className='buttons'>
          <a className='ui button brown small' href='zd-zhenduan-result.html'>
            <i className='icon checkmark' />
            <span>保存体检记录</span>
          </a>
        </div>
      </h2>
      <DiagnosisPage.Paper page={@}/>
      <DiagnosisPage.Sidebar ref='sidebar'/>
      <DiagnosisPage.Popbox page={@} ref='popbox'/>
    </div>

  show_box: (point, x, y)->
    @refs.popbox.show(point, x, y)

  statics:
    Sidebar: React.createClass
      getInitialState: ->
        records: []
      render: ->
        <div className='page-sidebar'>
          <DiagnosisPage.Logo />
          <div className='records'>
            <h3 className='ui header'>记录</h3>
          {
            for record, idx in @state.records
              <div key={idx} className='record'>
                <span className='key'>{record.key}</span>
                <span className='value'>{record.value}</span>
              </div>
          }
          </div>
          <div className='records'>
            <h3 className='ui header'>拍照</h3>
            <a href='javascript:;' className='ui button brown take-photo labeled icon'>
              <i className='icon photo' />
              <span>点击拍照</span>
            </a>
          </div>
          <div className='records'>
            <h3 className='ui header'>综合结论</h3>
            <a href='javascript:;' className='ui button brown take-photo labeled icon'>
              <i className='icon pencil' />
              <span>输入综合结论</span>
            </a>
          </div>
        </div>

      record: (key, value)->
        records = @state.records
        records.push {
          key: key
          value: value
        }
        @setState records: records


    Logo: React.createClass
      render: ->
        <div className='title-logo'>
          <div className='yw' />
          <div className='img' />
          <div className='yz' />
        </div>

    Paper: React.createClass
      render: ->
        <div className='page-paper'>
          <SVGToucher template='back' page={@props.page} />
        </div>

    Popbox: React.createClass
      getInitialState: ->
        x: 0
        y: 0
        show: false
        point: null
        selected_values: {}
      render: ->
        style = 
          left: @state.x
          top: @state.y
          display: if @state.show then 'block' else 'none'

        <div className='popbox' style={style}>
          {# <h3 className='ui header'>记录检查项</h3>}
          <div className='name'>
            <span>{@state.point?.text}</span>
            <a href='javascript:;' className='ui icon button circular brown small'>
              <i className='icon pencil' />
            </a>
          </div>
          <div className='values'>
          {
            values = ['阴', '阳', '虚', '实', '表', '里', '寒', '热']
            for value, idx in values
              klass = new ClassName {
                value: true
                active: @state.selected_values[value] is true
              }

              <div key={idx} className={klass} onClick={@click_value}>{value}</div>
          }
          </div>
          <a className='ui button self brown'>输入自定义内容</a>
          <a className='ui button self' onClick={@close}>关闭</a>
          {
            klass = new ClassName {
              'ui button self brown': true
              'disabled': Object.keys(@state.selected_values).length == 0
            }
            <a className={klass} onClick={@submit}>确定</a>
          }
        </div>

      show: (point, x, y)->
        console.log point, x, y
        @setState
          x: x
          y: y
          show: true
          point: point
          selected_values: {}

      close: ->
        @setState
          show: false

      click_value: (evt)->
        value = jQuery(evt.target).text()
        selected_values = @state.selected_values
        if not selected_values[value]
          selected_values[value] = true
        else
          delete selected_values[value]

        @setState selected_values: selected_values

      submit: ->
        values = Object.keys(@state.selected_values)
        key = @state.point.text
        value = values.join('')
        @props.page.refs.sidebar.record key, value
        @close()
