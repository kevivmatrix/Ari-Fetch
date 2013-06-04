module AriFetch

  class Vehicle

    attr_accessor :vehicle

    def initialize(vehicle)
      @vehicle = vehicle
    end

    def result
      OpenStruct.new(vehicle_data_with_downcased_keys)
    end

    def available?
      ari_action == "AVAILABLE"
    end

    private

    def vehicle_data_with_downcased_keys
      downcased_hash = {}
      vehicle.map{|k, v| downcased_hash.merge!({"#{k.downcase}" => v}) }
      downcased_hash
    end

    def vin_number
      vehicle["VIN"]
    end

    def ari_action
      vehicle["ACTION"]
    end

  end

end