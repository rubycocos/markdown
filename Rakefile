require 'hoe'
require './lib/markdown/version.rb'

Hoe.spec 'markdown' do

  self.version = Markdown::VERSION
  
  self.summary = 'Markdown Engine Wrapper - Use Your Markdown Library of Choice'
  self.description = summary

  self.urls    = ['https://github.com/rubylibs/markdown']

  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'

  self.extra_deps = [
    ['props','>= 1.1.2'],
    ['textutils','>=0.10.0'],
    ['kramdown','>= 1.5.0']
  ]

  # switch extension to .markdown for github formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.licenses = ['Public Domain']

  self.spec_extras = {
    required_ruby_version: '>= 1.9.2'
  }

end
