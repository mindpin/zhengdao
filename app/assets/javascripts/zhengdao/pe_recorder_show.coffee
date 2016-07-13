@PeRecorderShow = React.createClass
  render: ->
    console.log @props.data.records

    <div className='pe-recorder pe-recorder-show'>
      <SavedPeRecordShow saved_records={@props.data.records} />
    </div>

@SavedPeRecordShow = React.createClass
  render: ->
    records = @props.saved_records

    if records? and Object.keys(records).length
      <div className='saved_records' style={marginBottom: '1rem'}>
        {
          for key, record of records
            rs = (v for k, v of record)

            tags = rs.map (x)->
              name: x.name
              className: if x.type == 'tag' then 'tag-value' else null

            <TagsBar key={key} tags={tags} />
        }
      </div>
    else
      <div />


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