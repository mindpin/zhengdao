class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 覆盖 rails 默认的 render :template => params[:action] 行为
  # 改为
  # 如果 @page_name @component_data 存在就 render "/mockup/page"
  # 如果 @page_name @component_data 不存在就使用 rails 默认的 render :template => params[:action] 行为
  def default_render(*args)
    if @page_name.present? and not @component_data.nil?
      return render "/mockup/page"
    end
    super
  end
end