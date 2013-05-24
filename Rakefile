require 'hoe'
require './lib/markdown/version.rb'

Hoe.spec 'markdown' do
  
  self.version = Markdown::VERSION
  
  self.summary = 'Markdown Engine Wrapper - Use Your Markdown Library of Choice'
  self.description = summary

  self.urls    = ['http://geraldb.github.com/markdown']
  
  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'
  
  self.extra_deps = [
    ['props','>= 1.0.0'],
    ['textutils','>=0.6.4'],
    ['kramdown','>= 1.0.2']
    
    ## todo: add sinatra ?? - keep it optional for now
  ]
  
  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.markdown'
  self.history_file = 'History.markdown'

  self.licenses = ['Public Domain']

  self.spec_extras = {
   :required_ruby_version => '>= 1.9.2'
  }

end