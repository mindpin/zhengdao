@PeRecordsFormPage = React.createClass
  getInitialState: ->
    saving: false

  render: ->
    <div className='pe-records-page'>
      <div className='ui message warning'>正在录入{@props.data.pe_name}项目</div>

      <PeRecorder data={@props.data} ref="pe_recorder" />

      <div className='page-save'>
        {
          if @state.saving
            <a className='ui button green mini loading' href='javascript:;'>
              <i className='icon check' /> 保存
            </a>
          else
            <a className='ui button green mini' href='javascript:;' onClick={@save}>
              <i className='icon check' /> 保存
            </a>
        }
        <a className='ui button mini' href={@props.data.cancel_url}>
          <i className='icon back reply' /> 返回
        </a>
      </div>
    </div>

  save: ->
    saved_records = @refs.pe_recorder.get_values()

    @setState saving: true
    jQuery.ajax
      url: @props.data.submit_url
      type: 'PUT'
      data:
        saved_records: saved_records
    .done (res)=>
      @setState saving: false