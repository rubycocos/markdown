######
# NB: use rackup to startup Sinatra service (see config.ru)
#
#  e.g. config.ru:
#   require './boot'
#   run Markdown::Server


# 3rd party libs/gems

require 'sinatra/base'


# our own code

# require 'logutils'
# require 'logutils/db'



module Markdown

class Server < Sinatra::Base

  def self.banner
    "markdown-service #{Markdown::VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] on Sinatra/#{Sinatra::VERSION} (#{ENV['RACK_ENV']})"
  end

  PUBLIC_FOLDER = "#{Markdown.root}/lib/markdown/server/public"
  VIEWS_FOLDER  = "#{Markdown.root}/lib/markdown/server/views"

  puts "[debug] markdown-service - setting public folder to: #{PUBLIC_FOLDER}"
  puts "[debug] markdown-service - setting views folder to: #{VIEWS_FOLDER}"

  set :public_folder, PUBLIC_FOLDER   # set up the static dir (with images/js/css inside)   
  set :views,         VIEWS_FOLDER    # set up the views dir

  set :static, true   # set up static file routing


  ##############################################
  # Controllers / Routing / Request Handlers


  def welcome_markdown
    ## todo: rotate welcome / use random number for index
    # place markdown docs in server/docs
     text = File.read( "#{Markdown.root}/lib/markdown/server/docs/welcome.md" )
     text
  end


  get %r{/(service|services|srv|s)$} do
    erb :service
  end

  get %r{/(note|notes|n)$} do
    # for testing/debugging use copied sources 1:1 from markdown-notepad repo
    redirect '/note.html'
  end

  get %r{/(editor|edit|ed|e)$} do
    # NB: use editor for "ruby-enhanced" parts of note
    @welcome_markdown = welcome_markdown
    @welcome_html = Markdown.new( @welcome_markdown ).to_html

    erb :editor
  end

  get '/' do
    @welcome_markdown = welcome_markdown
    @welcome_html = Markdown.new( @welcome_markdown ).to_html

    erb :index
  end


  ## todo: use 3rd party services from markdown.yml (lets you configure)
  #   e.g. http://johnmacfarlane.net/cgi-bin/pandoc-dingus?text=hi


  def markdownify( params, opts={} )
    pp params
    text = params[:text]
    lib  = params[:lib]   # optional
    pp text
    pp lib

    # fix: use activesupport -> .present?
    if lib.nil? == false && lib.empty? == false
      Markdown.lib = lib
    end

    Markdown.new( text, opts ).to_html
  end


  # return babelmark2/dingus-style json
  get '/markdown/dingus' do
    html = markdownify( params )

    ## todo: use converter for markdownify
    lib = Markdown.lib
    conv = Markdown.create_converter( lib )
            
    data = {
      name: lib,
      html: html,
      version: conv.version
    }
    
    json_or_jsonp( data.to_json )
  end

  # return hypertext (html)
  get '/markdown' do
    content_type 'text/html'
    markdownify( params )
  end

  # return html wrapped in json (follows babelfish2 dingus service api)
  get '/dingus' do
    html = markdownify( params, banner: false )

    ## todo: use converter for markdownify
    lib = Markdown.lib
    conv = Markdown.create_converter( lib )
            
    data = {
      name: lib,
      html: html,
      version: conv.version
    }
    
    json_or_jsonp( data.to_json )
  end


  get '/d*' do
    erb :debug
  end


### helper for json or jsonp response (depending on callback para)

private
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


end # class Server
end #  module Markdown


# say hello
puts Markdown::Server.banner
puts "  default markdown engine: #{Markdown.lib}" # force loading of settings/config
puts "  markdown engines: #{Markdown.libs.inspect}"
