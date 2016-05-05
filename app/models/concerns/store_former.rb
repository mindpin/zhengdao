module StoreFormer
  extend ActiveSupport::Concern

  included do

    former "Store" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :location

      field :edit_url, ->(instance) {
        edit_manager_store_path(instance)
      }

    end

  end
end
