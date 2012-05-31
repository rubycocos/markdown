module Markdown

  class Props

    attr_reader :path
    attr_reader :parent
    
    def initialize( hash, path, parent=nil)
      @hash   = hash
      @path   = path
      @parent = parent
    end
    
    def self.load_file( path, parent=nil )
      Props.new( YAML.load_file( path ), path, parent )
    end
    
    def [](key)  get( key );  end
    
    def fetch(key, default)
      value = get( key )
      value.nil? ? default : value
    end

private
    def get( key )
      value = @hash[ key.to_s ]
      # if not found try lookup in parent hash
      (value.nil? && parent) ? parent[key] : value
    end
    
  end # class props


  class Config

# note: only kramdown is listed as a dependency in gem specs (because it's Ruby only and, thus, easy to install)
#  if you want to use other markdown libs install the required/desired lib e.g.
#  use  gem install rdiscount for rdiscount and so on
#
# also note for now the first present markdown library gets used
#  the search order is first come, first serve, that is: rdiscount, rpeg-markdown, maruku, bluecloth, kramdown (fallback, always present)

  DEFAULTS = {
    'libs' => [ 'pandoc-ruby',
               'rdiscount',
               'rpeg-markdown',
               'maruku',
               'bluecloth',
               'kramdown' ] }

  
    def initialize
      @props = @props_default = Props.new( DEFAULTS )
      
      # todo/fix: check more locations
      ## @props_home     : todo -> load .yml from home dir

      # check for user settings in working folder (check for markdown.yml)
    
      props_work_file = "./markdown.yml"
      if File.exists?( props_work_file )
        puts "Loading settings from '#{props_work_file}'..."
        @props = @props_work = Props.load_file( props_work_file, @props )
      end
    end

    
    def markdown_to_html_method( lib )
      opts = props.fetch( lib, {} )
      method = opts.fetch( 'converter', "#{lib.downcase}_to_html" )  # default to <lib>_to_html if converter prop not found    
      method.tr('-','_').to_sym
    end  

    
  
    def known_markdown_libs
      # returns an array of known markdown engines e.g.
      # [ pandoc-ruby, rdiscount, rpeg-markdown, maruku, bluecloth, kramdown ]
    
      ## todo: allow single lib para instead of libs    
      ##  todo: allow ENV setting markdown_[select]_lib=xxxx
    
      ## todo/fix: use lookup with config parent cascade
    
      user_libs = @hash.fetch( 'user', {} ).fetch( 'libs', [] )
    
      user_libs.length > 0 ? user_libs : DEFAULT_LIBS
    end

    
  @@libs   = []
  @@mn     = nil    # markdown converter method name (mn) e.g. kramdown_to_html
  
  def load_markdown_libs

    # check for available markdown libs/gems
    # try to require each lib and remove any not installed

    @@config.known_markdown_libs.each do |lib|
      begin
        require lib
        @@libs << lib
      rescue LoadError => ex
        ## todo: use logger.debug  instead of puts        
        puts "Markdown library #{lib} not found. Use gem install #{lib} to install."
      end
    end

    puts "  Found #{@@libs.length} Markdown libraries: #{@@libs.join(', ')}"
  end
   
    
    

  end # class Config
end # module Markdown