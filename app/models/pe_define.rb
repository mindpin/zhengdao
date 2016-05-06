class PeDefine
  CONFIG_DIR = Rails.root.join("config/pe_defines")

  def self.find(name)
    yaml_file_path = File.join(CONFIG_DIR, "#{name}.yml")
    data = YAML.load_file(yaml_file_path)
    self.new name, data
  end

  attr_reader :name, :data
  def initialize(name, data)
    @name = name
    @data = data
  end
end
