@KeyValueTable = React.createClass
  render: ->
    dataSource = @props.dataSource
    rows = @props.rows

    <div className='key-value-table'>
      {
        if @props.title?
          <div className='table-title'>{@props.title}</div>
      }
      <div className='rows'>
      {
        rows.map (row, idx)->
          <KVRow key={row.key || idx} row={row} dataSource={dataSource} />
      }
      </div>
      {
        if @props.footer?
          <div className='table-footer'>{@props.footer}</div>
      }
    </div>

KVRow = React.createClass
  render: ->
    row = @props.row
    text = @props.dataSource[row.dataIndex]

    <div className='row'>
      <div className='title'>{row.title}</div>
      <div className='text'>{text}</div>
    </div>

# -------------

@PatientBaseInfo = React.createClass
  render: ->
    data_source = @props.patient

    rows = [
      {title: '姓名', dataIndex: 'name', key: 'name'}
      {title: '性别', dataIndex: 'gender_str', key: 'gender_str'}
      {title: '年龄', dataIndex: 'age', key: 'age'}
      {title: '身份证号', dataIndex: 'id_card', key: 'id_card'}
      {title: '手机号', dataIndex: 'mobile_phone', key: 'mobile_phone'}
      {title: '症状描述', dataIndex: 'symptom_desc', key: 'symptom_desc'}
      {title: '个人病史', dataIndex: 'personal_pathography', key: 'personal_pathography'}
      {title: '家族病史', dataIndex: 'family_pathography', key: 'family_pathography'}
    ]

    <KeyValueTable dataSource={data_source} rows={rows} title='患者基本信息' />