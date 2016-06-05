module PeDefineFormer
  extend ActiveSupport::Concern

  included do

    former "PeDefine" do
      field :name
      field :data
    end

  end
end
