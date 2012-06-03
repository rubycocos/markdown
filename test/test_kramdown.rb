###
# NB: for local testing run like:
#
# 1.8.x: ruby -Ilib -rrubygems test/test_kramdown.rb
# 1.9.x: ruby -Ilib test/test_kramdown.rb

# core and stlibs

require 'test/unit'
require 'logger'
require 'pp'

# our own code

require 'lib/markdown'


class TestKramdown < Test::Unit::TestCase
  
  def setup
    Markdown.lib = 'kramdown'
  end
  
  def test_lib
    lib = Markdown.lib
    assert_equal( 'kramdown', lib )  
  end
  
  def test_to_html
    html = Markdown.new( 'Hello World!' ).to_html
    assert_equal( "<p>Hello World!</p>\n",  html )
  end

    
end # class TestKramdown