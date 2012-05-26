
$LOAD_PATH.unshift( File.expand_path( File.dirname(__FILE__) ) )

# core and stlibs

require 'yaml'


# our own code

require 'markdown_select/config'
require 'markdown_select/engine'
require 'markdown_select/markdown_select'


## todo: add main for bin (see slideshow)

module MarkdownSelect

  VERSION = '0.1.3'
  
end