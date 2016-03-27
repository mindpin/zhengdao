@GHSelectPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='index.html' />
          <span>导诊</span>
        </h2>

        <div className='select'>
          <div className="ui cards three">
            <a className="card" href='guide-guahao.html'>
              <div className="content">
                <div className='yunwen' />
                <div className="ui header"><span>现场挂号</span></div>
              </div>
            </a>
            <a className="card" href='guide-quhao.html'>
              <div className="content">
                <div className='yunwen' />
                <div className="ui header"><span>预约取号</span></div>
              </div>
            </a>
            <a className="card" href='guide-zhiliao.html'>
              <div className="content">
                <div className='yunwen' />
                <div className="ui header"><span>治疗预约</span></div>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>

@GHXCPage = React.createClass
  getInitialState: ->
    active: 0
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='guide.html' />
          <span>现场挂号</span>
        </h2>

        <div className='info-input-form'>
          {
            klass0 = new ClassName
              'item': true
              'active': @state.active == 0
            klass1 = new ClassName
              'item': true
              'active': @state.active == 1

            <div className="ui two item menu">
              <a className={klass0} onClick={@select0}>新患者</a>
              <a className={klass1} onClick={@select1}>已注册患者</a>
            </div>
          }
          {
            if @state.active == 0
              inputs = [
                '　就诊人', '身份证号', '　手机号', '诊疗卡号', 
                '症状描述', '个人病史', '家庭病史'
              ]
              <FormPanel title='输入患者信息' button='进入预约' inputs={inputs} to='guide-doctor-select.html'/>
            
            else if @state.active == 1
              inputs = [
                '手机号'
              ]
              <FormPanel title='读取患者信息' button='进入预约' inputs={inputs} to='guide-doctor-select.html'>
              <div className='ui segment basic'>
                <div className='ui form'>
                  <div className='grouped fields'>
                    <div className='field'>
                      <div className="ui radio checkbox">
                        <input type="radio" name="radio" />
                        <label>王大锤 - 男 - 33 岁</label>
                      </div>
                    </div>
                    <div className='field'>
                      <div className="ui radio checkbox">
                        <input type="radio" name="radio" />
                        <label>王小锤 - 男 - 3 岁</label>
                      </div>
                    </div>
                    <div className='field'>
                      <div className="ui radio checkbox">
                        <input type="radio" name="radio" />
                        <label>孔连顺 - 女 - 24 岁</label>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              </FormPanel>
          }
        </div>
      </div>
    </div>

  select0: ->
    @setState active: 0
  select1: ->
    @setState active: 1

@GHYYPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='guide.html' />
          <span>预约取号</span>
        </h2>

        <div className='info-input-form'>
          {
            inputs = [
              '　预约号', '　手机号', '诊疗卡号'
            ]
            <FormPanel title='查询预约信息' button='查看信息' inputs={inputs} to='guide-quhao-confirm.html'/>
          }
        </div>
      </div>
    </div>


FormPanel = React.createClass
  render: ->
    <div className='panel'>
      <h3 className='ui header'>{@props.title}</h3>
      {
        for input, idx in @props.inputs
          <div key={idx} className='ui labeled input fluid'>
            <div className='ui label'>{input}</div>
            <input type="text" />
          </div>
      }
      {@props.children}
      <a className='ui right labeled icon button brown enter-yy' href={@props.to}>
        <i className='icon arrow right' />
        <span>{@props.button}</span>
      </a>
    </div>

@GHYYConfirmPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='guide-quhao.html' />
          <span>预约取号</span>
        </h2>

        <ConfirmYYInfoPanel />
      </div>
    </div>

ConfirmYYInfoPanel = React.createClass
  render: ->
    data = [
      ['　就诊人', '王大锤']
      ['预约医师', '叶建华（主任医师 - 体检科）']
      ['就诊时间', '2015-12-08（星期二）上午']
      ['门诊类型', '专家门诊']
    ]

    <div className='info-input-form yy-info'>
      <h3 className='ui header'>预约信息确认</h3>
      <div className="ui divided list">
        {
          for item, idx in data
            <div className='item' key={idx}>
              <div className="ui horizontal label">{item[0]}</div>
              <span>{item[1]}</span>
            </div>
        }
      </div>
      <a className='ui right labeled icon button brown enter-yy' href='guide-quhao-result.html'>
        <i className='icon arrow right' />
        <span>确认挂号</span>
      </a>
    </div>

