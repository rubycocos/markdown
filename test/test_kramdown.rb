$LOAD_PATH.unshift( File.expand_path( File.dirname( 'lib' ) ) )

# core and stlibs

require 'test/unit'
require 'logger'
require 'pp'

require 'rubygems'


# our own code

require 'lib/markdown'


class TestKramdown < Test::Unit::TestCase
  
  def setup
    Markdown.lib( 'kramdown' )
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