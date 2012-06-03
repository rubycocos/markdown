require 'hoe'
require './lib/markdown.rb'

Hoe.spec 'markdown' do
  
  self.version = Markdown::VERSION
  
  self.summary = 'Markdown Engine Wrapper - Use Your Markdown Library of Choice'
  self.description = summary

  self.urls    = ['http://geraldb.github.com/markdown']
  
  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'
  
  self.extra_deps = [
    ['props','>= 0.1.0'],
    ['kramdown','>= 0.13.6']
  ]
  
  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.markdown'
  self.history_file = 'History.markdown'
  
end