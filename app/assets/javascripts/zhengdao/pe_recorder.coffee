@PeRecorder = React.createClass
  getInitialState: ->
    records: @props.data.records

  render: ->
    <div className='pe-recorder'>
      <div className='items'>
      {
        for item, idx in @state.records
          <PeRecorder.PeItemInput 
            key={idx}
            idx={idx}
            item={item} 
            parent={@} 
          />
      }
      </div>
      <div className='add-item'>
        <a className='ui button green mini' href='javascript:;' onClick={@add_field}>
          <i className='icon add' /> 增加记录项
        </a>
      </div>
    </div>

  add_field: ->
    records = @state.records
    records.push
      label: ''
      option_values: []
      saved_values: []
      disabled: false
    @setState records: records

  add_record_value: (idx, value)->
    records = @state.records
    record = records[idx]
    record.saved_values ||= []
    record.saved_values.push value
    @setState records: records

  remove_record_value: (idx, removed_value)->
    records = @state.records
    record = records[idx]
    record.saved_values ||= []
    record.saved_values = record.saved_values.filter (value)->
      value != removed_value
    @setState records: records

  record_label_change: (idx, new_label)->
    records = @state.records
    record = records[idx]
    record.label = new_label
    @setState records: records

  record_file_entity_id_change: (idx, file_entity_id)->
    records = @state.records
    record = records[idx]
    record.file_entity_id = file_entity_id
    @setState records: records

  get_values: ->
    @state.records.map (x)->
      label: x.label
      saved_values: x.saved_values || []
      file_entity_id: x.file_entity_id

  statics:
    PeItemInput: React.createClass
      componentDidMount: ->
        jQuery(React.findDOMNode @)
          .find('.ui.dropdown').dropdown
            allowAdditions: true
            onAdd: (addedValue, addedText, $addedChoice)=>
              @props.parent.add_record_value @props.idx, addedValue

            onRemove: (removedValue, removedText, $removedChoice)=>
              @props.parent.remove_record_value @props.idx, removedValue
              
      render: ->
        item = @props.item
        label = item.label
        option_values = item.option_values || []
        saved_values = item.saved_values || []

        label_readonly = item.disabled != false
        label_klass = new ClassName
          'label': true
          'readonly': label_readonly

        label_props =
          type: 'text'
          value: label
          readOnly: label_readonly
          className: label_klass
          onChange: @on_label_change
          placeholder: '输入自定义记录项名'

        <div className='field'>
          <input {...label_props} />

          <div className="ui fluid selection search multiple dropdown">
            {
              <input type='hidden' value={saved_values.join(",")} />
            }

            <div className="default text">输入记录内容</div>
            <div className="menu">
            {
              for value, idx in option_values
                <div className="item" key={idx} data-value={value}>{value}</div>
            }
            </div>
          </div>

          <Upload 
            idx={@props.idx} 
            parent={@props.parent} 
            file_entity_id={@props.item.file_entity_id} 
            download_url={@props.item.file_url}
          />

        </div>

      on_label_change: (evt)->
        @props.parent.record_label_change @props.idx, evt.target.value

Upload = React.createClass
  getInitialState: ->
    if @props.download_url
      status: UploadStatus.LOCAL_DONE
      percent: 0
      file_entity_id: @props.file_entity_id
      download_url: @props.download_url
    else
      status: UploadStatus.READY
      percent: 0
      file_entity_id: null
      download_url: null

  render: ->
    <div className='upload-photo'>
      <UploadProgress {...@state} />

      <UploadWidget.BrowseButton ref='browse_btn' status={@state.status}>
        <a href='javascript:;' className='ui button mini'>
          <i className='icon photo' /> 拍照上传
        </a>
      </UploadWidget.BrowseButton>
    </div>

  componentDidMount: ->
    # $browse_button = jQuery React.findDOMNode @refs.browse_btn
    $browse_button = jQuery React.findDOMNode @refs.browse_btn
    new QiniuFilePartUploader
      debug:                true
      browse_button:        $browse_button
      dragdrop_area:        null
      file_progress_class:  UploadUtils.GenerateOneFileUploadProgress(@)
      max_file_size:        '10MB'
      mime_types :          [{ title: 'photo', extensions: '*' }]

  on_upload_event: (evt, params...)->
    switch evt
      when 'local_done'
        response_info = params[0]
        file_entity_id  = response_info.file_entity_id
        download_url    = response_info.download_url
        @setState
          download_url: download_url
          file_entity_id: file_entity_id

        @props.parent.record_file_entity_id_change @props.idx, file_entity_id

UploadProgress = React.createClass
  render: ->
    if @props.status != UploadStatus.READY
      bar_style =
        width: "#{@props.percent}%"

      switch @props.status
        when UploadStatus.LOCAL_DONE
          img_url = "#{@props.download_url}?imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100"

          <div className='photo-preview' style={backgroundImage: "url(#{img_url})"}>
            <div className='percent'><i className='icon check' /></div>
          </div>
        else
          <div className='photo-preview'>
            <div className='bar' style={bar_style}></div>
            <div className='percent'>{@props.percent}%</div>
          </div>
    else
      <div />