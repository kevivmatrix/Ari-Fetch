module AriFetch
  class Files

    attr_accessor :files

    def initialize(files = [])
      @files = files
    end

    def filter!
      map_to_file_name.select{ |e| !useless_files.include?(e) && e.match(/\.xml\Z/) }
    end

    def sort!(reverse=false)
      files.sort {|f1, f2| file_date(f1) <=> file_date(f2) }
      files.reverse if reverse
    end

    private

    def map_to_file_name
      files.map { |e| e.split(/\s+/).last.to_s }
    end

    def useless_files
      [".", ".."]
    end

    def file_date(file)
      DateTime.strptime(file.to_s, "VehicleInformation%m_%d_%Y_%H_%M_%S_%p.xml") rescue DateTime.new
    end

  end
end