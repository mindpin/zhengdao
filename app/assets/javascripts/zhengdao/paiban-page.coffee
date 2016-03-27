@PaibanPage = React.createClass
  render: ->
    <div className='gh-page'>
      <div className='ui container'>
        <h2 className='ui header topbar'>
          <TopbarBack href={@props.back} />
          <span>我的排班</span>
        </h2>

        <div className='info-input-form' style={'width':'auto'}>
          <h3 className='ui header'>2015 年 12 月</h3>

          <table className='ui celled table paiban'>
            <thead><tr>
              <th>周一</th><th>周二</th><th>周三</th><th>周四</th><th>周五</th><th>周六</th><th>周日</th>
            </tr></thead>
            <tbody>
            {
              arr = [
                30, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
                13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
                24, 25, 26, 27, 28, 29, 30, 31, 1, 2, 3
              ]
              paiban = {
                1: [1,1,0]
                2: [1,1,0]
                3: [1,0,1]
                4: [0,1,0]
                5: [1,0,1]
                7: [1,1,0]
                8: [1,1,0]
                9: [1,0,1]
                10: [0,1,0]
                11: [1,0,1]
                16: [1,1,0]
                17: [1,1,0]
                18: [1,0,1]
                19: [0,1,0]
                20: [1,0,1]
                22: [1,1,0]
                23: [1,1,0]
                24: [1,0,1]
                25: [0,1,0]
                26: [1,0,1]
                28: [1,1,0]
                29: [1,1,0]
                30: [1,0,1]
                31: [0,1,0]
              }

              for i in [0...5]
                <tr key={i}>
                {
                  for j in [0...7]
                    date = arr[i * 7 + j]
                    pitem = paiban[date] || []

                    klass = new ClassName
                      'pbtd': true
                      'sat': j == 5
                      'sun': j == 6
                      'p1': pitem[0] == 1
                      'p2': pitem[1] == 1
                      'p3': pitem[2] == 1

                    <td key={j} className={klass}>
                      <div className='ui divided list'>
                        <div className='item date'><div className='text'>{date}</div></div>
                        <div className='item p1'><div className='text'>上午</div></div>
                        <div className='item p2'><div className='text'>下午</div></div>
                        <div className='item p3'><div className='text'>晚上</div></div>
                      </div>
                    </td>
                }
                </tr>
            }
            </tbody>
          </table>

        </div>
      </div>
    </div>