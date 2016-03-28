@DemoPatientGraphPage = React.createClass
  render: ->
    { 
      Patient 
      Yuyue
      Guahao
      Dangan
      Zhenduan
      Zhiliao
      Jiankang
    } = DemoPatientGraphPage

    <div className='ui container patient-graph-page'>
      <Patient />
      <Yuyue />
      <Guahao />
      <Dangan />
      <Zhenduan />
      <Zhiliao />
      <Jiankang />
    </div>

  statics:
    Patient: React.createClass
      render: ->
        <div>
          <div className='patient'>患者</div>
          <div className='patient-line' />
        </div>

    Yuyue: React.createClass
      render: ->
        <div>
          <div className='yuyue'>预约</div>
          <div className='yuyue-line' />
          <div className='weixin'>微信</div>
          <div className='wangzhan'>网站</div>
          <div className='weixin-line' />
          <div className='wangzhan-line' />
          <div className='wangzhan-line1' />
        </div>

    Guahao: React.createClass
      render: ->
        <div>
          <div className='guahao'>挂号/取号</div>
          <div className='guahao-line' />
        </div>

    Dangan: React.createClass
      render: ->
        <div>
          <div className='dangan'>建立患者档案</div>
          <div className='dangan-line' />

          <div className='dangan-jiben j0'>基本信息</div>
          <div className='dangan-jiben j1'>健康状况</div>
          <div className='dangan-jiben j2'>体检记录</div>
          <div className='dangan-jiben j3'>治疗记录</div>

          <a className='dangan-img' href='doctor-patient-info.html' target='_blank'/>
        </div>

    Zhenduan: React.createClass
      render: ->
        <div>
          <div className='zhenduan'>综合诊断</div>
          <div className='zhenduan-line' />

          <div className='tijian-xitong'>体检记录系统</div>
          <a className='tijian-xitong-img' href='zd-diagnosis.html' target='_blank' />
        </div>

    Zhiliao: React.createClass
      render: ->
        <div>
          <div className='zhiliao'>治疗</div>
          <div className='zhiliao-line' />
        </div>

    Jiankang: React.createClass
      render: ->
        <div>
          <div className='jiankang'>长期健康跟踪</div>
          <div className='jiankang-line' />
        </div>