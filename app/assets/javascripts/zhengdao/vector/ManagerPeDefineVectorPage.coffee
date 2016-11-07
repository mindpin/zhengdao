@ManagerPeDefineVectorPage = React.createClass
  render: ->
    svg_data = @props.data?.pe_define?.svg_data

    Paper = window.VectorSVGPaper

    <div className='pe-define-vector-editor'>
      <Toolbar {...@props} load_svg={@load_svg}/>
      <Paper ref='paper' svg_data={svg_data} />
    </div>

  load_svg: (svg_data)->
    @refs.paper.load_svg(svg_data)

Toolbar = React.createClass
  render: ->
    <div className='toolbar'>
      <Upload {...@props} />
    </div>


Upload = React.createClass
  getInitialState: ->
    status: UploadStatus.READY
    percent: 0
    photo:
      file_entity_id:  null
      file_entity_url: null
      download_url:    null

  render: ->
    { Button, Icon} = antd

    <div style={marginTop: 9, width: 200}>
      <UploadWidget.BrowseButton ref='browse_btn' status={@state.status}>
        <a href='javascript:;' className='ant-btn ant-btn-primary'>
          <Icon type='upload' /> 上传矢量图
        </a>
      </UploadWidget.BrowseButton>
      <UploadProgress {...@state} />
    </div>

  componentDidMount: ->
    new QiniuFilePartUploader
      debug:                false
      browse_button:        jQuery ReactDOM.findDOMNode @refs.browse_btn
      dragdrop_area:        null
      file_progress_class:  UploadUtils.GenerateOneFileUploadProgress(@)
      max_file_size:        '10MB'
      mime_types :          [{ title: 'photo', extensions: '*' }]

  on_upload_event: (evt, params...)->
    switch evt
      when 'local_done'
        data = params[0]
        @save_svg data

  save_svg: (svg_data)->
    # 保存 svg 图片文件信息
    jQuery.ajax
      url: @props.data.save_svg_url
      type: 'PUT'
      data:
        svg_data: svg_data
    .done (res)=>
      @props.load_svg svg_data


UploadProgress = React.createClass
  render: ->
    { Progress } = antd

    if @props.status != UploadStatus.READY
      bar_style =
        width: "#{@props.percent}%"

      switch @props.status
        when UploadStatus.LOCAL_DONE
          <div />
        else
          <Progress percent={@props.percent} />
    else
      <div />