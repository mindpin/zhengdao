class Mockup::IndexController < ApplicationController
  include SampleData

  PAGE_AND_COMPONENT = {
    home: %w{common DemoIndexPage},

    :'patient-graph' => %w{dashboard DemoPatientGraphPage},

    guide: %w{diagnosis GHSelectPage},
      :'guide-guahao' => %w{diagnosis GHXCPage},
        :'guide-doctor-select' => %w{diagnosis GHDoctorSelectPage},
        :'guide-doctor-selected' => %w{diagnosis GHDoctorSelectedPage},
        :'guide-quhao-result' => %w{diagnosis GHYYResultPage},
      :'guide-quhao' => %w{diagnosis GHYYPage},
        :'guide-quhao-confirm' => %w{diagnosis GHYYConfirmPage},
      :'guide-zhiliao' => %w{diagnosis GHZhiliao},
        :'guide-zhiliao-choose-room' => %w{diagnosis GHZhiliaoChooseRoom},
        :'guide-period-select' => %w{diagnosis GHPeriodSelectPage},
        :'guide-zhiliao-selected' => %w{diagnosis GHZhiliaoSelectedPage},

    doctor: %w{common DoctorSelectPage},
      :'doctor-patient-list' => %w{diagnosis DoctorPatientListPage},
        :'doctor-patient-info' => %w{diagnosis DoctorPatientInfoPage},
        :'doctor-pay' => %w{diagnosis DoctorPayPage},
        :'doctor-zhenduan' => %w{diagnosis ZDPatientResultPage1},
      :'doctor-paiban' => %w{diagnosis PaibanPageFromDoctor},

    tijian: %w{common TijianSelectPage},
      :'zd-patient-list' => %w{diagnosis ZDPatientListPage},
        :'zd-patient-info' => %w{diagnosis ZDPatientInfoPage},
        :'zd-diagnosis' => %w{diagnosis DiagnosisPage},
        :'zd-zhenduan-result' => %w{diagnosis ZDPatientResultPage},
      :'tijian-paiban' => %w{diagnosis PaibanPageFromTijian},

    clinic: %w{admin ZhengdaoClinicPage},
      :'clinic-branch' => %w{admin ZhengdaoClinicBranchPage},
      :'clinic-department' => %w{admin ZhengdaoClinicDepartmentPage},
      :'clinic-person' => %w{admin ZhengdaoClinicPersonPage},
      :'clinic-room' => %w{admin ZhengdaoClinicRoomPage},

      :'system' => %w{admin ZhengdaoSystemPage},
      :'system-project' => %w{admin ZhengdaoSystemProjectPage},
      :'system-input-item' => %w{admin ZhengdaoSystemInputItemPage},

      :'charge' => %w{admin ZhengdaoChargePage},
      :'charge-vip' => %w{admin ZhengdaoChargeVIPPage},

      :'resource' => %w{admin ZhengdaoResourcePage},
      :'resource-in' => %w{admin ZhengdaoResourceInPage},
      :'resource-out' => %w{admin ZhengdaoResourceOutPage},
      :'resource-balance' => %w{admin ZhengdaoResourceBalancePage},

      :'patient' => %w{admin ZhengdaoPatientPage},

      # :'plan' => %w{admin DemoAdminHeader.Plan},
      # :'register' => %w{admin DemoAdminHeader.Register},
  }

  layout -> {
    page = params[:page].to_sym
    PAGE_AND_COMPONENT[page][0]
  }

  def index
    redirect_to auth_url page: 'sign_in'
  end

  def page
    page = params[:page].to_sym

    case page
    when :'dashboard-guide'
      get_dashboard_guide
    when :'dashboard-doctor'
      get_dashboard_doctor
    when :'dashboard-pe'
      get_dashboard_pe
    when :'dashboard-treat'
      get_dashboard_treat
    else
      @component_name = PAGE_AND_COMPONENT[page][1]
    end
  end

  def graph
    render layout: 'dashboard'
  end

  def get_dashboard_guide
    @component_name = 'DashboardPage.Guide'
    @component_data = {
      yuyue_queue: GUAHAO_PATIENTS[0...8],
      zaiguan_queue: ZAIGUAN_PATIENTS[0...7],
      free_doctor: DOCTORS[0...7],
      free_pe: PES[0...5],
      free_treat: TREATS[0...6],
    }
    render layout: 'dashboard'
  end

  def get_dashboard_doctor
    @component_name = 'DashboardPage.Doctor'
    @component_data = {
      yuyue_queue: GUAHAO_PATIENTS,
      zaiguan_queue: ZAIGUAN_PATIENTS
    }
    render layout: 'dashboard'
  end

  def get_dashboard_pe
    @component_name = 'DashboardPage.PE'
    @component_data = {
      yuyue_queue: GUAHAO_PATIENTS[0...5],
      zaiguan_queue: ZAIGUAN_PATIENTS[0...4]
    }
    render layout: 'dashboard'
  end

  def get_dashboard_treat
    @component_name = 'DashboardPage.Treat'
    @component_data = {
      yuyue_queue: GUAHAO_PATIENTS,
      zaiguan_queue: ZAIGUAN_PATIENTS
    }
    render layout: 'dashboard'
  end

end
