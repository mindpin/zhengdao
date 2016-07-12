module PeDefineFormer
  extend ActiveSupport::Concern

  included do

    former "PeDefine" do
      field :name
      field :desc
    end

  end
end
