load 'c:\source\other\markdown\lib\markdown.rb'

puts Markdown.new('# test', 'banner' => false).to_html
#puts Markdown.new('# test').to_html
