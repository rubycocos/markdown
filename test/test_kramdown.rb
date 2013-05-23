###
# NB: for local testing run like:
#
# 1.9.x: ruby -Ilib test/test_kramdown.rb

# core and stlibs

require 'helper'



class TestKramdown < MiniTest::Unit::TestCase
  
  def setup
    puts 'enter setup'
    lib = Markdown.lib
    puts '  set lib=kramdown'
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
