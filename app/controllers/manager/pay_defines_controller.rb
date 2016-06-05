class Manager::PayDefinesController < ApplicationController
  layout 'manager'

  def index
    pay_defines = PayDefine.all.map{|x|
      DataFormer.new(x).data
    }

    @page_name = 'manager_pay_defines'
    @component_data = {
      pay_defines: pay_defines,
      new_url: new_manager_pay_define_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '治疗项目管理'
    }
  end

  def new
    @page_name = 'manager_pay_defines_new'
    @component_data = {
      submit_url: manager_pay_defines_path,
      cancel_url: manager_pay_defines_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_pay_defines_path,
      current_title: '添加治疗项'
    }
  end

  def create
    pay_define = PayDefine.new pay_define_params
    save_model(pay_define) do |x|
      DataFormer.new(x)
        .data
    end
  end

  def edit
    pay_define = PayDefine.find params[:id]

    @page_name = 'manager_pay_defines_edit'
    @component_data = {
      pay_define: DataFormer.new(pay_define).data,
      submit_url: manager_pay_define_path(pay_define),
      cancel_url: manager_pay_defines_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_pay_defines_path,
      current_title: '修改收费项'
    }
  end

  def update
    pay_define = PayDefine.find params[:id]
    update_model(pay_define, pay_define_params) do |x|
      DataFormer.new(x)
        .data
    end
  end

  private

  def pay_define_params
    params.require(:pay_define).permit(:name, :desc, :unit_price)
  end
end
