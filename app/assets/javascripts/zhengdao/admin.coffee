@ZhengdaoClinicPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Clinic />
      <DemoAdminTable.Company />
    </div>

@ZhengdaoClinicBranchPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Clinic />
      <DemoAdminTable.Clinic />
    </div>

@ZhengdaoClinicRoomPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Clinic />
      <DemoAdminTable.Room />
    </div>

@ZhengdaoClinicDepartmentPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Clinic />
      <DemoAdminTable.Department />
    </div>

@ZhengdaoClinicPersonPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Clinic />
      <DemoAdminTable.Person />
    </div>

@ZhengdaoSystemPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.System />
      <DemoAdminTable.Post />
    </div>

@ZhengdaoSystemProjectPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.System />
      <DemoAdminTable.Project />
    </div>

@ZhengdaoSystemInputItemPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.System />
      <DemoAdminTable.InputItem />
    </div>

@ZhengdaoChargePage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Charge />
      <DemoAdminTable.ChargeItem />
    </div>

@ZhengdaoChargeVIPPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Charge />
      <DemoAdminTable.VIP />
    </div>

@ZhengdaoResourcePage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Resource />
      <DemoAdminTable.ResourceItem />
    </div>

@ZhengdaoResourceInPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Resource />
      <DemoAdminTable.ResourceIn />
    </div>

@ZhengdaoResourceOutPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Resource />
      <DemoAdminTable.ResourceOut />
    </div>

@ZhengdaoResourceBalancePage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Resource />
      <DemoAdminTable.ResourceBalance />
    </div>

@ZhengdaoPatientPage = React.createClass
  render: ->
    <div>
      <DemoAdminHeader.Patient />
      <DemoAdminPatientPage />
    </div>