
$LOAD_PATH.unshift( File.expand_path( File.dirname(__FILE__) ) )

# core and stlibs

require 'yaml'


# our own code

require 'markdown/config'
require 'markdown/engines/bluecloth'
require 'markdown/engines/kramdown'
require 'markdown/engines/maruku'
require 'markdown/engines/pandoc_ruby'
require 'markdown/engines/rdiscount'
require 'markdown/engines/rpeg_markdown'
require 'markdown/markdown'


## todo: add main for bin (see slideshow)

module Markdown

  VERSION = '0.0.1'
  
end