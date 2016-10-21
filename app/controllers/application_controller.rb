class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def default_render
    if @component_name.present?
      @component_name = @component_name.camelize

      # 针对 zhengdao 的旧代码特殊处理
      @component_name = "#{@component_name}Page" if @component_name[-4..-1] != 'Page'
      
      respond_to do |format|
        format.html { render text: nil, layout: true }
        format.json { render json: @component_data }
      end
    else
      super
    end
  end

  # -----------------------

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