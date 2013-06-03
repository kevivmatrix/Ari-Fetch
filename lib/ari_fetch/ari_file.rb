require "nokogiri"

module AriFetch
  class AriFile < ActiveRecord::Base
    attr_accessible :name

    attr_accessor :content

    def fetch_data(ftp_instance)
      @content = parse!(ftp_instance.gettextfile(name))
      puts vehicles
      puts "vivek"
      puts content
      puts " ----------------------------------------------------------- "
      vehicles.map {|vehicle| AriFetch::Vehicle.new(vehicle).result }
    end

    private

    def parse!(xml)
      Hash.from_xml(::Nokogiri.XML(xml).to_s)# rescue {}
    end

    def vehicles
      content["VEHICLES"]["VEHICLE"] rescue []
    end

  end
end