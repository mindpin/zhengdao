@SentenceShow = React.createClass
  render: ->
    sentence = @props.sentence

    <div className='sentence'>
    {
      sentence.data.map (x, idx)->
        if x.values?
          <span key={idx}>
            <span style={color: '#aaa'}>{x.fact}: </span>
            <span>{x.values.join(', ')}</span>
            <span>; </span>
          </span>
        else if x.custom
          <span key={idx}>
            {x.custom};
          </span>
    }
    {
      if sentence.data.length == 0
        <span style={color: '#aaa'}>没有记录内容</span>
    }
    </div>

@PeRecordPhotosShow = React.createClass
  render: ->
    if @props.photos.length
      <div style={overflow: 'hidden'} className='record-photos'>
      {
        @props.photos.map (photo, idx)->
          url = "url(#{photo.file_entity_url}?imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100)"

          <a key={idx} className='photo-preview'
            href={photo.file_entity_url}
            target='_blank'
            style={backgroundImage: url}
          />
      }
      </div>

    else
      <div />