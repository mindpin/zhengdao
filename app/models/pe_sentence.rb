class PeSentence
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :pe_record

  field :data, type: Array, default: []

  default_scope -> { asc(:id) }

  after_save :update_custom_tags
  def update_custom_tags
    pe_define = self.pe_record.pe_define

    self.data.each do |fact_data|
      fact_name = fact_data['fact']
      fact = pe_define.facts.where(name: fact_name).first
      if fact
        custom_tag_names = fact_data['values'] - fact.tag_names - fact.custom_tag_names
        custom_tag_names.each do |name|
          PeCustomTag.create({
            name: name,
            fact: fact
          })
        end
      end
    end
  end
end