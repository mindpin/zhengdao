module PeSentenceFormer
  extend ActiveSupport::Concern

  included do
    former "PeSentence" do
      field :id, ->(instance) {instance.id.to_s}
      field :data
    end
  end
end