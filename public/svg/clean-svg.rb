require 'nokogiri'

class Cleaner
  def initialize(file_name)
    @doc = File.open file_name do |f|
      Nokogiri::XML f
    end
  end

  def parse
    @doc.xpath('//v:*').remove
    @doc.xpath('//@v:*').remove
    @doc.css('title').remove

    xml = @doc.to_xml

    xml = @doc.to_xml.lines.select {|x|
      x.strip.length > 0
    }.join("")

    File.open("output.svg", 'w') do |f|
      f.write xml
    end
  end
end

c = Cleaner.new ARGV[0]
c.parse