
LIB_PATH = File.expand_path( File.dirname(__FILE__) )
$LOAD_PATH.unshift(LIB_PATH) 

# core and stlibs

require 'yaml'


# our own code

require 'markdown_select/config'
require 'markdown_select/engine'
require 'markdown_select/markdown_select'


## todo: add main for bin (see slideshow)

module MarkdownSelect

  VERSION = '0.1.1'
  
end