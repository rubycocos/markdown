###
# NB: for local testing run like:
#
# 1.8.x: ruby -Ilib -rrubygems lib/markdown.rb
# 1.9.x: ruby -Ilib lib/markdown.rb

# core and stlibs

require 'yaml'
require 'pp'
require 'logger'
require 'optparse'
require 'fileutils'


# rubygems

require 'props'   # manage properties/settings/env

class Env
  def self.markdown_lib
      ENV['MARKDOWN_LIB']
  end    
end # class Env


require 'textutils'  # text filters and helpers

# our own code

require 'markdown/version'
require 'markdown/config'
require 'markdown/engines/bluecloth'
require 'markdown/engines/kramdown'
require 'markdown/engines/maruku'
require 'markdown/engines/pandoc_ruby'
require 'markdown/engines/rdiscount'
require 'markdown/engines/redcarpet'
require 'markdown/engines/rpeg_markdown'
require 'markdown/wrapper'

require 'markdown/cli/gen'
require 'markdown/cli/opts'
require 'markdown/cli/runner'


module Markdown

  # version string for generator meta tag (includes ruby version)
  def self.banner
    "markdown #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.main
    
    # allow env variable to set RUBYOPT-style default command line options
    #   e.g. -o site 
    markdownopt = ENV[ 'MARKDOWNOPT' ]
    
    args = []
    args += markdownopt.split if markdownopt
    args += ARGV.dup
    
    Runner.new.run(args)
  end

end  # module Markdown


Markdown.main if __FILE__ == $0