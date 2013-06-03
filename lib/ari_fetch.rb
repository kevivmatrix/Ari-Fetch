require "ari_fetch/version"

require "active_support/dependencies"
require "active_record"

require "net/ftp"

module AriFetch
  class Engine

    attr_accessor :read_files, :unread_files, :ftp_files, :ftp_url, :username,
      :password, :ftp_instance

    def initialize(ftp_url, username, password)
      @ftp_url, @username, @password = ftp_url, username, password
      @unread_files = ftp_files - read_files
    end

    def read_files
      @read_files ||= AriFile.pluck(:name) rescue @read_files = AriFetch::Files.new([]).files
    end

    def ftp_files
      @ftp_files ||= fetch! rescue @ftp_files = AriFetch::Files.new([]).files
    end

    def read_files_from_start(how_many=1)
      fetch_data_from_files(unread_files.first(how_many))
    end

    def read_files_from_end(how_many=1)
      fetch_data_from_files(unread_files.last(how_many))
    end

    private

    def fetch_data_from_files(files)
      files.map {|file| AriFetch::AriFile.create(name: file).fetch_data(ftp_instance) }.flatten!
    end

    def fetch!
      login
      AriFetch::Files.new(ftp_instance.list()).filter!.sort!
    end

    def login
      ftp_instance.connect(ftp_url, 21)
      ftp_instance.login(username, password)
      ftp_instance.passive = true
      ftp_instance.chdir('/')
    end

    def ftp_instance
      @ftp_instance ||= Net::FTP.new
    end

  end
end

require "ari_fetch/ari_file.rb"
require "ari_fetch/files.rb"
require "ari_fetch/vehicle.rb"