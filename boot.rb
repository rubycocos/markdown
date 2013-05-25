
# ruby stdlibs

require 'pp'



ENV['RACK_ENV'] ||= 'development'

puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV']}"

## NB: no DB required/in use for now; just simple service calls

## add lib to load path

$LOAD_PATH << "./lib"

# magic flag for config settings (see lib/markdown/config.rb)
$MARKDOWN_USE_SERVICE_CONFIG = true

require './lib/markdown.rb'
require './lib/markdown/server.rb'
