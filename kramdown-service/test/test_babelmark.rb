# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_babelmark.rb


ENV['RACK_ENV'] = 'test'   ## move to helper - why? why not??


require 'helper'

require 'rack/test'    ## move to helper - why? why not??


class TestBabelmark < MiniTest::Test
  include Rack::Test::Methods

def app
  Kramdown::Service
end

def test_hello_world  
  get '/babelmark', { text: 'Hello, World!' }

  assert last_response.ok?
  assert_equal 'application/json', last_response.headers['Content-Type']

  data = JSON.parse( last_response.body )
  pp data
  
  html = "<p>Hello, World!</p>\n"
  
  assert_equal 'kramdown',        data['name']
  assert_equal Kramdown::VERSION, data['version']
  assert_equal html,              data['html']
  
end  # method test_hello_world

def test_nil

  get '/babelmark'
  
  assert last_response.ok?
  assert_equal 'application/json', last_response.headers['Content-Type']

  data = JSON.parse( last_response.body )
  pp data
  
  html ="\n"    # note: empty string w/ kramdown becomes empty string w/ newline
  
  assert_equal 'kramdown',        data['name']
  assert_equal Kramdown::VERSION, data['version']
  assert_equal html,              data['html']
end  # method test_nil


end # class TestBabelmark

