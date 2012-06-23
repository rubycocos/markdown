module Markdown

  class Config

# note: only kramdown is listed as a dependency in gem specs (because it's Ruby only and, thus, easy to install)
#  if you want to use other markdown libs install the required/desired lib e.g.
#  use  gem install rdiscount for rdiscount and so on
#
# also note for now the first present markdown library gets used
#  the search order is first come, first serve, that is: rdiscount, rpeg-markdown, maruku, bluecloth, kramdown (fallback, always present)

#  DEFAULTS = {
#    'libs' => [ 'pandoc-ruby',
#                'rdiscount',
#                'rpeg-markdown',
#                'maruku',
#                'bluecloth',
#                'kramdown' ] }

# note: make kramdown default engine

DEFAULTS = { 'libs' => [
                'kramdown' ],
             'extnames' => [
                '.markdown',
                '.m',
                '.mark',
                '.mkdn',
                '.md',
                '.mdown',
                '.markdn',
                '.txt',
                '.text' ],  # todo: check - add .wiki??? ext
             'redcarpet' => {
                 'extensions' => [
                    'no_intra_emphasis',
                    'fenced_code_blocks',
                    'tables',
                    'strikethrough' ] },   # todo/fix:  merge nested hash??
             'filters' => [
                'comments-percent-style' ] # optional (preprocessing) text filters: e.g. comments-percent-style, skip-end-directive, etc. (see textutils gem)
           }

  
    def initialize
      @props = @props_default = Props.new( DEFAULTS, 'DEFAULTS' )

      # check for user settings (markdown.yml) in home folder

      ## todo: use .markdown.yml?? or differnt name ??
      props_home_file = File.join( Env.home, 'markdown.yml' )
      if File.exists?( props_home_file )
        puts "Loading settings from '#{props_home_file}'..."
        @props = @props_home = Props.load_file( props_home_file, @props )
      end
      
      # check for user settings (markdown.yml) in working folder
    
      props_work_file = File.join( '.', 'markdown.yml' )
      if File.exists?( props_work_file )
        puts "Loading settings from '#{props_work_file}'..."
        @props = @props_work = Props.load_file( props_work_file, @props )
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

    def markdown_lib
      @libs.first
    end
    
    def markdown_lib_defaults
      ## todo: return props ? that acts like a hash?? (lets us support section lookup without deep merge???)
      opts = @props.fetch( @libs.first, {} )
    end
    
    def markdown_to_html_method
      lib  = @libs.first
      method = @props.fetch_from_section( lib, 'converter', "#{lib.downcase}_to_html" )  # default to <lib>_to_html if converter prop not found    
      method.tr('-','_').to_sym
    end

  end # class Config
end # module Markdown