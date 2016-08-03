@PeRecordsFormPage = React.createClass
  getInitialState: ->
    arr_records = []
    for idx, r of @props.data.records
      record = (r1 for idx1, r1 of r)
      arr_records.push record

    console.log arr_records

    saving: false
    saved_records: arr_records

  render: ->
    <div className='pe-records-page'>
      <div className='ui message warning'>正在录入{@props.data.pe_name}项目</div>

      <FactTagQuickRecorder 
        object={@props.data.fact_object}
        saved_records={@state.saved_records}
        ref='recorder'
      />

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
    saved_records = @refs.recorder.get_records()

    console.log saved_records

    @setState saving: true
    jQuery.ajax
      url: @props.data.submit_url
      type: 'PUT'
      data:
        saved_records: saved_records
    .done (res)=>
      @setState saving: false
      location.href = @props.data.cancel_url