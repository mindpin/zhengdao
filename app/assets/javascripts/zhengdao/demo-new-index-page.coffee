@DemoNewIndexPage = React.createClass
  getInitialState: ->
    period: 0
  render: ->
    <div className='demo-new-index-page-component'>
      <a className='ui button mini' href='javascript:;' onClick={@show(1)}>过程一</a>
      <a className='ui button mini' href='javascript:;' onClick={@show(2)}>过程二</a>
      <a className='ui button mini' href='javascript:;' onClick={@show(3)}>过程三</a>
      <a className='ui button mini' href='javascript:;' onClick={@show(4)}>过程四</a>
      <a className='ui button mini' href='javascript:;' onClick={@show(5)}>过程五</a>
      <a className='ui button mini' href='javascript:;' onClick={@show(6)}>过程六</a>
      <a className='ui button mini' href='javascript:;' onClick={@show(7)}>过程七</a>
      {
        if @state.period is 1
          <div className='desc'>
            患者可以通过微信或网站的形式访问平台，进行线上预约；<br/>
            或者通过电话预约，或直接到访现场进行挂号；
          </div>
        else if @state.period is 2
          <div className='desc'>
            第一次到访的患者会在平台完成信息补录，每一个患者的信息都会进入统一管理的患者信息库；<br/>
            所有患者的数据在中医平台下所有店面将实现数据同步；
          </div>
        else if @state.period is 3
          <div className='desc'>
            导诊根据排班情况将患者分派给医师，医师将对患者进行初步诊断；<br/>
            并根据患者的具体情况，安排患者进行对应专项体检；
          </div>
        else if @state.period is 4
          <div className='desc'>
            体检师对患者进行专项体检，并通过标准化的系统完成对体检结果的记录；<br/>
            体检结论供医师参考，对患者做出进一步的诊断；形成治疗方案；
          </div>
        else if @state.period is 5
          <div className='desc'>
            患者根据治疗方案，在治疗师的帮助下接受多种形式的治疗；<br/>
            每一次治疗实施后，患者都将根据自身情况作出主观反馈，或者通过再次进行体检来跟踪病情变化；<br/>
            所有的反馈与变化情况都将被记录在平台中；
          </div>
        else if @state.period is 6
          <div className='desc'>
            患者通过多种形式进行费用结算缴纳；<br/>
            预充值用户将能够享有更便捷的支付方式，以及在诊疗项目上更优惠的折扣；
          </div>
        else if @state.period is 7
          <div className='desc'>
            所有患者在业务系统内完成的诊断，体检，治疗过程产生的治疗方案，体检记录，治疗反馈，都将以规范的形式被汇入中医平台知识库；<br/>
            从而对将来的诊疗案例分析提供参考，对患者健康状况的跟踪提供依据；<br/>
            以及作为将来更大众化的互联网诊疗应用的数据支持；
          </div>
      }
    </div>

  componentDidMount: ->
    jQuery('.svg-source svg title').remove()

  show: (num)-> 
    =>
      @setState period: num
      jQuery('.svg-source')
        .removeClass('p1 p2 p3 p4 p5 p6 p7')
        .addClass("p#{num}")