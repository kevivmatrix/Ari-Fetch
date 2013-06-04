module AriFetch
  class Files

    attr_accessor :files

    def initialize(files = [])
      @files = files
    end

    def filter!
      map_to_file_name.select{ |e| !useless_files.include?(e) && e.match(/\.xml\Z/) }
      self
    end

    # reverse implies latest date will come first
    def sort!(reverse=false)
      return files.sort {|f1, f2| file_date(f1) <=> file_date(f2) } unless reverse
      files.reverse
    end

    private

    def map_to_file_name
      @files = files.map { |e| e.split(/\s+/).last.to_s }
    end

    def useless_files
      [".", ".."]
    end

    def file_date(file)
      DateTime.strptime(file.to_s, "VehicleInformation%m_%d_%Y_%H_%M_%S_%p.xml") rescue DateTime.new
    end

  end
end