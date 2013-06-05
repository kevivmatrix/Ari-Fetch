require "nokogiri"

module AriFetch
  class AriReadFile < ActiveRecord::Base
    attr_accessible :name, :data_read

    scope :read_done, where("data_read = 1")

    attr_accessor :content, :vehicles

    def fetch_data(ftp_instance, include_cancel)
      ftp_instance.gettextfile(name)
      @content = parse!(File.open(name, "r"))
      FileUtils.rm name
      filter_cancel_vehicles! unless include_cancel
      result.tap { data_reading_done! }
    end

    private

    def parse!(xml)
      Hash.from_xml(::Nokogiri.XML(xml).to_s) rescue {}
    end

    def vehicles_hash
      content["VEHICLES"]["VEHICLE"] rescue []
    end

    def vehicles
      @vehicles ||= vehicles_hash.map {|vehicle| AriFetch::Vehicle.new(vehicle) }
    end

    def filter_cancel_vehicles!
      @vehicles = vehicles.select { |vehicle| vehicle.available? }
    end

    def result
      vehicles.map { |vehicle| vehicle.result }
    end

    def data_reading_done!
      self.update_attributes(data_read: true)
    end

  end
end