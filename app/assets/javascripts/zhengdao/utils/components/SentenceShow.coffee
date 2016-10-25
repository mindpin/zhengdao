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