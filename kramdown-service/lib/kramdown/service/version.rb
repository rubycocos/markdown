# encoding: utf-8

module KramdownService

  MAJOR = 1
  MINOR = 0
  PATCH = 0
  VERSION = [MAJOR,MINOR,PATCH].join('.')


  def self.version
    VERSION
  end

  def self.banner
    "kramdown-service/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] " +
    "using kramdown/#{Kramdown::VERSION} " +
    "on Sinatra/#{Sinatra::VERSION} (#{ENV['RACK_ENV']})"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(File.dirname(__FILE__)))) )}"
  end

end  # module KramdownService
