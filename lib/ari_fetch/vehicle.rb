module AriFetch

  class Vehicle

    attr_accessor :vehicle

    def initialize(vehicle)
      @vehicle = vehicle
    end

    def result
      OpenStruct.new(
        {
          vin_number: vehicle["VIN"]
        }
      )
    end

    private

    # def method_missing(name, *args)
    #   vehicle.send(name, *args)
    # end

  end

end