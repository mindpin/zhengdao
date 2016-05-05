module PayDefineFormer
  extend ActiveSupport::Concern

  included do

    former "PayDefine" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :desc
      field :unit_price

      field :edit_url, ->(instance) {
        edit_manager_pay_define_path(instance)
      }

    end

  end
end
