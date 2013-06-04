require "ari_fetch/version"

require "active_support/dependencies"
require "active_record"

require "net/ftp"

module AriFetch
  class Engine

    attr_accessor :read_files, :unread_files, :ftp_files, :ftp_url, :username,
      :password, :ftp_instance, :options

    def initialize(ftp_url, username, password, options = {})
      @ftp_url, @username, @password, @options = ftp_url, username, password, options
    end

    def read_files
      @read_files = AriFetch::AriReadFile.pluck(:name) rescue @read_files = AriFetch::Files.new([]).files
    end

    def ftp_files
      @ftp_files = fetch! rescue @ftp_files = AriFetch::Files.new([]).files
    end

    def unread_files
      @unread_files = ftp_files - read_files
    end

    def fetch_vehicles_from_files(how_many=1)
      unread_files.first(how_many).map {|file| AriFetch::AriReadFile.create(name: file, data_read: false).fetch_data(ftp_instance, include_cancel?) }.flatten!
    end

    private

    def fetch!
      login
      AriFetch::Files.new(ftp_instance.list()).filter!.sort!(reverse?)
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

    def include_cancel?
      options[:cancel] || false
    end

    def reverse?
      options[:reverse_order] || false
    end

  end
end

require "ari_fetch/ari_read_file.rb"
require "ari_fetch/files.rb"
require "ari_fetch/vehicle.rb"