require 'hoe'
require './lib/markdown_select.rb'

Hoe.spec 'markdown_select' do
  
  self.version = MarkdownSelect::VERSION
  
  self.summary = 'Markdown Select - Use Your Markdown Library of Choice'
  self.url     = 'http://geraldb.github.com/markdown_select'
  
  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'
  
  self.extra_deps = [
    ['kramdown','>= 0.13.6']
  ]
  
  self.remote_rdoc_dir = 'doc'
  
  # switch extension to .rdoc for gihub formatting
  self.readme_file  = 'README.rdoc'
  self.history_file = 'History.rdoc'
  
end