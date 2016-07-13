module PeDefineFormer
  extend ActiveSupport::Concern

  included do

    former "PeDefine" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :desc
    end

  end
end
