# core and stlibs

require 'yaml'
require 'json'
require 'pp'
require 'logger'
require 'optparse'
require 'fileutils'


# gems

require 'props'   # manage properties/settings/env

class Env
  def self.markdown_lib
      ENV['MARKDOWN_LIB']
  end    
end # class Env


require 'textutils'  # text filters and helpers


# our own code

require_relative 'markdown/version'      # Note: let version always go first
require_relative 'markdown/config'
require_relative 'markdown/engines/bluecloth'
require_relative 'markdown/engines/kramdown'
require_relative 'markdown/engines/maruku'
require_relative 'markdown/engines/pandoc_ruby'
require_relative 'markdown/engines/rdiscount'
require_relative 'markdown/engines/redcarpet'
require_relative 'markdown/engines/rpeg_markdown'
require_relative 'markdown/wrapper'



# say hello
puts Markdown.banner  if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
