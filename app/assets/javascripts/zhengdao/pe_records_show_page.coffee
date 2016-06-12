@PeRecordsShowPage = React.createClass
  render: ->
    <div className='pe-records-page'>
      <div className='ui message warning'>{@props.data.pe_name}项目记录</div>

      <PeRecorderShow data={@props.data} ref="pe_recorder" />

      <div className='page-save'>
        <a className='ui button mini' href={@props.data.cancel_url}>
          <i className='icon back reply' /> 返回
        </a>
      </div>
    </div>