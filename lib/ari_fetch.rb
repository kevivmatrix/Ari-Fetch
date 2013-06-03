require "ari_fetch/version"

require "active_support/dependencies"

module AriFetch
  class Engine

    attr_accessor :files

    def initialize(*args)
      # do something
      @files = AriFile.all
    end
  end

  class AriFile < ActiveRecord::Base
    attr_accessible :name
  end
end