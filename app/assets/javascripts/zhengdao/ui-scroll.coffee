@HorizontalChineseScroll = React.createClass
  render: ->
    <div className='horizontal-chinese-scroll'>
      <div className='handle begin'>
        <div className='handle-border top'></div>
        <div className='handle-border bottom'></div>
      </div>
      <div className='scroll-inner'>
        <div className='scroll-border top'></div>
        <div className='content-inner'>
        {@props.children}
        </div>
        <div className='scroll-border bottom'></div>
      </div>
      <div className='handle end'>
        <div className='handle-border top'></div>
        <div className='handle-border bottom'></div>
      </div>
    </div>