@PeRecordsNewPage = React.createClass
  render: ->
    <div className='pe-records-page'>
      <PeRecorder data={@props.data.pe} ref="pe_recorder" />

      <div className='page-save'>
        <a className='ui button green mini' href='javascript:;' onClick={@on_click}>
          <i className='icon check' /> 保存
        </a>
      </div>
    </div>

  on_click: ->
    console.log @refs.pe_recorder.get_values()
