require "nokogiri"

module AriFetch
  class AriFile < ActiveRecord::Base
    attr_accessible :name

    attr_accessor :content

    def fetch_data(ftp_instance)
      ftp_instance.gettextfile(name)
      @content = parse!(File.open(name, "r"))
      FileUtils.rm name
      vehicles.map {|vehicle| AriFetch::Vehicle.new(vehicle).result }
    end

    private

    def parse!(xml)
      Hash.from_xml(::Nokogiri.XML(xml).to_s) rescue {}
    end

    def vehicles
      content["VEHICLES"]["VEHICLE"] rescue []
    end

  end
end