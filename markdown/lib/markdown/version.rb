# encoding: utf-8

module Markdown

  MAJOR = 1
  MINOR = 2
  PATCH = 1
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  
  # version string for generator meta tag (includes ruby version)
  def self.banner
    "markdown/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] in (#{root})"
  end

  def self.root
    File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )
  end

end # module Markdown

