
$LOAD_PATH.unshift( File.expand_path( File.dirname(__FILE__) ) )

# core and stlibs

require 'yaml'


# our own code

require 'markdown/config'
require 'markdown/engine'
require 'markdown/markdown'


## todo: add main for bin (see slideshow)

module Markdown

  VERSION = '0.0.1'
  
end