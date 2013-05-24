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


  ##################
  # Helpers
  
    helpers do
      def path_prefix
        request.env['SCRIPT_NAME']
      end
    end 

  ##############################################
  # Controllers / Routing / Request Handlers

  get '/' do
    
    @welcome_markdown =<<EOS
# Header 1

## Header 2

### Header 3
    
Welcome to [Markdown](#{request.url}). We hope you **really** enjoy using this.

Just type some [markdown](http://daringfireball.net/projects/markdown) on the left and see it on the right. *Simple as that.*

> Quote goes here.

A list:

- One
- Two
- Three

Some inline code `to_html` and a preformatted block (code block):

```
Markdown.new( 'Hello Markdown!' ).to_html
```

EOS

    @welcome_html = Markdown.new( @welcome_markdown ).to_html

    erb :index
  end


  get '/update' do
    pp params
    text = params[:notepad][:text]
    lib  = params[:notepad][:lib]   # optional
    pp text
    pp lib
    
    Markdown.lib = lib   if lib.nil? == false && lib.empty? == false   # fix: use activesupport present?
    Markdown.new( text ).to_html
  end

  ## todo: use 3rd party services from markdown.yml (lets you configure)
  #   e.g. http://johnmacfarlane.net/cgi-bin/pandoc-dingus?text=hi

  ## return html
  get '/html' do

    # fix: use activesupport -> .present?
    if params[:lib].nil? == false && params[:lib].empty? == false
      Markdown.lib = params[:lib]
    end

    Markdown.new( params[:text] ).to_html
  end

  ## return html wrapped in json (follows babelfish2 dingus service api)
  get '/dingus' do

    # fix: use activesupport -> .present?
    if params[:lib].nil? == false && params[:lib].empty? == false
      Markdown.lib = params[:lib]
    end
    
    html = Markdown.new( params[:text] ).to_html
    
    ### todo: add/fill up version
    ## ass helper  <lib>_version to engine
    # {"name":"Pandoc","html":"<p>hi</p>","version":"1.9.4.2"}
    data = {
      name: Markdown.lib,
      html: html,
      version: 'x.x.x'  # to be done
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
