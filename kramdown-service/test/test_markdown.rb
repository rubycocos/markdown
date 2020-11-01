# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_markdown.rb


ENV['RACK_ENV'] = 'test'   ## move to helper - why? why not??


require 'helper'

require 'rack/test'    ## move to helper - why? why not??


class TestMarkdown < MiniTest::Test
  include Rack::Test::Methods

def app
  Kramdown::Service
end

def test_hello_world  
  get '/markdown', { text: 'Hello, World!' }

  assert last_response.ok?
  assert_equal 'text/html;charset=utf-8', last_response.headers['Content-Type']

  pp last_response.body

  html = "<p>Hello, World!</p>\n"
  assert_equal html, last_response.body
end  # method test_hello_world


def test_latex_hello_world  
  get '/markdown', { text: 'Hello, World!', to: 'latex' }

  assert last_response.ok?
  assert_equal 'text/latex;charset=utf-8', last_response.headers['Content-Type']

  pp last_response.body

  latex = "Hello, World!\n\n"
  assert_equal latex, last_response.body
end  # method test_latex_hello_world



end # class TestMarkdown

