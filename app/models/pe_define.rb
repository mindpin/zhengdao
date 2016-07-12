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
end
