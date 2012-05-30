module Markdown
 
  class Proxy   

    def initialize( lib, mn, content, options={} )
      @lib     = lib      
      @mn      = mn
      @content = content
      @options = options
    end
        
    def to_html
      # call markdown filter; turn markdown lib name into method_name (mn)
      # eg. rpeg-markdown =>  rpeg_markdown_to_html

      puts "  Converting Markdown-text (#{@content.length} bytes) to HTML using library '#{@lib}' calling '#{@mn}'..."

      send( @mn, @content )  # call 1st configured markdown engine e.g. kramdown_to_html( content )
    end    

    include Engine
    
  end # class Proxy

  @@markdown_config = nil    
  @@markdown_libs   = []
  @@markdown_mn     = nil
  
  def self.load_markdown_libs

    # check for available markdown libs/gems
    # try to require each lib and remove any not installed

    @@markdown_config.known_markdown_libs.each do |lib|
      begin
        require lib
        @@markdown_libs << lib
      rescue LoadError => ex
        ## todo: use logger.debug  instead of puts        
        puts "Markdown library #{lib} not found. Use gem install #{lib} to install."
      end
    end

    puts "  Found #{@@markdown_libs.length} Markdown libraries: #{@@markdown_libs.join(', ')}"
  end
   
  def self.lib
    if @@markdown_config.nil?
      @@markdown_config = Config.new
      @@markdown_config.load
      
      load_markdown_libs
    
      # lets you use differnt options/converters for a single markdown lib
      @@markdown_mn = @@markdown_config.markdown_to_html_method( @@markdown_libs.first )
    end

    @@markdown_libs.first
  end
  
  def self.new( content, options={} )

    ## todo: allow options to pass in
    ##   lets you change markdown engine/converter for every call
    ##   e.g. lets you add config properties (as headers) to your document (for example)
    
    if @@markdown_config.nil?
      @@markdown_config = Config.new
      @@markdown_config.load
      
      load_markdown_libs
    
      # lets you use differnt options/converters for a single markdown lib
      @@markdown_mn = @@markdown_config.markdown_to_html_method( @@markdown_libs.first )    
    end

    Proxy.new( @@markdown_libs.first, @@markdown_mn, content, options )
  end

end # module Markdown