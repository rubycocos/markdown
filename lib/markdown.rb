# encoding: utf-8

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

require 'markdown/version'      # Note: let version always go first
require 'markdown/config'
require 'markdown/engines/bluecloth'
require 'markdown/engines/kramdown'
require 'markdown/engines/maruku'
require 'markdown/engines/pandoc_ruby'
require 'markdown/engines/rdiscount'
require 'markdown/engines/redcarpet'
require 'markdown/engines/rpeg_markdown'
require 'markdown/wrapper'



# say hello
puts Markdown.banner  if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
