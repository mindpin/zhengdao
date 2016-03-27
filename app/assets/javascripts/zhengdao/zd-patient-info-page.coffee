@TopbarBack = React.createClass
  render: ->
    <a className='topbar-back' href={@props.href}>
      <i className='icon chevron left' />
    </a>

@ZDPatientInfoPage = React.createClass
  render: ->
    <div className='zd-patient-info-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='zd-patient-list.html' />
          <span>患者信息</span>
        </h2>

        <div className='table-div'>
        <table className='ui very basic celled table'>
          <tbody>
            <tr>
              <td className='label collapsing'>姓名：</td><td>王大锤</td>
              <td className='label collapsing'>性别：</td><td>男</td>
              <td className='label collapsing'>年龄：</td><td>33</td>
            </tr>
            <tr>
              <td className='label collapsing'>日期：</td><td>2015-12-08</td>
              <td className='label collapsing'>就诊号：</td><td>301</td>
              <td className='label collapsing'>诊疗卡：</td><td>1234567</td>
            </tr>
            <tr>
              <td className='label collapsing'>身高：</td><td>180 cm</td>
              <td className='label collapsing'>体重：</td><td>70 kg</td>
              <td className='label collapsing'>血压：</td><td>70/100 mmHg</td>
            </tr>
            <tr>
              <td className='label collapsing top aligned'>既往史：</td><td colSpan='5' className='desc'><span></span></td>
            </tr>
            <tr>
              <td className='label collapsing top aligned'>体质类型：</td><td colSpan='5' className='desc'><span></span></td>
            </tr>
          </tbody>
        </table>

        <div>
          <a className='ui labeled icon button back' href='zd-patient-list.html'>
            <i className='left arrow icon' />
            <span>返回患者队列</span>
          </a>
          <a className='ui right labeled icon button brown next' href='zd-diagnosis.html'>
            <i className='right arrow icon' />
            <span>进入体检系统</span>
          </a>
        </div>

        </div>
      </div>
    </div>

@ZDPatientResultPage = React.createClass
  render: ->
    <div className='zd-patient-info-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='zd-patient-list.html' />
          <span>患者信息</span>
        </h2>

        <div className='table-div'>
        <table className='ui very basic celled table'>
          <tbody>
            <tr>
              <td className='label collapsing'>姓名：</td><td>王大锤</td>
              <td className='label collapsing'>性别：</td><td>男</td>
              <td className='label collapsing'>年龄：</td><td>33</td>
            </tr>
            <tr>
              <td className='label collapsing'>日期：</td><td>2015-12-08</td>
              <td className='label collapsing'>就诊号：</td><td>301</td>
              <td className='label collapsing'>诊疗卡：</td><td>1234567</td>
            </tr>
          </tbody>
        </table>
        </div>

        <div className='table-div'>
          <div className='record'>
            <h3 className='ui header'>已检查项目：背诊</h3>
          </div>          
          <div>
            <a className='ui labeled icon button back' href='javascript:;'>
              <i className='icon file' />
              <span>查看体检记录</span>
            </a>
            <a className='ui right labeled icon button brown next' href='zd-diagnosis.html'>
              <i className='pencil icon' />
              <span>修改体检记录</span>
            </a>
          </div>
        </div>

        <div className='table-div'>
          <div className='record'>
            <h3 className='ui header'>已检查项目：舌诊</h3>
          </div>          
          <div>
            <a className='ui labeled icon button back' href='javascript:;'>
              <i className='icon file' />
              <span>查看体检记录</span>
            </a>
            <a className='ui right labeled icon button brown next' href='zd-diagnosis.html'>
              <i className='pencil icon' />
              <span>修改体检记录</span>
            </a>
          </div>
        </div>

        <div className='table-div'>
          <div>
            <a className='ui right labeled icon button brown next' href='zd-diagnosis.html'>
              <i className='plus icon' />
              <span>检查其他项目</span>
            </a>
          </div>
        </div>
        <div className='table-div'>
          <div>
            <a className='ui right labeled icon button brown next' href='index.html'>
              <i className='icon check' />
              <span>保存体检结果</span>
            </a>
          </div>
        </div>

      </div>
    </div>


@ZDPatientResultPage1 = React.createClass
  render: ->
    <div className='zd-patient-info-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href='doctor-patient-info.html' />
          <span>患者信息</span>
        </h2>

        <div className='table-div'>
        <table className='ui very basic celled table'>
          <tbody>
            <tr>
              <td className='label collapsing'>姓名：</td><td>王大锤</td>
              <td className='label collapsing'>性别：</td><td>男</td>
              <td className='label collapsing'>年龄：</td><td>33</td>
            </tr>
            <tr>
              <td className='label collapsing'>日期：</td><td>2015-12-08</td>
              <td className='label collapsing'>就诊号：</td><td>301</td>
              <td className='label collapsing'>诊疗卡：</td><td>1234567</td>
            </tr>
            <tr>
              <td className='label collapsing'>身高：</td><td>180 cm</td>
              <td className='label collapsing'>体重：</td><td>70 kg</td>
              <td className='label collapsing'>血压：</td><td>70/100 mmHg</td>
            </tr>
            <tr>
              <td className='label collapsing top aligned'>既往史：</td><td colSpan='5' className='desc'><span>无</span></td>
            </tr>
            <tr>
              <td className='label collapsing top aligned'>体质类型：</td><td colSpan='5' className='desc'><span>阳虚体质</span></td>
            </tr>
            <tr>
              <td className='label collapsing top aligned'>主诉：</td><td colSpan='5'><span>失眠</span></td>
            </tr>
            <tr>
              <td className='label collapsing top aligned'>初步诊断：</td><td colSpan='5' className='desc'><span>失眠</span></td>
            </tr>
            <tr>
              <td className='label collapsing top aligned'>处理：</td><td colSpan='5' className='desc'>
                <div>针灸：风池、印堂、神门、三阴交、太溪，平补平泻法，50分钟</div>
                <div>火罐：心俞、脾俞、内关、神门，单纯拔罐法，10分钟</div>
                <div>共5次</div>
              </td>
            </tr>
            <tr>
              <td className='label collapsing top aligned'>医师：</td><td colSpan='5'><span>叶建华</span></td>
            </tr>
          </tbody>
        </table>
        </div>

        <div className='table-div'>
          <div className='record'>
            <h3 className='ui header'>已检查项目：背诊</h3>
          </div>          
          <div>
            <a className='ui labeled icon button back' href='javascript:;'>
              <i className='icon file' />
              <span>查看体检记录</span>
            </a>
          </div>
        </div>

        <div className='table-div'>
          <div className='record'>
            <h3 className='ui header'>已检查项目：舌诊</h3>
          </div>          
          <div>
            <a className='ui labeled icon button back' href='javascript:;'>
              <i className='icon file' />
              <span>查看体检记录</span>
            </a>
          </div>
        </div>
      </div>
    </div>