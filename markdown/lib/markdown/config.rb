# encoding: utf-8

module Markdown

  class Config

# note: only kramdown is listed as a dependency in gem specs (because it's Ruby only and, thus, easy to install)
#  if you want to use other markdown libs install the required/desired lib e.g.
#  use  gem install rdiscount for rdiscount and so on
#
# also note for now the first present markdown library gets used
#  the search order is first come, first serve, that is: rdiscount, rpeg-markdown, maruku, bluecloth, kramdown (fallback, always present)


DEFAULT_EXTNAMES = [
  '.markdown',
  '.m',
  '.mark',
  '.mkdn',
  '.md',
  '.mdown',
  '.markdn',
  '.txt',
  '.text' ]    # todo: check - add .wiki??? ext

DEFAULT_REDCARPET = {
  'extensions' => [
    'no_intra_emphasis',
    'fenced_code_blocks',
    'tables',
    'strikethrough' ] }

DEFAULT_FILTERS = [
  'comments-percent-style' ] # optional (preprocessing) text filters: e.g. comments-percent-style, skip-end-directive, etc. (see textutils gem)


DEFAULTS = { 'libs'      => [ 'kramdown' ],    # note: make kramdown default engine
             'extnames'  => DEFAULT_EXTNAMES,
             'redcarpet' => DEFAULT_REDCARPET,   # todo/fix:  merge nested hash??
             'filters' =>  DEFAULT_FILTERS
           }

#
# pandoc-ruby  - how to include - gemfile cannot install binary ??
# rpeg-markdown  - build failure - still active, anyway?
# rdiscount - # compilation error on heroku; sorry excluded for now

DEFAULTS_SERVICE = { 'libs' => [
                'kramdown',   # note: make kramdown default engine
                'maruku',
                'bluecloth',
                'redcarpet'
                ],
             'extnames'  => DEFAULT_EXTNAMES,
             'redcarpet' => DEFAULT_REDCARPET
           }

    def load_props
      @props = @props_default = Props.new( DEFAULTS, 'DEFAULTS' )

      # check for user settings (markdown.yml) in home folder

      ## todo: use .markdown.yml?? or differnt name ??
      props_home_file = File.join( Env.home, 'markdown.yml' )
      if File.exist?( props_home_file )
        puts "Loading home settings from '#{props_home_file}'..."
        @props = @props_home = Props.load_file( props_home_file, @props )
      end
      
      # check for user settings (markdown.yml) in working folder
    
      props_work_file = File.join( '.', 'markdown.yml' )
      if File.exist?( props_work_file )
        puts "Loading work settings from '#{props_work_file}'..."
        @props = @props_work = Props.load_file( props_work_file, @props )
      end
    end

    def load_props_service
      puts "Loading service settings..."
      @props = @props_default = Props.new( DEFAULTS_SERVICE, 'DEFAULTS' )
    end

    def initialize

      # for an example see ./boot.rb
      if $MARKDOWN_USE_SERVICE_CONFIG == true
        load_props_service
      else
        load_props
      end
      
      @libs   = []
      
      require_markdown_libs()
    end

    def dump  # for debugging dump all settings
      puts "Markdown settings:"
      @props_default.dump   if @props_default
      @props_home.dump      if @props_home
      @props_work.dump      if @props_work
      
      puts
      puts "Markdown libs:"
      puts "  #{@libs.length} Markdown #{(@libs.length == 1) ? 'library' : 'libraries'} found: #{@libs.join(', ')}"
    end

    def markdown_extnames
      @props.fetch( 'extnames', nil )
    end
    
    def markdown_filters
      @props.fetch( 'filters', nil )
    end

    def known_markdown_libs
      # returns an array of known markdown engines e.g.
      # [ 'pandoc-ruby', 'rdiscount', 'rpeg-markdown', 'maruku', 'bluecloth', 'kramdown' ]
    
      ## todo: allow single lib para instead of libs
      ##  todo: allow ENV setting markdown_[select]_lib=xxxx
    
      ## todo/fix: use lookup with config parent cascade
    
    
      ## lookup order
      ## 1)  env variable MARKDOWN_LIB
      ## 2)  lib property (single markdown engine)
      ## 3)  libs property (first-come first-serve markdown engine list)

      user_lib = Env.markdown_lib || @props.fetch( 'lib', nil )

      if user_lib.nil?
        user_libs = @props.fetch( 'libs', nil )
      else
        [ user_lib ]  # return as array (wrap single lib entry)  
      end
    end

    def require_markdown_libs
      # check for available markdown libs/gems
      # try to require each lib and remove any not installed

      known_markdown_libs.each do |lib|
        begin
          require lib
          @libs << lib
        rescue LoadError => ex
          ## todo: use logger.debug  instead of puts
          puts "Markdown library #{lib} not found. Use gem install #{lib} to install."
        end
      end
    end

    def markdown_lib=( lib )
      
      # fix/todo: check if @libs.first == lib  => do nothing; return
      
      # check if value exists in libs array
      # if yes put it into first position
      # otherwise issue warning/error - better throw exception; engine not found
      
      # try to delete 
      obj = @libs.delete( lib )
      if obj.nil?  # nothing deleted; no obj found
        # try to require; will raise load error exception if not found; know what your're doing! no fallback; sorry; better fail fast
        require lib
      end
 
      # add it back; make it first entry
      @libs.unshift( lib )
    end

    def markdown_lib
      @libs.first
    end
    
    def markdown_libs
      @libs  # NB: return all libs - should we return a clone?
    end
    
    def markdown_lib_defaults( lib=nil )
      lib = @libs.first   if lib.nil?
      ## todo: return props ? that acts like a hash?? (lets us support section lookup without deep merge???)
      opts = @props.fetch( lib, {} )
    end

    def markdown_version_method( lib=nil )
      lib  = @libs.first   if lib.nil?
      method = "#{lib.downcase}_version"  # default to <lib>_to_html if converter prop not found    
      method.tr('-','_').to_sym
    end

    def markdown_to_html_method( lib=nil )
      lib  = @libs.first   if lib.nil?
      method = @props.fetch_from_section( lib, 'converter', "#{lib.downcase}_to_html" )  # default to <lib>_to_html if converter prop not found    
      method.tr('-','_').to_sym
    end

  end # class Config
end # module Markdown