ConfirmZhiliaoYYInfoPanel = React.createClass
  render: ->
    data = [
      ['　就诊人', '王大锤']
      ['预约诊室', '107']
      ['治疗时间', '2016-01-07 16:00-18:00']
      ['治疗项目', '针刺, 艾灸']
    ]

    <div className='info-input-form yy-info'>
      <h3 className='ui header'>预约信息确认</h3>
      <div className="ui divided list">
        {
          for item, idx in data
            <div className='item' key={idx}>
              <div className="ui horizontal label">{item[0]}</div>
              <span>{item[1]}</span>
            </div>
        }
      </div>
      <a className='ui right labeled icon button brown enter-yy' href='guide-quhao-result.html'>
        <i className='icon arrow right' />
        <span>确认挂号</span>
      </a>
    </div>

@GHYYResultPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <div className='info-input-form result'>
          <h3 className='ui header'>挂号成功</h3>
          <p style={'text-align': 'center'}>就诊号：<strong>105</strong></p>
          <a className='ui right labeled icon button brown enter-yy' href='javascript:;'>
            <i className='icon print' />
            <span>打印挂号单</span>
          </a>
          <a className='ui right labeled icon button enter-yy exit' href='guide.html'>
            <i className='icon arrow left' />
            <span>退出</span>
          </a>
        </div>
      </div>
    </div>

@GHDoctorSelectPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <PADLeftPanel>
          <h2 className='ui header topbar'>
            <TopbarBack href='guide-guahao.html' />
            医师
          </h2>
          {
            data = [
              ['李海峰', '医师']
              ['廖国林', '医师']
              ['周小娟', '医师']
              ['杨晓勇', '医师']
              ['朱杰辉', '医师']
              ['叶建华', '医师']
              ['游琼', '医师']
              ['周丽琴', '医师']
            ]
            <PADPanelList data={data} item_component=DoctorInfoItem />
          }
        </PADLeftPanel>
        <PADRightPanel>
          <h2 className='ui header topbar'>排班表</h2>
          {
            data = [
              ['2015-12-08', '星期二', '上午', 0]
              ['2015-12-08', '星期二', '下午', 6]
              ['2015-12-09', '星期三', '上午', 10]
              ['2015-12-09', '星期三', '下午', 13]
            ]
            <PADPanelList data={data} item_component=ArrangeInfoItem />
          }
        </PADRightPanel>
      </div>
    </div>

PADLeftPanel = React.createClass
  render: ->
    <div className='pad-left-panel'>
    {@props.children}
    </div>

PADRightPanel = React.createClass
  render: ->
    <div className='pad-right-panel'>
    {@props.children}
    </div>

PADPanelList = React.createClass
  render: ->
    <div className='pad-panel-list'>
    {
      for item, idx in @props.data
        React.createElement @props.item_component,
          'key': idx
          'data': item
    }
    </div>
RoomInfoItem = React.createClass
  render: ->
    data = @props.data

    <a className='item' href='javascript:;'>
      <span className='ui label'>{data[0]}</span>
      <span> - </span>
      <span>{data[1]}</span>
      <span> - </span>
      <span>{data[2]}</span>
      <span className='tail'>
        <i className='icon chevron right' />
      </span>
    </a>

DoctorInfoItem = React.createClass
  render: ->
    data = @props.data

    <a className='item' href='javascript:;'>
      <strong>{data[0]}</strong>
      <span> - </span>
      <span className='ui label small'>{data[1]}</span>
      <span className='tail'>
        <i className='icon chevron right' />
      </span>
    </a>

RoomArrangeInfoItem = React.createClass
  render: ->
    data = @props.data

    klass = new ClassName
      'item': true
      'disabled': data[2] == 0
      'full': data[2] == 0

    <a className={klass} href='guide-period-select.html'>
      <span>{data[0]}</span>
      <span> - </span>
      <span>{data[1]}</span>
      <span className='tail'>
        {
          if data[2] == 0
            <span>已约满</span>
          else
            <span>剩余时段：{data[2]}</span>
        }
        <i className='icon chevron right' />
      </span>
    </a>

ArrangeInfoItem = React.createClass
  render: ->
    data = @props.data

    klass = new ClassName
      'item': true
      'disabled': data[3] == 0
      'full': data[3] == 0

    <a className={klass} href='guide-doctor-selected.html'>
      <span>{data[0]}</span>
      <span> - </span>
      <span>{data[1]}</span>
      <span> - </span>
      <span>{data[2]}</span>
      <span className='tail'>
        {
          if data[3] == 0
            <span>已约满</span>
          else
            <span>剩余号：{data[3]}</span>
        }
        <i className='icon chevron right' />
      </span>
    </a>

