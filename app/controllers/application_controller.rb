class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 覆盖 rails 默认的 render :template => params[:action] 行为
  # 改为
  # 如果 @page_name @component_data 存在就 render "/layouts/page"
  # 如果 @page_name @component_data 不存在就使用 rails 默认的 render :template => params[:action] 行为
  def default_render(*args)
    if @page_name.present? and not @component_data.nil?
      return render "/layouts/page"
    end
    super
  end

  def save_model(model, wrap = nil, &block)
    if model.save
      data = block.call(model)
      data = {wrap.to_sym => data} if !wrap.blank?
      render json: data
    else
      data = model.errors.messages
      data = {wrap.to_sym => data} if !wrap.blank?
      render json: data, :status => 422
    end
  end

  def update_model(model, params_attrs, wrap = nil, &block)
    if model.update_attributes params_attrs
      data = block.call(model)
      data = {wrap.to_sym => data} if !wrap.blank?
      render json: data
    else
      data = model.errors.messages
      data = {wrap.to_sym => data} if !wrap.blank?
      render json: data, :status => 422
    end
  end
end