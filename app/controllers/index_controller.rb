class IndexController < ActionController::Base
  PAGE_AND_COMPONENT = {
    home: %w{common DemoIndexPage},
    guide: %w{common GHSelectPage},
    doctor: %w{common DoctorSelectPage},
    tijian: %w{common TijianSelectPage},
    clinic: %w{}
  }

  layout -> {
    page = params[:page].to_sym
    PAGE_AND_COMPONENT[page][0]
  }

  def index
    redirect_to zhengdao_url page: 'home'
  end

  def page
    page = params[:page].to_sym
    @component_name = PAGE_AND_COMPONENT[page][1]
  end
end
