class PeDefine
  # CONFIG_DIR = Rails.root.join("config/pe_defines")

  # def self.find(name)
  #   yaml_file_path = File.join(CONFIG_DIR, "#{name}.yml")
  #   data = YAML.load_file(yaml_file_path)
  #   self.new name, data
  # end

  # def self.all
  #   names = %w{
  #     三部九侯诊 经络诊 背诊 脉诊 脊柱诊 腹诊 舌诊 面诊
  #   }

  #   names.map {|name|
  #     yaml_file_path = File.join(CONFIG_DIR, "#{name}.yml")
  #     data = YAML.load_file(yaml_file_path)
  #     self.new name, data
  #   }
  # end

  # attr_reader :name, :data
  # def initialize(name, data)
  #   @name = name
  #   @data = data
  # end

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :fact_object
  field :name # 体检项名称
  field :desc

  def fact_group_ids=(ids)
    @fact_group_ids = ids
  end

  after_save :create_or_update_fact_object
  def create_or_update_fact_object
    return if @fact_group_ids == nil
    if self.fact_object.blank?
      fact_object = FactObject.create(fact_group_ids: @fact_group_ids)
      self.fact_object = fact_object
      @fact_group_ids = nil
      self.save
    else
      fact_object = self.fact_object
      fact_object.fact_group_ids = @fact_group_ids
      fact_object.save
      @fact_group_ids = nil
      self.save
    end
  end
end
