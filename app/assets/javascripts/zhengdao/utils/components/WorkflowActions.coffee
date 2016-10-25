@NoDeal = React.createClass
  render: ->
    { Alert } = antd

    data_source = {
      status: @props.text
    }

    rows = [
      {title: '状态', dataIndex: 'status', key: 'status'}
    ]

    <KeyValueTable dataSource={data_source} rows={rows} title='患者当前状态' />


@PEDeal = React.createClass
  render: ->
    { Table, Button, Icon } = antd

    patient_record = @props.patient_record

    data_source = @props.pe_records
    columns = [
      {title: '体检项名称', dataIndex: 'name', key: 'name'}
      {title: '记录内容', key: 'desc', render: (x)->
        <pre>{x.desc}</pre>
      }
      {title: '操作', key: 'ops', render: (x)->
        <TableEditButton href={x.edit_url} text='编辑记录' />
      }
    ]

    <div>
      <PageDesc text='为患者填写体检记录' />
      <Table
        columns={columns}
        dataSource={data_source}
        bordered
        size='mini'
        rowKey='id'
        pagination={false}
      />
      <div style={marginTop: '0.5rem'}>
        <Button type='primary' onClick={@continue}>
          <Icon type='check' /> 填写完毕
        </Button>
      </div>
    </div>

  continue: ->
    { Modal } = antd
    { confirm } = Modal

    patient_record = @props.patient_record

    confirm
      title: ''
      content: '确定结束体检记录吗？'
      onOk: ->
        jQuery.ajax
          type: 'PUT'
          url: patient_record.back_to_doctor_url
        .done (res)->
          window.location.reload()
