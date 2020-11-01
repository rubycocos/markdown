# encoding: utf-8

######
# NB: use rackup to startup Sinatra service (see config.ru)
#
#  e.g. config.ru:
#   require './boot'
#   run Kramdown::Service


require 'pp'
require 'json'


# 3rd party libs/gems

require 'sinatra/base'

require 'kramdown'

# our own code

require 'kramdown/service/version'   # let version always go first



module Kramdown

class Service < Sinatra::Base

  PUBLIC_FOLDER = "#{KramdownService.root}/lib/kramdown/service/public"
  VIEWS_FOLDER  = "#{KramdownService.root}/lib/kramdown/service/views"

  puts "[boot] kramdown-service - setting public folder to: #{PUBLIC_FOLDER}"
  puts "[boot] kramdown-service - setting views folder to: #{VIEWS_FOLDER}"

  set :public_folder, PUBLIC_FOLDER   # set up the static dir (with images/js/css inside)
  set :views,         VIEWS_FOLDER    # set up the views dir

  set :static, true   # set up static file routing


  ##############################################
  # Controllers / Routing / Request Handlers


  get %r{/(service|services|srv|s)} do
    ## just a "live" docu page
    erb :service
  end

  get %r{/(editor|edit|ed|e)} do
    # note: allow optional params e.g. text and opts
    ##  note: for now only html supported on get form/url params
    text = params.delete('text') || welcome_markdown
    to   = params.delete('to')   || 'html'  ## optional - default to html
    opts = params_to_opts( params )

    @welcome_markdown = text
    @welcome_html     = text_to_html( text, opts )

    erb :editor
  end

  get '/' do
    # note: allow optional params e.g. text and opts
    ##  note: for now only html supported on get form/url params
    text = params.delete('text') || welcome_markdown
    to   = params.delete('to')   || 'html'  ## optional - default to html
    opts = params_to_opts( params )

    @welcome_markdown = text
    @welcome_html     = text_to_html( text, opts )

    erb :index
  end

  # return hypertext (html)    ## allow /markdown  or /m
  get %r{/(markdown|m)} do

    text = params.delete('text') || ''      ## if no text param supplied, use empty/blank string
    to   = params.delete('to')   || 'html'  ## optional - default to html
    opts = params_to_opts( params )

    if ['latex','l','tex'].include?( to.downcase )
      content_type 'text/latex'     ### todo: check if latex content_type exists?
      text_to_latex( text, opts )
    else  ## assume html (default)
      content_type 'text/html'
      text_to_html( text, opts )
    end

 end


  # return babelmark2/dingus-style json
  # return html wrapped in json (follows babelmark2 dingus service api)
  #  note: defaults (uses) GFM - github-flavored markdown mode/input
  #  note: only supports html for now (e.g. does NOT support to=html|latex option etc.)
  get '/babelmark' do
    text = params.delete('text') || ''    ## if no text param supplied, use empty/blank string

    data = {
      name:   'kramdown',
      html:    Kramdown::Document.new( text, input: 'GFM' ).to_html,
      version: Kramdown::VERSION
    }

    json_or_jsonp( data.to_json )
  end


  get %r{/(options|opts|o)} do    ## for debugging/testing "dump" options
    content_type 'text/plain'

    opts = preprocess_opts( params_to_opts( params ))
    doc = Kramdown::Document.new( '', opts )
    doc.options.inspect
  end


  get '/d*' do
    erb :debug
  end


private

  def welcome_markdown
    ## todo: rotate welcome / use random number for index
    # place markdown docs in server/docs
     text = File.read( "#{KramdownService.root}/lib/kramdown/service/docs/welcome.md" )
     text
  end

  def params_to_opts( params )
    ## convert (web form) params to kramdown (ruby) opts

    puts "params : #{params.class.name}:"
    pp params

    opts = {}

    ## map true/false strings to boolean
    params.each do |k,v|
      puts " k: >#{k}< : #{k.class.name}, v: >#{v}< : #{v.class.name}"

      ##  skip "built-in" sinatra "internal" params
      ##   - todo - use splice and whitelist instead - why? why not?
      next  if ['splat', 'captures'].include?( k )

      if v.is_a?( String ) && ['t', 'true'].include?( v.downcase )
        opts[ k ] = true
      elsif v.is_a?( String ) && ['f', 'false'].include?( v.downcase )
        opts[ k ] = false
      else
        opts[ k ] = v
      end
    end

    opts
  end


  def preprocess_opts( opts )
    ### special case for input opt
    ##     always default to gfm (github-flavored markdown) for now

    input = opts.delete( 'input' ) || 'GFM'

    if ['classic', 'std', 'standard', 'kramdown' ].include?( input.downcase )
       ## skip; "pseudo" input options map to no (zero) standard/classic input
    elsif ['gfm'].include?( input.downcase )
      ## note: GFM **MUST** be uppercase (gets converted to a matching ruby parser class)
      opts[ 'input' ] = 'GFM'
      ## in gfm mode (auto-)add hard_wrap = false unless set
      opts['hard_wrap'] = false   if opts['hard_wrap'].nil?
    else
      opts[ 'input' ] = input
    end

    puts "opts (preprocessed/effective):"
    pp opts

    opts
  end

  def text_to_html( text, opts={} )
    puts "text_to_html:"
    pp text
    pp opts

    opts = preprocess_opts( opts )   ## defaults to GFM input etc.

    Kramdown::Document.new( text, opts ).to_html
  end

  def text_to_latex( text, opts={} )
    puts "text_to_latex:"
    pp text
    pp opts

    opts = preprocess_opts( opts )   ## defaults to GFM input etc.

    Kramdown::Document.new( text, opts ).to_latex
  end


### helper for json or jsonp response (depending on callback para)

def json_or_jsonp( json )
  callback = params.delete('callback')
  response = ''

  if callback
    content_type :js
    response = "#{callback}(#{json})"
  else
    content_type :json
    response = json
  end

  response
end


end # class Service
end #  module Kramdown


# say hello
puts KramdownService.banner
