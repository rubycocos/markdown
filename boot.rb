
# ruby stdlibs

require 'pp'



ENV['RACK_ENV'] ||= 'development'

puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV']}"

## NB: no DB required/in use for now; just simple service calls

## add lib to load path

$LOAD_PATH << "./lib"

require './lib/markdown.rb'
require './lib/markdown/server.rb'
