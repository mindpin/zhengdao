ModelForm = React.createClass
  mixins: [CRUDMixin]

  getInitialState: ->
    photos: @props.data[@props.model].photos

  render: ->
    { Form, Input, Button, Icon, Select } = antd
    FormItem  = Form.Item
    { getFieldDecorator } = @props.form

    iprops = {
      labelCol: { span: 3 }
      wrapperCol: { span: 16 }
    }

    model = @props.data[@props.model]

    <div style={@form_style()}>
      <Form onSubmit={@submit}>
        {
          model?.sentences.map (s, idx)->
            <FormItem key={s.id} {...iprops} label='记录'>
              <div style={lineHeight: '1.5', padding: '7px 0'}>
                <SentenceShow sentence={s} />
              </div>
            </FormItem>
        }

        <FormItem {...iprops} label='操作'>
          <BTNS {...@props} model={model} add_photo={@add_photo} photos={@state.photos} />
        </FormItem>
      </Form>
    </div>

  add_photo: (data)->
    photos = @state.photos
    photos.push data
    @setState photos: photos

    jQuery.ajax
      type: 'PUT'
      url: @props.data[@props.model].update_photos_url
      data:
        photos_data_json: JSON.stringify photos
    .done (res)->
      console.log res



BTNS = React.createClass
  getInitialState: ->
    # if @props.download_url
    #   status: UploadStatus.LOCAL_DONE
    #   percent: 0
    #   file_entity_id: @props.file_entity_id
    #   download_url: @props.download_url
    # else

    status: UploadStatus.READY
    percent: 0
    photo:
      file_entity_id:  null
      file_entity_url: null
      download_url:    null

  render: ->
    { Icon } = antd

    b1 = 
      className: 'ant-btn ant-btn-primary ant-btn-lg'
      style:
        marginRight: 8
      href: @props.model.new_sentence_url

    b3 =
      className: 'ant-btn ant-btn-lg'
      style:
        marginRight: 8
      href: @props.data.cancel_url

    <div>
      <div style={overflow: 'hidden'}>
        {
          @props.photos.map (photo, idx)->
            url = "url(#{photo.file_entity_url}?imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100)"

            <a key={idx} className='photo-preview'
              href={photo.file_entity_url}
              target='_blank'
              style={backgroundImage: url}
            />
        }
        <UploadProgress {...@state} />
      </div>
      <a {...b1}><Icon type='plus' /> 增加一条记录</a>
      <div style={display: 'inline-block', marginRight: 8}>
        <UploadWidget.BrowseButton ref='browse_btn' status={@state.status}>
          <a href='javascript:;' className='ant-btn ant-btn-primary ant-btn-lg'>
            <Icon type='photo' /> 上传照片
          </a>
        </UploadWidget.BrowseButton>
      </div>
      <a {...b3}>返回</a>
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
        @setState photo: data
        @props.add_photo data


UploadProgress = React.createClass
  render: ->
    if @props.status != UploadStatus.READY
      bar_style =
        width: "#{@props.percent}%"

      switch @props.status
        when UploadStatus.LOCAL_DONE
          <div />
        else
          <div className='photo-preview'>
            <div className='bar' style={bar_style}></div>
            <div className='percent'>{@props.percent}%</div>
          </div>
    else
      <div />


@PeRecordFormPage = antd.Form.create()(
  React.createClass
    render: ->
      <div className='pe-records-page'>
        <ModelForm {...@props} method='PUT' model='pe_record' />
      </div>
)
