# encoding: utf-8

require 'markdown'
require 'markdown/service'    # pull in markdown HTTP JSON service addon


# our own code

require 'markdown/cli/version'   # note: let version always go first
require 'markdown/cli/gen'
require 'markdown/cli/opts'
require 'markdown/cli/runner'


module Markdown

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
