###
# NB: for local testing run like:
#
# 1.9.x: ruby -Ilib test/test_redcarpet.rb

# core and stlibs

require 'helper'


class TestRedcarpet < MiniTest::Unit::TestCase

  def setup
    puts 'enter setup'
    lib = Markdown.lib
    puts '  set lib=redcarpet'
    Markdown.lib = 'redcarpet'
  end

  def test_lib
    lib = Markdown.lib
    assert_equal( 'redcarpet', lib )
  end

  def test_to_html_banner_false
    html = Markdown.new( 'Hello World!', banner: false ).to_html
    assert_equal( "<p>Hello World!</p>\n",  html )
  end

  def test_to_html_banner_true
    html = Markdown.new( 'Hello World!', banner: true ).to_html
    assert( html =~ /^<!-- === begin markdown block ===/ )
    assert( html.include?( "<p>Hello World!</p>\n" ))
    assert( html =~ /=== -->$/ )
  end


end # class TestRedcarpet
