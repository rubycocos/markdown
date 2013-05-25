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

  def test_to_html_banner_false
    md = Markdown.new( 'Hello World!', banner: false )

    assert_equal( "<p>Hello World!</p>\n", md.to_html )
    assert_equal( "<p>Hello World!</p>\n", md.to_html )
    assert_equal( "<p>Hello World!</p>\n", md.to_html )
  end

  def test_to_html_banner_true
    md = Markdown.new( 'Hello World!', banner: true )
    html1 = md.to_html
    html2 = md.to_html
    assert( html1 =~ /^<!-- === begin markdown block ===/ )
    assert( html1.include?( "<p>Hello World!</p>\n" ))
    assert( html2.include?( "<p>Hello World!</p>\n" ))
    assert( html1 =~ /=== -->$/ )
  end

end # class TestKramdown
