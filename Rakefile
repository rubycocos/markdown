require 'hoe'
require './lib/markdown_select.rb'

Hoe.spec 'markdown' do
  
  self.version = MarkdownSelect::VERSION
  
  self.summary = 'Markdown - Use Your Markdown Library of Choice'
  self.url     = 'http://geraldb.github.com/markdown_select'
  
  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'
  
  self.extra_deps = [
    ['kramdown','>= 0.13.6']
  ]
  
  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.markdown'
  self.history_file = 'History.markdown'
  
end