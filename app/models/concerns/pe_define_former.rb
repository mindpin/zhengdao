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

        records.map { |idx, v|
          a = {}
          d = data[idx.to_i]

          a['label'] = v['label']
          a['option_values'] = d.blank? ? [] : d['option_values']
          a['saved_values'] = v['saved_values']
          file_entity_id = v['file_entity_id']
          if file_entity_id.present?
            a['file_entity_id'] = file_entity_id
            a['file_url'] = FilePartUpload::FileEntity.find(file_entity_id).url
          end
          a
        }
      }

      field :edit_url, ->(instance) {
        "/manager/pe_defines/#{instance.name}/edit"
      }

    end

  end
end