PatientInfoItem = React.createClass
  render: ->
    data = @props.data

    <a className='item' href='javascript:;'>
      <span className='ui label'>{data[0]}</span>
      <span> - </span>
      <span>{data[1]}</span>
      <span> - </span>
      <span>{data[2]}</span>
      <span className='tail'>
        <i className='icon chevron right' />
      </span>
    </a>


@GHDoctorSelectedPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='guide-quhao.html' />
          <span>预约取号</span>
        </h2>

        <ConfirmYYInfoPanel />
      </div>
    </div>

@GHZhiliaoSelectedPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='guide-quhao.html' />
          <span>治疗预约</span>
        </h2>

        <ConfirmZhiliaoYYInfoPanel />
      </div>
    </div>

@GHZhiliao = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='guide.html' />
          <span>治疗预约</span>
        </h2>

        <div className='info-input-form'>
          {
            inputs = [
              '手机号'
            ]
            <FormPanel title='读取患者信息' button='进入房间选择' inputs={inputs} to='guide-zhiliao-choose-room.html'>
            <div className='ui segment basic'>
              <div className='ui form'>
                <div className='grouped fields'>
                  <div className='field'>
                    <div className="ui radio checkbox">
                      <input type="radio" name="radio" />
                      <label>
                        <div>王大锤 - 男 - 33 岁</div>
                        <div style={'marginTop': '10px'}>
                          <span>治疗项：</span>
                          <span className='ui label small'>针刺</span>
                          <span className='ui label small'>艾灸</span>
                        </div>
                      </label>
                    </div>
                  </div>
                  <div className='field' style={'marginTop': '20px'}>
                    <div className="ui radio checkbox">
                      <input type="radio" name="radio" />
                      <label>
                        <div>孔连顺 - 女 - 24 岁</div>
                        <div style={'marginTop': '10px'}>
                          <span>治疗项：</span>
                          <span className='ui label small'>拔罐</span>
                        </div>
                      </label>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            </FormPanel>
          }
        </div>
      </div>
    </div>

@GHZhiliaoChooseRoom = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <PADLeftPanel>
          <h2 className='ui header topbar'>
            <TopbarBack href='guide-zhiliao.html' />
            房间
          </h2>
          {
            data = [
              ['101', '单人', '东向']
              ['102', '单人', '南向']
              ['103', '双人', '东向']
              ['104', '双人', '南向']
              ['105', '双人', '北向']
              ['106', '三人', '东向']
              ['107', '三人', '南向']
              ['108', '三人', '北向']
            ]
            <PADPanelList data={data} item_component=RoomInfoItem />
          }
        </PADLeftPanel>
        <PADRightPanel>
          <h2 className='ui header topbar'>日期时段</h2>
          {
            data = [
              ['2016-01-04', '星期一', 0]
              ['2016-01-05', '星期二', 4]
              ['2016-01-06', '星期三', 6]
              ['2016-01-07', '星期四', 7]
            ]
            <PADPanelList data={data} item_component=RoomArrangeInfoItem />
          }
        </PADRightPanel>
      </div>
    </div>

@GHPeriodSelectPage = React.createClass
  render: ->
    data = [
      ['08:00 - 10:00', true]
      ['10:00 - 12:00', false]
      ['12:00 - 14:00', false]
      ['14:00 - 16:00', true]
      ['16:00 - 18:00', true]
      ['18:00 - 20:00', false]
      ['20:00 - 22:00', true]
    ]

    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='guide-zhiliao-choose-room.html' />
          <span>选择床位时段</span>
        </h2>

        <div className='info-input-form'>
          <h3 className='ui header'>107 房 2016-01-07</h3>
          <h3 className='ui header'>请从下列时段选择</h3>
          <div className='ui divided list'>
          {
            for item, idx in data
              full = item[1] == false

              klass = new ClassName
                'item': true
                'period': true
                'full': full

              <div key={idx} className={klass}>
                <span className='plabel' style={'lineHeight':'30px'}>
                  <i className='icon clock' />
                  {item[0]}
                </span>
                <div className='right floated'>
                  {
                    if full
                      <span style={'lineHeight':'30px'}>此时段已排满</span>
                    else
                      <a className='ui button brown tiny' href='guide-zhiliao-selected.html'>选定</a>
                  }
                </div>
              </div>
          }
          </div>
        </div>
      </div>
    </div>