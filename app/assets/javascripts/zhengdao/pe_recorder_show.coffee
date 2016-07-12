@PeRecorderShow = React.createClass
  render: ->
    console.log @props.data.records

    <div className='pe-recorder pe-recorder-show'>
      <div className='items'>
      {
        for key, record of @props.data.records
          rs = (v for k, v of record)

          tags = rs.map (x)->
            name: x.name
            className: if x.type == 'tag' then 'tag-value' else null

          <TagsBar key={key} tags={tags} />
      }
      </div>
    </div>

  statics:
    PeItemShow: React.createClass
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
          <div className='item-name'>
            <i className='icon asterisk' style={color: '#796138'} /> {label}
          </div>

          <div className='tags'>
          {
            if saved_values.length
              for tag, idx in saved_values
                <div className='tag' key={idx}>{tag}</div>
            else
              <div className='tag no'>没有记录内容</div>
          }
          </div>
          {
            if @props.item.file_entity_id?
              <ImageShow 
                idx={@props.idx} 
                parent={@props.parent} 
                file_entity_id={@props.item.file_entity_id} 
                download_url={@props.item.file_url}
              />
          }
        </div>

      on_label_change: (evt)->
        @props.parent.record_label_change @props.idx, evt.target.value

ImageShow = React.createClass
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
    img_url = "#{@props.download_url}?imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100"

    <div className='upload-photo'>
      <a className='photo-preview' style={backgroundImage: "url(#{img_url})"} href={@props.download_url} target='_blank' />
    </div>