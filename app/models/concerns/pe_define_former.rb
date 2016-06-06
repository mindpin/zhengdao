module PeDefineFormer
  extend ActiveSupport::Concern

  included do

    former "PeDefine" do
      field :name
      field :data

      logic :merge_records, ->(instance, records) {
        data = instance.data.map do |x|
          x['option_values'] = x['values']
          x.delete 'values'
          x
        end
        return data if records.blank?
      }

    end

  end
end
