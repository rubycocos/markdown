# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_kramdown.rb



require 'helper'


class TestKramdown < MiniTest::Test


def test_kramdown
  
  text = 'Hello, World!'
  
  doc = Kramdown::Document.new( text )

  puts "options:"  
  pp doc.options
  
  html  = "<p>Hello, World!</p>\n"
  latex = "Hello, World!\n\n"
  
  assert_equal html,  doc.to_html
  assert_equal latex, doc.to_latex
end  # method test_kramdown


def test_gfm_w_rouge
  
  text = "A Line.\nAnother Line.\n"
  
  doc = Kramdown::Document.new( text,
                                input: 'GFM',
                                hard_wrap: false,
                                syntax_highlighter: 'rouge' )

  puts "options:"  
  pp doc.options
  
  html  = "<p>A Line.\nAnother Line.</p>\n"
  
  pp doc.to_html
  
  assert_equal html,  doc.to_html
end  # method test_gfm_w_rouge



end # class TestKramdown

