@PeRecordsNewPage = React.createClass
  render: ->
    <div className='ui segment form data-form'>
      <PeRecorder data={@props.data.pe} ref="pe_recorder" />

      <a className='ui button green' href='javascript:;' onClick={@on_click}>
        <i className='icon check' />
        提交
      </a>
    </div>

  on_click: ->
    console.log @refs.pe_recorder.get_values()
